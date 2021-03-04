#' Create README badges via img.shields.io
#'
#' @param label badge label
#' @param value badge value
#' @param color badge color
#' @param url url
#'
#' @return character string to be pasted into README
#' @export
badge <- function(label, value, color, url) {

  # adjust value and label for any spaces
  value <- gsub(" ", "%20", value)
  label <- gsub(" ", "%20", label)

  paste0(
    "[![", tolower(label), "](https://img.shields.io/badge/", label, "-",
    value, "-", color, ".svg)](", url, ")"
  )
}
