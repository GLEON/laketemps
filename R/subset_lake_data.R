subset_lake_data = function(lake_name, types){
  
  check_lake(lake_name)  
  
  # -- fix for R CMD check 'no visible binding for global variable'
  siteID <- "_private"
  variable <- "_private"
  year <- "_private"
  value <- "_private"
  # -- fix for R CMD check 'no visible binding for global variable'
  
  df = tryCatch({
    df <- filter(gltc_values, tolower(variable) %in% tolower(types), siteID == get_site_ID(lake_name)) %>%
      select(variable, year, value) %>% 
      acast(year ~ variable)
    df <- cbind(data.frame(year = as.numeric(row.names(df))), df)
    
    rownames(df) <- NULL
    df
  }, error = function(e) {
    return(NULL)
  })

  return(df)
}