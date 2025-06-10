--Super Sneaky Loader (tm)
--purpose: edit the lua script in notepad++ instead of ingame because we dont want to use the ingame editor And we have a million clients running
--does it change anything? no . it just simplifies editing multiple script instances locally for your use with multiple chars.

--thanks to eden from the disc for the idea!
--for fishing script
loadfiyelZZ = os.getenv("appdata").."\\XIVLauncher\\pluginConfigs\\SomethingNeedDoing\\DeluxeOceanFishingCharSwapping_MxVaxius.lua"
functionsToLoad = loadfile(loadfiyelZZ)
functionsToLoad()
DidWeLoadcorrectly()
