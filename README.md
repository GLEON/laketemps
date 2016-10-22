laketemps
=========

Lake temperature data package for [Global Lake Temperature Collaboration Project](www.laketemperature.org)

[![Build status](https://ci.appveyor.com/api/projects/status/314c58ibg5351g0n?svg=true)](https://ci.appveyor.com/project/jread-usgs/laketemps)

# Installation

## Stable version from CRAN

`install.packages("laketemps")`

## Development version from Github

`devtools::install_github("USGS-R/laketemps")`

# Usage

`library(laketemps)`

`load("R/sysdata.rda")`

`get_lake_names()`

`get_surface_temps('Mendota','Lake.Temp.Summer.InSitu')`


# References

`citation('laketemps')`
