#' Backup Raw Data
#'
#' This function copies raw data from an external location (i.e. a mapped network drive)
#' to a specified local project directory. In addition, a snapshot of the files
#' being copied is taken and stored in the specified "cache_dir" so that files
#' are only re-copied if changed.
#'
#' @param from_dir Directory to copy from.
#' @param to_dir Directory to copy to.
#' @param cache_dir Directory to store cached file snapshots.
#' @param force Logical indicating if copying should be forced.
#'
#' @return Invisible - this function is used for its side effects
#' @export
#'
#' @examples
#'
#' \dontrun{
#' library(jimstools)
#' library(fs)
#'
#' network_path <- fs::path(
#' "H:\\ATLRFI", "INDUSTRY", "Rates - Loss Costs", "Exposure_Adjustment_Template",
#' "2019", "Backup", "Excess Loss Factors", "Raw Data"
#' )
#'
#' local_path <- fs::path("data-raw", "xs-loss-factors")
#'
#' backup_raw(network_path, local_path)
#' }
#'
#' @importFrom fs dir_exists dir_create path dir_copy
#' @importFrom utils fileSnapshot changedFiles
backup_raw <- function(from_dir, to_dir, cache_dir = "cache", force = FALSE) {

  if (!fs::dir_exists(to_dir)) fs::dir_create(to_dir, recurse = TRUE)
  if (!fs::dir_exists(cache_dir)) fs::dir_create(cache_dir, recurse = TRUE)

  stopifnot(fs::dir_exists(from_dir), fs::dir_exists(to_dir), fs::dir_exists(cache_dir))

  cache_file <- fs::path(cache_dir, paste0("file_snapshot_", basename(from_dir), ".RDS"))
  timestamp_file <- fs::path(cache_dir,
                             paste0("file_snapshot_timestamp_",
                                    basename(from_dir)))

  # pull metadata on directory
  meta_curr <- utils::fileSnapshot(path = from_dir, file.info = TRUE,
                                   timestamp = timestamp_file,
                                   md5sum = TRUE,
                                   full.names = FALSE)

  if (force == TRUE || !file.exists(cache_file) || length(list.files(to_dir)) == 0) {

    message("Copying files...")

    fs::dir_copy(from_dir, to_dir, overwrite = TRUE)

    saveRDS(meta_curr, cache_file)

    return(invisible(0))

  }

  # see if any other snapshots in cache_dir
  if (file.exists(cache_file)) {

    meta_prior <- readRDS(cache_file)

    changes <- utils::changedFiles(before = meta_prior,
                            after = meta_curr,
                            check.file.info = c("size", "mtime"))

  } else {

    changes <- utils::changedFiles(before = meta_curr,
                            check.file.info = c("size", "mtime"))

  }

  # determine any changes
  changed <- changes$changed

  if (length(changed) > 1) {

    message("Detected changes in files, re-copying to local project...")

    fs::dir_copy(from_dir, to_dir, overwrite = TRUE)

    saveRDS(meta_curr, cache_file)

  } else {

    message("No changes in files detected.")

  }

  if (!file.exists(cache_file)) saveRDS(meta_curr, cache_file)

}
