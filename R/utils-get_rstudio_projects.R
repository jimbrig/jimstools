#' Get RStudio Projects
#'
#' Pulls projects list from RStudio's AppData files.
#'
#' @return data.frame
#' @export
#' @importFrom dplyr mutate distinct bind_rows filter left_join coalesce select arrange desc
#' @importFrom fs path dir_ls path_ext_remove
#' @importFrom purrr discard
#' @importFrom readr read_lines
#' @importFrom tibble as_tibble
#' @importFrom tidyr separate
get_rstudio_projects <- function(proj_dir = getOption("projects.dir")) {

  local_app_dir <- get_local_app_dir()

  path_1 <- fs::path(local_app_dir, "RStudio-Desktop\\projects_settings\\project-id-mappings")
  path_2 <- fs::path(local_app_dir, "RStudio\\projects_settings\\project-id-mappings")

  path_mru_1 <- fs::path(local_app_dir, "RStudio-Desktop\\monitored\\lists\\project_mru")
  path_mru_2 <- fs::path(local_app_dir, "RStudio\\monitored\\lists\\project_mru")

  proj_dir <- getOption("projects.dir")

  removes <- c("sandbox", "code", "docs", "templates")

  dirs_x_nonprojs <- fs::dir_ls(proj_dir, type = "directory") %>%
    purrr::discard(tolower(basename(.)) %in% removes)

  all_detected_projects_in_proj_dir <- fs::dir_ls(
    dirs_x_nonprojs, type = "file", recurse = TRUE, glob = "*.Rproj"
  ) %>%
    unique() %>%
    tibble::as_tibble() %>%
    dplyr::mutate(value = gsub("~", dirname(dirname(local_app_dir)), value, fixed = TRUE)) %>%
    dplyr::distinct() %>%
    dplyr::mutate(project_path = dirname(value))

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
    dplyr::bind_rows(mru, all_detected_projects_in_proj_dir) %>%
    dplyr::mutate(project_path = gsub('"', '', .data$project_path, fixed = TRUE),
                  exists = file.exists(.data$project_path),
                  project_file = as.character(get_rproj_vec(.data$project_path))) %>%
    dplyr::filter(.data$project_file != "character(0)",
                  !is.na(.data$project_file),
                  !is.null(.data$project_file),
                  .data$exists == TRUE) %>%
    dplyr::left_join(mru, by = "project_path") %>%
    dplyr::mutate(value = dplyr::coalesce(.data$value.x, .data$value.y)) %>%
    dplyr::select(-value.x, -value.y) %>%
    dplyr::mutate(project_name = fs::path_ext_remove(basename(.data$project_file)),
                  git_config_file = fs::path(.data$project_path, ".git", "config"),
                  git = file.exists(.data$git_config_file),
                  git_url = ifelse(.data$git == TRUE, get_git_url_vec(.data$git_config_file), NA),
                  last_modified = file.mtime(.data$project_path)) %>%
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

  return(out)
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
    fs::dir_ls(path, type = "file", recurse = TRUE, glob = "*.Rproj") %>%
      as.character()
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
    tibble::as_tibble() %>%
    dplyr::filter(stringr::str_detect(.data$value, "\turl = ")) %>%
    dplyr::pull(.data$value) %>%
    stringr::str_sub(8L, nchar(.))

}

#' @keywords internal
get_rproj_vec <- Vectorize(get_rproj)

#' @keywords internal
get_git_url_vec <- Vectorize(get_git_url)

#  ------------------------------------------------------------------------
#
# Title : Add new projects to project launcher
#    By : Jimmy Briggs
#  Date : 2021-01-17
#
#  ------------------------------------------------------------------------

# library(jimstools)
# library(fs)
# library(magrittr)
# library(dplyr)
# library(tibble)
#
#
# current <- jimstools::get_rstudio_projects()
# # str(current)
#
# # loop through directories for *.Rproj files
#
#
#
# # merge
# projects_to_add <- tibble::tibble(
#   project_id = NA_character_,
#   project_name = gsub(".Rproj", "", basename(missing_projects)),
#   project_path = dirname(missing_projects),
#   project_file = basename(missing_projects),
#   git_config_file = fs::path(project_path, ".git", "config"),
#   git = file.exists(git_config_file),
#   git_url = ifelse(git == TRUE, jimstools:::get_git_url(git_config_file), NA),
#   last_modified = file.mtime(project_path)) %>%
#   select(
#     project_id,
#     project_name,
#     project_path,
#     project_file,
#     git,
#     git_url,
#     last_modified
#   ) %>%
#   dplyr::distinct(project_file, .keep_all = TRUE) %>%
#   dplyr::arrange(!.data$git, dplyr::desc(.data$last_modified))
#
# projects_to_add <- projects_to_add[!(projects_to_add$project_path %in% current$project_path),]
#
# # merge
# out <- bind_rows(current, projects_to_add)
