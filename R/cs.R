#' Vector of character strings from list of unquoted names
#'
#' @param ... dots to quote and `c()`.
#'
#' Returns a vector of character strings from list of unquoted names.
#' (Copied directly from the Hmisc package).
#' @export
#' @examples
#' cs(a,cat,dog)
cs = function(...) {
  return(as.character(sys.call()[-1]))
}
