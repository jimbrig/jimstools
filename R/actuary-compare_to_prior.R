#' Compare to Prior
#'
#' Compares data across evaluations.
#'
#' @keywords actuarial
#'
#' @param data current data
#' @param col columns to compare (character vector)
#'
#' @return new data frame with added columns for changes and priors
#' @export
#' @importFrom dplyr group_by mutate lag ungroup if_else
#' @importFrom rlang quo sym quo_name UQ
#' @importFrom lubridate is.Date
compare_to_prior <- function(data, col){

  col <- rlang::quo(!! rlang::sym(col))
  prcol <- paste0("pr_", rlang::quo_name(col))
  chgcol <- paste0(rlang::quo_name(col), "_chg")

  if (is.character(data[[rlang::quo_name(col)]])) {
    hold <- data %>%
      dplyr::group_by(clm_num) %>%
      dplyr::mutate(!!prcol := dplyr::lag(!!col, default = "NEW", order_by = eval_dt)) %>%
      dplyr::ungroup() %>%
      dplyr::mutate(!!chgcol := dplyr::if_else(rlang::UQ(col) == rlang::UQ(rlang::quo(!! rlang::sym(prcol))),
                                 "No Change", paste0(rlang::UQ(rlang::quo(!! rlang::sym(prcol))),
                                                     "->", !!col)))
  } else if (lubridate::is.Date(data[[rlang::quo_name(col)]])) {

    hold <- data %>%
      dplyr::group_by(clm_num) %>%
      dplyr::mutate(!!prcol := dplyr::lag(!!col, default = NA, order_by = eval_dt)) %>%
      dplyr::ungroup() %>%
      dplyr::mutate(!!chgcol := ifelse(rlang::UQ(col) == rlang::UQ(rlang::quo(!! rlang::sym(prcol))),
                                "No Change", rlang::UQ(col) - rlang::UQ(rlang::quo(!! rlang::sym(prcol)))))

  } else {

    hold <- data %>%
      dplyr::group_by(clm_num) %>%
      dplyr::mutate(!!prcol := dplyr::lag(!!col, order_by = eval_dt)) %>%
      dplyr::ungroup() %>%
      dplyr::mutate(!!chgcol := dplyr::if_else(is.na(rlang::UQ(rlang::quo(!! rlang::sym(prcol)))),
                                 rlang::UQ(col), rlang::UQ(col) - rlang::UQ(rlang::quo(!! rlang::sym(prcol)))))
  }

  return(hold)

}
