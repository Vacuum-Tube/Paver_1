local paver = require "paver.main"
local ui = require "paver.ui"

local function table_find(tbl, value)
    for i, v in pairs(tbl) do
        if v == value then
            return i
        end
    end
end

local function sendScriptEvent(name, param)
	api.cmd.sendCommand(api.cmd.make.sendScriptEvent("paver.lua", "__paverEvent__", name, param ))
end

local state = {
    markers = {}
}

local gtype
local sgtype
local windowData

local function createWindow(upgrade, id)
	local entity, params
	if upgrade then
		entity = game.interface.getEntity(id)
		params = entity.params
		params.seed = nil
	else
		windowData = {}
	end
	
	local boxLayout = api.gui.layout.BoxLayout.new("VERTICAL")
	
	local headerLayout = api.gui.layout.BoxLayout.new("HORIZONTAL")
	headerLayout:addItem(api.gui.comp.TextView.new(_("Stroke Mode")..":"))
	local stroke_cbox = api.gui.comp.ComboBox.new()
	for _,item in pairs(paver.modesText) do
		stroke_cbox:addItem(item)
	end
	headerLayout:addItem(stroke_cbox)
	local check_fill = api.gui.comp.CheckBox.new("Fill")
	headerLayout:addItem(check_fill)
	local check_active = api.gui.comp.CheckBox.new("Disable")
	check_active:setTooltip("Temporary disable of texture")
	if upgrade then
		headerLayout:addItem(api.gui.comp.TextView.new(""))
		headerLayout:addItem(check_active)
		if type(params.disable)=="boolean" then
			check_active:setSelected(params.disable, false)
		end
		check_active:onToggle(function(toggle)
			params.disable = toggle
			sendScriptEvent("upgrade", {id = id, params = params})
		end)
	end
	local comp = api.gui.comp.Component.new("")
	comp:setLayout(headerLayout)
	boxLayout:addItem(comp)
	
	local list = api.gui.comp.List.new(true, api.gui.util.Orientation.VERTICAL, true)
	list:setVerticalScrollBarPolicy(api.gui.comp.ScrollBarPolicy.ALWAYS_ON)
	list:setHorizontalScrollBarPolicy(api.gui.comp.ScrollBarPolicy.ALWAYS_OFF)
	list:setMaximumSize(api.gui.util.Size.new(220, -1))
	list:setFocusable(false)
	local list2 = api.gui.comp.List.new(true, api.gui.util.Orientation.VERTICAL, true)
	list2:setVerticalScrollBarPolicy(api.gui.comp.ScrollBarPolicy.ALWAYS_ON)
	list2:setHorizontalScrollBarPolicy(api.gui.comp.ScrollBarPolicy.ALWAYS_OFF)
	list2:setMaximumSize(api.gui.util.Size.new(220, -1))
	for i,groundTex in pairs(paver.types) do
		for _,l in pairs{list,list2} do
			local text = api.gui.comp.TextView.new(paver.typesinfo.name[groundTex] or groundTex)
			-- text:setTooltip(groundTex)
			local boxlayout = api.gui.layout.BoxLayout.new("HORIZONTAL")
			local t = api.gui.comp.TextView.new(" ")  -- UGLY WORKAROUND to avoid jumping in the list when clicking letters (there is some kind of automatic element search)
			t:setVisible(false,false)
			boxlayout:addItem(t)
			boxlayout:addItem(text)
			local comp = api.gui.comp.Component.new("")
			comp:setLayout(boxlayout)
			comp:setGravity(-1,0)
			l:addItem(comp)
			if not paver.typesinfo.terrainTexDesc[groundTex] then
				text:setEnabled(false)
				comp:setTooltip(paver.typesinfo.tooltip[groundTex] or "")
			end
		end
	end
	
	local list2layout = api.gui.layout.BoxLayout.new("VERTICAL")
	list2layout:addItem(api.gui.comp.TextView.new(_("Stroke Texture")..":"))
	list2layout:addItem(list2)
	local list2comp = api.gui.comp.Component.new("")
	list2comp:setLayout(list2layout)
	
	local layoutInfos = api.gui.layout.BoxLayout.new("VERTICAL")
	layoutInfos:addItem(api.gui.comp.Component.new("HorizontalLine"))
	layoutInfos:addItem(api.gui.comp.TextView.new(_("Ground Texture")..":"))
    local typeText = api.gui.comp.TextView.new("-")
	typeText:addStyleClass("gtexTypeText")
	layoutInfos:addItem(typeText)
	
	layoutInfos:addItem(api.gui.comp.Component.new("HorizontalLine"))
	
	local imageView = api.gui.comp.ImageView.new("")
	if not upgrade then
		imageView:setGravity(.5,0)
		layoutInfos:addItem(imageView)
	end
	
    local typePrioText = api.gui.comp.TextView.new("Priority")
    local typeSizeText = api.gui.comp.TextView.new(_("Texture Size"))
    local typeTerrDescText = api.gui.comp.TextView.new("Terrain Textures")
	if debug_on then
		layoutInfos:addItem(typePrioText)
		layoutInfos:addItem(typeSizeText)
		layoutInfos:addItem(typeTerrDescText)
		layoutInfos:addItem(api.gui.comp.Component.new("HorizontalLine"))
	end
	
	if upgrade then
		local sliderComp = ui.Slider(0, 360, nil, 150, "Orientation Angle:", "-", "%3d°", (type(params.orientationAngle)=="number") and math.floor(params.orientationAngle), nil, function(value)		
			params.orientationAngle = value
			sendScriptEvent("upgrade", {id = id, params = params})
		end)
		-- layoutInfos:addItem(sliderComp)
		
		local sliderComp= ui.Slider(-10, 10, 0.25, 200, "Offset X:", "-", "%4g", (type(params.alignmentOffset)=="table") and params.alignmentOffset[1] or 0, 0, function(value)
			if not params.alignmentOffset then params.alignmentOffset = {} end
			params.alignmentOffset[1] = value
			sendScriptEvent("upgrade", {id = id, params = params})
		end)
		-- layoutInfos:addItem(sliderComp)
		
		local sliderComp= ui.Slider(-10, 10, 0.25, 200, "Offset Y:", "-", "%4g", (type(params.alignmentOffset)=="table") and params.alignmentOffset[2] or 0, 0, function(value)
			if not params.alignmentOffset then params.alignmentOffset = {} end
			params.alignmentOffset[2] = value
			sendScriptEvent("upgrade", {id = id, params = params})
		end)
		-- layoutInfos:addItem(sliderComp)
		
		local check_terrAlign = api.gui.comp.CheckBox.new(_("Make Terrain Flat"))
		layoutInfos:addItem(check_terrAlign)
		check_terrAlign:setSelected(params.terrainAlignment==1, false)
		check_terrAlign:onToggle(function(toggle)
			if toggle then
				params.terrainAlignment = 1
			else
				params.terrainAlignment = 0
			end
			sendScriptEvent("upgrade", {id = id, params = params})
		end)
		
		local sliderComp= ui.Slider(0.05, 2.5, 0.05, 150, "Embankment Low:", "-", "%5g", (type(params.emankmentLow)=="number") and params.emankmentLow or 0.3, 0.3, function(value) 
			params.emankmentLow = value
			sendScriptEvent("upgrade", {id = id, params = params})
		end)
		layoutInfos:addItem(sliderComp)
		
		local sliderComp= ui.Slider(0.05, 2.5, 0.05, 150, "Embankment High:", "-", "%5g", (type(params.emankmentLow)=="number") and params.emankmentLow or 0.6, 0.6, function(value) 
			params.emankmentHigh = value
			sendScriptEvent("upgrade", {id = id, params = params})
		end)
		layoutInfos:addItem(sliderComp)
	end
		
	local hfill = api.gui.comp.Component.new("")
	hfill:setGravity(-1,-1)
	layoutInfos:addItem(hfill)
		
	if not upgrade then
		layoutInfos:addItem(api.gui.comp.Component.new("HorizontalLine"))
		windowData.markersText = api.gui.comp.TextView.new("")
		windowData.areaText = api.gui.comp.TextView.new(_("Area"))
		layoutInfos:addItem(windowData.markersText)
		layoutInfos:addItem(windowData.areaText)
	end
	
	local acceptButton, resetButton
	if not upgrade then
		acceptButton = ui.newButton(_("Pave"), "ui/paver/ui_accept.tga", 32, 150, 42)
		resetButton = ui.newButton(_("Reset"),  "ui/paver/ui_delete.tga", 26, 150)
		-- acceptButton:setGravity(-1,0)
		-- resetButton:setGravity(-1,0)
		local buttonsLayout = api.gui.layout.BoxLayout.new("VERTICAL")
		-- buttonsLayout:addItem(api.gui.comp.TextView.new(""))
		-- local fill = api.gui.comp.Component.new("")
		-- fill:setGravity(-1,0)
		-- buttonsLayout:addItem(fill)
		buttonsLayout:addItem(resetButton)
		buttonsLayout:addItem(acceptButton)
		-- buttonsLayout:addItem(api.gui.comp.TextView.new(""))
		local comp = api.gui.comp.Component.new("")
		comp:setLayout(buttonsLayout)
		-- boxLayout:addItem(comp)
		layoutInfos:addItem(api.gui.comp.Component.new("HorizontalLine"))
		layoutInfos:addItem(comp)
		windowData.acceptButton = acceptButton
	end
    
	local compInfo = api.gui.comp.Component.new("")
	compInfo:setLayout(layoutInfos)
	
	local boxlayoutH = api.gui.layout.BoxLayout.new("HORIZONTAL")
	boxlayoutH:addItem(list)
	boxlayoutH:addItem(compInfo)
	boxlayoutH:addItem(list2comp)
	
	local complayoutH = api.gui.comp.Component.new("")
	complayoutH:setLayout(boxlayoutH)
	boxLayout:addItem(complayoutH)
	
	-- ### Callbacks
	
	if not upgrade then
		list:onSelect(function(idx)
			gtype = idx + 1
			local gtexkey = paver.types[gtype]
			if paver.typesinfo.terrainTexDesc[gtexkey] then
				typeText:setText(gtexkey or "ERROR - type: "..gtype)
				typeTerrDescText:setText(("Terrain Textures (Material Index Map): "..paver.typesinfo.terrainTexDesc[gtexkey]) or "ERROR - type: "..gtype)
				typeSizeText:setText("Texture Size (m): ".. (paver.typesinfo.size[gtexkey] or "ERROR - type: "..gtype))
				typePrioText:setText("Priority: ".. (paver.typesinfo.priority[gtexkey] or "ERROR - type: "..gtype))
				typeTerrDescText:setVisible(true,true)
				typeSizeText:setVisible(true,true)
				typePrioText:setVisible(true,true)
				acceptButton:setEnabled(true)
				sendScriptEvent("update_previews", gtype)
			else  -- is heading
				acceptButton:setEnabled(false)
				typeText:setText("-")
				typeTerrDescText:setVisible(false,true)
				typeSizeText:setVisible(false,true)
				typePrioText:setVisible(false,true)
			end
			if paver.typesinfo.icon[gtexkey] then
				imageView:setImage(paver.typesinfo.icon[gtexkey], true)
				imageView:setVisible(true,true)
				typeTerrDescText:setVisible(false,true)
				typeSizeText:setVisible(false,true)
				typePrioText:setVisible(false,true)
			else
				imageView:setVisible(false,true)
			end
		end)
		list:select((gtype or 1) - 1, true)
		list2:onSelect(function(idx)
			sgtype = idx + 1
		end)
		list2:select((sgtype or 1) - 1, true)
	else  -- upgrade window
		local idx = table_find(paver.types, params.groundType)
		if type(idx)=="number" then
			list:select(idx - 1, false)
			typeText:setText(params.groundType or "ERROR - type: "..gtype)
		else
			print("Paver existing groundType not found", id, params.groundType)
		end
		if params.strokeMode>0 then
			local idx = table_find(paver.types, params.strokeType)
			if type(idx)=="number" then			
				list2:select(idx - 1, false)
			else
				print("Paver existing groundType not found", id, params.strokeType)
			end
		else
			list2:select((sgtype or 1) - 1, false)
			params.strokeType = paver.types[sgtype or 1]
		end
		list:onSelect(function(idx)
			local gtexkey = paver.types[idx + 1]
			if paver.typesinfo.terrainTexDesc[gtexkey] then  -- is no heading
				typeText:setText(gtexkey or "ERROR - type: "..gtype)
				params.groundType = gtexkey
				sendScriptEvent("upgrade", {id = id, params = params})
			else
				typeText:setText("-")
			end
		end)
		list2:onSelect(function(idx)
			local sgtexkey = paver.types[idx + 1]
			if paver.typesinfo.terrainTexDesc[sgtexkey] then
				params.strokeType = sgtexkey
				sendScriptEvent("upgrade", {id = id, params = params})
			end
		end)
	end
		
	stroke_cbox:onIndexChanged(function(idx)
		if idx==0 then
			list2comp:setVisible(false, true)
			check_fill:setSelected(true, true)
			check_fill:setEnabled(false)
		else
			list2comp:setVisible(true, true)
			check_fill:setEnabled(true)
		end
		if upgrade then
			params.strokeMode = idx
			sendScriptEvent("upgrade", {id = id, params = params})
		end
	end)
	
	if not upgrade then
		stroke_cbox:setSelected(0, true)
	else
		if type(params.strokeMode)=="number" then
			stroke_cbox:setSelected(params.strokeMode, false)-- dont trigger upgrade
			if params.strokeMode==0 then
				list2comp:setVisible(false, true)
				check_fill:setSelected(true, true)
				check_fill:setEnabled(false)
			end 
		else
			print("Paver existing strokeMode not found", id, params.strokeMode)
		end
		check_fill:setSelected(params.fill, false)
		if #params.polygon==2 and params.fill==false then
			check_fill:setEnabled(false)
		end
	end
	
	check_fill:onToggle(function(toggle)
		if upgrade then
			params.fill = toggle
			sendScriptEvent("upgrade", {id = id, params = params})
		else
			if #state.markers==2 then
				if toggle then  -- Stroke inner+outer creates error ;or stroke_cbox:getCurrentIndex()<=1
					acceptButton:setEnabled(false)
				else
					acceptButton:setEnabled(true)
				end
			end
		end
	end)
	
	-- ### Window
	
	local window = api.gui.comp.Window.new(upgrade and (_("Paver Upgrader").." Entity: "..id) or _("Paver"), boxLayout)
	window:addHideOnCloseHandler()
	window:setPosition(75, 75)
	window:setMaximumSize(api.gui.util.Size.new(-1, 500))
	
	if not upgrade then
		window:onClose(function()
			windowData = nil
			if #state.markers > 0 then
				sendScriptEvent("reset", true )
			end
		end)
		-- windowData.window = window
		resetButton:onClick(function()
			window:close()
		end)
		acceptButton:onClick(function()
			sendScriptEvent("pave", {
				type = gtype, 
				fill = check_fill:isSelected(),
				stroke_mode = stroke_cbox:getCurrentIndex(),
				stroke_type = sgtype,
			})
			window:close()
		end)
		windowData.created = true
	end
	
