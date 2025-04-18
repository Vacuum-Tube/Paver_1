function data()
	return {
		en = {
			mod_name = "Paver",
			mod_desc = [[
Can create free-form areas with any ground texture.

Find under 'misc' in the asset menu. Click on the terrain to create a polygon. With a dedicated window, you can customize the ground texture and optionally set a border texture. Additionally, there are preset shapes (rectangle, triangle, circle) as usual constructions, which can also be used as preview for the textures.

The created areas can be conveniently upgraded with further options. With the terrain aligment option, this mod can even be used as a flattener.

Beside the vanilla terrain textures from the paint tool, ground textures from some mods are supported: [list]
[*][url=https://www.transportfever.net/filebase/entry/5942-natural-environment-professional-2/]Natural Environment Professional (NEP)[/url]
[*][url=https://steamcommunity.com/sharedfiles/filedetails/?id=2763516913]Ingo's textures - Pavers[/url]
[*][url=https://steamcommunity.com/sharedfiles/filedetails/?id=2763525700]Ingo's textures - Rocks and Fields[/url]
[*][url=https://steamcommunity.com/sharedfiles/filedetails/?id=2573124746]Ingo's Vegetation[/url]
[*][url=https://steamcommunity.com/sharedfiles/filedetails/?id=3432184100]Ingo's Vegetation Extended[/url]
[*][url=https://www.transportfever.net/filebase/entry/5852-bodentexturen-1-0-sch%C3%B6nbau-pinseltool/]Mariotator Ground Textures 1.0[/url]
[*][url=https://www.transportfever.net/filebase/entry/5870-bodentexturen-2-0-sch%C3%B6nbau-pinseltool/]Mariotator Ground Textures 2.0[/url]
[*][url=https://www.transportfever.net/filebase/entry/6110-bodentexturen-3-0-sch%C3%B6nbau-pinseltool/]Mariotator Ground Textures 3.0[/url]
[*][url=https://www.transportfever.net/filebase/entry/6250-bodentexturen-4-0-sch%C3%B6nbau-pinseltool/]Mariotator Ground Textures 4.0[/url]
[*][url=https://www.transportfever.net/filebase/entry/5939-sexy-vegetation-sch%C3%B6nbau-pinseltool/]Mariotator Sexy Vegetation[/url]
[*][url=https://www.transportfever.net/filebase/entry/6251-sexy-vegetation-2-0-sch%C3%B6nbau-pinseltool/]Mariotator Sexy Vegetation 2[/url]
[*][url=https://steamcommunity.com/workshop/filedetails/?id=2812141821]Farm Land textures (JamesT85Gaming)[/url]
[*][url=https://steamcommunity.com/workshop/filedetails/?id=2233342755]Farmland Textures (Quince99)[/url]
[*][url=https://www.transportfever.net/filebase/entry/6191-alpenheulers-pflasterpaket-3-von-burgen-und-alten-hinterh%C3%B6fen-tpf2-texturen-f%C3%BCr/]Alpenheuler Pflasterpaket 3[/url]
[*][url=https://steamcommunity.com/sharedfiles/filedetails/?id=2233592994]BloodyRulez Cobblestone-Textures 1.0[/url]
[*][url=https://www.transportfever.net/filebase/entry/5675-roads-n-trams-projekt-rtp/]Roads´n Trams Project (RTP)[/url]
[/list]
If they are activated, their textures will be available in the list. If not, some entries may still be in the list without function (I cannot determine whether some mods are active; they just create an empty area).

[b]Warning:[/b] Too many active ground textures can impact performance.

GitHub: https://github.com/Vacuum-Tube/Paver_1
]],
			con_name = "Paver - Polygon",
			con_param = "Paver Polygon Constructor",
			con_value = "Click on the terrain to create a polygon",
			con_groundTex = "Ground Texture Type",
			con_groundTex_check = "Preview On/Off",
			con_param_tt = [[
This is only a preview to get an impression of the ground texture.
It will vanish after built.
Select the final texture in the other window!]],
			con_desc = [[
Can create free-form areas with any ground texture.

Click on the terrain to create a polygon area (not intersecting). A window will appear for selecting the ground texture. When pressing 'Pave', the area will be filled with the texture.

Optionally, an additional border texture (Stroke) can be defined. If deactivating fill, the stroke is even possible with 2 markers as a line (a SMALL stone in its center can be used for editing and bulldozing).]],
			con_name_preset = "Paver - Preset Shapes",
			con_desc_preset = [[
Instead of the free-form tool, this provides predefined shapes.

Can also be used as preview to get an impression of the ground texture. ]],
			selfIntersectingWarning = "WARNING: Polygon is self-intersecting",
			mix_tooltip = "Custom ground texture files from the vanilla folder. Some can be used as a stroke texture.",
			mod_nep = "Natural Environment Professional (NEP)",
			mod_rtp = "Roads´n Trams Project (RTP)",
			mod_ingo_pavers = "Ingo's textures - Pavers",
			mod_ingo_rocks_fields = "Ingo's textures - Rocks and Fields",
			mod_ingo_vegetation = "Ingo's Vegetation",
			mod_ingo_vegetation_ext = "Ingo's Vegetation Extended",
			mod_mt_bodentex1 = "Mariotator Ground Textures 1.0",
			mod_mt_bodentex2 = "Mariotator Ground Textures 2.0",
			mod_mt_bodentex3 = "Mariotator Ground Textures 3.0",
			mod_mt_bodentex4 = "Mariotator Ground Textures 4.0",
			mod_mt_sexy_vegetation = "Mariotator Sexy Vegetation",
			mod_mt_sexy_vegetation2 = "Mariotator Sexy Vegetation 2",
			mod_ah_pflasterpaket3 = "Alpenheuler Pflasterpaket 3",
			mod_bloody_cobblestone = "BloodyRulez Cobblestone-Textures 1.0",
			mod_farm_land_textures_jt85 = "Farm land textures (JamesT85Gaming)",
			mod_farmland_textures_qu99 = "Farmland Textures (Quince99)",
		},
		de = {
			mod_name = "Paver (Pflasterer)",
			mod_desc = [[
Kann Frei-Form-Flächen mit beliebiger Bodentextur erzeugen.

Im Asset Menü unter "Verschiedenes" zu finden. Klicke auf das Terrain um eine Polygon Fläche zu erzeugen. Ein Fenster erscheint, um die Grundfläche auszuwählen und optional eine Randtextur. Zusätzlich gibt es Preset Formen (Rechteck, Dreieck, Kreis) als klassische Konstruktionen, welche auch als Vorschau für die Texturen genutzt werden können.

Die erzeugten Flächen können bequem geupgraded werden mit weiteren Optionen. So kann das Tool mit der Terrain Angleichung auch zum Ebnen/Planieren genutzt werden.

Neben den Vanilla Texturen vom Maltool, sind auch die Bodentexturen aus einigen Mods unterstützt: [list]
[*][url=https://www.transportfever.net/filebase/entry/5942-natural-environment-professional-2/]Natural Environment Professional (NEP)[/url]
[*][url=https://steamcommunity.com/sharedfiles/filedetails/?id=2763516913]Ingo's Texturen - Pflaster[/url]
[*][url=https://steamcommunity.com/sharedfiles/filedetails/?id=2763525700]Ingo's Texturen - Felsen und Acker[/url]
[*][url=https://steamcommunity.com/sharedfiles/filedetails/?id=2573124746]Ingo's Vegetation[/url]
[*][url=https://steamcommunity.com/sharedfiles/filedetails/?id=3432184100]Ingo's Vegetation Extended[/url]
[*][url=https://www.transportfever.net/filebase/entry/5852-bodentexturen-1-0-sch%C3%B6nbau-pinseltool/]Mariotator Bodentexturen 1.0[/url]
[*][url=https://www.transportfever.net/filebase/entry/5870-bodentexturen-2-0-sch%C3%B6nbau-pinseltool/]Mariotator Bodentexturen 2.0[/url]
[*][url=https://www.transportfever.net/filebase/entry/6110-bodentexturen-3-0-sch%C3%B6nbau-pinseltool/]Mariotator Bodentexturen 3.0[/url]
[*][url=https://www.transportfever.net/filebase/entry/6250-bodentexturen-4-0-sch%C3%B6nbau-pinseltool/]Mariotator Bodentexturen 4.0[/url]
[*][url=https://www.transportfever.net/filebase/entry/5939-sexy-vegetation-sch%C3%B6nbau-pinseltool/]Mariotator Sexy Vegetation[/url]
[*][url=https://www.transportfever.net/filebase/entry/6251-sexy-vegetation-2-0-sch%C3%B6nbau-pinseltool/]Mariotator Sexy Vegetation 2[/url]
[*][url=https://steamcommunity.com/workshop/filedetails/?id=2812141821]Farm Land textures (JamesT85Gaming)[/url]
[*][url=https://steamcommunity.com/workshop/filedetails/?id=2233342755]Farmland Textures (Quince99)[/url]
[*][url=https://www.transportfever.net/filebase/entry/6191-alpenheulers-pflasterpaket-3-von-burgen-und-alten-hinterh%C3%B6fen-tpf2-texturen-f%C3%BCr/]Alpenheuler Pflasterpaket 3[/url]
[*][url=https://steamcommunity.com/sharedfiles/filedetails/?id=2233592994]BloodyRulez Kopfsteinpflaster-Texturen 1.0[/url]
[*][url=https://www.transportfever.net/filebase/entry/5675-roads-n-trams-projekt-rtp/]Roads´n Trams Project (RTP)[/url]
[/list]
Wenn diese aktiviert sind, sind deren Texturen in der Liste verfügbar. Falls nicht, sind einige Einträge trotzdem in der Liste, aber ohne Funktion (Ich kann nicht erkennen ob manche Mods aktiv sind; es wird aber einfach nur eine leere Fläche erzeugt).

[b]Warnung:[/b] Zu viele Bodentexuren können die Performance beeinträchtigen.

GitHub: https://github.com/Vacuum-Tube/Paver_1
]],
			con_name = "Paver (Pflasterer) - Polygon",
			con_value = "Klick auf das Terrain um ein Polygon zu erzeugen",
			con_groundTex = "Boden Textur Typ",
			con_param_tt = [[
Dies ist nur eine Vorschau, um einen Eindruck der Bodentextur zu bekommen.
Verschwindet beim finalen Bau.
Wähle die finale Textur im anderen Fenster!]],
			con_desc = [[
Kann Frei-Form-Flächen mit beliebiger Bodentextur erzeugen.

Klicke auf das Terrain um eine Polygon Fläche zu erzeugen (nicht überschneidend). Ein Fenster erscheint um die Bodentextur auszuwählen. Mit einem Klick auf 'Pave' wird die komplette Fläche mit der Textur gefüllt.

Optional kann eine zusätzliche Randtextur definiert werden (Stroke). Wenn fill deaktiviert wird, ist Stroke sogar mit 2 Markern als Linie möglich (ein KLEINER Stein im Zentrum ermöglicht das Löschen und Bearbeiten).]],
			con_name_preset = "Paver (Pflasterer) - Preset",
			con_desc_preset = [[
Anstelle des Frei-Form-Tools gibt es hier vordefinierte Formen.

Kann außerdem als Vorschau genutzt werden, um einen Eindruck der Bodentextur zu bekommen. ]],
			selfIntersectingWarning = "WARNUNG: Polygon überschneidet sich",
			mix_tooltip = "Spezielle Ground Textures aus dem Vanilla Ordner. Manche können als Stroke genutzt werden.",
			Mode = "Modus",
			Type = "Typ",
			Area = "Fläche",
			None = "Keine",
			Hole = "Loch",
			Shape = "Form",
			Rectangle = "Rechteck",
			Triangle = "Dreieck",
			Circle = "Kreis",
			["for leveling"] = "für Ebnen",
			["Make Terrain Flat"] = "Terrain ebnen",
			
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
			
			mod_ingo_pavers = "Ingo's Texturen - Pflaster",
			["Ingo's Natural stone"] = ("Ingo's Naturstein"),
			["Ingo's Old paving"] = "Ingo's Altpflaster",
			["Ingo's Paving"] = "Ingo's Pflaster",
			["Ingo's Cobblestone paving"] = "Ingo's Kopfsteinpflaster",
			
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
			
			["Ingo's yellow flowers"] = "Ingo's gelbe Blumen",
			["Ingo's Poppy flowers"] = "Ingo's Mohnblumen",
			["Ingo's flax"] = "Ingo's Flachs",
			["Ingo's cannabis"] = "Ingo's Cannabis",
			["Ingo's curcuma"] = "Ingo's Kurkuma",
			["Ingo's dry grass"] = "Ingo's trockenes Gras",
			["Ingo's dry meadow - short"] = "Ingo's trockene Wiese - kurz",
			
			mod_mt_bodentex1 = "Mariotator Bodentexturen 1.0",
			mod_mt_bodentex2 = "Mariotator Bodentexturen 2.0",
			mod_mt_bodentex3 = "Mariotator Bodentexturen 3.0",
			mod_mt_bodentex4 = "Mariotator Bodentexturen 4.0",
						
			mod_bloody_cobblestone = "BloodyRulez Kopfsteinpflaster-Texturen 1.0",
			
		},
	}
end