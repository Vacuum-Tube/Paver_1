local ParamBuilder = require "parambuilder_v1_2"

return {
	groundTexOffset = a,
	groundTexAngle = ParamBuilder.Slider("paver_groundTexAngle", _("param_groundTexAngle"), ParamBuilder.range(0,359,1), 0, _("param_groundTexAngle_TT"), "%d°"),
} 