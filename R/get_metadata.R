#'@title get metadata for a lake in GLTC dataset
#'@param lake_name a name of a lake in GLTC dataset
#'@param metadata_name a name of a metadata variable in GLTC dataset (optional)
#'@return list with metadata (if metadata_name == NULL) or value if 
#'metadata_name is specified
#'@export
get_metadata <- function(lake_name, metadata_name = NULL){
  check_lake(lake_name)
  data(gltc_metadata)
  if (is.null(metadata_name)){
    metadata <- gltc_metadata[[lake_name]]
  } else {
    metadata <- gltc_metadata[[lake_name]][[metadata_name]]
  }
  
  return(metadata)
}