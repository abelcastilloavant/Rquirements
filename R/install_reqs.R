install_reqs <- function(reqsfile = default_reqsfile_location(), lockfile = default_lockfile_location(), save_tree = TRUE) {
  message("reading reqsfile and lockfile")
  requirements <- read_list(reqsfile)
  lockfile     <- read_list(lockfile)

  if (!`packages_already_installed?`(requirements)) {
    lockfile <- create_lockfile(requirements, lockbox_hash, lockfile_path, save_tree)
    install_from_lockfile(lockfile)
    register_lockfile(lockfile_hash)
  }
}
