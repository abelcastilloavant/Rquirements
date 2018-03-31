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
