local transf = require "transf"
local vec3 = require "vec3"
require "serialize"

local Polygon = require "paver.polygon"
local gtex_rep = require "paver.gtex_rep"

local paver = {
	markerId = "asset/paver_marker.mdl",
	markerIdbulldozable = "asset/paver_marker_bulldozable.mdl",
	conFileMarker = "asset/paver_marker.con",
	conFileResult = "asset/paver_result.con",
	conFilePreset = "asset/paver_preset.con",
	zonecolor = {0.8, 0.8, 0.8, 0.7},
	zonecolorBad = {0.8, 0, 0, 1},
	modes = {
		"FILL",
		"STROKE",
		"STROKE_INNER",
		"STROKE_OUTER",
	},
	modesText = {
		_("Fill only"),
		_("Stroke"),
		_("Stroke inner"),
		_("Stroke outer"),
	}
}

function paver.getPolygon(markers)
	local points = {}
	for i = 1, #markers do
		table.insert(points, markers[i].position)
	end
	return Polygon:Create(points)
end

function paver.updateZone(markers)
    if #markers == 0 then
        return
    end
    local zone = paver.getPolygon(markers)
    if #zone == 1 then
        game.interface.setZone("paver_zone", {
			polygon = {{zone[1][1] - 5, zone[1][2]}, {zone[1][1] + 5, zone[1][2]}}, 
			draw = true, 
			drawColor = paver.zonecolor
		})
    else
        game.interface.setZone("paver_zone", {
			polygon = zone, 
			draw = true, 
			drawColor = zone:IsSelfIntersecting() and paver.zonecolorBad or paver.zonecolor
		})
    end
	return zone
end

function paver.updateMarkerPreviews(markers,gtype)
	for i = 1, #markers do
		local id = markers[i].id
		if api.engine.entityExists(id) then
			local conEntity = assert(game.interface.getEntity(id), "No entity "..id)
			if conEntity.fileName == paver.conFileMarker then
				local params = conEntity.params
				params.paver_groundTex = gtype-1
				params.paver_groundTex_mode = 0
				params.seed = nil
				game.interface.upgradeConstruction(id, conEntity.fileName, params)
			else
				print("Unknown marker entity: "..id)
			end
		end
	end
end

function paver.reset(markers)
    for i = 1, #markers do
        if api.engine.entityExists(markers[i].id) then
            game.interface.bulldoze(markers[i].id)
        end
    end
	game.interface.setZone("paver_zone", nil)
end

function paver.manualMarkerCleanup()
    local fields = game.interface.getEntities({pos = {0,0}, radius = 1e42}, {type = "CONSTRUCTION", fileName = paver.conFileMarker})
    for i = 1, #fields do
        if api.engine.entityExists(fields[i]) then
            game.interface.bulldoze(fields[i])
        end
    end
end

function paver.pave(polygon, groundType, fill, strokeMode, strokeType)
	assert(type(groundType)=="string")
	if not groundType:ends(".lua") then
		if not paver.typesinfo.fullName[groundType] then
			print("Unknown ground type: "..groundType)
			return
		end
		groundType = paver.typesinfo.fullName[groundType]
	end
	if api.res.groundTextureRep.find(groundType)<0 then
		print("Unknown ground type: "..groundType)
		return
	end
	if fill==nil then
		fill = true
	end
	if strokeMode==nil then
		strokeMode = 0
	end
	assert(strokeMode<4)
	if strokeMode>0 then
		assert(type(strokeType)=="string", "No strokeType")
		if not strokeType:ends(".lua") then
			if not paver.typesinfo.fullName[strokeType] then
				print("Unknown stroke type: "..strokeType)
				return
			end
			strokeType = paver.typesinfo.fullName[strokeType]
		end
		if api.res.groundTextureRep.find(strokeType)<0 then
			print("Unknown stroke type: "..strokeType)
			return
		end
	end	
	if #polygon < 2 then  
		print("#polygon < 2 !")
		return
	end
	if polygon:IsSelfIntersecting() then
		print("Polygon self intersecting !")
		return
	end
	
    if polygon:IsClockwise() then
        polygon = polygon:reverse()  -- clockwise face gets triangled outlines for some reason
    end	
	local center = polygon:getCenter()
	local center_z = api.engine.terrain.getHeightAt(api.type.Vec2f.new(center[1], center[2]))
	polygon = polygon:makeCentered()
	
	local transf = {1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 1, 0, center[1], center[2], center_z, 1}
	local params = {
		polygon = polygon, 
		groundType = groundType,
		fill = fill,
		strokeMode = strokeMode,
		strokeType = strokeType,
	}
	local entity
	local status,res	= pcall(function()
		entity = game.interface.buildConstruction(paver.conFileResult, params, transf)
		game.interface.setPlayer(entity, game.interface.getPlayer())
		paver.setConName(entity, params)
	end)
	if status then
		-- print("Paver: Successfully built con with "..#polygon.." markers")
	else
		print("Paver - ERROR: ", res)
	end
	return entity
end

function paver.setConName(id, params)
	local name = paver.typesinfo.name[params.groundType] or params.groundType
	if not params.fill then
		name = "Stroke: "..(paver.typesinfo.name[params.strokeType] or params.strokeType)
	end
	game.interface.setName(id, "Paver - "..name)
end

function paver.initGroundTexRep()
	paver.types, paver.typesinfo = gtex_rep.initGroundTexRep()
end

function paver.postRunFn(settings, modsettings)
	local types, typesinfo = gtex_rep.initGroundTexRep()
	local types_names = {}
	for i,groundTex in pairs(types) do
		table.insert(types_names, typesinfo.name[groundTex] or groundTex)
	end
	local paver_con_marker = api.res.constructionRep.get(api.res.constructionRep.find(paver.conFileMarker))
	local paver_con_res = api.res.constructionRep.get(api.res.constructionRep.find(paver.conFileResult))
	local paver_con_preset = api.res.constructionRep.get(api.res.constructionRep.find(paver.conFilePreset))
	for _,p in pairs(paver_con_marker.params) do 
		if p.key=="paver_groundTex" then 
			p.values = types_names
		end
	end
	for _,p in pairs(paver_con_preset.params) do 
		if p.key=="paver_groundTex" then 
			p.values = types_names
		end
	end
	paver_con_marker.updateScript.fileName = "construction/asset/paver_marker.updateFn"
	paver_con_marker.updateScript.params = {
		groundTexTypes = types,
		gtexInfos = typesinfo,
	}
	paver_con_preset.updateScript.fileName = "construction/asset/paver_preset.updateFn"
	paver_con_preset.updateScript.params = {
		groundTexTypes = types,
		gtexInfos = typesinfo,
	}
end

return paver