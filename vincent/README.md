# Vincent

Very simple style focused on railways. 

Possible use cases: those screens in the train showing you map around the train, railfan websites etc.

Not usable above zoom 10 yet.

## specification

- background `#eee8d5`
- forests (also scrub,orchard,park,cemetery) `#CAEDAB`
- water `#7BAFDE` 2px width
- buildings `#D6C1DE`
- track `#F6C141` (track,path,unclassified) 1px width dashed 2/2
- minor roads `#F6C141` (living_street,service,road,residential,cycleway,taxiway) 1px width
- major roads `#F6C141` (link,motorway,motorway_link,primary,secondary,tertiary,trunk,runway) (2px width)
- railway `#000000`
- trams `#ff0000`
- water names - `#7BAFDE` 10px italic
- secondary place names (hamlet,suburb,quarter) - black 10px
- place names (capital,state_capital,city,town,village) - black 13px CAPS LOCK
- street name (black 10px)
- tram or bus name (red 10px)
- railway stop name (black 13px)

Labels priority - railway stations > bus/tram stations > streets > place names > secondary place names.