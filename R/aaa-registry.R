ObjectRegistry <- R6::R6Class("ObjectRegistry",
  public = list(
    initialize = function(read_fn, write_fn, filename_fn, object_type) {
      private$write_fn    <- write_fn
      private$read_fn     <- read_fn
      private$filename_fn <- filename_fn
      private$filepath    <- ensure_directory_exists(file.path(rquirements_registry_path(), object_type))
    },
    put = function(obj, filename_input) {
      private$write_fn(obj, private$filename(filename_input))
    },
    get = function(filename_input) {
      private$read_fn(private$filename(filename_input))
    },
    exists = function(filename_input) {
      file.exits(private$filename(filename_input))
    }
  ),

  private = list(
    read_fn     = "",
    write_fn    = "",
    filename_fn = "",
    filepath    = "",
    filename    = memoise::memoise(function(filename_input) {
      file.path(private$filepath, filename_fn(filename_input))
    })
  )
)

reqs_registry_filename <- memoise::memoise(function(reqs) {
  digest::digest(lapply(reqs, `[`, c("name", "version")))
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
    lockfile$installation_order <- lapply(lockfile$installation_order, `[`, c("name", "version"))
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



