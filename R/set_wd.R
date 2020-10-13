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

#' Paste and print texts with rich formats and colors
#'
#' Be tired of \code{print()} and \code{cat()}? Try \code{Print()}!
#' Run \strong{\code{example("Print")}} and see its power.
#'
#' See more details in help pages of \code{glue::\link[glue]{glue}} and \code{glue::\link[glue]{glue_col}}.
#' @import glue
#' @importFrom crayon reset bold italic underline strikethrough black silver white red green blue yellow magenta cyan
#' @param ... Character strings enclosed by \code{"{ }"} will be evaluated as R codes.
#'
#' Character strings enclosed by \code{"<< >>"} will be printed as formatted and colored texts.
#'
#' Long strings are broken by line and concatenated together.
#'
#' Leading whitespace and blank lines from the first and last lines are automatically trimmed.
#' @examples
#' name="Bruce"
#' Print("My name is <<underline <<bold {name}>>>>.
#'        <<bold <<blue Pi = {pi:.15}.>>>>
#'        <<italic <<green 1 + 1 = {1 + 1}.>>>>
#'        sqrt({x}) = <<red {sqrt(x):.3}>>", x=10)
#' @describeIn Print Paste and print strings.
#' @export
Print=function(...) {
  tryCatch({
    output=glue(..., .transformer=sprintf_transformer, .envir=parent.frame())
    output_color=glue_col( gsub("<<", "{", gsub(">>", "}", output)) )
    print(output_color)
  }, error=function(e) {
    warning(e)
    print(...)
  })
}
