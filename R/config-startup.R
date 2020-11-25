#' R Startup Functions
#'
#' Use these utility functions to quickly edit your \code{.Rprofile},
#' \code{.Renviron}, or other startup files.
#'
#' @name startup
#'
#' @param scope
#'
#' @return invisible
#'
#' @seealso See [base::Startup()] for details on the R specific startup process.
#'
#' @export

# edit_startup <- function(which = "choose") {
#
#   files <- c(
#     "R Profile" = Sys.getenv("R_PROFILE_USER"),
#     "R Environment" = Sys.getenv("R_ENVIRON_USER"),
#     "R Makevars" = ,
#     "RStudio Snippets",
#     "Git Ignore",
#     "Git Config",
#     "R Secrets File",
#     "R History"
#   )
#
#   paths <- list(
#     Sys.getenv("R_PROFILE")
#   )
#
#   utils::select.list(
#     choices = files,
#
#   )
#
# }

#' @rdname startup
editrprof <- function(scope = c("user", "project")) {
  file.edit("~/.config/R/.Rprofile")
}

#' @rdname startup
editrenv <- function(scope = c("user", "project")) {
  file.edit("~/.config/R/.Renviron")
}

# editrbuildignore <- function()
