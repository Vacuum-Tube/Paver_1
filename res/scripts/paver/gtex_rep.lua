local g = {}

local mods = {
	"nep",
	"rtp",
	"mt_bodentex1",
	"mt_bodentex2",
	"mt_bodentex3",
	"mt_bodentex4",
	"ingo_rocks_fields",
	"ingo_vegetation",
	"mt_sexy_vegetation",
	"mt_sexy_vegetation2",
}

function g.initGroundTexRep(options)
	print("Paver init GroundTexRep")
	local types = {
		paverVanilla = {},
		vanillaMix = {},
		others = {},
	}
	for z,mod in pairs(mods) do
		types[mod] = {}
	end
	local info = {
		terrainTexDesc = {},
		size = {},
		priority = {},
		name = {},
		icon = {},
		tooltip = {},
	}
	local groundTexturesRep = api.res.groundTextureRep.getAll()
	for idx,fileName in pairs(groundTexturesRep) do
		if api.res.groundTextureRep.isVisible(idx) and not g.filter(g.vanillaHide, fileName) then
			local groundTex = api.res.groundTextureRep.get(idx)
			if groundTex.matIndexMap:size()>0 then
				local terrainTexDesc = toString(groundTex.matIndexMap)
				info.terrainTexDesc[fileName] = terrainTexDesc
				info.size[fileName] = string.format("%s x %s", groundTex.texSize.x, groundTex.texSize.y)
				info.priority[fileName] = groundTex.priority
				if fileName:starts("paver/") then
					local found
					if fileName:starts("paver/mix/") then
						table.insert(types.vanillaMix, fileName)
						found = true
					end
					for _,mod in pairs(mods) do
						if fileName:starts(string.format("paver/mod_%s/", mod)) then
							table.insert(types[mod], fileName)
							found = true
						end
					end					
					if not found then
						table.insert(types.paverVanilla, fileName)
					end
				else
					table.insert(types.others, fileName)
				end
			end
		end
	end
	local typeslist = {}
	for z,typ in pairs(types.paverVanilla) do
		table.insert(typeslist, typ)
		info.name[typ] = g.paverVanillaConfig.name[typ:match("^paver/([^/]+)%.lua$")]
		info.icon[typ] = string.format("ui/paver/previews/%s.tga", typ:match("^paver/([^/]+)%.lua$"))
	end
	table.insert(typeslist, "===  Mix  ===")
	info.tooltip["===  Mix  ==="] = "Some custom ground texture files from the vanilla folder. Can be used as a stroke texture."
	for z,typ in pairs(types.vanillaMix) do
		table.insert(typeslist, typ)
	end
	for z,mod in pairs(mods) do
		if g.isModActive(mod) then
			local heading = string.format("===  %s  ===", g.modsStrings.shortName[mod] )
			table.insert(typeslist, heading)
			info.tooltip[heading] = "Textures from mod: "..g.modsStrings.longName[mod]..((g.isModActive(mod)=="maybe") and " (can't determine if active or not)" or "")
			for _,typ in pairs(types[mod]) do
				table.insert(typeslist, typ)
				local groundTex = typ:match("^paver/mod_"..mod.."/([^/]+)%.lua$")
				info.name[typ] = g.paverVanillaConfig.name[groundTex] or groundTex
			end
		end
	end
	-- table.insert(typeslist, _("===  Others (Mods)  ==="))
	-- for _,typ in pairs(types.others) do
		-- table.insert(typeslist, typ)
	-- end
	return typeslist, info
end

g.modsStrings = {
	shortName = {
		nep = "NEP Textures",
		rtp = "RTP Textures",
		ingo_rocks_fields = "Ingo Rocks&Fields",
		ingo_vegetation = "Ingo Vegetation",
		mt_bodentex1 = "MT Bodentexturen 1",
		mt_bodentex2 = "MT Bodentexturen 2",
		mt_bodentex3 = "MT Bodentexturen 3",
		mt_bodentex4 = "MT Bodentexturen 4",
		mt_sexy_vegetation = "Sexy Vegetation",	
		mt_sexy_vegetation2 = "Sexy Vegetation 2",	
	},
	longName = {}
}
for z,mod in pairs(mods) do
	g.modsStrings.longName[mod] = _("mod_"..mod)
