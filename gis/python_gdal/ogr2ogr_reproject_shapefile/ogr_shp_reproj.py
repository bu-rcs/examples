# -*- coding: utf-8 -*-
"""
Author: Dennis Milechin
Created: 4/17/2020
Description: Converts all Shapefile projection to WGS Web Mercator Projection for a given directory shp_path.
"""

import gdal
import os
import subprocess
gdal.UseExceptions()

# INPUTS

shp_path = 'data/'              # Location of Shapefiles that need to be reprojected
output_path = 'output/'   		# Location to save outputs

# Specify new coordinate system
newRef = 'EPSG:4326'  # WGS84 Web Mercator Projection

# SCRIPT

# List all files in shp_path
files = os.listdir(shp_path)

# Loop through the files
for file in files:
    
    # Only proceed if file has .hdf extension
    if file.endswith(".shp"):
        print("processing: ", file)
		
        path_to_file = os.path.join(shp_path, file)

        # Create output filenames for GeoTiffs
        output_filename =  os.path.splitext(file)[0] + "_proj.shp"

        # Assemble full path for output files
        output_fullpath = os.path.join(output_path, output_filename)
        
		# Python gdal API does not have a wrapper for ogr2ogr command, so this
		# will be executed as a subprocess.
		# Below the ogr2ogr CLI command is assembled.
        ogr2ogr_cmd = 'ogr2ogr -f "ESRI Shapefile" -t_srs "' +newRef + '" '+ output_fullpath+ " " +path_to_file
        
        print("Executing command: " + ogr2ogr_cmd)
        print("\n")
        
		# Execute sub-process
        process = subprocess.check_call(ogr2ogr_cmd,stdout=subprocess.PIPE)
        

