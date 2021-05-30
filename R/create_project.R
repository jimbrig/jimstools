create_project <- function(path, rstudio = rstudioapi::isAvailable(),
                           open = rlang::is_interactive(), fields = list()) {

  create_rstudio_project(path = path, rstudio = rstudio, open = open)

  usethis::proj_set(path = path)

  description(fields = fields, update_deps = TRUE)

  usethis::use_namespace(roxygen = TRUE)



}

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
