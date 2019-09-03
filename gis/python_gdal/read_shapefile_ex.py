#!/usr/bin/env python

####
# This Python script reads 2014 national county shapefile for the United States,
# and filters for Massachusetts data.  Writes the county names of Massachusetts to the
# console and then saves the filtered results to a new shapefile called "massachusetts".
####

# Import ogr libraries
from osgeo import ogr
ogr.UseExceptions()

# Need to specify driver to open file.  In this example it is an "ESRI Shapefile".
driver = ogr.GetDriverByName("ESRI Shapefile")

# Path to the shapefile
shapefile='/projectnb/scv/milechin/git/examples/gis/python_gdal/data/cb_2014_us_county_5m.shp'

# Open the shapefile
layer_conn = driver.Open(shapefile, 0)
layer = layer_conn.GetLayer()

# Set filter to extract the polygon representing the 
# state of Massachusetts using FIPS code 25.
layer.SetAttributeFilter("STATEFP='25'")

# Print the counties in the state of Massachusetts
print("Counties in State:")
for feature in layer:
    print(feature.GetField("NAME"))

# Create shapefile for output
out_driver = ogr.GetDriverByName('ESRI Shapefile')
out_layer = driver.CreateDataSource("MA_counties.shp")

# Copy filtered data to the new shapefile
out_layer.CopyLayer(layer, 'massachusetts')









