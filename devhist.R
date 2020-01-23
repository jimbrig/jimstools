
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
  purrr
)

# initialize package
usethis::create_package("Personal/jimstools")
usethis::use_build_ignore("devhist.R")
usethis::use_roxygen_md()
usethis::use_namespace()
devtools::document()
