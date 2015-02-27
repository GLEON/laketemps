#'@title get climate data names in GLTC dataset
#'@param lake_name a valid name of a lake in the GLTC database
#'@return a character vector of valid climate variable names
#'@importFrom dplyr filter
#'@seealso \code{\link{get_climate}}, \code{\link{get_lake_names}}
#'@examples
#'get_climate_names()
#'@export
get_climate_names <- function(lake_name = NULL){
  skip_names <- temp_types()  
  
  # -- fix for R CMD check 'no visible binding for global variable'
  siteID <- "_private"
  # -- fix for R CMD check 'no visible binding for global variable'
  
  if (is.null(lake_name)){
    
    val_names <- unique(gltc_values$variable)
    
  } else {
    data <- filter(gltc_values, siteID == get_site_ID(lake_name))
    val_names <- unique(data$variable)
  }
  
  climate_vars <- val_names[!val_names %in% skip_names]
  
  return(climate_vars)
}