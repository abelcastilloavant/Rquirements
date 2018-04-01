generate_lockfile <- function(reqs) {
  reqs     <- validate_reqs(reqs)
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
  lapply(reqs, function(required_pkg) {
    if (!all(c("name", "version") %in% names(required_pkg))) {
      stop("Your requirements list has an entry that's missing ",
           "either a 'name' or a 'version', but these are needed ",
           "to generate a lockfile. Please fix this.")
    }
    if (!"source" %in% names(required_pkg)) {
      # the default source for a package is CRAN
      required_pkg$source <- "CRAN"
    }
    required_pkg
  })
}
