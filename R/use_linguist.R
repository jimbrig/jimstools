#' GitHub Linguist Exclusions
#'
#' This function creates a `.gitattributes` file in the root of your project in
#' order to exclude certain file types from being detected as a certain programming language on GitHub. See details for more information.
#'
#' @param excludes Character vector of wildcards indicating extensions to be labelled as `linguist-vendored` and ignored by GitHub's language detector `github-linguist`.
#'
#' @return invisibly returns the text written to `.gitattributes`
#' @export
#'
#' @details
#' By default this function will write `*.js`, `*.html`, and `*.css` to a `.gitattributes` file in order for `github-linguist` to ignore Javascript, HTML, and CSS languages in your repositories language section.
#'
#' The resulting file will look like so:
#' ```
#' # github linguist exclusions:
#' *.js linguist-vendored
#' *.html linguist-vendored
#' *.css linguist-vendored
#' ````
#'
#' @examples
#' \dontrun{
#' use_gh_linguist()
#' }
#' @importFrom fs file_exists file_create
use_gh_linguist <- function(excludes = c("*.js", "*.html", "*.css")) {

  if (!fs::file_exists(".gitattributes")) fs::file_create(".gitattributes")
  excludes_ <- paste0(excludes, " linguist-vendored")
  txt <- paste(c("# github linguist exclusions:", excludes_), collapse = "\n")
  write(txt, ".gitattributes", append = TRUE)
  invisible(txt)

}
