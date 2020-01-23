# No Remotes ----
# Attachments ----
to_install <- c("dplyr", "fs", "fst", "htmltools", "magrittr", "openxlsx", "purrr", "rlang", "shiny", "tibble", "tidyr")
  for (i in to_install) {
    message(paste("looking for ", i))
    if (!requireNamespace(i)) {
      message(paste("     installing", i))
      install.packages(i)
    }
  }
