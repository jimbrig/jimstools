
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
  rstudioapi::openProject(open, newSession = TRUE)
}
