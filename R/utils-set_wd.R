#' Set working directory to the path of \strong{current} script
#'
#' @importFrom rstudioapi getSourceEditorContext
#' @param dir \code{NULL} (default) or a character string specifying the working directory.
#'
#' If \code{NULL}, set working directory to the path of \strong{the current R script}.
#' @examples
#' \dontrun{
#' set_wd()  # set working directory to the path of the current R script
#'
#' set_wd("D:/")  # "\" is not allowed, you should use "/"
#'
#' set_wd("../")  # set working directory to the parent directory
#' }
#' @seealso \code{\link{setwd}}
#' @export
set_wd <- function(dir = NULL) {

  if(is.null(dir)) dir <- dirname(getSourceEditorContext()$path)

  setwd(dir)

  path <- getwd()

  message("Set working directory to ", path)

}

