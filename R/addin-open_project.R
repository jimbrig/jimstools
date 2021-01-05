
#' Open RStudio Project
#'
#' @return invisibly returns an RStudio project
#' @export
#'
#' @importFrom rstudioapi openProject
#' @importFrom utils menu
open_project <- function() {
  hold <- get_rstudio_projects()
  out <- hold$project_file
  projs <- paste0(basename(dirname(out)), " (", basename(dirname(dirname(out))), ")")
  ask <- utils::menu(projs, TRUE, title = "Select a Project to Open")
  if (ask == 0) return(0)
  open <- out[ask]
  if (in_rstudio()) {
    rstudioapi::openProject(open, newSession = TRUE)
  } else {
   shell.exec(open)
  }

}


#' @keywords internal
#' @importFrom tcltk tk_select.list
open_project.shell <- function() {

  hold <- get_rstudio_projects()
  out <- hold$project_file
  projs <- paste0(basename(dirname(out)), " (", basename(dirname(dirname(out))), ")")
  ask <- tcltk::tk_select.list(projs, title = "Select a Project to Open")
  if (ask == 0 || ask == "") return(0)
  open <- out[match(ask, projs)]
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
