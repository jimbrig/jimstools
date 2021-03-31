#' is_inst
#'
#' Check if a package is installed.
#'
#' @details This function provides a lightweight alternative to
#'  [utils::installed.packages()] by using [nzchar] instead.
#'
#' @param pkg string: package to search installation path for
#'
#' @return logical (TRUE/FALSE)
#' @export
#' @references
#'  - [Check for installed packages before running install.packages-Stack Overflow](https://stackoverflow.com/questions/9341635/check-for-installed-packages-before-running-install-packages/38082613#38082613)
#' @examples
#' \dontrun{
#' is_inst("dplyr")
#' }
is_inst <- function(pkg) {
  nzchar(system.file(package = pkg))
}
