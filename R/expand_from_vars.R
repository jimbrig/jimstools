#' Create a Skeleton 'Grid' for Data based on combinations of unique column values
#'
#' @param data data.frame
#' @param vars variables to use
#'
#' @return expanded data.frame
#'
#' @importFrom purrr map set_names
#' @importFrom tidyr expand_grid
#' @importFrom rlang !!!
#' @importFrom tibble as_tibble
expand_from_vars <- function(data, vars) {

  vars_in <- purrr::map(
    vars, function(x) pull_unique(data, var = x, names = FALSE)
  ) %>%
    purrr::set_names(vars)

  tidyr::expand_grid(

    !!!vars_in

  ) %>% tibble::as_tibble()

}
