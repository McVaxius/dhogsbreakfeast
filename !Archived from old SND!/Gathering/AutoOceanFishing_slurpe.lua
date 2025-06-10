--[[
  Description: It teleport to Limsa then get a fishing spot, run to near by bell waiting for retainer. Then check is it on the boat yet once on the boat run to edge start casting
  Author: slurpe
  Link: https://discord.com/channels/1162031769403543643/1162799234874093661/1170492807790735511
]]

--
-- Teleport to Lisma
yield("/tp Limsa Lominsa Lower Decks <wait.5>")
yield("/waitaddon _ActionBar <maxwait.600><wait.5>")
yield("/target Aetheryte <wait.6>")
yield("/send D")
yield("/send D")
yield("/send W")
yield("/send W")
yield("/send W")
yield("/send W")
yield("/send W")
yield("/send W")
yield("/send W")
yield("/send W")
yield("/send W")

yield("/lockon on")
yield("/automove on <wait.2>")

yield("/pinteract <wait.2>")
yield("/pcall SelectString true 0")
yield("/pcall TelepotTown false 11 3u <wait.1>") -- Arcanists' Guild
yield("/pcall TelepotTown false 11 3u <wait.1>")
yield("/waitaddon _ActionBar <maxwait.600><wait.5>")

-- from Arcanists' Guild to Ocean Fishing

yield("/visland execonce OC_Arc_Guild") -- create a path from Arcanists' Guild to Dryskthota
yield("<wait.18>")
yield("/visland stop")
yield("<wait.1.0>")

yield("/target Dryskthota")
yield("/pinteract <wait.2>")
yield("/wait 1")
yield("/send ESCAPE <wait.1.5>")
yield("/send ESCAPE <wait.1.5>")
yield("/send ESCAPE <wait.1.5>")
yield("/send ESCAPE <wait.1>")
yield("/wait 1")

-- from Ocean fishing to Hawkers Alley Bell

yield("/visland execonce Arc_Guild_OC")  -- create a path to Arcanists' Guild from Dryskthota
yield("<wait.18>")
yield("/visland stop")
yield("<wait.1.0>")

yield("/targetnpc <wait.1>")
yield("/lockon on")
yield("/pinteract <wait.2>")
yield("/pcall SelectString true 0")
yield("/pcall TelepotTown false 11 6u <wait.1>") -- Hawkers' Alley
yield("/pcall TelepotTown false 11 6u <wait.1>")
yield("/waitaddon _ActionBar <maxwait.600><wait.5>")

yield("/visland execonce Hawkers_Alley_Bell_wait")  -- a path from Hawkers alley to bell
yield("<wait.2>")
yield("/visland stop")
yield("<wait.1.0>")