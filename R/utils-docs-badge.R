#' Create README badges via img.shields.io
#'
#' @param label badge label
#' @param value badge value
#' @param color badge color
#' @param url url
#'
#' @return character string to be pasted into README
#' @export
#'
#' @examples
#' badge("Client", "Client XYZ", color = "black", url = "https://www.client-xyz.com/en-us")
badge <- function(label, value, color, url) {

  # adjust value and label for any spaces
  value <- gsub(" ", "%20", value)
  label <- gsub(" ", "%20", label)

  paste0(
    "[![", tolower(label), "](https://img.shields.io/badge/", label, "-",
    value, "-", color, ".svg)](", url, ")"
  )
}

# TEST
#
# b <- badge("Client", "Client XYZ", color = "black", url = "https://www.client-xyz.com/en-us")
# b == "[![client](https://img.shields.io/badge/Client-FedEx%20Express-black.svg)](https://www.fedex.com/en-us)"
