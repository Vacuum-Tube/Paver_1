local g = {}

g.filtersAll = {
	"construction/building/.*",
	"construction/industry/.*",
	"headquarter_.*",
	"fallback.lua",
	"none.lua",
	"airfield.lua",
	"airfield_hangar.lua",
	"airfield_main_building.lua",
	"airfield_terminal.lua",
	"airfield_terminal_cargo.lua",
	"airport_cargo_terminal.lua",
	"airport_hangar.lua",
	"farmland_0.lua",  -- identical to farmland_1
	-- "farmland_3.lua",  -- identical to farmland_2  ... but NEP replaces some?
	-- "farmland_4.lua",  -- identical to farmland_2
	-- "farmland_6.lua",  -- identical to farmland_5
	"usa/farmland_0.lua",
	"usa/farmland_1.lua",
	"usa/farmland_2.lua",
	"usa/farmland_3.lua",
	"usa/farmland_4.lua",
	"usa/farmland_5.lua",
	"usa/farmland_6.lua",
	"industry_gras_01.lua",  -- identical to industry_floor_paving
	"industry_gravel_big_01.lua",  -- identical to industry_floor_paving
	"industry_gravel_small_01.lua",  -- identical to industry_floor_paving
	"industry_soil_01.lua",  -- identical to industry_floor_paving
}

function g.filter(filters, fileName)
	for i,f in pairs(filters) do
		if fileName:match("^"..f.."$") then
			return false
		end
	end
	return true
end

function g.initGroundTexRep(options)
	print("Paver init GroundTexRep")
	local types = {}
	local info = {
		terrainTexDesc = {},
		size = {},
		priority = {},
	}
	local groundTexturesRep = api.res.groundTextureRep.getAll()
	for idx,fileName in pairs(groundTexturesRep) do
		if api.res.groundTextureRep.isVisible(idx) and g.filter(g.filtersAll, fileName) then
			local groundTex = api.res.groundTextureRep.get(idx)
			if groundTex.matIndexMap:size()>0 then
				local terrainTexDesc = toString(groundTex.matIndexMap) --""
				-- for i,terrtex in pairs(groundTex.matIndexMap) do  -- materialIndexMap
					-- terrainTexDesc=terrainTexDesc..terrtex.."\n"
				-- end			
				table.insert(types, fileName)
				info.terrainTexDesc[fileName] = terrainTexDesc
				info.size[fileName] = string.format("%s x %s", groundTex.texSize.x, groundTex.texSize.y)
				info.priority[fileName] = groundTex.priority
			end
		end
	end
	return types, info
end

return g