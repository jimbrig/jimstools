#' Feedback Message Utility Functions
#'
#' @description
#' A set of helper functions for providing verbose feedback to the developer using
#' this packages functions.
#'
#' @param x The string passed to various `msg_` functions.
#' @param bullet What to use for the message's `bullet`. Defaults to `cli::symbol$bullet`
#'
#' @name feedback
#' @family Feedback Utilities
#' @keywords feedback
#'
#' @seealso
#'   - [usethis::ui-questions()]
#'   - [cli::list_symbols()]
NULL

#' Use Feedback Helpers
#'
#' This function allows a package developer to automatically add these functions
#' to their package.
#'
#' @param pkg Package - defaults to "."
#'
#' @export
#' @rdname feedback
#'
#' @importFrom fs file_copy path_package path
#' @importFrom utils file.edit
#' @importFrom usethis with_project
#' @importFrom attachment att_amend_desc
#' @importFrom devtools document
use_feedback_helpers <- function(pkg = ".") {

  fs::file_copy(path = fs::path_package(package = "jimstools", "templates/feedback-helpers.R"),
                new_path = fs::path(pkg, "R", "feedback-helpers.R"),
                overwrite = TRUE)

  usethis::with_project(path = pkg, code = {
    attachment::att_amend_desc()
    devtools::document()
  })

  file.edit(fs::path(pkg, "R", "feedback-helpers.R"))

}

#' Inform
#'
#' @description
#' A wrapper around [rlang::inform()] for providing feedback to developers using
#' this packages functions.
#'
#' @inheritDotParams rlang::inform
#'
#' @family Feedback Utilities
#' @seealso [rlang::inform()]
#'
#' @return feedback in console
#' @export
#'
#' @importFrom rlang inform
inform <- function(...) {
  rlang::inform(paste0(...))
}

#' Indent
#'
#' @description
#' Indentation around various `msg_` feedback functions.
#'
#' @param x The string passed to various `msg_` functions.
#' @param first what to indent with - defaults to `"  "`.
#' @param indent indentation of next line - defaults to `first`
#'
#' @family Feedback Utilities
#'
#' @export
#' @return string
indent <- function(x, first = "  ", indent = first) {
  x <- gsub("\n", paste0("\n", indent), x)
  paste0(first, x)
}

#' @rdname feedback
#' @importFrom crayon green
#' @importFrom glue glue_collapse
msg_field <- function(x) {
  x <- crayon::green(x)
  x <- glue::glue_collapse(x, sep = ", ")
  x
}

#' @rdname feedback
#' @importFrom crayon yellow
#' @importFrom glue glue_collapse
msg_value <- function(x) {

  if (is.character(x)) {
    x <- encodeString(x, quote = "'")
  }
  x <- crayon::yellow(x)
  x <- glue::glue_collapse(x, sep = ", ")
  x

}

#' @rdname feedback
#' @importFrom glue glue glue_collapse
#' @importFrom crayon green
#' @importFrom cli symbol
msg_done <- function(x) {
  x <- glue::glue_collapse(x, "\n")
  x <- glue::glue(x, .envir = parent.frame())
  msg_bullet(x, crayon::green(cli::symbol$tick))
}

#' @rdname feedback
#' @importFrom cli symbol
msg_bullet <- function(x, bullet = cli::symbol$bullet) {
  bullet <- paste0(bullet, " ")
  x <- indent(x, bullet, "  ")
  inform(x)
}

#' @rdname feedback
#' @importFrom crayon red
#' @importFrom cli symbol
msg_err <- function(x) {
  x <- glue::glue_collapse(x, "\n")
  x <- glue::glue(x, .envir = parent.frame())
  msg_bullet(x, crayon::red(cli::symbol$cross))
}

#' @rdname feedback
#' @importFrom fs is_dir path_rel path_tidy
#' @importFrom here here
msg_path <- function(x) {
  is_directory <- fs::is_dir(x) | grepl("/$", x)
  x_rel <- fs::path_rel(x, start = here::here())
  x_tidy <- fs::path_tidy(x_rel)
  out <- ifelse(is_directory, paste0(x_tidy, "/"), x_tidy)
  msg_value(out)
}

#' @rdname feedback
#' @importFrom cli symbol
#' @importFrom crayon yellow
#' @importFrom glue glue_collapse glue
msg_info <- function(x) {
  x <- glue::glue_collapse(x, "\n")
  x <- glue::glue(x, .envir = parent.frame())
  msg_bullet(x, crayon::yellow(cli::symbol$info))
}

#' @rdname feedback
#' @importFrom glue glue_collapse
#' @importFrom crayon silver
msg_code <- function(x) {
  x <- encodeString(x, quote = "`")
  x <- crayon::silver(x)
  x <- glue::glue_collapse(x, sep = ", ")
  x
}

#' @rdname feedback
#' @importFrom glue glue_collapse
#' @importFrom crayon green
msg_feedback <- function(x) {
  x <- crayon::green(x)
  x <- glue_collapse(x, sep = ", ")
  x
}
