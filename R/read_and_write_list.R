FILE_FORMATS = list()

FILE_FORMATS$yaml = list(
  read  = function(filename) { yaml::yaml.load_file(filename) },
  write = function(lst, filename) { yaml::write_yaml(lst, filename)
)

read_list <- function(filename, format = getOption("lockbox2.file_formats", "yaml") {
  FILE_FORMATS[[format]]$read(filename)
}

write_list <- function(lst, filename, format = getOption("lockbox2.file_formats", "yaml") {
  FILE_FORMATS[[format]]$write(lst, filename)
}

