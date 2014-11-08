
get_data <- function(lines, delim, row_names, lake_names, data_match){
  lines <- lines[row_names == data_match]
  ncol <- length(lake_names)
  data = matrix(nrow = length(lines), ncol = ncol)
  for (j in 1:length(lines)){
    vals <- str_split(lines[j], delim)[[1]][-2:-1]
    na_i <- vals =='NA' | vals == ''
    vals[na_i] <- NA
    vals[!na_i] <- vals[!na_i]
    data[j, ] <- as.numeric(vals)
  }
  return(data)
}

get_time <- function(lines, delim, row_names, data_match){
  lines <- lines[row_names == data_match]
  time = vector(mode = 'numeric', length= length(lines))
  for (j in 1:length(lines)){
    time[j] <- as.numeric(str_split(lines[j], delim)[[1]][2])
  }
  return(time)
}

build_lake_list <- function(situ_time, situ_data, sat_time, sat_data, lake_names){
  
  lake_data = vector("list", length(lake_names))
  names(lake_data) <- lake_names
  
  for (i in 1:length(lake_names)){
    
    lake_data[[i]] <- list('surface_temps'=list('in_situ' = NULL, 'satellite' = NULL))
    
    situ_temps <- situ_data[, i]
    u_i <- !is.na(situ_temps)

    if (any(u_i)){
      lake_data[[i]]$surface_temps$in_situ <- list('temperature' = situ_temps[u_i], 'year' = situ_time[u_i])
    }
    
    sat_temps <- sat_data[, i]
    u_i <- !is.na(sat_temps)
    if (any(u_i)){
      lake_data[[i]]$surface_temps$satellite <- list('temperature' = sat_temps[u_i], 'year' = sat_time[u_i])
    }
    
  }
  return(lake_data)
}

build_climate <- function(lines, delim, row_names, lake_names){
  lake_data = vector("list", length(lake_names))
  names(lake_data) <- lake_names
  
  match_names <- c("NCEP 3 month (WINTER)", "NCEP 3 month", "NCEP Annual", "SWdown_Summer", "SWdown_Winter",
                   "Lwdown_Summer", "LWdown_Winter", "Rtot_Summer", "Rtot_Winter", "SWdown_Summer_weighted",
                   "SWdown_Winter_weighted", "LWdown_Summer_weighted", "LWdown_Winter_weighted",
                   "Rtot_Summer_weighted","Rtot_JAS_weighted","Rtot_Winter_weighted", "SWdown_Ann",
                   "LWdown_Ann","Rtot_Ann","SWdown_Ann_weighted","LWdown_Ann_weighted","Rtot_Ann_weighted",
                   "PATMOS_Clouds_Summer","PATMOS_Clouds_Winter","PATMOS_Clouds_Annual","CRU 3 month Tmax 9C",
                   "CRU Annual Tmax 9C","CRU Winter Tmax 9C","CRU WINTER Tmax 9C","CRU 3 month Tmean 9C",
                   "CRU Annual Tmean 9C","CRU WINTER Tmean 9C","CRU 3 month Tmin 9C","CRU Annual Tmin 9C",
                   "CRU WINTER Tmin 9C","CRU 3 month DTR 9C","CRU Annual DTR 9C","CRU WINTER DTR 9C",
                   "CRU 3 month Tmax 1C","CRU Annual Tmax 1C","CRU WINTER Tmax 1C","CRU 3 month Tmean 1C",
                   "CRU Annual Tmean 1C","CRU WINTER Tmean 1C","CRU 3 month Tmin 1C","CRU Annual Tmin 1C",
                   "CRU WINTER Tmin 1C","CRU 3 month DTR 1C","CRU Annual DTR 1C","CRU WINTER DTR 1C")
  for (j in 1:length(lake_names)){
    lst <- vector('list', length = length(match_names))
    names(lst) <- match_names
    lake_data[[j]] <- lst
  }
  for (i in 1:length(match_names)){
    val_name <- match_names[i]
    data <- get_data(lines, delim, row_names, lake_names, data_match = val_name)
    time <- get_time(lines, delim, row_names, data_match = val_name)
    for (k in 1:length(lake_names)){
      dat_sub <- data[, k]
      u_i <- !is.na(dat_sub)
      if (any(u_i)){
        lake_data[[k]][[val_name]] <- list('time' = time[u_i], 'value' = data[u_i, k])
      } # else stays NULL
      
    }
  }
  return(lake_data)
  
}
get_metadata <- function(lines, delim, row_names, lake_names){
  
  lines <- lines[row_names == "metadata"]
  
  ncol <- length(lake_names)
  metadata = vector("list", ncol)
  names(metadata) <- lake_names
  data = matrix(nrow = length(lines), ncol = ncol)
  m_names <- vector(length = length(lines))
  for (j in 1:length(lines)){
    vals <- str_split(lines[j], delim)[[1]][-2:-1]
    na_i <- vals =='NA' | vals == '' | vals == ' '
    vals[na_i] <- NA
    num_vals <- tryCatch(as.numeric(vals[!na_i]),warning=function(w) return(vals[!na_i]))
    vals[!na_i] <- num_vals

    data[j, ] <- vals # this goes back to strings...
    # here should try numeric...
    m_names[j] <- str_split(lines[j], delim)[[1]][2]
  }
  
  for (i in 1:length(lake_names)){
    m_data <- data[, i]
    na_i <- is.na(m_data) | m_data == '' | m_data == ' '
    m_data[na_i] <- NA
    df_data = matrix(m_data, nrow=1)
    df <- as.data.frame(df_data, stringsAsFactors = FALSE)

    colnames(df) <- make.names(m_names)
    
    metadata[[i]] <- df
  }

  return(metadata)
}

get_row_names <- function(lines, delim){
  row_names <- vector('character',length= length(lines))
  
  for (j in 1:length(lines)){
    row_names[j] <- str_split(lines[j], delim)[[1]][1]
  }
  return(row_names)
}

get_lake_names <- function(lines, delim, row_names){
  u_i <- row_names == 'Data.type'
  lake_names <- str_split(lines[u_i], delim)[[1]][-2:-1]
  return(lake_names)
}

library(stringr)

con <- file('~/Documents/R/laketemps/inst/extdata/Master_2014-07-18-1.txt', "r", blocking = FALSE)
delim = '\t'
lines <- readLines(con)
close(con)

row_names <- get_row_names(lines, delim)
lake_names <- get_lake_names(lines, delim, row_names)
gltc_metadata <- get_metadata(lines, delim, row_names, lake_names)
gltc_climate <- build_climate(lines, delim, row_names, lake_names)

situ_data <- get_data(lines, delim, row_names, lake_names, data_match = "In situ")
situ_time <- get_time(lines, delim, row_names, data_match = "In situ")

sat_data <- get_data(lines, delim, row_names, lake_names, data_match = "Satellite")
sat_time <- get_time(lines, delim, row_names, data_match = "Satellite")

# lake_data is the list of the lat, lon, time and temp for each lake.
gltc_temperature <- build_lake_list(situ_time, situ_data, sat_time, sat_data, lake_names)
save(gltc_temperature, file = '~/Documents/R/laketemps/data/gltc_temperature.rda', compress = TRUE)

save(gltc_metadata, file = '~/Documents/R/laketemps/data/gltc_metadata.rda', compress = TRUE)

save(gltc_climate, file = '~/Documents/R/laketemps/data/gltc_climate.rda', compress = TRUE)

