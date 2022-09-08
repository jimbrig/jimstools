#' Create Project
#'
#' @param path Path
#' @param rstudio Boolean - Use RStudio?
#' @param open Boolean - Open?
#' @param fields passed to [usethis::use_description()]'s `fields` argument.
#'
#' @return RStudio project (side-effect)
#' @export
#'
#' @importFrom usethis proj_set use_namespace use_description
create_project <- function(path, rstudio = rstudioapi::isAvailable(),
                           open = rlang::is_interactive(), fields = list()) {

  create_rstudio_project(path = path, rstudio = rstudio, open = open)

  usethis::proj_set(path = path)

  usethis::use_description(fields = fields, update_deps = TRUE)

  usethis::use_namespace(roxygen = TRUE)

}

#' Create RStudio Project
#'
#' @param name name of project
#' @param path defaults to "."
#' @param ... passed to [render_template()]'s `data` argument
#'
#' @export
#' @return same as [usethis::create_package()].
#'
#' @importFrom fs path path_package
#' @importFrom usethis create_package
create_rstudio_project <- function(name, path = ".", ...) {

  proj_file <- fs::path(path, name, paste0(name, ".Rproj"))

  render_template(
    fs::path_package("jimstools", "templates/rstudio_project_template"),
    proj_file,
    data = list(
      ...
    ),
    open = FALSE
  )

  msg_done("Created new project at: {msg_path(proj_file)}")

  usethis::create_package(path = dirname(proj_file))


}



#' Render Template
#'
#' @description
#' Renders a template using [whisker::whisker.render()] for templates
#' used in a fashion similar to [usethis::use_template()].
#'
#' @param template_path Path to template
#' @param out_path Path to output the rendered template
#' @param data list to pass to [whisker::whisker.render()]
#' @param open boolean - open template after it renders?
#'
#' @return invisible
#' @export
#'
#' @importFrom usethis write_over
#' @importFrom whisker whisker.render
render_template <- function(template_path, out_path, data = list(), open = TRUE) {

  contents <- strsplit(
    whisker::whisker.render(
      readLines(template_path, encoding = "UTF-8", warn = FALSE), data
    ),
    "\n"
  )[[1]]

  usethis::write_over(out_path, contents)
  if (open) file.edit(out_path)
  invisible()

}
