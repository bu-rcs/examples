####
# This R script reads 2014 national county shapefile for the United States,
# and filters for Massachusetts data.  Writes the county names of Massachusetts to the
# console and then saves the filtered results to a new shapefile called "massachusetts".
####

library(rgdal)

# Read Shapefile
SHP_file <- readOGR(dsn="data", "cb_2014_us_county_5m")

# Select data associated with Massachusetts by filtering for FIPS code 25.
state <- SHP_file[SHP_file@data$STATEFP=="25",]

print("Counties in Massachusetts")

# Display the county names in Massachusetts
for(cnt_name in state$NAME){
	print(cnt_name)
}

# Save the filtered results to a shapefile.
writeOGR(obj=state, dsn="output", layer="massachusetts", driver="ESRI Shapefile")


