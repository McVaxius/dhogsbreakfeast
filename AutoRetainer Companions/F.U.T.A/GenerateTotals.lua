--get the FC, MGP and GIL totals

--------EDIT THESE IN THE SND SETTINGS!---------------------------------------------------------------------------------------
--[=====[
[[SND Metadata]]
author: dhogGPT
version: 384
description: Checking your Empire stats
plugin_dependencies:
configs:
  zversion:
    default: "1"
    description: "version/account to append to file\n Useful if running multiple outputs to same folder"
    type: string
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

version = Config.Get("zversion")
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
cf = 0
mrk = 0
hjl = 0
gcr = 0
fcr = 0

local file = io.open(filepath .. "FUTA_Daily_"..version..".txt", "w")
file:write("nem\tgil\tfc\tmgp\tvc\tcf\tmrk\thjl\tgcr\tfcr\r")

for i = 1, #FUTA_processors do
	gil = 0
	fc = 0
	mgp = 0
	vc = 0
	cf = 0
	mrk = 0
	hjl = 0
	gcr = 0
	fcr = 0

    if FUTA_processors[i][11][2] ~= nil then gil = FUTA_processors[i][11][2] end
    if FUTA_processors[i][11][3] ~= nil then
		if FUTA_processors[i][11][3] > -1 then
			fc = FUTA_processors[i][11][3]
		end
	end
    if FUTA_processors[i][11][29] ~= nil then mgp = FUTA_processors[i][11][29] end
    if FUTA_processors[i][11][32161] ~= nil then vc = FUTA_processors[i][11][32161] end
    if FUTA_processors[i][11][10155] ~= nil then cf = FUTA_processors[i][11][10155] end
    if FUTA_processors[i][11][10373] ~= nil then mrk = FUTA_processors[i][11][10373] end
    if FUTA_processors[i][11][999420999] ~= nil then hjl = FUTA_processors[i][11][999420999] end
    if FUTA_processors[i][11][999423999] ~= nil then gcr = FUTA_processors[i][11][999423999] end
    if FUTA_processors[i][11][999422999] ~= nil then fcr = FUTA_processors[i][11][999422999] end

	if file then
		nem = tostring(FUTA_processors[i][1][1])
		file:write(nem.."\t"..gil.."\t"..fc.."\t"..mgp.."\t"..vc.."\t"..cf.."\t"..mrk.."\t"..hjl.."\t"..gcr.."\t"..fcr.."\r")
	else
		yield("/echo Error: Unable to open file for writing")
	end
end
	file:close()

yield("/echo gil -> "..gil)
yield("/echo fc -> "..fc)
yield("/echo mgp -> "..mgp)
yield("/echo vc -> "..vc)
yield("/echo ----- formatted for copy paste ----")
yield("/echo "..gil.."\t"..fc.."\t"..mgp.."\t"..vc.."\t"..cf.."\t"..mrk.."\t"..hjl.."\t"..gcr.."\t"..fcr)

