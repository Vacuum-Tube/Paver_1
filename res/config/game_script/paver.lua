local paver = require "paver.main"
local ui = require "paver.ui"

local state = {
    markers = {}
}

local gtype
local sgtype
local areaText, markersText, acceptButton

local function createWindow()
	local boxLayout = api.gui.layout.BoxLayout.new("VERTICAL")
	
	local headerLayout = api.gui.layout.BoxLayout.new("HORIZONTAL")
	headerLayout:addItem(api.gui.comp.TextView.new(_("Stroke Mode")..":"))
	local stroke_cbox = api.gui.comp.ComboBox.new()
	for _,item in pairs({
		_("No border"),
		_("Stroke border "),
		_("Stroke border inner"),
		_("Stroke border outer"),
	}) do
		stroke_cbox:addItem(item)
	end
	headerLayout:addItem(stroke_cbox)
	local check_fill = api.gui.comp.CheckBox.new("Fill")
	headerLayout:addItem(check_fill)
	local comp = api.gui.comp.Component.new("")
	comp:setLayout(headerLayout)
	boxLayout:addItem(comp)
	
	local list = api.gui.comp.List.new(true, api.gui.util.Orientation.VERTICAL, true)
	list:setVerticalScrollBarPolicy(api.gui.comp.ScrollBarPolicy.ALWAYS_ON)
	list:setHorizontalScrollBarPolicy(api.gui.comp.ScrollBarPolicy.ALWAYS_OFF)
	list:setMaximumSize(api.gui.util.Size.new(300, -1))
	local list2 = api.gui.comp.List.new(true, api.gui.util.Orientation.VERTICAL, true)
	list2:setVerticalScrollBarPolicy(api.gui.comp.ScrollBarPolicy.ALWAYS_ON)
	list2:setHorizontalScrollBarPolicy(api.gui.comp.ScrollBarPolicy.ALWAYS_OFF)
	list2:setMaximumSize(api.gui.util.Size.new(300, -1))
	for i,groundTex in pairs(paver.types) do
		for _,l in pairs{list,list2} do
			local text = api.gui.comp.TextView.new(groundTex)
			text:setTooltip(groundTex)
			local boxlayout = api.gui.layout.BoxLayout.new("HORIZONTAL")
			boxlayout:addItem(text)
			local comp = api.gui.comp.Component.new("")
			comp:setLayout(boxlayout)
			comp:setGravity(-1,0)
			l:addItem(comp)
		end
	end
	
	local list2layout = api.gui.layout.BoxLayout.new("VERTICAL")
	list2layout:addItem(api.gui.comp.TextView.new(_("Stroke Texture")..":"))
	list2layout:addItem(list2)
	local list2comp = api.gui.comp.Component.new("")
	list2comp:setLayout(list2layout)
	
	local layoutTexts = api.gui.layout.BoxLayout.new("VERTICAL")
	-- layoutTexts:addItem(api.gui.comp.ImageView.new("ui/snowball_paver_header.tga"))
	layoutTexts:addItem(api.gui.comp.TextView.new(_("Ground Texture")..":"))
    local typeText = api.gui.comp.TextView.new("-")
	typeText:addStyleClass("gtexTypeText")
	layoutTexts:addItem(typeText)
	
	layoutTexts:addItem(api.gui.comp.Component.new("HorizontalLine"))
	
	-- layoutTexts:addItem(api.gui.comp.TextView.new(""))
    local typePrioText = api.gui.comp.TextView.new("xyzt")
	layoutTexts:addItem(typePrioText)
	-- layoutTexts:addItem(api.gui.comp.TextView.new(""))
    local typeSizeText = api.gui.comp.TextView.new(_("Texture Size"))
	layoutTexts:addItem(typeSizeText)
	-- layoutTexts:addItem(api.gui.comp.TextView.new(""))
	layoutTexts:addItem(api.gui.comp.TextView.new(_("typeTerrDescText")..":"))
    local typeTerrDescText = api.gui.comp.TextView.new("x")
	layoutTexts:addItem(typeTerrDescText)
	
	local hfill = api.gui.comp.Component.new("")
	hfill:setGravity(-1,-1)
	layoutTexts:addItem(hfill)
	
	layoutTexts:addItem(api.gui.comp.Component.new("HorizontalLine"))
	
	markersText =  api.gui.comp.TextView.new("")
    areaText = api.gui.comp.TextView.new(_("Area"))
    layoutTexts:addItem(markersText)
    layoutTexts:addItem(areaText)
	local compTexts = api.gui.comp.Component.new("")
	compTexts:setLayout(layoutTexts)
	
	local boxlayoutH = api.gui.layout.BoxLayout.new("HORIZONTAL")
	boxlayoutH:addItem(list)
	boxlayoutH:addItem(compTexts)
	boxlayoutH:addItem(list2comp)
	
	local complayoutH = api.gui.comp.Component.new("")
	complayoutH:setLayout(boxlayoutH)
	boxLayout:addItem(complayoutH)
	
    acceptButton = ui.newButton(_("Pave"), "ui/snowball_ui_accept.tga", 32)
	local resetButton = ui.newButton(_("Reset"),  "ui/snowball_ui_delete.tga", 32)
	local buttonsLayout = api.gui.layout.BoxLayout.new("HORIZONTAL")
	buttonsLayout:addItem(api.gui.comp.TextView.new(""))
	buttonsLayout:addItem(acceptButton)
	local hfill = api.gui.comp.Component.new("")
	hfill:setGravity(-1,0)
	buttonsLayout:addItem(hfill)
	buttonsLayout:addItem(resetButton)
	buttonsLayout:addItem(api.gui.comp.TextView.new(""))
	local comp = api.gui.comp.Component.new("")
	comp:setLayout(buttonsLayout)
	-- boxLayout:addItem(comp)
	layoutTexts:addItem(api.gui.comp.Component.new("HorizontalLine"))
	layoutTexts:addItem(comp)
    
	-- boxLayout:addItem(api.gui.comp.Component.new("HorizontalLine"))
	
	list:onSelect(function(idx)
		gtype = idx + 1
		typeText:setText(paver.types[gtype] or "ERROR - type: "..gtype)
		typeTerrDescText:setText(paver.typesinfo.terrainTexDesc[paver.types[gtype]] or "ERROR - type: "..gtype)
		typeSizeText:setText(_("Texture Size").." (m): ".. (paver.typesinfo.size[paver.types[gtype]] or "ERROR - type: "..gtype))
		typePrioText:setText(_("Priority")..": ".. (paver.typesinfo.priority[paver.types[gtype]] or "ERROR - type: "..gtype))
		api.cmd.sendCommand(api.cmd.make.sendScriptEvent("paver.lua", "__paverEvent__", "update_previews", gtype ))
	end)
	list:select((gtype or 1) - 1, true)
	
	list2:onSelect(function(idx)
		sgtype = idx + 1
	end)
	list2:select((sgtype or 1) - 1, true)
	
	stroke_cbox:onIndexChanged(function(idx)
		if idx==0 then
			list2comp:setVisible(false, true)
			check_fill:setSelected(true, true)
			check_fill:setEnabled(false)
		else
			list2comp:setVisible(true, true)
			check_fill:setEnabled(true)
		end
	end)
	stroke_cbox:setSelected(0, true)
	
	check_fill:onToggle(function(toggle)
		if #state.markers==2 then
			if toggle then  -- Stroke inner+outer creates error ;or stroke_cbox:getCurrentIndex()<=1
				acceptButton:setEnabled(false)
			else
				acceptButton:setEnabled(true)
			end
		end
	end)
	
	local window = api.gui.comp.Window.new(_("Paver (BETA)"), boxLayout)
	window:addHideOnCloseHandler()
	window:onClose(function()
		state.window = nil
		areaText = nil
		markersText = nil
		acceptButton = nil
		if #state.markers > 0 then
			api.cmd.sendCommand(api.cmd.make.sendScriptEvent("paver.lua", "__paverEvent__", "reset", true ))
		end
	end)
	window:setMaximumSize(api.gui.util.Size.new(-1, 500))
	window:setPosition(75, 75)
	state.window = true
	
    resetButton:onClick(function()
		window:close()
	end)
	acceptButton:onClick(function()
		api.cmd.sendCommand(api.cmd.make.sendScriptEvent("paver.lua", "__paverEvent__", "pave", {
			type = gtype, 
			fill = check_fill:isSelected(),
			stroke_mode = stroke_cbox:getCurrentIndex(),
			stroke_type = sgtype,
		}))
		window:close()
	end)
