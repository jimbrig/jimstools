# No Remotes ----
# Attachments ----
to_install <- c("checkmate", "data.table", "dplyr", "DT", "fs", "git2r", "glue", "htmltools", "listviewer", "lubridate", "magrittr", "memoise", "openxlsx", "progress", "purrr", "qs", "readr", "rlang", "rstudioapi", "shiny", "stringr", "tibble", "tidyr", "usethis", "whoami")
  for (i in to_install) {
    message(paste("looking for ", i))
    if (!requireNamespace(i)) {
      message(paste("     installing", i))
      pak::pak(i)
    }
  }
