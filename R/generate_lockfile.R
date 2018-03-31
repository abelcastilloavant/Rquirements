generate_lockfile <- function(reqs) {
  validate_reqs(reqs)
  dep_tree           <- DependencyTree$new(reqs)
  installation_order <- DependencyTree$sort_packages()
  register_dep_tree(dependency_tree)
  list(
    requirements       = reqs,
    installation_order = installation_order,
    reqs_registry_key  = reqs_registry_key(reqs)
  )
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
