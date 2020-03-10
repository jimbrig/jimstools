
#  ------------------------------------------------------------------------
#
# Title : Development History Script for `jimstools` R Package
#    By : Jimmy Briggs
#  Date : 2020-01-23
#
#  ------------------------------------------------------------------------

# dev packages necessary to develop the package
if (!require(pacman)) install.packages("pacman")
pacman::p_load(
  devtools,
  usethis,
  desc,
  fs,
  purrr,
  attachment,
  knitr
)

# initialize package
usethis::create_package("Personal/jimstools")
usethis::use_build_ignore("devhist.R")
usethis::use_roxygen_md()
usethis::use_namespace()
usethis::use_package_doc()
usethis::use_mit_license(name = "Jimmy Briggs")
devtools::document()

# setup git
usethis::use_git()
usethis::use_github()
usethis::git_sitrep()

# readme
usethis::use_readme_rmd()
usethis::use_lifecycle_badge("experimental")
knitr::knit("README.Rmd")

# initialize functions
usethis::use_pipe()
usethis::use_tibble()
usethis::use_tidy_eval()
usethis::use_r("utils")
usethis::use_r("pull_unique")
usethis::use_r("expand_from_vars")
usethis::use_r("coalesce_join")
usethis::use_r("cache")
usethis::use_r("backup_raw")
usethis::use_r("multi_filt")
usethis::use_r("compare_to_prior")
usethis::use_r("group_by_occurrence")
usethis::use_r("shinytools")


usethis::use_vignette("benchmarking")

devtools::document()

attachment::att_to_description(
  extra.suggests = c("roxygen2", "devtools", "usethis", "desc", "attachment")
)

usethis::use_vignette("benchmarking")

attachment::create_dependencies_file(open_file = FALSE)
