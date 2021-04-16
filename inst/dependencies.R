# No Remotes ----
# Attachments ----
to_install <-
  c(
    "checkmate",
    "data.table",
    "dplyr",
    "DT",
    "fs",
    "git2r",
    "glue",
    "htmltools",
    "listviewer",
    "lubridate",
    "magrittr",
    "memoise",
    "openxlsx",
    "progress",
    "purrr",
    "qs",
    "readr",
    "rlang",
    "rstudioapi",
    "shiny",
    "stringr",
    "tibble",
    "tidyr",
    "usethis",
    "whoami",
    "HenrikBengtsson/rcli"
  )

pacman::p_unlock()
pacman::p_delete(char = to_install)

pak::pak(to_install)

# for (i in to_install) {
#   message(paste("     installing", i))
#   install.packages(i)
# }

