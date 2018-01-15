create_lockfile <- function(requirements, lockbox_hash, lockfile_path, save_tree) {
  required_packages  <- lapply(requirements, get_package_info)
  dependency_tree    <- DependencyTree$new(required_packages)
  installation_order <- DependencyTree$sort_dependencies()
  lockfile           <- write_lockfile(installation_order, lockbox_hash, lockfile_path)
  if (isTRUE(save_tree)) {
    save_dependency_tree(lockfile, dependency_tree)
  }
  lockfile
}

write_lockfile <- function(installation_order, lockbox_hash, lockfile_path ) {
  write_list(list(lockbox_hash = lockbox_has, packages = installation_order), lockfile_path)
}
