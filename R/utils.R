## A standard helper: if `x` is null, `y` will be returned instead.
`%||%` <- function(x, y) if (is.null(x)) y else x

## Easily support options being set as env vars with similar names
get_option <- function(x, default = NULL) {
  result <- getOption(x)
  if (is.null(result)) {
    result <- Sys.getenv(toupper(gsub("\\.", "_", x)))
    if (!nzchar(result)) { result <- NULL }
  }
  result %||% default
}

# Utilities for handling argumants being passed to `do.call`
get_function_arguments <- function(fn) {
  names(as.list(args(fn)))
}

subset_by_function <- function(fn, lst) {
  lst[intersect(names(lst), get_function_arguments(fn))]
}

rquirements_registry_path <- function() {
  ensure_directory_exists(get_option("rquirements.registry_path", "~/.R/rquirements/registry"))
}

ensure_directory_exists <- memoise::memoise(function(directory) {
  if (!dir.exists(directory)) {
    dir.create(directory, recursive = TRUE)
  }
  directory
})

save_dep_trees <- function() {
  opt <- get_option("rquirements.save_dep_trees")
  isTRUE(opt) %||% identical(opt, "TRUE")
}
