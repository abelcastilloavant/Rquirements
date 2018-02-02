install_reqs <- function(reqsfile = default_reqsfile_location(), lockfile = default_lockfile_location(), save_tree = TRUE) {
  message("reading reqsfile and lockfile")
  requirements <- read_list(reqsfile)
  lockfile     <- read_list(lockfile)

  message("Checking if lockfile is up to date")
  lockbox_hash <- calculate_lockbox_hash(requirements)
  if (identical(lockbox_hash, lockfile$lockbox_hash)) {
    message("Reqs unchanged, lockfile up to date")
  } else {
    message("Lockfile is outdated, recalculating dependencies")
    lockfile <- create_lockfile(requirements, lockbox_hash, lockfile_path, save_tree)
  }

  install_from_lockfile(lockfile)
}
