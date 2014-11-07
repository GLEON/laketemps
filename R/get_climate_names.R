#'@title get climate data names in GLTC dataset
#'@return a character vector of valid climate variable names
#'@examples
#'get_climate_names()
#'@export
get_climate_names <- function(){
  data(gltc_climate)
  
  climate_vars <- names(gltc_climate[[1]])
  return(climate_vars)
}