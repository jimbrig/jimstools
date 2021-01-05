git2r::workdir()

#' Open Github Repository URL
#'
#' @export
#' @importFrom git2r remote_url
open_gh_repo <- function() {

  if (!dir.exists(".git")) stop("Working directory not a git repository.")
  git_remote <- git2r::remote_url()
  url <- valid_url(git_remote)
  utils::browseURL(url)

}

#' @keywords internal
#' @importFrom stringr str_detect regex str_sub str_replace
valid_url <- function(s) {
  hold <- stringr::str_detect(
    s,
    stringr::regex("http[s]?://(?:[a-zA-Z]|[0-9]|[$-_@.&+]|[!*\\(\\),]|(?:%[0-9a-fA-F][0-9a-fA-F]))+")
  )
  if (hold) return(hold) else {
    out <- stringr::str_sub(
        stringr::str_replace(s, "git@github.com:", "https://github.com/"),
        1L, -5L
      )
    return(out)
  }
}


