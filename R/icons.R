#' Open fontawesome icons webpage
#'
#' @export
browse_fontawesome <- function() {
  browseURL("https://fontawesome.com/v5.3.1/icons?d=gallery&m=free")
}


#' Shiny Icons
#'
#' @return character vector of shiny package icons
#' @export
shiny_icons <- function() {

  file.path('www', 'shared', 'fontawesome', 'css', 'all.min.css') %>%
    system.file(package = 'shiny') %>%
    readLines(warn = FALSE) %>% tail(1L) %>%
    strsplit('.', fixed = TRUE) %>% unlist %>%
    gsub(':before\\{content:".+"\\}', '', . ) %>%
    grep('fa-', ., fixed = TRUE, value = TRUE) %>%
    grep('[{,]', ., value = TRUE, invert = TRUE) %>%
    gsub('^fa-', '', .)

}