end


local init = false

function data()
    return {
        save = function()
            return state
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
					if not init then 
						paver.initGroundTexRep()
						init = true
					end
					paver.pave(paver.getPolygon(state.markers), paver.types[param.type], param.fill, param.stroke_mode, paver.types[param.stroke_type] )
				elseif name == "reset" then
					paver.reset(state.markers)
					state.markers = {}
				end
            end
        end,
        load = function(data)
			if data and #state.markers ~= #data.markers then
				state.markers = data.markers
				if markersText then
					markersText:setText(string.format("%s: %d", "Polygon Markers", #state.markers))
				end
				local polygon = paver.updateZone(state.markers)
				if #state.markers >= 2 and areaText then
					acceptButton:setEnabled(true)
					if #state.markers==2 then
						markersText:setText(markersText:getText().." (only Stroke mode)")
						acceptButton:setEnabled(false)
					end
					if polygon:IsSelfIntersecting() then
						ui.attentionWindow("Warning", _("selfIntersectingWarning"))
						api.cmd.sendCommand(api.cmd.make.sendScriptEvent("paver.lua", "__paverEvent__", "remove_last_marker", true))
					else
						areaText:setText(string.format("%s: %.1f ha", _("Area"), polygon:GetArea()/10000 ))
					end
				end
			end
        end,
		guiInit = function()
			paver.initGroundTexRep()
		end,
        guiHandleEvent = function(id, name, param)
            if id == "constructionBuilder" and name == "builder.apply" and param.proposal.toAdd and #param.proposal.toAdd > 0 then
				local added = param.proposal.toAdd[1]
				if added.fileName == paver.conFileMarker then
					api.cmd.sendCommand(api.cmd.make.sendScriptEvent("paver.lua", "__paverEvent__", "plan", {
						marker = {
							id = param.result[1],
							position = {added.transf[13], added.transf[14]},
						},
						gtype = gtype,
					}))
					if #state.markers >= 1 and not state.window then
						local status,msg = pcall(createWindow)
						if not status then
							print("PAVER - ERROR: "..msg)
						end
					end
				end
			end
        end
    }
end