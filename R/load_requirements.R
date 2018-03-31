load_requirements <- function(reqsfile) {
  reqs <- read_list(reqsfile)
  if (`reqs_registered?`(reqs)) {
    lockfile <- get_lockfile_from_reqs_registry(reqs)
  } else {
    lockfile <- generate_lockfile(reqs)
    register_requirements(reqs, lockfile)
  }

  if (!`lockfile_registered?`(lockfile)) {
    install_packages_into_lockbox(lockfile)
    register_lockfile(lockfile)
  }

  `set_session_package_versions!`(lockfile)
}
