import json
import subprocess

geojson = json.loads(open('osm/centroids.geojson').read())

features = geojson['features']

for f in features:
    lat = str(f['geometry']['coordinates'][0])
    lon = str(f['geometry']['coordinates'][1])

    subprocess.call('landsat', 'search', '--cloud 1', '--lat', lat, '--lon', lon)
