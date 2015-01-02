#'@title get summer surface lake temperature data from GLTC dataset
#'@param lake_name a valid name of a lake in the GLTC database
#'@param type source for the data. Either "in_situ" or "satellite".
#'@return a lake data.frame, or NULL if no data exist
#'@examples
#'get_surface_temps('Victoria','Satellite')
#'get_surface_temps('Mendota','In situ')
#'@export
get_surface_temps <- function(lake_name, type){
  
  both = temp_types()
  
  if (missing(type)){
    type = both
  }
  
  if (!all(type %in% both)){stop(paste0('type=', type, ' not recognized'))}
  
  data(gltc_values)
  check_lake(lake_name)
  
  df <- filter(gltc_values, variable %in% type, siteID == get_site_ID(lake_name)) %>%
    select(variable, year, value) %>% 
    acast(year ~ variable)
  df <- cbind(data.frame(year = as.numeric(row.names(df))), df)
  
  rownames(df) <- NULL
  
  
  surf_temps <- df
  
  if (is.null(surf_temps)){
    return(NULL)
  } else {
    return(as.data.frame(surf_temps))
  }
  
}

temp_types = function(){
  return(c('Satellite','In situ'))
}