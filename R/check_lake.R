check_lake <- function(lake_name){
  
  if (!tolower(lake_name) %in% tolower(get_lake_names())){
    stop(paste0('lake_name=', lake_name, ' not recognized in GLTC dataset'))
  }
}