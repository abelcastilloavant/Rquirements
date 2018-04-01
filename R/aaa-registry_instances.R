# we need memoising out here because we want to cache values across different
# instances of the class
reqs_registry_filename <- memoise::memoise(function(reqs) {
  # sort reqs before computing digest to make sure
  # we don't get a different registry key just because we
  # change the order of its entries
  pkg_names <- vapply(reqs, `[[`, character(1), "names")
  digest::digest(lapply(reqs[order(pkg_names)], `[`, c("name", "version", "source")))
})

REQS_REGISTRY <- ObjectRegistry$new(
  object_type = "reqs",
  read_fn     = read_list,
  write_fn    = write_list,
  filename_fn = reqs_registry_filename
)

LOCKFILE_REGISTRY <- ObjectRegistry$new(
  object_type = "lockfile",
  read_fn     = read_list,
  write_fn    = write_list,
  filename_fn = function(lockfile) {
    lockfile$installation_order <- lapply(lockfile$installation_order, `[`, c("name", "version", "source"))
    digest::digest(lockfile[c("reqs_registry_key", "installation_order")])
  }
)

DEP_TREE_REGISTRY <- ObjectRegistry$new(
  object_type = "dep_tree",
  read_fn     = readRDS,
  write_fn    = saveRDS,
  filename_fn = function(dep_tree) {
    reqs_registry_filename(dep_tree$reqs())
  }
)
