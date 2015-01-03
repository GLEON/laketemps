#'@title get lake names in GLTC dataset
#'@return a character vector of valid lake names
#'@seealso \code{\link{get_climate_names}}, \code{\link{get_metadata_names}}
#'@examples
#'get_lake_names()
#'@export
get_lake_names <- function(){
  data(gltc_metadata)
  lake_names <- gltc_metadata$Lake.name
  
  if (length(lake_names) != length(unique(lake_names))){
    stop('not all lake names are unique.')
  }
  return(lake_names)
}