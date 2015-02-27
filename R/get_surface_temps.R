#'@title get summer surface lake temperature data from GLTC dataset
#'@param lake_name a valid name of a lake in the GLTC database
#'@param type source for the data. Either "Lake.Temp.Summer.InSitu" or "Lake.Temp.Summer.Satellite".
#'@return a lake data.frame (empty data.frame) if no data exist
#'@seealso \code{\link{get_lake_names}}, \code{\link{get_climate}}
#'@examples
#'get_surface_temps('Victoria','Lake.Temp.Summer.Satellite')
#'get_surface_temps('Mendota','Lake.Temp.Summer.InSitu')
#'# retrieve from a lake site with multiple surface temperature sources:
#'get_surface_temps('Tahoe.Mid.Lake')
#'@export
get_surface_temps <- function(lake_name, type){
  
  both = temp_types()
  
  if (missing(type)){
    type = both
  }
  
  if (!all(type %in% both)){stop(paste0('type=', type, ' not recognized'))}
  
  surf_temps <- subset_lake_data(lake_name, types = type)
  return(surf_temps)
  
}