end

function g.isModActive(mod)
	if mod=="nep" then
		return api.res.groundTextureRep.find("ballast_fill_stone_alternativ.lua")>0
	elseif mod=="rtp" then
		return api.res.groundTextureRep.find("rtp_groundtexture_sidewalk_dirt_dirt.lua")>0
	end
	-- cant determine others
	return "maybe"
end

function g.filter(filters, fileName)
	for i,f in pairs(filters) do
		if fileName:match("^"..f.."$") then
			return true
		end
	end
	return false
end

g.paverVanillaConfig = {
	name = {
		-- root
		dirt = _("Dirt"),
		forest_ground = _("Forest ground"),
		grass_alpine = _("Grass alpine"),
		grass_brown = _("Grass brown"),
		grass_dark_green = _("Grass dark green"),
		grass_gravel = _("Grass Gravel"),
		grass_green = _("Grass green"),
		grass_light_green = _("Grass light green"),
		gravel1 = _("Gravel 01"),
		river_bed = _("River bed"),
		rock = _("Rock"),
		scree = _("Scree"),
		snow = _("Snow 01"),
		hole = _("Hole"),
		
		-- shared/
		asphalt1 = _("Asphalt 01"),
		asphalt2 = _("Asphalt 02"),
		asphalt3 = _("Asphalt 03"),
		asphalt4 = _("Asphalt 04"),
		asphalt5 = _("Asphalt 05"),
		ballast = _("Ballast"),
		coal = _("Coal"),
		corn = _("Corn"),
		grass_cutted1 = _("Grass Cutted 01"),
		grass_cutted2 = _("Grass Cutted 02"),
		gravel2 = _("Gravel 02"),
		gravel3 = _("Gravel 03"),
		gravel4 = _("Gravel 04"),
		soil = _("Soil 01"),
		tiles_hexagon = _("Tiles hexagon"),
		water_dirty = _("Water Dirty"),
		wheat = _("Wheat"),
		
		-- mix
		border_dirt = "border_dirt",
		border_dirt2 = "border_dirt2",
		border_gravel_dirt = "border_gravel_dirt",
		border_path = "border_path",
		country_sidewalk = "country_sidewalk",
		soil_dirt = "soil_dirt",
		
		-- nep
		dirt_track = _("Dirt Track"),
		ballast_alternativ = _("Ballast Alternativ"),
		barley = _("Barley Ripe"),
		barley2 = _("Barley Young"),
		corn2 = _("Corn Young"),
		lupine = _("Lupine"),
		lupine_pink = _("Lupine Pink"),
		daisy = _("Daisy"),
		oat = _("Oat Ripe"),
		oat2 = _("Oat Young"),
		potato = _("Potato Blooming"),
		rape = _("Rapeseed Blooming"),
		sunflower = _("Sunflower Blooming"),
		wheat2 = _("Wheat Young"),
		
		--rtp
		rtp_street_gravel = _("RTP - Street gravel"),
		rtp_red_gravel = _("RTP - Red gravel"),
		
		-- ingo fels+acker
		ingo_fels_moos = _("Ingo's rock with moss"),
		ingo_fels_moos_klein = _("Ingo's rock with moss small"),
		ingo_fels_dunkel = _("Ingo's dark rock"),
		ingo_fels = _("Ingo's rock"),
		ingo_dreck_nass = _("Ingo's wet dirt"),
		ingo_dreck_nass_bepflanzt = _("Ingo's wet dirt planted"),
		
		-- ingo vegetation		
		ingo_gerbera = _("Ingo's orange gerbera (Aster)"),
		ingo_beeren = _("Ingo's berry bush"),
		ingo_buchweizen = _("Ingo's Real Buckwheat"),
		ingo_wiese_green = _("Ingo's green meadow"),
		ingo_ufer = _("Ingo's shore"),
		ingo_tulpen = _("Ingo's Tulips"),
		ingo_flieder = _("Ingo's Lilac"),
		ingo_wiese_blumen = _("Ingo's Flower meadow"),
		ingo_baumrose = _("Ingo's Rose tree"),
		ingo_waldrand = _("Ingo's Forest edge"),
		ingo_wiese_trocken = _("Ingo's dry meadow"),
		ingo_kornblumen = _("Ingo's Cornflowers"),
		ingo_hirse = _("Ingo's Switchgrass"),
		ingo_schilf = _("Ingo's Reed"),
		ingo_farn = _("Ingo's Farn"),
		ingo_underwater = _("Ingo's Underwater"),
		ingo_kaffee = _("Ingo's Coffee"),
		ingo_tabak = _("Ingo's Tobacco"),
		ingo_reis = _("Ingo's Rice"),
		ingo_baumwolle = _("Ingo's Cotton"),
		ingo_wiese_tropical2 = _("Ingo's tropical meadow 2"),
		ingo_dschungel = _("Ingo's Tropical jungle"),
		ingo_wiese_tropical1 = _("Ingo's tropical meadow 1"),
		ingo_aloevera = _("Ingo's Aloe Vera"),
		ingo_zyperngras = _("Ingo's Cyprus grass"),
		
		-- Mariotator Bodentexturen 1
		mt_asphalt_extra1 = "MT Asphalt Extra",
		mt_asphalt1 = "MT Asphalt 1",
		mt_asphalt2 = "MT Asphalt 2",
		mt_asphalt3 = "MT Asphalt 3",
		mt_asphalt4 = "MT Asphalt 4",
		mt_kies1 = "MT Kies 1",
		mt_kies2 = "MT Kies 2",
		mt_kies3 = "MT Kies 3",
		mt_kies4 = "MT Kies 4",
		mt_mixbeton1 = "MT Mix Beton 1",
		mt_mixbeton2 = "MT Mix Beton 2",
		mt_mixbeton3 = "MT Mix Beton 3",
		mt_mixbeton4 = "MT Mix Beton 4",
		mt_pflaster1 = "MT Pflaster 1",
		mt_pflaster2 = "MT Pflaster 2",
		mt_pflaster3 = "MT Pflaster 3",
		mt_pflaster4 = "MT Pflaster 4",
		mt_schotter1 = "MT Schotter 1",
		mt_schotter2 = "MT Schotter 2",
		mt_schotter3 = "MT Schotter 3",
		mt_schotter4 = "MT Schotter 4",
		mt_schutt1 = "MT Schutt 1",
		mt_schutt2 = "MT Schutt 2",
		mt_spargel1 = "MT Spargel",
		mt_trocken1 = "MT Trocken 1",
		mt_trocken2 = "MT Trocken 2",
		
		-- Mariotator Bodentexturen 2
		mt_bohnen1 = "MT Bohnen 1",
		mt_kartoffeln1 = "MT Kartoffeln 1",
		mt_kohl1 = "MT Kohl 1",
		mt_salat1 = "MT Salat 1",
		mt_zwiebeln1 = "MT Zwiebeln 1",
		mt_zwiebeln2 = "MT Zwiebeln 2",
		mt_zwiebeln3 = "MT Zwiebeln 3",
		
		-- Mariotator Bodentexturen 3
		mt_industriebeton1 = "MT Industriebeton 1",
		mt_industriebeton2 = "MT Industriebeton 2",
		mt_industriebeton3 = "MT Industriebeton 3",
		mt_industriebeton4 = "MT Industriebeton 4",
		mt_industriebeton5 = "MT Industriebeton 5",
		mt_industriebeton6 = "MT Industriebeton 6",
		
		-- Mariotator Bodentexturen 4
		mt_acker_trocken1 = "MT Acker Trocken 1",
		mt_ackerrand1 = "MT Ackerrand 1",
		mt_strand1 = "MT Strand 1",
		mt_strand2 = "MT Strand 2",
		mt_dirtywater1 = "MT Dirty Water 1",
		mt_dirtywater2 = "MT Dirty Water 2",
		mt_dirtywater3 = "MT Dirty Water 3",
		mt_dirtywater4 = "MT Dirty Water 4",
		mt_dirtywater5 = "MT Dirty Water 5",
		
		-- Mariotator Sexy Vegetation
		mt_strauch1 = "MT Hohes Gras Hell",
		mt_strauch2 = "MT Hanf",
		mt_strauch3 = "MT Sommer Gras",
		mt_strauch4 = "MT Wildklette",
		mt_strauch5 = "MT Schilf",
		mt_strauch6 = "MT Wild Gras Rosen",
		mt_strauch7 = "MT Wild Nessel",
		mt_strauch8 = "MT Wild Blauhut",
		mt_strauch9 = "MT Weizen",
		mt_strauch10 = "MT Oliven Gras",
		mt_strauch11 = "MT Konifere",
		mt_strauch12 = "MT Wasser Schilf",
		
		-- Mariotator Sexy Vegetation 2
		mt_bergwiese1 = "MT Bergwiese 1",
		mt_bergwiese2 = "MT Bergwiese 2",
		mt_brennnessel = "MT Brennnessel",
		mt_elfentau = "MT Elfentau",
		mt_feuerpalme = "MT Feuerpalme",
		mt_heidekraut = "MT Heidekraut",
		mt_sirisimmertoll = "MT Sirisimmertoll",
		mt_wildbeere = "MT Wildbeere",
		mt_mais1 = "MT Mais 1",
		mt_mais2 = "MT Mais 2",
		mt_mais3 = "MT Mais 3",
		mt_mais4 = "MT Mais 4",
		mt_mohn2 = "MT Mohn",
	},
}

