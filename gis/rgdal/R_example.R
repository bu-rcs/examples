library(rgdal)

# Read Shapefile
SHP_file <- readOGR(dsn="data", "cb_2014_us_county_5m")

# Select NH only
state <- SHP_file[SHP_file@data$STATEFP=="33",]

# Save filtering
writeOGR(obj=state, dsn="output", layer="State_33", driver="ESRI Shapefile")


