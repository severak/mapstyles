-- after zoom level 12, stroke width is scaled by 1.5 ^ (12-zoom).

print '## mapsforge stroke size table'

for zoom=12,15 do
	print('## zoom '..zoom)
	print ''
	print '| stroke size | resulting size |'
	print '| --- | --- |'
	for px=1,15 do
		print('| '..string.format('%0.2f', px * math.pow(1.5, 12-zoom) )..' | '..px..' |')
	end
	print ''
end