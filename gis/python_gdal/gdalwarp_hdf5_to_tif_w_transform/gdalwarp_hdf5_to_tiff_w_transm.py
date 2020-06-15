#!/usr/bin/env python
# -*- coding: utf-8 -*-
"""
Created: 4/17/2020
Author: Dennis Milechin
Description: Extracts NDVI and EVI data from MOD13Q1 product HDF files and 
            saves each subset as Geotiff in a new projection.
"""

import gdal
import os
gdal.UseExceptions()

######### INPUTS ########

hdf_path = 'data/'              # Location of HDF files
output_path = 'output/'   # Location to save GeoTiff files

# Specify new coordinate system
newRef = 'EPSG:4326'  # WGS84 Web Mercator Projection


######### SCRIPT ########

# List all files in hdf_path
files = os.listdir(hdf_path)

# Loop through the files
for file in files:
    
    # Only proceed if file has .hdf extension
    if file.endswith(".hdf"):
        print("processing: ", file)
		
        path_to_file = os.path.join(hdf_path, file)

        # Open hdf file
        hdf_file = gdal.Open(path_to_file, gdal.GA_ReadOnly)
        
        # Define the index location for NDVI and EVI in the HDF file
        NDVI_subset_index = 0
        EVI_subset_index = 1
        
        # Extract the subset data NDVI and EVI
        hdf_NDVI = gdal.Open(hdf_file.GetSubDatasets()[NDVI_subset_index][0], gdal.GA_ReadOnly)
        hdf_EVI = gdal.Open(hdf_file.GetSubDatasets()[EVI_subset_index][0], gdal.GA_ReadOnly)

        # Create output filenames for GeoTiffs
        output_NDVI_filename = os.path.splitext(file)[0] + "_NDVI.tif"
        output_EVI_filename = os.path.splitext(file)[0] + "_EVI.tif"
        
        # Assemble full path for output files
        output_NDVI_fullpath = os.path.join(output_path, output_NDVI_filename)
        output_EVI_fullpath = os.path.join(output_path, output_EVI_filename)

        # Use gdal warp to apply projection transformation and save file as GeoTiff
        print("Saving: " + output_NDVI_fullpath)
        gdal.Warp(output_NDVI_fullpath, hdf_NDVI, dstSRS=newRef)
        
        print("Saving: " + output_EVI_fullpath)
        gdal.Warp(output_EVI_fullpath, hdf_NDVI, dstSRS=newRef)

