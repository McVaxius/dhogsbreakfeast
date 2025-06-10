--[[
8manRaidTurnins_McVaxius.lua

purpose of this script is to handle the turnins for 8 man raids including GC Delivery.


Configuration will let you pick which 8 man raid you are turning in items for.

for now will just be alexander and omega.

instructions added later after dogfooding it a bit
]]


--SCRIPT CONFIGURATION
script_to_run after = "whateveryounamedit"  --script name in SND to run after handins are done.
returnto = 0 --0 = fc, 1 = bell near fc, 2 = gridania inn
raid8 = 1 --1 = alexander, 2 = omega
tier = 1 --tier is 1 2 3 for the menu options to pick for purchasing items

--script contants
raid8_1_zone = "Idyllshire"
raid8_1_vendor_x = 1
raid8_1_vendor_y = 1
raid8_1_vendor_z = 1
raid8_1_vendor_name = "Sabina"

raid8_2_zone = "Rhalg'r Reach Around"
raid8_2_vendor_x = 1
raid8_2_vendor_y = 1
raid8_2_vendor_z = 1
raid8_2_vendor_name = "Gobbler"


yield("/ays multi d")
loadfiyel = os.getenv("appdata").."\\XIVLauncher\\pluginConfigs\\SomethingNeedDoing\\_functions.lua"
functionsToLoad = loadfile(loadfiyel)
functionsToLoad()
DidWeLoadcorrectly()

