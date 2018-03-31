generate_lockfile <- function(reqs) {
  validate_reqs(reqs)
  dep_tree <- DependencyTree$new(reqs)
  lockfile <- list(
    requirements       = dep_tree$reqs(),
    installation_order = dep_tree$installation_order(),
    registry_key       = dep_tree$registry_key()
  )

  if (save_dep_trees()) {
    DEP_TREE_REGISTRY$put(dep_tree, dep_tree$reqs())
  }

  lockfile
}

validate_reqs <- function(reqs) {
  lapply(reqs, function(x) {
    if (!all(c("name", "version") %in% names(x))) {
      stop("Your requirements list has an entry that's missing ",
           "either a 'name' or a 'version', but these are needed ",
           "to generate a lockfile. Please fix this.")
    }
  })
}
