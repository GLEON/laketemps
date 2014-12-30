#'@title get climate data according to lake name from GLTC dataset
#'@param lake_name a valid name of a lake in the GLTC dataset
#'@param types name for the climate data.
#'@return a lake data.frame, or NULL if no data exist
#'@export
#'@examples
#'get_climate_names()
#'get_climate('Victoria', 'SWdown_Summer')
#'get_climate('Mendota')
get_climate <- function(lake_name, types = 'all'){
  
  data(gltc_climate)
  check_lake(lake_name)
  
  if (types[1] == "all" & length(types)==1){
    types <- get_climate_names()
  }
  
  time_un <- c()
  
  for (i in 1:length(types)){
    time_un <- unique(c(time_un, gltc_climate[[lake_name]][[types[i]]][[1]]))
  }
  df <- data.frame(x = time_un)
  names(df) <- names(gltc_climate[[lake_name]][[types[1]]][1])
  fau_vec <- vector('numeric',nrow(df))*NA
  
  for (i in 1:length(types)){
    df_bnd <- data.frame(x=fau_vec)
    colnames(df_bnd) <- make.names(types[i])
    time <- gltc_climate[[lake_name]][[types[i]]][[1]]
    u_i <- which(df[,1] %in% time)
    df_bnd[u_i, ] <- gltc_climate[[lake_name]][[types[i]]][[2]]
    df <- cbind(df,df_bnd)
    
  }
  
  
  if (is.null(df)){
    return(NULL)
  } else {
    return(df)
  }
  
}