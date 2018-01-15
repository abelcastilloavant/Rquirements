lockbox <- function(requirements_file, lockfile_path, save_tree = TRUE) {
  message("reading requirements file and existing lockfile")
  requirements <- read_list(requirements_file)
  lockfile     <- read_list(lockfile_path)

  message("Checking if lockfile is up to date")
  lockbox_hash <- calculate_lockbox_hash(requirements)
  if (identical(lockbox_hash, lockfile$lockbox_hash)) {
    message("Requirements unchanged, lockfile up to date")
  } else {
    message("Lockfile is outdated, recalculating dependencies")
    lockfile <- create_lockfile(requirements, lockbox_hash, lockfile_path, save_tree)
  }
  
  install_from_lockfile(lockfile)
}
