#' editenv
#'
#' quickly edit .Renviron
#'
#' @importFrom usethis edit_r_environ
#' @export
editenv <- function() {

  usethis::edit_r_environ("user")

}

#' editprof
#'
#' Quickly edit .Rprofile
#'
#' @importFrom usethis edit_r_profile
#' @export
editprof <- function() {

  usethis::edit_r_profile("user")

}
