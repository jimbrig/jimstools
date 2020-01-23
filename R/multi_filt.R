#' Multi Filt
#'
#' Filter across multiple variables.
#'
#' @param data data
#' @param vars variables
#' @param filts filters
#'
#' @return filtered df
#' @export
#' @importFrom dplyr filter
#' @importFrom purrr map2
#' @importFrom rlang quo
multi_filt <- function(data, vars, filts) {

  fp <- purrr::map2(vars, filts, function(x, y) rlang::quo((!!(as.name(x))) %in% !!y))

  dplyr::filter(data, !!!fp)

}
