function read_file(fname)
	local fh = io.open(fname, 'r')
	local text = fh:read('*a')
	fh:close()
	return text
end

function resize_w(px, zoom)
	return string.format('%0.3f', px * math.pow(1.5, 12-zoom) )
end

local header = [[
<?xml version="1.0" encoding="UTF-8"?>
<rendertheme xmlns="http://mapsforge.org/renderTheme" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:schemaLocation="http://mapsforge.org/renderTheme ../renderTheme.xsd" version="1" map-background="#F8F8F8">
]]

local footer = [[
</rendertheme>
]]

local template = read_file('body.txt')

local outp = io.open('czmil.xml', 'w+')
outp:write(header)

for zoom=12,15 do
	local tmp = template
	
	tmp = string.gsub(tmp, 'width="(%d+)"', function(px) return 'width="' .. resize_w(px, zoom)..'"'  end)
	-- tmp = string.gsub(tmp, 'dasharray="(%d+), (%d+)"', function(a,b) return 'dasharray="' .. resize_w(a, zoom) .. ', ' .. resize_w(b, zoom) .. '"'  end)
	
	outp:write('<rule e="any" k="*" v="*" ')
	if zoom>12 then
		outp:write('zoom-min="'..zoom..'" ' )
	end
	if zoom<15 then
		outp:write('zoom-max="'..zoom..'" ' )
	end
	outp:write('>\n')
	
	
	outp:write(tmp .. '\n')
	outp:write('</rule>\n\n')
end

outp:write(read_file('tail.txt'))
outp:write(footer)
outp:close()