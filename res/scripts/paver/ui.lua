local ui = {}

function ui.attentionWindow(title,msg,icon,highlight,size)
	local window = api.gui.comp.Window.new(title, api.gui.comp.TextView.new(msg))
	window:addHideOnCloseHandler()
	window:setIcon(icon or "ui/icons/windows/attention.tga")
	local uiSize = window:getParent():getContentRect()
	if size~=false then
		local newSize = api.gui.util.Size.new(size and size.h or 300, size and size.w or 100)
		window:setSize(newSize)
	end
	window:setPosition(0, 0) -- TRICK opens the window 'somewhere' to get the scaled size
	local winSize = window:getContentRect() -- now we have got the scaled size
	local x = math.floor((uiSize.w - winSize.w) * .5 + .5)
	local y = math.floor((uiSize.h - winSize.h) * .5 + .5)
	window:setPosition(x, y)
	window:setVisible(true, false)
	if highlight then
		window:setHighlighted(true)
	end
	api.gui.util.getGameUI():playSoundEffect("attention")
end

function ui.newButton(text, icon, iconsize, minwidth, minheight, maxwidth, maxheight)
	local comp
	local textView = text and api.gui.comp.TextView.new(text)
	local imageView = icon and api.gui.comp.ImageView.new(icon)
	if imageView and iconsize then
		imageView:setMinimumSize(api.gui.util.Size.new(iconsize,iconsize))
		imageView:setMaximumSize(api.gui.util.Size.new(iconsize,iconsize))
	end
	-- if textView and imageView then
		local boxLayout = api.gui.layout.BoxLayout.new("HORIZONTAL")
		boxLayout:addItem(imageView)
		boxLayout:addItem(textView)
		comp = api.gui.comp.Component.new("")
		comp:setLayout(boxLayout)
	-- elseif textView then
		-- comp = textView
	-- else
		-- comp = imageView
	-- end
		boxLayout:setGravity(0.5,0)
	comp:setGravity(-1,0)
	local button = api.gui.comp.Button.new(comp, false)
	button:addStyleClass("PaverButton")
	if minwidth or minheight then
		button:setMinimumSize(api.gui.util.Size.new(minwidth or -1,minheight or -1))
	end
	if maxwidth or maxheight then 
		button:setMaximumSize(api.gui.util.Size.new(maxwidth or -1,maxheight or -1))
	end
	return button, textView
end

function ui.Slider(min,max,step,width,label,valueTextInitial,valueText,initialValue,defaultValue,onUpdate)
	local slider = api.gui.comp.Slider.new(true)
	local numSteps
	if step==nil then
		step=1
	end
	if math.floor(step)==step then
		slider:setStep(step)
		slider:setMinimum(min)
		slider:setMaximum(max)
	else -- scale mode
		numSteps = math.ceil((max-min)/step)
		slider:setMinimum(0)
		slider:setMaximum(numSteps)
	end
	local idx2value = function(idx)
		if numSteps then
			return min+idx*step 
		else
			return idx
		end
	end
	local value2idx = function(value)
		if numSteps then
			return math.max(math.round((value-min)/step), 0)
		else
			return value
		end
	end
	slider:setMinimumSize(api.gui.util.Size.new(width,-1))
	local sliderLayout = api.gui.layout.BoxLayout.new("HORIZONTAL")
	if label then
		local labelText = api.gui.comp.TextView.new(label)
		sliderLayout:addItem(labelText)
	end
	sliderLayout:addItem(slider)
	local sliderText
	if valueTextInitial==true then
		valueTextInitial=""
	end
	if valueTextInitial then
		sliderText = api.gui.comp.TextView.new(valueTextInitial)
		sliderLayout:addItem(sliderText)
	end
	if valueText==true then
		valueText = "%s"
	end
	if type(valueText)=="string" then
	local formatstr = valueText
		valueText = function(v) return string.format(formatstr, v) end
	end
	local updateValue = function(value)
		if sliderText and valueText then
			sliderText:setText(valueText(value))
		end
	end
	if defaultValue then
		slider:setDefaultValue(value2idx(defaultValue))
		if initialValue==nil then
			initialValue = defaultValue
		end
	end
	if initialValue then
		slider:setValue(value2idx(initialValue), false)
		updateValue(initialValue)
	end
	slider:onValueChanged(function(idx)
		local value = idx2value(idx)
		updateValue(value)
		if onUpdate then onUpdate(value) end
	end)
	local getValue = function()
		return idx2value(slider:getValue())
	end
	local setValue = function(value)
		return slider:setValue(value2idx(value))
	end
	local sliderComp = api.gui.comp.Component.new("")
	sliderComp:setLayout(sliderLayout)
	return sliderComp, slider, sliderText, getValue, setValue
end
	

return ui