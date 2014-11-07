#'@title get summer surface lake temperature data from GLTC dataset
#'@param lake_name a valid name of a lake in the GLTC database
#'@param type source for the data. Either "in_situ" or "satellite".
#'@return a lake data.frame, or NULL if no data exist
#'@export
get_surface_temps <- function(lake_name, type = 'in_situ'){
  
  if (!type %in% c('satellite','in_situ')){stop(paste0('type=', type, ' not recognized'))}
  data(gltc_temperature)
  check_lake(lake_name)
  
  surf_temps <- gltc_temperature[[lake_name]]$surface_temps[[type]]
  
  if (is.null(surf_temps)){
    return(NULL)
  } else {
    return(as.data.frame(surf_temps))
  }
  
}