#'@title get metadata for a lake in GLTC dataset
#'@param lake_name a name of a lake in GLTC dataset
#'@param metadata_name a name of a metadata variable in GLTC dataset (optional)
#'@return data.frame with metadata (if metadata_name is missing) or value if 
#'metadata_name is specified
#'@seealso \code{\link{get_metadata_names}}, \code{\link{get_lake_names}}, \code{\link{get_climate_names}}
#'@examples
#'get_metadata('Victoria','Sampling.depth')
#'get_metadata('Mendota')
#'get_metadata('mendota','sampling.depth')
#'get_metadata("Toolik.JJA",c('location','source'))
#'@importFrom dplyr filter
#'@export
get_metadata <- function(lake_name, metadata_name){
  
  # -- fix for R CMD check 'no visible binding for global variable'
  Lake.name <- "_private"
  # -- fix for R CMD check 'no visible binding for global variable'
  
  if (missing(lake_name)){
    lake_name <- get_lake_names()
  } else {
    check_lake(lake_name)
  }
  
  if (missing(metadata_name)){
    metadata_name <- get_metadata_names(lake_name)
  }
  
  metadata <- filter(gltc_metadata, tolower(Lake.name) == tolower(lake_name))
  c_i <- which((tolower(names(metadata)) %in% tolower(metadata_name)))
  
  if (length(c_i) == 0){
    stop('variable "', metadata_name,'" not found in GLTC metadata')
  }
  if (length(metadata_name) == 1){
      metadata <- metadata[[c_i]]
  } else {
      metadata <- metadata[c_i]
  }
  
  return(metadata)
}