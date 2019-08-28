from osgeo import ogr, osr, gdal


driver = ogr.GetDriverByName("ESRI Shapefile")
shapefile='/project/scv/examples/EE/R/data/cb_2014_us_county_5m.shp'
dataSource = driver.Open(shapefile, 0)
layer = dataSource.GetLayer()

layer.SetAttributeFilter("STATEFP = '33'")

for feature in layer:
    geom = feature.GetGeometryRef()
    print geom.Centroid().ExportToWkt()





