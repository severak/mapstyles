local mapdef = require "mapdef"
local push = table.insert
local legend = {}


function legend.html(rulez)
	local lines_by_feat = {}
	
	for idx, rule in ipairs(mapdef.rules) do
		if rule._type=='line' then
			if not lines_by_feat[rule.feat] then
				lines_by_feat[rule.feat] = {}
			end
			push(lines_by_feat[rule.feat], rule)
		end
	end
	

	local rfile = 'legend.html'
	-- rulez.file = nil
	
	local fh = io.open(rfile, 'w+')
	
	fh:write [[
<!DOCTYPE html>
<html><head>
	<meta http-equiv="content-type" content="text/html; charset=UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<title>Legenda</title>
</head>
<body>

<table>]]
	
	for idx, rule in ipairs(mapdef.rules) do
		if rule.desc then
		
			fh:write '<tr><td>'
			
			fh:write '<svg xmlns="http://www.w3.org/2000/svg" width="30" height="30">'
			
			if rule._type=='area' then
				fh:write('<rect width="30" height="30" fill="' .. rule.color .. '" />')
			end
			
			if rule._type=='line' then
				for feat, subrules in pairs(lines_by_feat) do
					
					if feat==rule.feat then
						for _, _r in ipairs(subrules) do
							fh:write('<path d="M0,15 L30,15" stroke="' .. _r.color .. '" ')
						
							if _r.width then
								fh:write('stroke-width="' .. _r.width .. '" ')
							end
			
							if _r.dashing then
								fh:write('stroke-dasharray="' .. table.concat(_r.dashing, ',') .. '" ')
							end
						
							fh:write ' />'
						end
					end
					
				end
				
				
			end
			
			fh:write '<rect width="30" height="30" stroke="#000000" fill="none" />'
			
			fh:write '</svg>'
			
			fh:write '</td><td>'
			fh:write(rule.desc)
			fh:write '</td></tr>'

		
		end
		
		
	end
	
	
fh:write [[
</table>
</body>
</html>]]
	
	fh:close()
end

return legend