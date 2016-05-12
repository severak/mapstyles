# -*- coding: utf-8 -*-
import overpass

pt_track_q = """// public transport stops CZ
(
  area[name="Česko"]->.cz;
  node(area.cz)["public_transport"="stop_position"];
  node(area.cz)["highway"="bus_stop"];
  node(area.cz)["amenity"="bus_station"];
  node(area.cz)["amenity"="ferry_terminal"];
);
out body geom;
>;"""

api = overpass.API(timeout=360)
response = api.Get(pt_track_q)

for feature in response.features:
	props = {}
	if 'name' in feature.properties:
		props['name'] = feature.properties['name']
	
	feature.properties = props
print(response)
