#' Coalesce Join
#'
#' @param x data.frame
#' @param y data.frame to join with
#' @param by variables to join by
#' @param suffix common variables suffix
#' @param join type of join
#' @param ... passed to join function
#'
#' @return joined data.frame with values replaced
#' @export
#'
#' @importFrom dplyr union coalesce bind_cols
#' @importFrom purrr map_dfc
coalesce_join <- function(x,
                          y,
                          by = NULL,
                          suffix = c(".x", ".y"),
                          join = dplyr::full_join,
                          ...) {

  joined <- join(y, x, by = by, suffix = suffix, ...)

  # names of desired output
  cols <- dplyr::union(names(x), names(y))

  to_coalesce <- names(joined)[!names(joined) %in% cols]

  suffix_used <- suffix[ifelse(endsWith(to_coalesce, suffix[1]), 1, 2)]

  # remove suffixes and deduplicate
  to_coalesce <- unique(substr(to_coalesce,
                               1,
                               nchar(to_coalesce) - nchar(suffix_used)))

  coalesced <- purrr::map_dfc(
    to_coalesce, ~ dplyr::coalesce(joined[[paste0(.x, suffix[1])]],
                                   joined[[paste0(.x, suffix[2])]])
  )

  names(coalesced) <- to_coalesce

  dplyr::bind_cols(joined, coalesced)[cols]

}
