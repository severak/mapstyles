package.path = '../lualibs/?.lua;' .. package.path

require 'mapdef'
local colorbook = require 'colorbook'
local legend = require 'legend'
local openmaptiles = require 'openmaptiles'

-- možné prvky

-- TODO: nehádat filtry v openmaptiles, ale mít je přímo napsané zde:

local F_WATER = {waterway=ANY, landuse='reservoir'}
local F_BUILDING = {building=ANY}
local F_FOREST = {landuse='forest'}

local F_RAIL = {railway='rail'}
local F_TRAM = {railway='tram', railway='transit'}

local F_ROAD_MAJOR = {highway={motorway=true, major=true, primary=true, secondary=true, tertiary=true, trunk=true, primary_link=true, secondary_link=true, tertiary_link=true, trunk_link=true}}

local F_ROAD_MINOR = { highway={minor=true, residential=true, service=true, path=true} }

local F_FOOTWAY = { highway={footway=true, pedestrian=true}}

local F_STEPS = { highway={steps=true}}

-- barvy (Solarized paleta)
local BASE03 = '#002b36'
local BASE02 = '#073642'
local BASE01 = '#586e75'
local BASE00 = '#657b83'
local BASE0 = '#839496'
local BASE1 = '#93a1a1'
local BASE2 = '#eee85d'
local BASE3 = '#fdf6d3'

local YELLOW = '#b58900'
local ORANGE = '#cb4b16'
local RED = '#dc322f'
local MAGENTA = '#d33682'
local VIOLET = '#6c71c4'
local BLUE = '#268bd2'
local CYAN = '#2aa198'
local GREEN = '#859900'
-- ...

-- samotný styl

stylesheet 'ColorIze'
by 'Severák'

background(BASE3)

-- plochy

area{
	feat = F_WATER,
	color = BLUE,
	desc = 'vodní plochy'
}

area{
	feat = F_FOREST,
	color = GREEN,
	desc = 'les'
}

area{
	feat = F_BUILDING,
	color = BASE00,
	desc = 'budovy'
}

-- potoky

line{
	feat = F_WATER,
	color = BLUE,
	width = 2,
	desc = 'vodní toky'
}

-- silnice / okraje

line{
	feat=F_FOOTWAY,
	color = ORANGE,
	dashing = {2, 2},
	desc = 'pěšina'
}

line{
	feat=F_ROAD_MINOR,
	color = ORANGE,
	width = 3,
	desc = 'vedlejší silnice'
}

line{
	feat=F_ROAD_MAJOR,
	color = ORANGE,
	width = 5,
	desc = 'hlavní silnice'
}

-- silnice / výplň

line{
	feat=F_ROAD_MAJOR,
	color = BASE3,
	width = 3
}

line{
	feat=F_ROAD_MINOR,
	color = BASE3,
	width = 1
}

-- koleje

line{
	feat = F_RAIL,
	color = BASE03,
	width = 3,
	desc = 'železnice'
}

line{ -- čárkované koleje
	feat = F_RAIL,
	color = BASE3,
	width = 1,
	dashing = {4,4}
}

line{
	feat = F_TRAM,
	color = RED,
	width = 2
}

-- názvy obcí -- name{...}

-- názvy silnic -- stretname{...}

-- generujeme zatím jen ColorBook CSS

colorbook.css 'map.css'

-- + legendu

legend.html()

-- + openmaptiles

openmaptiles.style()

print "OK"
