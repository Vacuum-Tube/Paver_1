function data()
	return {
		en = {
			mod_name = "Paver",
			mod_desc = [[
Can create free-form areas with any ground texture.
Find under 'misc' in the construction menu. Click on the terrain to create a polygon. With a dedicated window, you can customize the ground texture and optionally a border texture. To have an impression of the ground texture, you can use the preview setting.

The created areas can also be conveniently upgraded with further options. Moreover, with the terrain aligment option, this mod can also be used as a flattener.

Beside the vanilla terrain textures from the paint tool, other textures from some mods are supported (but not mandatory):[list]
[*]Natural Environment Professional (NEP)
[*]Roads´n Trams Project (RTP)
[*]Ingo's textures - Rocks and Fields
[*]Ingo's Vegetation
[*]Mariotator Ground Textures 1.0
[*]Mariotator Ground Textures 2.0
[*]Mariotator Ground Textures 3.0
[*]Mariotator Ground Textures 4.0
[*]Mariotator Sexy Vegetation
[*]Mariotator Sexy Vegetation 2
[/list]
If they are installed, the textures will be available. If not, some entries may still appear in the list (I cannot determine whether some mods are active; they create only empty area).
]],
			con_name = "Paver",
			con_param = "Paver Constructor",
			con_value = "Click on the terrain to create a polygon",
			con_groundTex = "Ground Texture Type (only for peview!)",
			con_groundTex_check = "Preview On/Off",
			con_param_tt = "This is only a preview to get an impression of the ground texture.\nIt will vanish after built.\nSelect the final texture in the other window!",
			con_desc = "Can create free-form areas with any ground texture.\n\n\z
			Click on the terrain to create a polygon area (not intersecting). A window will appear for selecting the ground texture. When pressing 'Pave', the area will be filled with the texture. \n\n\z
			Optionally, an additional border texture (Stroke) can be defined. If deactivating fill, the stroke is even possible with 2 markers as a line (a small stone in its center can be used for bulldozing)",
			selfIntersectingWarning = "WARNING: Polygon is self-intersecting",
			mod_nep = "Natural Environment Professional (NEP)",
			mod_rtp = "Roads´n Trams Project (RTP)",
			mod_ingo_rocks_fields = "Ingo's textures - Rocks and Fields",
			mod_ingo_vegetation = "Ingo's Vegetation",
			mod_mt_bodentex1 = "Mariotator Ground Textures 1.0",
			mod_mt_bodentex2 = "Mariotator Ground Textures 2.0",
			mod_mt_bodentex3 = "Mariotator Ground Textures 3.0",
			mod_mt_bodentex4 = "Mariotator Ground Textures 4.0",
			mod_mt_sexy_vegetation = "Mariotator Sexy Vegetation",
			mod_mt_sexy_vegetation2 = "Mariotator Sexy Vegetation 2",
		},
		de = {
			mod_name = "Paver (Pflasterer)",
			mod_desc = [[
Kann Frei-Form-Flächen mit beliebiger Bodentextur erzeugen.
]],
			con_name = "Paver (Pflasterer)",
			con_value = "Klick auf das Terrain um ein Polygon zu erzeugen",
			con_groundTex = "Boden Textur Typ (nur zur Vorschau!)",
			con_param_tt = "Dies ist nur eine Vorschau, um einen Eindruck der Bodentextur zu bekommen.\nVerschwindet beim finalen Bau.\nWähle die finale Textur im anderen Fenster!",
			con_desc = "Kann Frei-Form-Flächen mit beliebiger Bodentextur erzeugen.\n\n\z
			Klicke auf das Terrain um eine Polygon Fläche zu erzeugen (nicht überschneidend). Ein Fenster erscheint um die Bodentextur auszuwählen. Mit einem Klick auf 'Pave' wird die komplette Fläche mit der Textur gefüllt. \n\n\z
			Optional kann eine zusätzliche Randtextur definiert werden (Stroke). Wenn fill deaktiviert wird, ist Stroke sogar mit 2 Markern als Linie möglich (ein Stein im Zentrum ermöglicht das Löschen).",
			selfIntersectingWarning = "WARNUNG: Polygon überschneidet sich",
			Mode = "Modus",
			Type = "Typ",
			Area = "Fläche",
			
			["Barley Ripe"] = ("Gerste Reif"),
			["Barley Young"] = ("Gerste Jung"),
			["Corn"] = ("Mais Reif"),
			["Corn Young"] = ("Mais Jung"),
			["Oat Ripe"] = ("Hafer Reif"),
			["Oat Young"] = ("Hafer Jung"),
			["Wheat"] = ("Weizen Reif"),
			["Wheat Young"] = ("Weizen Jung"),
			["Potato Blooming"] = ("Kartoffeln Blühend"),
			["Sunflower Blooming"] = ("Sonnenblumen Blühend"),
			["Rapeseed Blooming"] = ("Raps Blühend"),
			["Daisy"] = ("Weiße Blümchen"),
			
			["RTP - Street gravel"] = "RTP - Strassenschotter",
			["RTP - Red gravel"] = "RTP - roter Schotter",
			
			mod_ingo_rocks_fields = "Ingo's Texturen - Felsen und Acker",
			["Ingo's rock with moss"] = ("Ingo's Fels mit Moos"),
			["Ingo's rock with moss small"] = ("Ingo's Fels mit Moos klein"),
			["Ingo's dark rock"] = ("Ingo's Dunkler Fels"),
			["Ingo's rock"] = ("Ingo's Fels"),
			["Ingo's wet dirt"] = ("Ingo's nasser Dreck"),
			["Ingo's wet dirt planted"] = ("Ingo's nasser Dreck bepflanzt"),
			
			["Ingo's orange gerbera (Aster)"] = "Ingo's orangefarbene Gerbera (Aster)",
			["Ingo's berry bush"] = "Ingo's Beerenstrauch",
			["Ingo's Real Buckwheat"] = "Ingo's Echter Buchweizen",
			["Ingo's green meadow"] = "Ingo's grüne Wiese",
			["Ingo's shore"] = "Ingo's Ufer",
			["Ingo's Tulips"] = "Ingo's Tulpen",
			["Ingo's Lilac"] = "Ingo's Flieder",
			["Ingo's Flower meadow"] = "Ingo's Blumenwiese",
			["Ingo's Rose tree"] = "Ingo's Baumrose",
			["Ingo's Forest edge"] = "Ingo's Waldrand",
			["Ingo's dry meadow"] = "Ingo's trockene Wiese",
			["Ingo's Cornflowers"] = "Ingo's Kornblumen",
			["Ingo's Reed"] = "Ingo's Schilf",
			["Ingo's Switchgrass"] = "Ingo's Rutenhirse",
			["Ingo's Farn"] = "Ingo's Farn",
			["Ingo's Underwater"] = "Ingo's Unterwasser",
			["Ingo's Coffee"] = "Ingo's Kaffee",
			["Ingo's Tobacco"] = "Ingo's Tabak",
			["Ingo's Rice"] = "Ingo's Reis",
			["Ingo's Cotton"] = "Ingo's Baumwolle",
			["Ingo's tropical meadow 2"] = "Ingo's tropische Wiese 2",
			["Ingo's Tropical jungle"] = "Ingo's Tropischer Dschungel",
			["Ingo's tropical meadow 1"] = "Ingo's tropische Wiese 1",
			["Ingo's Aloe Vera"] = "Ingo's Aloe Vera",
			["Ingo's Cyprus grass"] = "Ingo's Zyperngras",
			
			mod_mt_bodentex1 = "Mariotator Bodentexturen 1.0",
			mod_mt_bodentex2 = "Mariotator Bodentexturen 2.0",
			mod_mt_bodentex3 = "Mariotator Bodentexturen 3.0",
			mod_mt_bodentex4 = "Mariotator Bodentexturen 4.0",
			
		},
	}
end