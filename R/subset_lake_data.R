subset_lake_data = function(lake_name, types){
  
  data(gltc_values)
  check_lake(lake_name)
  
  
  
  df = tryCatch({
    df <- filter(gltc_values, variable %in% types, siteID == get_site_ID(lake_name)) %>%
      select(variable, year, value) %>% 
      acast(year ~ variable)
    df <- cbind(data.frame(year = as.numeric(row.names(df))), df)
    
    rownames(df) <- NULL
  }, error = function(e) {
    return(NULL)
  })

  return(df)
}