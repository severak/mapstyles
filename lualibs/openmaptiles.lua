local omt = {}
local json = require 'dkjson'
local mapdef = require 'mapdef'
local push = table.insert

local style_tmp = [[
{
  "version": 8,
  "name": "mapdef template",
  "center": [
    8.542,
    47.372
  ],
  "zoom": 11.6,
  "bearing": 0,
  "pitch": 0,
  "sources": {
    "openmaptiles": {
      "type": "vector",
      "url": "https://api.maptiler.com/tiles/v3/tiles.json?key=lFBi7gs1S6TyJPtVVvOX"
    }
  },
  "sprite": "https://cloud.maptiler.com/api/sprites/562ae42d-8e03-483e-b83b-2eba8f700b89",
  "glyphs": "https://api.maptiler.com/fonts/{fontstack}/{range}.pbf?key=lFBi7gs1S6TyJPtVVvOX",
  "layers": []
}
]]

function make_filter(rule)
	local ANY = mapdef.ANY
	local feat = rule.feat
	
	local is_class_like = {railway=true, highway=true}
	local geom_type = {line='LineString', area='Polygon'}
	
	local all = {'all', {"in", "$type", geom_type[rule._type] }}

	for key, val in pairs(feat) do
		if val==mapdef.ANY then
			
			
			
			-- push(all, {'has', })
			
		elseif type(val)=='string' then
			
			if is_class_like[key] then
				push(all, {'==', 'class', val})
			end
			
		elseif type(val)=='table' then
		
			if is_class_like[key] then
				
				local fin = {'in', 'class'}
				
				for subval,_ in pairs(val) do
					push(fin, subval)
				end
			
				push(all, fin)
			end
		
			
		end
	end
	
	return all
end

function guess_source(rule)
	if rule.feat.railway or rule.feat.highway then
		return {source="openmaptiles", ['source-layer']='transportation'}
	end
	
	if rule.feat.waterway and rule._type=='area' then
		-- speciální případ
		return {source="openmaptiles", ['source-layer']='water'}
	end
	
	if rule.feat.waterway then
		return {source="openmaptiles", ['source-layer']='waterway'}
	end
	
	if rule.feat.building then
		return {source="openmaptiles", ['source-layer']='building'}
	end
end

function omt.style()
	local ret = json.decode(style_tmp)
	
	if mapdef.name then
		ret.name = mapdef.name
	end
	
	if mapdef.background then
		push(ret.layers, {id='background', type='background', paint={['background-color']=mapdef.background}})
	end
	
	for idx, rule in ipairs(mapdef.rules) do
	
		if rule._type=='line' and guess_source(rule) then
			local draw = guess_source(rule)
			draw.id='idx'..idx
			draw.type='line'
			draw.paint={ ['line-color']=rule.color }
			if rule.width then
				draw.paint['line-width'] = rule.width
			end
			if rule.dashing then
				draw.paint['line-dasharray'] = rule.dashing
			end
			
			draw.filter = make_filter(rule)
			
			push(ret.layers, draw)
		end
		
		if rule._type=='area' and guess_source(rule) then
			local draw = guess_source(rule)
			draw.id='idx'..idx
			draw.type='fill'
			draw.paint = {['fill-color']=rule.color}
			
			draw.filter = make_filter(rule)
			
			push(ret.layers, draw)
		end
	end
	
	
	local fh = io.open('style.json', 'w+')
	fh:write(json.encode(ret, {indent=true}))
	fh:close()
end

return omt