rquirements_registry_path <- function() {
  ensure_directory_exists(get_option("rquirements.registry_path", "~/.R/rquirements/registry"))
}


ensure_directory_exists <- memoise::memoise(function(directory) {
  if (!dir.exists(directory)) {
    dir.create(directory, recursive = TRUE)
  }
  directory
})
