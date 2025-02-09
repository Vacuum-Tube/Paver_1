local tu = require "texutil"

function data()
return {
	texture = tu.makeMaterialIndexTexture("res/textures/terrain/material/cut_grass_mix.tga", "REPEAT", "REPEAT"),
	texSize = { 512, 512 },
	materialIndexMap = {
		[0] = "grass_light_green.lua",
		[1] = "grass_dark_green.lua",
	},
	
	priority = 10
}
end
