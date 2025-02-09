local ssu = require "stylesheetutil"

function data()
    local result = {}
    local a = ssu.makeAdder(result)

	a("!PaverButton", {
		backgroundColor = ssu.makeColor(83, 151, 198, 200),
		borderColor = ssu.makeColor(0, 0, 0, 150),
		margin = { 2, 15, 10, 15 },
		padding = { 0, 10, 0, 10 },
	})
	a("!PaverButton:hover", {
		backgroundColor = ssu.makeColor(106, 192, 251, 200),
	})
	a("!PaverButton:active", {
		backgroundColor = ssu.makeColor(161, 217, 255, 200),
	})
	a("!PaverButton:disabled", {
		backgroundColor = ssu.makeColor(160, 180, 190, 50),
	})
	
	a("!PaverButton TextView", {
		fontSize = 20,
	})
	
	a("!gtexTypeText", {
		color = { .6, .8, 1.0, 1.0 },
	})
	
    return result
end