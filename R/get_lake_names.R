#'@title get lake names in GLTC dataset
#'@return a character vector of valid lake names
#'@seealso \code{\link{get_climate_names}}, \code{\link{get_metadata_names}}
#'@examples
#'get_lake_names()
#'@export
get_lake_names <- function(){

  lake_names <- unique(gltc_metadata$Lake.name)
  
  return(lake_names)
}