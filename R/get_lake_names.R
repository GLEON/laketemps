#'@title get lake names in GLTC dataset
#'@return a character vector of valid lake names
#'@export
get_lake_names <- function(){
  data(gltc_temperature)
  return(names(gltc_temperature))
}