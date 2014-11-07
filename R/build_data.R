
get_data <- function(line, delim = ',', ncol){
  
  data = matrix(nrow = length(line), ncol = ncol)
  for (j in 1:length(line)){
    vals <- str_split(line[j], delim)[[1]][-2:-1]
    na_i <- vals =='NA' | vals == ''
    vals[na_i] <- NA
    vals[!na_i] <- vals[!na_i]
    data[j, ] <- as.numeric(vals)
  }
  return(data)
}

get_time <- function(line, delim = ','){
  time = vector(mode = 'numeric', length= length(line))
  for (j in 1:length(line)){
    time[j] <- as.numeric(str_split(line[j], delim)[[1]][2])
  }
  return(time)
}

build_lake_list <- function(situ_time, situ_data, sat_time, sat_data, lake_names, lat, lon, region){
  
  lake_data = vector("list", length(lake_names))
  names(lake_data) <- lake_names
  
  for (i in 1:length(lake_names)){
    
    lake_data[[i]] <- list('surface_temps'=list('in_situ' = NULL, 'satellite' = NULL), 
                           'lat'=lat[i],'lon'=lon[i], 'region' = region[i])
    
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


library(stringr)

con <- file('~/Documents/R/laketemps/inst/extdata/Master_2014-07-18-1.csv', "r", blocking = FALSE)
delim = ','

line <- readLines(con, n = 1)
lake_names <- str_split(line, delim)[[1]][-2:-1]
line <- readLines(con, n = 3) # code, etc
line <- readLines(con, n = 1)
region <- str_split(line, delim)[[1]][-2:-1]
line <- readLines(con, n = 1)
lat <- as.numeric(str_split(line, delim)[[1]][-2:-1])
line <- readLines(con, n = 1)
lon <- as.numeric(str_split(line, delim)[[1]][-2:-1])
line <- readLines(con, n = 14) # skip metadata
line <- readLines(con, n = 115)

situ_data <- get_data(line, ncol = length(lake_names))
situ_time <- get_time(line)

line <- readLines(con, n = 105)
line <- readLines(con, n = 27)
close(con)

sat_data <- get_data(line, ncol = length(lake_names))
sat_time <- get_time(line)

# lake_data is the list of the lat, lon, time and temp for each lake.
lake_data <- build_lake_list(situ_time, situ_data, sat_time, sat_data, lake_names, lat, lon, region)
save(lake_data, file = '~/Documents/R/laketemps/data/lake_data.rda', compress = TRUE)


