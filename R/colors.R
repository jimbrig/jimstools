#' Vectors of colors for figures
#'
#' Creates different vectors of related colors that may be useful for figures.
#'
#' @return Vector of character strings representing colors, in RGB.
#' @export
#' @keywords utilities
#' @examples
#' plot(1:4,rep(1,4),col=default_colors(),pch=19,cex=5)
#' plot(1:16,rep(1,16),col=default_colors(),pch=19,cex=5)
default_colors <- function() {

  # from http://clrs.cc
  c(navy = "#001f3f",
    blue = "#0074d9",
    aqua = "#7fdbff",
    teal = "#39cccc",
    olive = "#3d9970",
    green = "#2ecc40",
    lime = "#01ff70",
    yellow = "#ffdc00",
    orange = "#ff851b",
    red = "#ff4136",
    maroon = "#85144b",
    fuchsia = "#f012be",
    purple = "#b10dc9",
    black = "#111111",
    gray = "#aaaaaa",
    silver = "#dddddd",
    purple = '#9E4679',
    green = '#76BC44',
    blue = '#02AAC8',
    grey = '#55575A')

}
