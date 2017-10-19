-- fce pro definici mapy

local push = table.insert


local mapdef = {
	rules = {},
	ANY = {}
}

_G.ANY = mapdef.ANY

function _G.line(def)
	def._type = 'line'
	def.color = def.color or error 'Missing color!'
	def.feat = def.feat or error 'Missing feat!'
	
	push(mapdef.rules, def)
end

function _G.area(def)
	def._type = 'area'
	def.color = def.color or error 'Missing color!'
	def.feat = def.feat or error 'Missing feat!'
	
	push(mapdef.rules, def)
end

return mapdef
