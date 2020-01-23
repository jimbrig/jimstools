#' Download Button
#'
#' Download button without opening up new window in browser when downloaded.
#'
#' @param outputId output id
#' @param label label
#' @param class class
#' @param icon icon
#' @param ... passed to tags$a
#'
#' @return download button HTML
#' @export
#' @importFrom htmltools tags
#' @importFrom shiny icon
download_bttn <- function(outputId, label = "Download", class = NULL, icon = NULL, ...) {

  aTag <- htmltools::tags$a(
      id = outputId,
      class = paste("btn btn-default shiny-download-link", class),
      href = "",
      target = NA, # NA here instead of _blank
      download = NA,
      shiny::icon(icon),
      label,
      ...
    )
}

#' Ensures a text string is a valid email address
#'
#' @param x string
#'
#' @return logical
#' @export
is_valid_email <- function(x) {

  grepl("\\<[A-Z0-9._%+-]+@[A-Z0-9.-]+\\.[A-Z]{2,}\\>",
        as.character(x),
        ignore.case = TRUE)

}
