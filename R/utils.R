calculate_lockbox_hash <- function(requirements) {
  digest::digest(requirements)
}

default_reqsfile_location <- function() {
}

default_lockfile_location <- function() {
}
