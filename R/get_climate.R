#'@title get climate data according to lake name from GLTC dataset
#'@param lake_name a valid name of a lake in the GLTC dataset
#'@param types name for the climate data.
#'@return a lake data.frame, or NULL if no data exist
#'@export
#'@import dplyr reshape2
#'@examples
#'get_climate_names()
#'get_climate('Victoria', types = c('SWdown_Summer', 'NCEP 3 month'))
#'get_climate('Mendota')
get_climate <- function(lake_name, types = 'all'){
  
  data(gltc_values)
  check_lake(lake_name)
  
  if (types[1] == "all" & length(types)==1){
    types <- get_climate_names()
  }
  
  df <- filter(gltc_values, variable %in% types, siteID == 2) %>%
    select(variable, year, value) %>% 
    acast(year ~ variable)
  df <- cbind(data.frame(year = as.numeric(row.names(df))), df)
  
  rownames(df) <- NULL
  
  if (is.null(df)){
    return(NULL)
  } else {
    return(df)
  }
  
}