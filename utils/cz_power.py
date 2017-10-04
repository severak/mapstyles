# -*- coding: utf-8 -*-
import overpass

pt_track_q = """// public transport stops CZ
(
  area[name="Česko"]->.cz;
  way(area.cz)["power"="line"];
  node(area.cz)["power"="tower"];
  node(area.cz)["power"="plant"];
  way(area.cz)["power"="plant"];
);
out body geom;
>;"""

api = overpass.API(timeout=360)
response = api.Get(pt_track_q)

for feature in response.features:
	props = {}
	if 'power' in feature.properties:
		props['power'] = feature.properties['power']
	if 'name' in feature.properties:
		props['name'] = feature.properties['name']
	feature.properties = {}
print(response)
