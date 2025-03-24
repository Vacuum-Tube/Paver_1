local ParamBuilder = require "parambuilder_v1_2"

local width = ParamBuilder.Slider("paver_width", _("Width").." [m]", ParamBuilder.range(1,250,1), 24  )

local hrange = ParamBuilder.range(1,250,1)
table.insert(hrange, 1, 0)
local height = ParamBuilder.Slider("paver_height", _("Height").." [m]", hrange, 0  )
height.params.values[1] = "= ".._("Width")

return {
	width = width,
	height = height,
}