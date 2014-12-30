#'@title get metadata for a lake in GLTC dataset
#'@param lake_name a name of a lake in GLTC dataset
#'@param metadata_name a name of a metadata variable in GLTC dataset (optional)
#'@return list with metadata (if metadata_name == NULL) or value if 
#'metadata_name is specified
#'@examples
#'get_metadata('Victoria','Sampling depth')
#'get_metadata('Mendota')
#'@export
get_metadata <- function(lake_name, metadata_name = NULL){
  check_lake(lake_name)
  data(gltc_metadata)
  
  metadata <- filter(gltc_metadata, Lake.name == lake_name)
  if (!is.null(metadata_name)){
    metadata <- metadata[[metadata_name]]
  } 
  return(metadata)
}