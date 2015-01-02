infile1  <- "https://pasta.lternet.edu/package/data/eml/knb-lter-ntl/10001/1/6e52deaa45c1695e7742c923ba04d16b" 
infile1 <- sub("^https","http",infile1) 
gltc_values <-read.csv(infile1, 
                   ,skip=1
                   ,sep=","  
                   , col.names=c(
                     "recordID",     
                     "variable",     
                     "year",     
                     "siteID",     
                     "value"    ), check.names=TRUE,
                   stringsAsFactors = FALSE)


infile2  <- "https://pasta.lternet.edu/package/data/eml/knb-lter-ntl/10001/1/6167b9938e8dc99e9ee75251c70776a9" 
infile2 <- sub("^https","http",infile2) 
gltc_metadata <-read.csv(infile2, 
                     ,skip=1
                     ,sep=","  
                     ,quot='"' 
                     , col.names=c(
                       "siteID",     
                       "Lake.name",     
                       "Other.names",     
                       "lake.or.reservoir",     
                       "location",     
                       "region",     
                       "latitude",     
                       "longitude",     
                       "elevation.m",     
                       "mean.depth.m",     
                       "max.depth.m",     
                       "surface.area.km2",     
                       "volume.km3",     
                       "source",     
                       "sampling.depth",     
                       "time.period",     
                       "contributor"    ), check.names=TRUE,
                     stringsAsFactors = FALSE)


save(gltc_metadata, file = '~/Documents/R/laketemps/data/gltc_metadata.rda', compress = TRUE)
save(gltc_values, file = '~/Documents/R/laketemps/data/gltc_values.rda', compress = TRUE)


