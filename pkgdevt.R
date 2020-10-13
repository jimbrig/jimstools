
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
  chameleon,
  checkhelper,
  knitr,
  rmarkdown
)

# initialize package
usethis::create_package("jimstools")
usethis::use_build_ignore("devhist.R")
usethis::use_roxygen_md()
usethis::use_namespace()
usethis::use_package_doc()
usethis::use_mit_license(name = "Jimmy Briggs")
devtools::document()

# edit Rprofile
usethis::edit_r_profile()

# setup git
usethis::use_git()
usethis::use_github()
usethis::git_vaccinate()
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
usethis::use_r("paste_winslash")
usethis::use_r("pull_unique")
usethis::use_r("expand_from_vars")
usethis::use_r("coalesce_join")
usethis::use_r("cache")
usethis::use_r("backup_raw")
usethis::use_r("multi_filt")
usethis::use_r("compare_to_prior")
usethis::use_r("group_by_occurrence")
usethis::use_r("shinytools")
usethis::use_r("paste_winslash")
usethis::use_r("get_rstudio_projects")

usethis::use_r("open_project")
usethis::use_addin("open_project")

usethis::use_vignette("benchmarking")

devtools::document()

attachment::att_to_description(
  extra.suggests = c("roxygen2", "devtools", "usethis", "desc", "attachment")
)

usethis::use_vignette("benchmarking")

attachment::create_dependencies_file(open_file = FALSE)

usethis::use_news_md()


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
usethis::create_package("jimstools")
usethis::use_build_ignore("devhist.R")
usethis::use_roxygen_md()
usethis::use_namespace()
usethis::use_package_doc()
usethis::use_mit_license(name = "Jimmy Briggs")
devtools::document()

# edit Rprofile
usethis::edit_r_profile()

# setup git
usethis::use_git()
usethis::use_github()
usethis::git_vaccinate()
usethis::git_sitrep()

# readme
usethis::use_readme_rmd()
usethis::use_lifecycle_badge("experimental")
knitr::knit("README.Rmd")

# initialize functions
usethis::use_pipe()
usethis::use_tibble()
usethis::use_tidy_eval()


usethis::use_r("utils-general")
usethis::use_r("utils-data")
usethis::use_r("utils-text")

usethis::use_r("shiny-helpers")
usethis::use_r("shiny-ui")
usethis::use_r("shiny-server")
usethis::use_r("shiny-modules")

usethis::use_r("actuarial")

usethis::use_r("meta-package")

usethis::use_r("rstudio-addins")

usethis::use_r("pull_unique")
usethis::use_r("expand_from_vars")
usethis::use_r("coalesce_join")
usethis::use_r("cache")
usethis::use_r("backup_raw")
usethis::use_r("multi_filt")
usethis::use_r("compare_to_prior")
usethis::use_r("group_by_occurrence")
usethis::use_r("shinytools")
usethis::use_r("paste_winslash")
usethis::use_r("get_rstudio_projects")

usethis::use_r("open_project")
usethis::use_addin("open_project")

usethis::use_vignette("benchmarking")

devtools::document()

attachment::att_to_description(
  extra.suggests = c("roxygen2", "devtools", "usethis", "desc", "attachment")
)

usethis::use_vignette("benchmarking")

attachment::create_dependencies_file(open_file = FALSE)
