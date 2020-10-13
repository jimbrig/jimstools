#' group_by_occurrence
#'
#' Group loss data by occurrence ID.
#'
#' @keywords actuarial
#'
#' @param dat loss_data by claim ID
#'
#' @return data grouped by occurrence
#' @export
#'
#' @examples
#' \dontrun{
#' dat <- readRDS("data/shiny-data.rds") %>%
#'   filter(
#'     eval_dt == as.Date("2018-12-31"),
#'     member == "Ace Endico Corporation"
#'   )
#' test <- by_occurrence(dat)
#' }
#'
#'
#' @importFrom dplyr mutate arrange desc select group_by summarise_at vars ungroup slice summarise left_join mutate_at
#' @importFrom openxlsx convertToDate
#' @importFrom lubridate ymd
group_by_occurrence <- function(dat) {

  # create a temporary open/closed column for arranging
  dat_arranged <- dat %>%
    dplyr::mutate(
      open_closed = substr(status, 1, 1),
      open_closed = ifelse(.data$open_closed %in% c("O", "R"), 1, 2)) %>%
    dplyr::arrange(.data$open_closed, dplyr::desc(.data$last_dt)) %>%
    dplyr::select(-.data$open_closed)

  dat_occ <- dat_arranged %>%
    dplyr::group_by(.data$eval_dt, .data$occ_num) %>%
    dplyr::summarise_at(dplyr::vars(med_pd:subro), sum, na.rm = TRUE) %>%
    dplyr::ungroup()

  # just get 1 value for each value that should be static.  By getting only
  # one value we avoid the problem where an occurrence with 2 claims with different values for a
  # variable (e.g. status) will be counted twice
  static_vals <- dat_arranged %>%
    dplyr::group_by(.data$eval_dt, .data$occ_num) %>%
    dplyr::slice(1L) %>%
    dplyr::ungroup() %>%
    dplyr::select(-c(med_pd:subro), -.data$clsd_dt, -.data$last_dt, -.data$reopen_dt, -.data$rept_dt, -.data$rept_lag)


  # adjust dates: for all dates EXCEPT report date want to take max of all claims
  # in occurrence. For Report date take minimum
  dates_data <- dat %>%
    dplyr::select(occ_num, eval_dt, clsd_dt, last_dt, reopen_dt, rept_dt, rept_lag) %>%
    dplyr::group_by(.data$occ_num, .data$eval_dt) %>%
    dplyr::summarise(clsd_dt = if (all(is.na(.data$clsd_dt))) NA else max(.data$clsd_dt, na.rm = TRUE),
                     last_dt = if (all(is.na(.data$last_dt))) NA else max(.data$ast_dt, na.rm = TRUE),
                     reopen_dt = if (all(is.na(.data$reopen_dt))) NA else max(.data$reopen_dt, na.rm = TRUE),
                     rept_dt = if (all(is.na(.data$rept_dt))) NA else min(.data$rept_dt, na.rm = TRUE),
                     rept_lag = if (all(is.na(.data$rept_lag))) NA else min(as.numeric(.data$rept_lag), na.rm = TRUE)) %>%
    dplyr::ungroup()

  dat_occ %>%
    dplyr::left_join(static_vals, by = c("eval_dt", "occ_num")) %>%
    dplyr::left_join(dates_data, by = c("eval_dt", "occ_num")) %>%
    # convert `clsd_dt` and `last_dt` to NA if the occurrence is open
    dplyr::mutate(open_closed = substr(status, 1, 1)) %>%
    dplyr::mutate_at(dplyr::vars(clsd_dt, last_dt), list(~ifelse(.data$open_closed %in% c("O", "R"), NA_character_, as.character(.)))) %>%
    dplyr::mutate_at(dplyr::vars(clsd_dt, last_dt), list(~ymd(.))) %>%
    dplyr::select(-.data$open_closed) %>%
    dplyr::mutate(reopen_dt = openxlsx::convertToDate(reopen_dt, origin = "1970-01-01"),
                  rept_dt = lubridate::ymd(as.character(rept_dt)))

}

