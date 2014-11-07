#'@title get lake data according to lake name
#'@param lake_name a valid name of a lake in the GLTC database
#'@param type source for the data. Either "in_situ" or "satellite".
#'@return a lake data.frame
#'@export
get_surface_temps <- function(lake_name, type = 'in_situ'){
  data(lake_data)
  surf_temps <- lake_data[[lake_name]]$surface_temps[[type]]
  return(surf_temps)
}