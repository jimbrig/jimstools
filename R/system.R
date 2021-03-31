#' Determine Operating System (OS)
#'
#' Determine the operating system (OS) of your machine.
#'
#' @return OS name in lower case: windows, mac, linux, etc.
#'
#' @seealso https://www.r-bloggers.com/identifying-the-os-from-r/
#'
#' @export
#' @concept system
#'
#' @examples
#' get_os()
get_os <- function() {

  sys_info <- Sys.info()

  if (!is.null(sys_info)) {

    os <- sys_info["sysname"]
    if (os == "Darwin")
      os <- "mac"

  } else {

    os <- .Platform$OS.type
    if (grepl("^darwin", R.version$os))
      os <- "mac"
    if (grepl("linux-gnu", R.version$os))
      os <- "linux"

  }

  unname(tolower(os))

}

#' @rdname get_os
#' @export
#' @importFrom stringr str_detect
#' @importFrom stringr str_detect
is_32bit_os <- function() {
  stringr::str_detect(version$arch, "32$")
}

#' @rdname get_os
#' @export
#' @importFrom stringr str_detect
#' @importFrom stringr str_detect
is_64bit_os <- function() {
  stringr::str_detect(version$arch, "64$")
}

# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
#' Get User-Related Information
#'
#' Get user-related information.
#'
#' @export
#'
#' @concept system
#'
#' @examples
#' \dontrun{\donttest{
#' user_info()
#' }}
#' @importFrom fs path
#' @importFrom stats setNames
#' @importFrom utils sessionInfo
user_info <- function() {

  os_info <- c("Operating system " = utils::sessionInfo()$running,
               "Platform " = utils::sessionInfo()$platform,
               Sys.getenv(c("LOGNAME", "USERNAME", "USERPROFILE", "HOME", "R_USER", "R_HOME", "R_LIBS_USER"))) %>%
    as.data.frame()

  os_info$. = fs::path(os_info$.)
  os_info <- stats::setNames(os_info, c("  "))

  print(os_info, right = FALSE)
  cat("\n")

  invisible(os_info)
}


# check_installed_programs <- function(which = "all", skip_online_check = FALSE) {
#
#   if (!skip_online_check) {
#     skip_online_check <- check_internet_connection()
#   }
#
#   v_req <- get_prgm_req_version(use_local_list = skip_online_check)
#   check_r_version(v_recommended = v_req$R, skip_online_check = skip_online_check)
#   check_rs_version(v_recommended = v_req$RStudio, skip_online_check = skip_online_check)
#   if (get_os_type() == "windows") {
#     check_program_installed("Rtools", pkgbuild::has_build_tools())
#   }
#   else {
#     check_program_installed("'R Build Tools'", pkgbuild::has_build_tools())
#   }
#   if (get_os_type() == "mac") {
#     check_program_installed("XQuartz", is_xquartz_installed())
#   }
#   switch(tolower(which), main = {
#     NULL
#   }, all = {
#     check_program_installed("Atom", is_atom_installed())
#     check_program_installed("Git", is_git_installed())
#     try({
#       check_program_installed("Meld", is_meld_installed())
#     }, silent = TRUE)
#   }, `bs-2020` = {
#     check_program_installed("Atom", is_atom_installed())
#   }, ui_warn("Unknown value '{which}'"))
#   invisible()
# }
#
#
