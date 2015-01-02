#'@title get climate data according to lake name from GLTC dataset
#'@param lake_name a valid name of a lake in the GLTC dataset
#'@param types name for the climate data. All returned if missing.
#'@return a lake data.frame, or NULL if no data exist
#'@export
#'@import dplyr reshape2
#'@examples
#'get_climate_names()
#'get_climate('Victoria', types = c('SWdown_Summer', 'NCEP 3 month'))
#'get_climate('Mendota')
get_climate <- function(lake_name, types){
  
  
  
  if (missing(types)){
    types <- get_climate_names()
  }
  
  climate_data <- subset_lake_data(lake_name, types)
  return(climate_data)
  
}

