register_lockfile <- function(lockfile, install_status) {
  if (!isTRUE(install_status$completed)) {
    stop("lockfile failed to complete installation successfully. we will not regster it")
  }
  write_list(install_status, lockfile_registry_key(lockfile))
}

`lockfile_registered?` <- function(lockfile) {
  file.exists(lockfile_registry_key(lockfile))
}

lockfile_registry_key <- function(lockfile) {
  file.path(lockfile_registry_path(), digest_lockfile(lockfile))
}

reqs_registry_path <- function() {
  ensure_directory_exists(file.path(rquirements_registry_path(), "lockfile"))
}

digest_lockfile <- function(lockfile) {
  lockfile$installation_order <- lapply(lockfile$installation_order, `[`, c("name", "version"))
  digest::digest(lockfile[c("reqs_registry_key", "installation_order")])
}
