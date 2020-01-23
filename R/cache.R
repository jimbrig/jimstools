
#' Write Cache
#'
#' Quick caching utility write function.
#'
#' @param x object to cache
#' @param name name to store object with
#' @param cache_dir path to cache directory
#' @param overwrite logical (default = TRUE)
#'
#' @return invisible
#' @export
#'
#' @importFrom fs dir_exists dir_create path file_exists file_delete
#' @importFrom fst write_fst
#' @importFrom tibble is_tibble
write_cache <- function(x,
                        name = NULL,
                        cache_dir = "cache",
                        overwrite = TRUE) {

  if (!fs::dir_exists(cache_dir)) fs::dir_create(cache_dir)

  if (is.null(name)) name <- deparse(substitute(x))

  fst_file <- paste0(fs::path(cache_dir, name), ".fst")
  rds_file <- paste0(fs::path(cache_dir, name), ".RDS")

  if (tibble::is_tibble(x) || is.data.frame(x)) {

    tryCatch(
      fst::write_fst(x, fst_file),
      error = function(e, ...) saveRDS(x, rds_file)
    )

  } else {

    saveRDS(x, rds_file)

  }

  if (fs::file_exists(fst_file) && fs::file_exists(rds_file)) fs::file_delete(fst_file)

  return(invisible())

}

#' Read Cache
#'
#' Quick caching utility read function.
#'
#' @param name name of object to read in.
#' @param cache_dir path to cache directory.
#'
#' @return invisibly attaches object to parent global environment
#' @export
#' @importFrom fs path file_exists
#' @importFrom fst read_fst
read_cache <- function(name,
                       cache_dir = "cache") {

  fst_file <- paste0(fs::path(cache_dir, name), ".fst")
  rds_file <- paste0(fs::path(cache_dir, name), ".RDS")

  if (!fs::file_exists(fst_file) && !fs::file_exists(rds_file)) stop("File not found in ", cache_dir)

  if (fs::file_exists(fst_file)) out <- fst::read_fst(fst_file)

  if (fs::file_exists(rds_file)) out <- readRDS(rds_file)

  assign(name, out, envir = .GlobalEnv)

  return(invisible())

}
