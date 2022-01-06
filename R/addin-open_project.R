
#' Open RStudio Project
#'
#' @return invisibly returns an RStudio project
#' @export
#'
#' @importFrom rstudioapi openProject
#' @importFrom utils menu
#' @importFrom fs path_expand
open_project <- function() {
  hold <- get_rstudio_projects()
  out <- hold$project_file
  projs <- paste0(basename(dirname(out)), " (", basename(dirname(dirname(out))), ")")

  if (in_rstudio()) {
    ask <- utils::menu(projs, TRUE, title = "Select a Project to Open")
    if (ask == 0) return(0)
    open <- fs::path_expand(out[ask])
    rstudioapi::openProject(open, newSession = TRUE)
  } else {
    ask <- tcltk::tk_select.list(projs, title = "Select a Project to Open")
    if (ask == 0 || ask == "") return(0)
    open <- fs::path_expand(out[match(ask, projs)])
    shell.exec(open)
  }

}


#' @keywords internal
#' @importFrom tcltk tk_select.list
#' @importFrom fs path_expand
open_project.shell <- function() {

  hold <- get_rstudio_projects()
  out <- hold$project_file
  projs <- paste0(basename(dirname(out)), " (", basename(dirname(dirname(out))), ")")
  ask <- tcltk::tk_select.list(projs, title = "Select a Project to Open")
  if (ask == 0 || ask == "") return(0)
  open <- fs::path_expand(out[match(ask, projs)])
  shell.exec(open)

}

#' In RStudio
#'
#' Determine if user is in an RStudio Environment
#'
#' @return logical
#' @export
#' @importFrom rstudioapi isAvailable hasFun
in_rstudio <- function() {
  rstudioapi::isAvailable() && rstudioapi::hasFun("navigateToFile")
}
