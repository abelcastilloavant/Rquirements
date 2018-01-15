calculate_lockbox_hash <- function(requirements) {
  digest::digest(requirements)
}

