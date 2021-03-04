#' Prints framework for documenting a data frame
#'
#' @description Prints the standard fframework for documenting a data frame in
#'     an R package.
#'
#' @param df data frame object; can be a \code{data.frame}, \code{data.table},
#'     or \code{tibble}
#' @param num_spaces number of a spaces per tab; default is 4
#'
#' @return nothing
#'
#' @examples
#' set.seed(0)
#' dat <- data.frame(x = c(LETTERS[1:5]),
#'                   y = c(sample(1:100, 5)))
#' document_df(dat)
#'
#' @export document_df
document_df <- function(df, num_spaces = 4) {
  line_one(df)
  item_lines(df, num_spaces = num_spaces)
  close_line()
  invisible(0)
}

# print out the first line
line_one <- function(df) {
  df_type <- get_df_type(df)
  n_rows <- nrow(df)
  n_cols <- ncol(df)
  cat("#' @format a ", df_type, " (", n_rows, " x ", n_cols, ")\n", sep = "")
}

# return the data frame object type
get_df_type <- function(df) {
  if (tibble::is_tibble(df)) {
    return("tibble")
  } else if (data.table::is.data.table(df)) {
    return("data.table")
  } else if (is.data.frame(df)) {
    return("data.frame")
  } else {
    stop("type of 'df' not recognized")
  }
}

# one line per column of the data frame
item_lines <- function(df, num_spaces) {
  cat("#' \\describe{\n")
  purrr::map(colnames(df), item_line, num_spaces = num_spaces)
  return(0)
}

item_line <- function(col_name, num_spaces) {
  sp <- paste0(rep(" ", num_spaces), collapse = "")
  cat("#' ", sp, "\\item{", col_name, "}{}\n", sep = "")
}

# close the "\describe{ ... }"
close_line <- function() {
  cat("#' }\n")
}
