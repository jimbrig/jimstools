#' Ensures a text string is a valid email address
#'
#' @param x string
#'
#' @return logical
#' @export
is_valid_email <- function(x) {

  grepl("\\<[A-Z0-9._%+-]+@[A-Z0-9.-]+\\.[A-Z]{2,}\\>",
        as.character(x),
        ignore.case = TRUE)

}