end



local init = false

function data()
    return {
        save = function()
            return state
        end,
		update = function()
			if not init then 
				paver.initGroundTexRep()
				init = true
			end
        end,
        handleEvent = function(src, id, name, param)
            if id == "__paverEvent__" then
				if name == "plan" then
					table.insert(state.markers, param.marker)
					if param.gtype then
						paver.updateMarkerPreviews(state.markers, param.gtype)
					end
				elseif name == "remove_last_marker" then
					print("Removing last marker")
					local marker = table.remove(state.markers)
					print(marker.id)
					game.interface.bulldoze(marker.id)
				elseif name == "update_previews" then
					paver.updateMarkerPreviews(state.markers, param)
				elseif name == "pave" then
					paver.pave(paver.getPolygon(state.markers), paver.types[param.type], param.fill, param.stroke_mode, paver.types[param.stroke_type] )
				elseif name == "reset" then
					paver.reset(state.markers)
					state.markers = {}
				elseif name=="upgrade" then
					-- print("Paver Upgrade", param.id)
					local status,msg = pcall(function()
						game.interface.upgradeConstruction(param.id, paver.conFileResult, param.params)
						paver.setConName(param.id, param.params)
					end)
					if not status then
						print("PAVER - ERROR while upgrading: "..msg)
					end
				end
            end
        end,
        load = function(data)
			if data and #state.markers ~= #data.markers then
				state.markers = data.markers
				if windowData and windowData.created then
					windowData.markersText:setText(string.format("%s: %d", "Marker", #state.markers))
				end
				local polygon = paver.updateZone(state.markers)
				if #state.markers >= 2 and windowData and windowData.created then
					windowData.acceptButton:setEnabled(true)
					if #state.markers==2 then
						windowData.markersText:setText("Marker: 2 (only Stroke mode)")
						windowData.acceptButton:setEnabled(false)
					end
					if polygon:IsSelfIntersecting() then
						-- ui.attentionWindow("Warning", _("selfIntersectingWarning"))
						-- sendScriptEvent( "remove_last_marker", true)
						windowData.areaText:setText(_("selfIntersectingWarning"))
						windowData.acceptButton:setEnabled(false)
					else
						windowData.areaText:setText(string.format("%s: %.1f ha", _("Area"), polygon:GetArea()/10000 ))
					end
				end
			end
        end,
		guiInit = function()
			paver.initGroundTexRep()
		end,
        guiHandleEvent = function(id, name, param)
            if id == "constructionBuilder" and name == "builder.apply" then
				local added = param.proposal.toAdd[1]
				if added.fileName == paver.conFileMarker then
					sendScriptEvent("plan", {
						marker = {
							id = param.result[1],
							position = {added.transf[13], added.transf[14]},
						},
						gtype = gtype,
					})
					if #state.markers >= 1 and not windowData then
						local status,msg = pcall(createWindow)
						if not status then
							print("PAVER - ERROR: "..msg)
							ui.attentionWindow("PAVER - ERROR", msg, nil, nil, false)
						end
					end
				end
			end
			if name == "idAdded" and id:match("temp.view.entity_%d") then
				local entstr = id:gsub("temp.view.entity_","")
				local entity = tonumber(entstr)
				if entity then
					local comp = api.engine.getComponent(entity, api.type.ComponentType.CONSTRUCTION)
					if comp and comp.fileName == paver.conFileResult then
						local status,msg = pcall(createWindow, true, entity)
						if not status then
							print("PAVER - ERROR: "..msg)
							ui.attentionWindow("PAVER - ERROR", msg, nil, nil, false)
						end
					end
				end
			end
        end
    }
end