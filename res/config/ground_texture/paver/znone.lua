local tu = require "texutil"

function data()
return {
	texture = tu.makeTextureLinearNearest("res/textures/terrain/material/mat255.tga", true, false, false),
	texSize = { 1, 1 },
	materialIndexMap = { },
	priority = 0
}
end
