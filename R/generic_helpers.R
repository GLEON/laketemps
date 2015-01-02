get_site_ID <- function(lake_name){
  siteID <- get_metadata(lake_name, 'siteID')
  return(siteID)
}

temp_types = function(){
  return(c('Satellite','In situ'))
}