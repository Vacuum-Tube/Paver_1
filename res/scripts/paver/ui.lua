local ui = {}

function ui.attentionWindow(title,msg,icon,highlight)
	local window = api.gui.comp.Window.new(title, api.gui.comp.TextView.new(msg))
	window:addHideOnCloseHandler()
	window:setIcon(icon or "ui/icons/windows/attention.tga")
	local uiSize = window:getParent():getContentRect()
	local newSize = api.gui.util.Size.new(300, 100)
	window:setSize(newSize)
	-- window:setVisible(false, false)
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

function ui.newButton(text, icon, size)
	local comp
	local textView = text and api.gui.comp.TextView.new(text)
	local imageView = icon and api.gui.comp.ImageView.new(icon)
	if imageView and size then
		imageView:setMinimumSize(api.gui.util.Size.new(size,size))
		imageView:setMaximumSize(api.gui.util.Size.new(size,size))
	end
	if textView and imageView then
		local boxLayout = api.gui.layout.BoxLayout.new("HORIZONTAL")
		boxLayout:addItem(imageView)
		boxLayout:addItem(textView)
		comp = api.gui.comp.Component.new("")
		comp:setLayout(boxLayout)
	elseif textView then
		comp = textView
	else
		comp = imageView
	end
	local button = api.gui.comp.Button.new(comp, false)
	button:addStyleClass("PaverButton")
	return button, textView
end

return ui