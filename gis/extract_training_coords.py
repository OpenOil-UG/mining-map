import json
from subprocess import Popen, PIPE, STDOUT
from landsat.search import Search

# disable these nasty 'insecure platform' warnings:
import urllib3
urllib3.disable_warnings()

ls = Search()

ls_search_results_all = []

geojson = json.loads(open('osm/centroids-test.geojson').read())

features = geojson['features']

for f in features:
    lat = str(f['geometry']['coordinates'][1])
    lon = str(f['geometry']['coordinates'][0])
    #id  = f['properties']['@id']

    scenes = ls.search(lat=lat, lon=lon, cloud_max=10, limit=200)

    # check if there are results
    if scenes.has_key('results'):
        # choose result with least cloud cover
        scene_chosen = min(scenes['results'], key=lambda x: x['cloud'])
        ls_search_results_all.append(scene_chosen)

        # download and clip
        params={
            'dest': 'gis/landsat',
            'scene': scene_chosen['sceneID'],
            'lon_min': float(lon)-0.02,
            'lon_max': float(lon)+0.02,
            'lat_min': float(lat)-0.02,
            'lat_max': float(lat)+0.02
        }

        cmd = '''landsat download {scene} -p --pansharpen --clip={lon_min},{lat_min},{lon_max},{lat_max}'''.format(**params)

        p = Popen(cmd, shell=True, stdin=PIPE, stdout=PIPE, stderr=STDOUT, close_fds=True)
        output = p.stdout.read()
        print output

    else:
        pass
