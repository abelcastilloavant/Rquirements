#TODO: DRY up registry code paths for reqs, lockfiles, and dep_trees.

register_requirements <- function(reqs, lockfile) {
  write_list(lockfile, reqs_registry_filename(reqs))
}

get_lockfile_from_reqs_registry <- function(reqs) {
  read_list(reqs_registry_filename(reqs))
}

`reqs_registered?` <- function(reqs) {
  file.exists(reqs_registry_filename(reqs))
}

reqs_registry_filename <- function(reqs) {
  file.path(reqs_registry_path(), reqs_registry_key(reqs))
}

reqs_registry_path <- function() {
  ensure_directory_exists(file.path(rquirements_registry_path(), "reqs"))
}

reqs_registry_key <- memoise::memoise(function(reqs) {
  digest::digest(lapply(reqs, `[`, c("name", "version")))
})
