# jimstools 0.4.0



# jimstools 0.3.0

## Package Infrastructure

* Updated Package Down configurations.
* Removed `data-raw`.
* Upgraded `testthat` to edition 3.
* Replaced `git2r` with `gert`.
* Removed dependency on `grDevices`.
* Created an RMarkdown Template.
* Added code coverage.

## Bugfixes

* Fixed bug in `open_project` and `open_project.shell` to expand path with`fs::path_expand` in case User's home directory has a space.
* Fixed bug in `get_rstudio_projects` where no `by` argument was specified in `dplyr::left_join()`.

## Functions

* Added various *System* functions for Operating System information.
* Added `open_gh_repo` to open current projects GitHub Repo.
* Added `save_pdf` to save PDFs.
* Added `cs` function to wrap unquoted strings in quotes and vecorize with `c()`.

# jimstools 0.2.0

* Added `pkgdown` and various docs.
* Added a `NEWS.md` file to track changes to the package.

## Functions

* Added new RStudio Add-Ins: `open_project` and `paste_winslash`

# jimstools 0.1.0

## Functions

* Added `multi_filt`
* Added various `shinytools`
* Added various `utils`

## Imports

* Added `tidyeval` imports

## Docs

* `inst/dependencies.R`

# jimstools 0.0.1

## Functions

* Added `collapseRows`
* Added `coalesce_join`
* Added `group_by_occurrence`
* Added `expand_from_vars`
* Added `backup_raw`
* Added `pull_unique`

## Imports

* Added pipe operator `%>%` import

## Docs

* `jimstools-package` docs
* README.Rmd with ROADMAP and Resources
* `License.md`
