--get the FC, MGP and GIL totals

--------EDIT THESE IN THE SND SETTINGS!---------------------------------------------------------------------------------------
--[=====[
[[SND Metadata]]
author: dhogGPT
version: 384
description: Farm mogtomes with your cousins.
plugin_dependencies:
configs:
  zfilenem:
    default: "FUTAconfig_acc1.lua"
    description: "Filename containing the configs"
    type: string
    required: true
  zfilepath:
    default: "default"
    description: "pathroot for the configs. please know about LUA escapes"
    type: string
    required: true
[[End Metadata]]
--]=====]

--Don't edit these
filepath = Config.Get("zfilepath")
if filepath == "default" then filepath = os.getenv("appdata").."\\XIVLauncher\\pluginConfigs\\SomethingNeedDoing\\" end

filenem  = Config.Get("zfilenem"):gsub('"', '')
filepath = filepath:gsub('"', '')
fullPath = filepath .. filenem

require("dfunc")

FUTA_processors = {} -- Initialize variable


-- Read and deserialize the data
serializedData = readSerializedData(fullPath)
deserializedTable = {}
if serializedData then
    deserializedTable = deserializeTable(serializedData)
	-- Assign the deserialized table to FUTA_processors
    FUTA_processors = deserializedTable

    -- Check the deserialized table
    --yield("/echo Deserialized table:")
    --printTable(FUTA_processors)
else
    yield("/echo Error: Serialized data is nil.")
end

gil = 0
fc = 0
mgp = 0
vc = 0

for i = 1, #FUTA_processors do
    if FUTA_processors[i][11][2] ~= nil then gil = gil + FUTA_processors[i][11][2] end
    if FUTA_processors[i][11][3] ~= nil then
		if FUTA_processors[i][11][3] > -1 then
			fc = fc + FUTA_processors[i][11][3]
		end
	end
    if FUTA_processors[i][11][29] ~= nil then mgp = mgp + FUTA_processors[i][11][29] end
    if FUTA_processors[i][11][10386] ~= nil then vc = vc + FUTA_processors[i][11][10386] end
end

yield("/echo gil -> "..gil)
yield("/echo fc -> "..fc)
yield("/echo mgp -> "..mgp)
yield("/echo vc -> "..vc)
yield("/echo ----- formatted for copy paste ----")
yield("/echo "..gil.."\t"..fc.."\t"..mgp.."\t"..vc)