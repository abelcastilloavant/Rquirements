install_reqs <- function(reqfile = default_reqfile_location(), lockfile = default_lockfile_location(), save_tree = TRUE) {
  message("reading reqfile and lockfile")
  requirements <- read_list(reqfile)
  lockfile     <- read_list(lockfile)

  if (!`packages_already_installed?`(requirements)) {
    lockfile <- create_lockfile(requirements, lockbox_hash, lockfile_path, save_tree)
    install_from_lockfile(lockfile)
    register_lockfile(lockfile_hash)
  }
}
