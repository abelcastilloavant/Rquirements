register_dep_tree <- function(dep_tree) {
  stopifnot(is(dep_tree, "DependencyTree"))
  saveRDS(dep_tree, dep_tree_registry_filename(dep_tree$reqs()))
}

`dep_tree_registered?` <- function(reqs) {
  file.exists(dep_tree_registry_filename(reqs))
}

get_dep_tree_from_registry <- function(reqs) {
  readRDS(dep_tree_registry_filename(reqs))
}

dep_tree_registry_filename <- function(reqs) {
  file.path(dep_tree_registry_path, dep_tree_registry_key(reqs))
}

dep_tree_registry_path <- function() {
  ensure_directory_exists(file.path(rquirements_registry_path(), "dep_tree"))
}

dep_tree_registry_key <- function(reqs) {
  reqs_registry_key(reqs)
}
