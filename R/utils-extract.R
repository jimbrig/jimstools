#' Extract Date
#'
#' Extracts dates from a character string with format "mm-dd-yyyy" or "mm/dd/yyyy".
#'
#' @param string character string
#'
#' @return date object
#' @export
#'
#' @examples
#' extract_date("data-raw/lossrun-as-of-2019-01-31.xlsx")
#' @importFrom lubridate mdy
#' @importFrom stringr str_extract_all
extract_date <- function(string) {

  paste0(
    unlist(
      stringr::str_extract_all(
        string,
        "[0-9]{1,2}[-./][0-9]{1,2}[-./][0-9]{2,4}"
      ),
      recursive = TRUE
    ),
    collapse = ""
  ) %>%
    lubridate::mdy() %>%
    as.character()

}

#' Extract numbers from a string
#'
#' @param string String to pull numbers from
#'
#' @return String of numbers
#' @export
#' @importFrom stringr str_extract
extract_num <- function(string){
  stringr::str_extract(string, "\\-*\\d+\\.*\\d*")
}
