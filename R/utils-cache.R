#' Caching Utility Functions
#'
#' Quick caching utility read/write functions utilizing the \code{qs} package.
#'
#' @name caching
#' @seealso [qs::qread()] and [qs::qsave()]
#' @return invisibly returns object passed to the function.
#' @examples
#' mydata <- mtcars
#' write_cache(mydata) # will save to 'cache/mydata'.
#' write_cache(mydata, "mydata-v2", cache_dir = "data/temp") # will save to 'data/temp/mydata-v2'
#'
#' # read back in
#' read_cache(mydata)
NULL


#' Write Cache
#'
#' @rdname caching
#'
#' @param x object to cache
#' @param name name to store object with
#' @param cache_dir path to cache directory
#' @param overwrite logical (default = TRUE)
#'
#' @return x
#' @export
#' @importFrom fs dir_exists dir_create path
#' @importFrom qs qsave
#' @importFrom usethis ui_info ui_path
write_cache <- function(x,
                        name = NULL,
                        cache_dir = "cache",
                        overwrite = TRUE) {

  if (!fs::dir_exists(cache_dir)) fs::dir_create(cache_dir)
  if (is.null(name)) name <- deparse(substitute(x))
  qs_file <- fs::path(cache_dir, name)

  if (file.exists(qs_file)) {
    usethis::ui_info("File: {usethis::ui_path(basename(qs_file))}, already
                     exists in cache; copying to prior and overwriting.")
    fs::dir_create(fs::path(cache_dir, "prior"))
    file.copy(qs_file,
              fs::path(cache_dir, "prior", basename(qs_file)),
              overwrite = TRUE)
  }

  usethis::ui_info("Caching {usethis::ui_path(basename(qs_file))},
                   in {usethis::ui_path(cache_dir)}")

  qs::qsave(x, qs_file)
  return(invisible(x))

}

#' Read Cache
#'
#' @rdname caching
#'
#' @param name name of object to read in.
#' @param cache_dir path to cache directory.
#'
#' @return invisibly attaches object to parent global environment
#' @export
#' @importFrom fs path file_exists
#' @importFrom qs qread
read_cache <- function(x,
                       name = NULL,
                       cache_dir = "cache") {

  if (is.null(name)) name <- deparse(substitute(x))
  qs_file <- fs::path(cache_dir, name)
  if (!fs::file_exists(qs_file)) {
    stop("File not found in ", cache_dir)
  }
  out <- list(qs::qread(qs_file))
  if (is.null(name)) name <- deparse(substitute(x))
  names(out) <- name
  list2env(out, envir = .GlobalEnv) # avoid assign by using list2env
  return(invisible(x))

}
