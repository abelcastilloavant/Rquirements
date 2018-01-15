install_from_lockfile <- function(lockfile) {
  lockfile_packages <- lapply(lockfile, get_package_info)
  lapply(lockfile_packages, install_one_package)
}
