#'@title get climate data according to lake name from GLTC dataset
#'@param lake_name a valid name of a lake in the GLTC dataset
#'@param types name for the climate data. All returned if missing.
#'@return a lake data.frame, or an empty data.frame if no data exist
#'@export
#'@seealso \code{\link{get_climate_names}}, \code{\link{get_surface_temps}}
#'@examples
#'get_climate_names()
#'get_climate('Victoria', types = c('Radiation.Shortwave.Summer', 'Air.Temp.Mean.Summer.NCEP'))
#'get_climate('Mendota')
#'get_climate('mendota','radiation.shortwave.summer')
get_climate <- function(lake_name, types){
  

  
  if (missing(types)){
    types <- get_climate_names()
  }
  check_climate(types)
  
  climate_data <- subset_lake_data(lake_name, types)
  return(climate_data)
  
}

