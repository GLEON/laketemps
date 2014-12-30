#'@title get lake names in GLTC dataset
#'@return a character vector of valid lake names
#'@examples
#'get_lake_names()
#'@export
get_lake_names <- function(){
  data(gltc_metadata)
  return(names(gltc_temperature))
}