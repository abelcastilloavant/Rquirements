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

rquirements_registry_path <- function() {
  ensure_directory_exists(get_option("rquirements.registry_path", "~/.R/rquirements/registry"))
}


ensure_directory_exists <- memoise::memoise(function(directory) {
  if (!dir.exists(directory)) {
    dir.create(directory, recursive = TRUE)
  }
  directory
})

