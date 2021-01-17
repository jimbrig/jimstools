add_openrproj_to_path <- function() {

  fs::dir_create("C:/env/R", recurse = TRUE)
  fs::file_copy(fs::path_package("jimstools", "scripts/open_project_script.R"),
                "C:/env/R/open_project_script.R",
                overwrite = FALSE)
  fs::file_copy(fs::path_package("jimstools", "scripts/openrproject.bat"),
                "C:/env/bat/openrproject.bat",
                overwrite = FALSE)
  R.utils::createWindowsShortcut(pathname = "C:/env/open_r_project.lnk",
                                 target = "c:/env/bat/openrproject.bat",
                                 overwrite = FALSE)

}