g.vanillaHide = {
	"tropical/.*",
	"usa/.*",
	"construction/building/.*",  -- . (dot) matches any character except for line breaks
	"construction/industry/.*",
	"headquarter_.*",
	"airfield.*.lua",
	"airport_.*.lua",
	"fallback.lua",
	"none.lua",
	"building_path.lua",  -- asphalt01
	"building_paving_fill.lua",  -- asphalt03
	"building_paving_stroke.lua",  -- asphalt03
	"farmland_0.lua",  -- soil
	"farmland_1.lua",  -- soil
	"farmland_2.lua",  -- wheat
	"farmland_3.lua",  -- identical to farmland_2  ... but NEP replaces some?
	"farmland_4.lua",  -- identical to farmland_2
	"farmland_5.lua",  -- corn
	"farmland_6.lua",  -- identical to farmland_5
	"farmland_border.lua",  -- dirt
	"usa/farmland_border.lua",  -- soil
	"usa/farmland_0.lua",
	"usa/farmland_1.lua",
	"usa/farmland_2.lua",
	"usa/farmland_3.lua",
	"usa/farmland_4.lua",
	"usa/farmland_5.lua",
	"usa/farmland_6.lua",
	"industry_concrete_01.lua",  -- asphalt02
	"industry_floor_paving.lua",  -- asphalt03
	"industry_gras_01.lua",  -- identical to industry_floor_paving
	"industry_gravel_big_01.lua",  -- identical to industry_floor_paving
	"industry_gravel_small_01.lua",  -- identical to industry_floor_paving
	"industry_soil_01.lua",  -- identical to industry_floor_paving
	"rock_.*.lua",
	"shared/asphalt_01.gtex.lua",
	"shared/asphalt_02.gtex.lua",
	"shared/asphalt_03.gtex.lua",
	"shared/coal.gtex.lua",
	"shared/dirt.gtex.lua",
	"shared/grass_cutted_01.gtex.lua",
	"shared/gravel_02.gtex.lua",
	"shared/gravel_03.gtex.lua",
	"water_ground.lua",
	"hole.lua",
	"tree_ground.lua",
	"forest_floor.*.lua",
}

return g