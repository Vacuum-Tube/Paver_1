local transf = require "transf"
local vec3 = require "vec3"
require "serialize"

local Polygon = require "paver.polygon"
local gtex_rep = require "paver.gtex_rep"

local paver = {
	markerId = "asset/paver_marker.mdl",
	conFileMarker = "asset/paver_marker.con",
	conFileResult = "asset/paver_result.con",
	zonecolor = {0.8, 0.8, 0.8, 0.7},
	zonecolorBad = {0.8, 0, 0, 1},
	params = require "paver.params",
	modes = {
		"FILL",
		"STROKE",
		"STROKE_INNER",
		"STROKE_OUTER",
	},
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
	print("update Paver markers", gtype)
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
    local fields = game.interface.getEntities({pos = {0,0}, radius = 1e42}, {type = "CONSTRUCTION", fileName = paver.conFileResult})
    for i = 1, #fields do
        if api.engine.entityExists(fields[i]) then
            game.interface.bulldoze(fields[i])
        end
    end
end

function paver.pave(polygon, groundType, fill, strokeMode, strokeType)
--   MultiPolygon?

    
	if #polygon < 2 then  
		print("#polygon < 2 !")
		return
	end
	if polygon:IsSelfIntersecting() then
		print("Polygon self intersecting !")
		return
	end
	
	assert(type(groundType)=="string")
	if fill==nil then
		fill = true
	end
	if strokeMode==nil then
		strokeMode = 0
	end
	if strokeMode>0 then
		assert(type(strokeType)=="string", "No strokeType")
	end
	
    if polygon:IsClockwise() then
        polygon = polygon:reverse()  -- clockwise faces gets triangled outlines for some reason
    end
	
	local center = polygon:getCenter()
	local center_z = api.engine.terrain.getHeightAt(api.type.Vec2f.new(center[1], center[2]))
	polygon:makeCentered()
	
	local transf = {1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 1, 0, center[1], center[2], center_z, 1}
	local params = {
		faces = polygon, 
		groundType = groundType,
		fill = fill,
		strokeMode = strokeMode,
		strokeType = strokeType,
	}
    
	local status,res	= pcall(function()
		local entity = game.interface.buildConstruction(paver.conFileResult, params, transf)
		game.interface.setPlayer(entity, game.interface.getPlayer())
		game.interface.setName(entity, "Paver: "..groundType)
	end)
	if status then
		print("Paver: Successfully built con with "..#polygon.." markers")
	else
		print("PAVER - ERROR: ", res)
	end
end

function paver.initGroundTexRep()
	paver.types, paver.typesinfo = gtex_rep.initGroundTexRep()
end

function paver.postRunFn(settings, modsettings)
	paver.initGroundTexRep()
	local paver_con_marker = api.res.constructionRep.get(api.res.constructionRep.find(paver.conFileMarker))
	local paver_con_res = api.res.constructionRep.get(api.res.constructionRep.find(paver.conFileResult))
	for _,p in pairs(paver_con_marker.params) do 
		if p.key=="paver_groundTex" then 
			p.values = paver.types
		end
	end
	for _,p in pairs(paver_con_res.params) do 
		if p.key=="groundType" then 
			p.values = paver.types
		end
		if p.key=="strokeType" then 
			p.values = paver.types
		end
	end
	paver_con_marker.updateScript.fileName = "construction/asset/paver_marker.updateFn"
	paver_con_marker.updateScript.params = {
		groundTexTypes = paver.types,
	}
end

return paver