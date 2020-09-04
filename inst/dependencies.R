# No Remotes ----
# Attachments ----
to_install <- c("dplyr", "fs", "fst", "htmltools", "lubridate", "magrittr", "openxlsx", "purrr", "rlang", "shiny", "stringr", "tibble", "tidyr")
  for (i in to_install) {
    message(paste("looking for ", i))
    if (!requireNamespace(i)) {
      message(paste("     installing", i))
      install.packages(i)
    }
  }
