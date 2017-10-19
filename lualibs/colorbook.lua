-- generuje CSS kompatibilní s http://severak.github.io/colorbook/

local mapdef = require "mapdef"

local push = table.insert
local colorbook = {}

local function feat2selector(dtype, feat)
	local ret = {}
	for key, val in pairs(feat) do
		if val==mapdef.ANY then
			push(ret, '.' .. dtype .. '.tag-' .. key)
		elseif type(val)=='string' then
			push(ret, '.' .. dtype .. '.tag-' .. key .. '-' .. val)
		elseif type(val)=='table' then
			for subval,_ in pairs(val) do
				push(ret, '.' .. dtype .. '.tag-' .. key .. '-' .. subval)
			end
		end
	end
	return table.concat(ret, ', ')
end

function colorbook.css(fname)

	local line_is_casing = {}

	local fh = io.open(fname, 'w+')
	
	fh:write '/* autogenerated - do not edit by hand */ \n'
	
	fh:write('/* hide tunnel*/ \n')
	fh:write('.tag-tunnel { display: none; } \n')
	
	for idx, rule in ipairs(mapdef.rules) do
		fh:write('/* r#' .. idx .. '*/ \n')
		
		if rule._type=='line' then
			local ltype = 'casing'
			
			if line_is_casing[rule.feat] then
				ltype = 'stroke'
			end
			
			fh:write(feat2selector(ltype, rule.feat) .. ' { stroke: ' .. rule.color .. '; ' )
			
			if rule.width then
				fh:write('stroke-width: ' .. rule.width .. '; ')
			end
			
			if rule.dashing then
				fh:write('stroke-dasharray: ' .. table.concat(rule.dashing, ',') .. '; ')
			end
			
			
			fh:write(' }\n')
			
			line_is_casing[rule.feat] = true
			
		end
		
		if rule._type=='area' then
			
			fh:write(feat2selector('fill', rule.feat) .. ' { fill: ' .. rule.color .. '; ' )
			
			
			fh:write(' }\n')
			
			line_is_casing[rule.feat] = true
			
		end
		
		
	end
	
	
	
	fh:close()
end

return colorbook