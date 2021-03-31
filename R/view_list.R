#' view_list
#'
#' Interactive view of list structures with [listviewer::jsonedit()]
#'
#' @param list list to display
#' @param ... options sent through to [listviewer::jsonedit()]
#'
#' @export
#'
#' @importFrom listviewer jsonedit
#'
#' @examples
#' view_list(mtcars)
view_list <- function(list, ...) {
  listviewer::jsonedit(list, ...)
}

