#'@title get metadata names in GLTC dataset
#'@param lake_name
#'@return a character vector of valid metadata variable names for all lakes. 
#'If lake_name is specified, only the metadata fields populated for lake_name 
#'are returned. 
#'@examples
#'get_metadata_names()
#'get_metadata_names('Victoria')
#'@export
get_metadata_names <- function(lake_name = NULL){
  data(gltc_metadata)
  
  if (is.null(lake_name)){
    metadata_vars <- vector('character', 0)
    for (i in 1:length(gltc_metadata)){
      metadata_vars <- unique(c(metadata_vars, names(gltc_metadata[[i]][[1]])))
    }
  } else {
    metadata_vars <- names(gltc_metadata[[lake_name]][[1]])
  }

  return(metadata_vars)
}