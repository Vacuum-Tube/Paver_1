function data()
	return {
		info = {
			minorVersion = -1,
			severityAdd = "NONE",
			severityRemove = "NONE", 
			name = "Paver",
			description = _("mod_desc"),
			tags = { "Script Mod" },
			authors = {
				{
					name = "VacuumTube",
					tfnetId = 29264,
				},
			},
		},
		runFn = function(settings)
		
		end,
		postRunFn = function(settings, modsettings)
			(require "paver.main").postRunFn(settings, modsettings)
		end
	}
end