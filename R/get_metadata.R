#'@title get metadata for a lake in GLTC dataset
#'@param lake_name a name of a lake in GLTC dataset
#'@param metadata_name a name of a metadata variable in GLTC dataset (optional)
#'@return list with metadata (if metadata_name is missing) or value if 
#'metadata_name is specified
#'@seealso \code{\link{get_metadata_names}}, \code{\link{get_lake_names}}, \code{\link{get_climate_names}}
#'@examples
#'get_metadata('Victoria','Sampling depth')
#'get_metadata('Mendota')
#'get_metadata("Toolik.JJA",c('location','source'))
#'@import dplyr
#'@export
get_metadata <- function(lake_name, metadata_name){
  
  if (missing(lake_name)){
    lake_name <- get_lake_names()
  } else {
    check_lake(lake_name)
  }
  
  if (missing(metadata_name)){
    metadata_name <- get_metadata_names(lake_name)
  }
  
  metadata <- filter(gltc_metadata, Lake.name == lake_name)
  if (length(metadata_name) == 1){
      metadata <- metadata[[metadata_name]]
  } else {
      metadata <- metadata[metadata_name]
  }
  
  return(metadata)
}