#' Get RStudio Projects
#'
#' Pulls projects list from RStudio's AppData files.
#'
#' @param exclude_nonexistant Defaults to TRUE
#'
#' @return data.frame
#' @export
#' @importFrom dplyr distinct filter mutate left_join select arrange desc
#' @importFrom fs path path_expand
#' @importFrom purrr map_chr
#' @importFrom readr read_lines
#' @importFrom stringr str_subset
#' @importFrom tibble as_tibble
#' @importFrom tidyr separate
get_rstudio_projects <- function(exclude_nonexistant = TRUE) {

  local_app_dir <- get_local_app_dir()
  path <- get_path_recent_projects_list()
  path_2 <- fs::path(local_app_dir, "RStudio\\projects_settings\\project-id-mappings")

  projs <- readr::read_lines(path) %>% stringr::str_subset("^\\s*$", negate = TRUE)

  proj_df <- parse_proj_path(projs) %>%
    dplyr::distinct() %>%
    dplyr::filter(exists == TRUE) %>%
    dplyr::mutate(project_path = as.character(fs::path_expand(project_path))) %>%
    dplyr::left_join(
      readr::read_lines(path_2) %>%
        tibble::as_tibble() %>%
        tidyr::separate(value, c("project_id", "project_path"), sep = "=") %>%
        dplyr::distinct() %>%
        dplyr::mutate(project_path = gsub('"', '', .data$project_path, fixed = TRUE),
                      exists = file.exists(.data$project_path)) %>%
        dplyr::filter(.data$exists == TRUE),
      by = c("project_path", "exists")
    ) %>%
    dplyr::mutate(
      git_config_file = fs::path(.data$project_path, ".git", "config"),
      git = file.exists(.data$git_config_file),
      git_url = purrr::map_chr(.data$git_config_file, get_git_url), #(.data$git_config_file),
      last_modified = file.mtime(.data$project_path)
    ) %>%
    dplyr::select(
      .data$project_id,
      .data$project_name,
      .data$project_path,
      .data$project_file,
      .data$git,
      .data$git_url,
      .data$last_modified
    ) %>%
    dplyr::distinct(.data$project_file, .keep_all = TRUE) %>%
    dplyr::arrange(!.data$git, dplyr::desc(.data$last_modified))

  return(proj_df)
}

#' #' @importFrom readr read_lines
#' #' @importFrom stringr str_subset
#' get_rsudio_projects <- function() {
#'   file <- path
#'   projs <- readr::read_lines(file)
#'   stringr::str_subset(projs, "^\\s*$", negate = TRUE)
#' }

#' @importFrom tibble tibble
parse_proj_path <- function(proj_path) {

  tibble::tibble(project_name = extract_proj_name(proj_path = proj_path),
                 project_file = proj_path,
                 project_path = dirname(proj_path),
                 exists = file.exists(proj_path))

}

#' @importFrom fs path path_ext
#' @importFrom stringr str_replace
extract_proj_name <- function(proj_path) {

  proj_path <- fs::path(proj_path)

  ext <- fs::path_ext(proj_path)

  if (any(!tolower(ext) %in% c("Rproj", "rproj"))) {
    warning("The result is incorrect as the extension in some strings are not \".Rproj\".")
  }

  stringr::str_replace(proj_path, "(.*/)?([^/]*?)(/[^/]*?\\.[Rr]proj$)", "\\2")

}

get_rstudio_version <- function() {
  rstudioapi:::getVersion()
}

#' @importFrom fs path file_exists
#' @importFrom usethis ui_stop ui_path
check_path <- function(base, ...) {

  file <- fs::path(base, ...)

  if (fs::file_exists(file)) {
    file
  }
  else {
    usethis::ui_stop("The path does not exist: \n{usethis::ui_path(file)}")
  }

}

#' @importFrom fs path path_expand
get_path_rstudio_config_dir <- function(..., check = FALSE) {

  rstudio_version <- get_rstudio_version()

  rstudio_dirname <- if (rstudio_version < 1.4) "RStudio-Desktop" else "RStudio"

  base <- switch(get_os(),
                 windows = fs::path(Sys.getenv("LOCALAPPDATA"), rstudio_dirname),
                 fs::path_expand("~/.rstudio-desktop"))

  base <- Sys.getenv("RSTUDIO_CONFIG_DIR", unset = base)

  if (check) check_path(base, ...) else fs::path(base, ...)

}

get_path_recent_projects_list <- function() {
  get_path_rstudio_config_dir("monitored/lists/project_mru")
}



#' @importFrom fs path
#' @importFrom whoami whoami
get_local_app_dir <- function() {
  fs::path(
    "C:\\Users",
    whoami::whoami()["username"],
    #Sys.getenv("RSTUDIO_USER_IDENTITY"),
    #rstudioapi::userIdentity()
    "AppData", "Local"
  )
}

#' @keywords internal
#' @importFrom fs dir_ls
get_rproj <- function(path) {

  tryCatch({
    hold <- fs::dir_ls(path, type = "file", recurse = 1, glob = "*.Rproj") %>%
      as.character()

    if (length(hold) > 1) hold <- hold[[match(basename(path), basename(fs::path_ext_remove(hold)))]]

    hold

  }, error = function(e) {
    return(NULL)
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
    purrr::keep(~ stringr::str_detect(.x, "\turl = ")) %>%
    stringr::str_sub(8L, nchar(.)) %>%
    purrr::pluck(1)

}

#' @keywords internal
get_rproj_vec <- Vectorize(get_rproj)

#' @keywords internal
get_git_url_vec <- Vectorize(get_git_url)
