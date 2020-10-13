#' Collapse Rows
#'
#' for each group, sets the top row of the group to the group's value.  All other
#' rows in the group are set to "".  See the example
#'
#' @param df a data frame
#' @param variable group variable to be collapsed
#'
#' @return a data frame with an updated `variable` column
#'
#' @export
#'
#' @importFrom dplyr group_by mutate n ungroup select
#' @importFrom rlang enquo quo_name
collapseRows <- function(df, variable){

  group_var <- rlang::enquo(variable)

  df %>%
    dplyr::group_by(!! group_var) %>%
    dplyr::mutate(groupRow = 1:dplyr::n()) %>%
    dplyr::ungroup() %>%
    dplyr::mutate(!!rlang::quo_name(group_var) := ifelse(groupRow == 1, as.character(!! group_var), "")) %>%
    dplyr::select(-c(groupRow))
}
