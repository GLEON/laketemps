#'@title get climate data according to lake name from GLTC dataset
#'@param lake_name a valid name of a lake in the GLTC dataset
#'@param type name for the climate data.
#'@return a lake data.frame, or NULL if no data exist
#'@export
#'@examples
#'get_climate_names()
#'get_climate('Victoria', 'SWdown_Summer')
get_climate <- function(lake_name, type){
  
  data(gltc_climate)
  check_lake(lake_name)
  
  climate <- gltc_climate[[lake_name]][[type]]
  
  if (is.null(climate)){
    return(NULL)
  } else {
    return(as.data.frame(climate))
  }
  
}