#' Get RStudio Projects
#'
#' Pulls projects list from RStudio's AppData files.
#'
#' @return data.frame
#' @export
#' @importFrom dplyr mutate distinct bind_rows left_join filter select arrange
#' @importFrom fs path path_ext_remove
#' @importFrom readr read_lines
#' @importFrom tibble as_tibble
#' @importFrom tidyr separate
get_rstudio_projects <- function() {

  local_app_dir <- get_local_app_dir()

  path_1 <- fs::path(local_app_dir, "RStudio-Desktop\\projects_settings\\project-id-mappings")
  path_2 <- fs::path(local_app_dir, "RStudio\\projects_settings\\project-id-mappings")

  path_mru_1 <- fs::path(local_app_dir, "RStudio-Desktop\\monitored\\lists\\project_mru")
  path_mru_2 <- fs::path(local_app_dir, "RStudio\\monitored\\lists\\project_mru")

  mru <- c(readr::read_lines(path_mru_1), readr::read_lines(path_mru_2)) %>%
    unique() %>%
    tibble::as_tibble() %>%
    dplyr::mutate(value = gsub("~", dirname(dirname(local_app_dir)), value, fixed = TRUE)) %>%
    dplyr::distinct() %>%
    dplyr::mutate(project_path = dirname(value))

  out <- readr::read_lines(path_1) %>%
    tibble::as_tibble() %>%
    tidyr::separate(value, c("project_id", "project_path"), sep = "=") %>%
    dplyr::bind_rows(
      readr::read_lines(path_2) %>%
        tibble::as_tibble() %>%
        tidyr::separate(value, c("project_id", "project_path"), sep = "=")
    ) %>%
    dplyr::mutate(project_path = gsub('"', '', .data$project_path, fixed = TRUE),
                  exists = file.exists(project_path),
                  project_file = get_rproj_vec(.data$project_path)) %>%
    dplyr::filter(!is.na(project_file), exists == TRUE) %>%
    # dplyr::left_join(mru, by = "project_path") %>%
    dplyr::mutate(project_name = fs::path_ext_remove(basename(project_file)),
                  git_config_file = fs::path(project_path, ".git", "config"),
                  git = file.exists(git_config_file),
                  git_url = ifelse(git == TRUE, get_git_url_vec(.data$git_config_file), NA)) %>%
    dplyr::select(
      project_id,
      project_name,
      project_path,
      project_file,
      git,
      git_url
    ) %>%
    dplyr::distinct(project_file, .keep_all = TRUE) %>%
    dplyr::arrange(!git)

}

#' @importFrom fs path
#' @importFrom rstudioapi userIdentity
get_local_app_dir <- function() {
  fs::path(
    "C:\\Users",
    rstudioapi::userIdentity(),
    "AppData", "Local"
  )
}

#' @keywords internal
#' @importFrom fs dir_ls
get_rproj <- function(path) {

  tryCatch({
    fs::dir_ls(path, type = "file", recurse = TRUE, glob = "*.Rproj")
  }, error = function(e) {
    return(NA)
  })

}

#' @keywords internal
#' @importFrom dplyr filter pull
#' @importFrom readr read_lines
#' @importFrom stringr str_detect str_sub
#' @importFrom tibble as_tibble
get_git_url <- function(path) {

  if (!file.exists(path)) return(NA_character_)

  readr::read_lines(path) %>%
    tibble::as_tibble() %>%
    dplyr::filter(stringr::str_detect(.data$value, "\turl = ")) %>%
    dplyr::pull(value) %>%
    stringr::str_sub(8L, nchar(.))

}

#' @keywords internal
get_rproj_vec <- Vectorize(get_rproj)

#' @keywords internal
get_git_url_vec <- Vectorize(get_git_url)
