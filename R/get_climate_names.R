#'@title get climate data names in GLTC dataset
#'@return a character vector of valid climate variable names
#'@seealso \code{\link{get_climate}}, \code{\link{get_lake_names}}
#'@examples
#'get_climate_names()
#'@export
get_climate_names <- function(){
  skip_names <- temp_types()  
  
  val_names <- unique(gltc_values$variable)
  
  climate_vars <- val_names[!val_names %in% skip_names]
  return(climate_vars)
}