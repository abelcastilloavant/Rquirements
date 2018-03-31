load_requirements <- function(reqsfile) {
  reqs <- read_list(reqsfile)
  if (REQS_REGISTRY$exists(reqs)) {
    lockfile <- REQS_REGISTRY$get(reqs)
  } else {
    lockfile <- generate_lockfile(reqs)
    REQS_REGISTRY$put(lockfile, reqs)
  }

  if (!LOCKFILE_REGISTRY$exists(lockfile)) {
    install_status <- install_packages_into_lockbox(lockfile)
    LOCKFILE_REGISTRY$put(install_status, lockfile)
  }

  `set_session_package_versions!`(lockfile)
}
