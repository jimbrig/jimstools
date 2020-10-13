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
