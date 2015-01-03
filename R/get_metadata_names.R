#'@title get metadata names in GLTC dataset
#'@param lake_name
#'@return a character vector of valid metadata variable names for all lakes. 
#'If lake_name is specified, only the metadata fields populated for lake_name 
#'are returned. 
#'@seealso \code{\link{get_metadata}}, \code{\link{get_climate_names}}, \code{\link{get_lake_names}},
#'@examples
#'get_metadata_names()
#'get_metadata_names('Victoria')
#'@export
get_metadata_names <- function(lake_name = NULL){
  data(gltc_metadata)
  
  if (is.null(lake_name)){
    metadata_vars <- names(gltc_metadata)
  } else {
    data <- filter(gltc_metadata, siteID == get_site_ID(lake_name))
    # empty data is '' ##
    u_i <- data[1,] != ''
    metadata_vars <- colnames(data[,u_i])
  }

  return(metadata_vars)
}