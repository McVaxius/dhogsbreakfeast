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
    description: "pathroot for the FUTA generated configs. \rplease know about LUA escapes"
    type: string
    required: true
  zfilepathAR:
    default: "default"
    description: "pathroot for the Autoretainer generated configs (defaultconfig.json).\rThis is for Retainer Gil\rplease know about LUA escapes"
    type: string
    required: true
[[End Metadata]]
--]=====]

--Don't edit these
filepath = Config.Get("zfilepath")
filepathAR = Config.Get("zfilepathAR")
if filepath == "default" then filepath = os.getenv("appdata").."\\XIVLauncher\\pluginConfigs\\SomethingNeedDoing\\" end
if filepathAR == "default" then filepathAR = os.getenv("appdata").."\\XIVLauncher\\pluginConfigs\\Autoretainer\\" end

version = Config.Get("zversion")
filenem  = Config.Get("zfilenem"):gsub('"', '')
filepath = filepath:gsub('"', '')
fullPath = filepath .. filenem

require("dfunc")

--change this later maybe
local path = filepathAR .. "DefaultConfig.json"

local function readFile(filePath)
    local f = io.open(filePath, "r")
    if not f then return nil end
    local content = f:read("*a")
    f:close()
    -- Remove BOM if present
    content = content:gsub("\239\187\191", "")
    return content
end

local content = readFile(path)
if not content then
    print("Failed to open file!")
    return
end

-- Extract SelectedRetainers block
local selectedBlock = content:match('"SelectedRetainers"%s*:%s*{(.-)}%s*,')
if not selectedBlock then
    print("No SelectedRetainers block found!")
    return
end

-- Extract OfflineData block (greedy until last ])
local offlineBlock = content:match('"OfflineData"%s*:%s*(%[.+%])')
if not offlineBlock then
    print("No OfflineData block found!")
    return
end

-- Build RetainerName -> {owner, gil, server} map
local retainerMap = {}
for ownerID, ownerName, serverName, retainersBlock in offlineBlock:gmatch(
    '"CID"%s*:%s*(%d+).-,"Name"%s*:%s*"([^"]+)".-,"World"%s*:%s*"([^"]+)".-,"RetainerData"%s*:%s*%[(.-)%]') 
do
    for retName, gil in retainersBlock:gmatch('"Name"%s*:%s*"([^"]+)".-,"Gil"%s*:%s*(%d+)') do
        retainerMap[retName] = {owner = ownerName, gil = tonumber(gil), server = serverName}
    end
end

-- Iterate SelectedRetainers and print info
flart = {}
for ownerID, charList in selectedBlock:gmatch('"(.-)"%s*:%s*%[(.-)%]') do
    for charName in charList:gmatch('"([^"]+)"') do
        local info = retainerMap[charName]
        if info then
            --print(string.format("%s (%s)\t%s -> %s -> %d gil", info.owner, info.server, ownerID, charName, info.gil))
			-- Append a new table to flart in one step
			flart[#flart+1] = {info.owner.."@"..info.server, ownerID, charName, info.gil}
            print(info.owner.."@"..info.server.."<-->"..ownerID.."<-->"..charName.."<-->"..info.gil)
           -- print("flart size -> "..#flart)
            --print(info.owner.."\t"..ownerID .. " -> " .. charName .. " -> " .. info.gil .. " gil (Owner: " .. info.owner .. ")")
        else
            print(ownerID .. " -> " .. charName .. " -> no data")
        end
    end
end

--print(flart[1][1])
yield("/echo Retainer Data extracted -> enjoy!")

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

--init the vars

gil = 0
fc = 0
mgp = 0
vc = 0
cf = 0
mrk = 0
hjl = 0
gcr = 0
fcr = 0
fcs = ""
fcl = ""
fcSize = ""
fcDistrict = ""
fcWard = 0
fcPlot = 0
pfcSize = ""
pfcDistrict = ""
pfcWard = 0
pfcPlot = 0
leveA = 0
retainergil = 0

local file = io.open(filepath .. "FUTA_Daily_"..version..".txt", "w")
file:write("nem\tgil\tfc\tmgp\tvc\tcf\tmrk\thjl\tgcr\tfcr\tfcs\tfcn\tfcsize\tfcdistrict\tfcward\tfcplot\tpfcsize\tpfcdistrict\tpfcward\tpfcplot\tleveA\r")

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
	fcs = ""
	fcl = ""
	fcSize = ""
	fcDistrict = ""
	fcWard = 0
	fcPlot = 0
	pfcSize = ""
	pfcDistrict = ""
	pfcWard = 0
	pfcPlot = 0
	leveA = 0
	retainergil = 0

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
    if FUTA_processors[i][11][999424999] ~= nil then fcs = FUTA_processors[i][11][999424999] end
    if FUTA_processors[i][11][999425999] ~= nil then fcl = FUTA_processors[i][11][999425999] end
    if FUTA_processors[i][11][999426999] ~= nil then fcSize = FUTA_processors[i][11][999426999] end
    if FUTA_processors[i][11][999427999] ~= nil then fcDistrict = FUTA_processors[i][11][999427999] end
    if FUTA_processors[i][11][999428999] ~= nil then fcWard = FUTA_processors[i][11][999428999] end
    if FUTA_processors[i][11][999429999] ~= nil then fcPlot = FUTA_processors[i][11][999429999] end
    if FUTA_processors[i][11][999430999] ~= nil then pfcSize = FUTA_processors[i][11][999430999] end
    if FUTA_processors[i][11][999431999] ~= nil then pfcDistrict = FUTA_processors[i][11][999431999] end
    if FUTA_processors[i][11][999432999] ~= nil then pfcWard = FUTA_processors[i][11][999432999] end
    if FUTA_processors[i][11][999433999] ~= nil then pfcPlot = FUTA_processors[i][11][999433999] end
    if FUTA_processors[i][11][99934999] ~= nil then leveA = FUTA_processors[i][11][99934999] end
	for i=1,#flart do
		if flart[i][1] == nem then
		print("debug -> "..nem.."->"..retainergil.."->"..flart[i][4])
			retainergil = retainergil + flart[i][4]
		end
	end
	if file then
		nem = tostring(FUTA_processors[i][1][1])
		file:write(nem.."\t"..gil.."\t"..fc.."\t"..mgp.."\t"..vc.."\t"..cf.."\t"..mrk.."\t"..hjl.."\t"..gcr.."\t"..fcr.."\t"..fcs.."\t"..fcl.."\t"..fcSize.."\t"..fcDistrict.."\t"..fcWard.."\t"..fcPlot.."\t"..pfcSize.."\t"..pfcDistrict.."\t"..pfcWard.."\t"..pfcPlot.."\t"..leveA.."\t"..retainergil.."\r")
	else
		yield("/echo Error: Unable to open file for writing")
	end
end
	file:close()

yield("/echo Character Data extracted -> enjoy!")
--pointless output. for debug only.
--yield("/echo ----- formatted for copy paste ----")
--yield("/echo "..gil.."\t"..fc.."\t"..mgp.."\t"..vc.."\t"..cf.."\t"..mrk.."\t"..hjl.."\t"..gcr.."\t"..fcr.."\t"..fcs.."\t"..fcl.."\t"..fcSize.."\t"..fcDistrict.."\t"..fcWard.."\t"..fcPlot.."\t"..pfcSize.."\t"..pfcDistrict.."\t"..pfcWard.."\t"..pfcPlot.."\r")
