
#' #' Explore Directory Tree
#' #'
#' #' @description
#' #' Utilizes [dir2json::shinyDirTree()] to
#' #'
#' #' @
#' #'
#' #' @param path
#' #'
#' #' @return
#' #' @export
#' #'
#' #' @examples
#' explore_dir_tree <- function(path = ".") {
#'
#'   dir2json::shinyDirTree(".")
#'
#' }

dir_tree <- function(path, recurse = TRUE) {

  fs::dir_tree(path, recurse)

}


