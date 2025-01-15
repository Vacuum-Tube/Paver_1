local paver = require "paver.main"

local config = {}

config.types = {
	{
		name = "Mix Temperate", 
		icon = "ui/construction/asset/default_brush_tree_broadleaf.tga",--default_brush_tree_all.tga",
		models = {
			"tree/azalea.mdl",
			"tree/common_hazel.mdl", 
			"tree/elderberry.mdl",
			"tree/european_linden.mdl",
			"tree/scots_pine.mdl",
			"tree/shingle_oak.mdl", 
			"tree/sugar_maple.mdl", 
		},
	},
	{
		name = "Mix Temperate Shrubs", 
		icon = "ui/construction/asset/default_brush_tree_shrubs.tga",
		models = {
			"tree/azalea.mdl",
			"tree/common_hazel.mdl", 
			"tree/elderberry.mdl",
		},
	},
    {
        name = _("azalea"),       
        icon = "ui/construction/asset/temperate/azalea.tga",
        models = {"tree/azalea.mdl"}
    },
    {
        name = _("common_hazel"),       
        icon = "ui/construction/asset/temperate/common_hazel.tga",
        models = {"tree/common_hazel.mdl"}
    },
    {
        name = _("elderberry"),       
        icon = "ui/construction/asset/temperate/elderberry.tga",
        models = {"tree/elderberry.mdl"}
    },
}

function config.load()
    
end

return config