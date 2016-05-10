# -*- coding: utf-8 -*-
import overpass

pt_track_q = """// trolejbusy a tramvaje CZ
(
  area[name="Česko"]->.cz;
  way(area.cz)["trolley_wire"];
  way(area.cz)["railway"="tram"];
);
out body geom;
>;"""

api = overpass.API(timeout=360)
response = api.Get(pt_track_q)

for feature in response.features:
	props = {}
	
	props['class'] = 'none'
	if 'railway' in feature.properties and  feature.properties['railway']=='tram':
		props['class']='tram'
	if 'trolley_wire' in feature.properties:
		props['class']='trolleybus'
	if 'railway' in feature.properties and feature.properties['railway']=='tram' and 'trolley_wire' in feature.properties:
		props['class']='both'
	
	props['structure'] = 'none'
	if 'bridge' in feature.properties and feature.properties['bridge']!='no':
		props['structure']='bridge'
	if 'tunnel' in feature.properties and feature.properties['tunnel']!='no':
		props['structure']='tunnel'
		
	props['is_separated'] =  not 'highway' in feature.properties
	
	feature.properties = props

print(response)