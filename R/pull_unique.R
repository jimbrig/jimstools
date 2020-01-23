#' Pull all unique values for a variable
#'
#' @param data data.frame
#' @param var variable name
#' @param sort logical (default = TRUE)
#' @param decreasing logical (default = FALSE)
#' @param names logical (default = TRUE)
#'
#' @return vector
#'
#' @importFrom rlang sym !!
#' @importFrom dplyr pull
#' @importFrom purrr set_names
pull_unique <- function(data, var, sort = TRUE, decreasing = FALSE, names = TRUE) {

  hold <- data %>%
    dplyr::pull(!!rlang::sym(var)) %>%
    unique()

  if (sort) hold <- hold %>% sort(decreasing = decreasing)
  if (names) hold <- hold %>% purrr::set_names()

  return(hold)

}
