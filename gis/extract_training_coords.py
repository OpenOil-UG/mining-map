import json
import subprocess
from landsat.search import Search

# disable these nasty 'insecure platform' warnings:
import urllib3
urllib3.disable_warnings()

ls = Search()

ls_search_results_all = []

geojson = json.loads(open('osm/centroids.geojson').read())

features = geojson['features']

for f in features:
    lat = str(f['geometry']['coordinates'][0])
    lon = str(f['geometry']['coordinates'][1])
    #id  = f['properties']['@id']

    scenes = ls.search(lat=lat, lon=lon, cloud_max=100, limit=200)

    # check if there are results
    if scenes.has_key('results'):
        # choose result with least cloud cover
        scene_chosen = min(scenes['results'], key=lambda x: x['cloud'])
        ls_search_results_all.append(scene_chosen)

    else:
        pass

print ls_search_results_all
