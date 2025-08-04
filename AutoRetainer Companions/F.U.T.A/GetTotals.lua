--get the FC, MGP and GIL totals

FUTA_config_file = "FUTAconfig_McVaxius_"..table_version..".lua"
--FUTA_config_file = "FUTAconfig_acc1.lua"
--FUTA_config_file = "FUTAconfig_acc2.lua"
--FUTA_config_file = "FUTAconfig_acc3.lua"
--FUTA_config_file = "FUTAconfig_acc4.lua"
--FUTA_config_file = "FUTAconfig_accN.lua"

folderPath = os.getenv("appdata").."\\XIVLauncher\\pluginConfigs\\SomethingNeedDoing\\"
fullPath = os.getenv("appdata") .. "\\XIVLauncher\\pluginConfigs\\SomethingNeedDoing\\" .. FUTA_config_file
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

for i = 1, #FUTA_processors do
    gil = gil + FUTA_processors[i][11][2]
    fc = fc + FUTA_processors[i][11][3]
    mgp = mgp + FUTA_processors[i][11][4]
end

yield("/echo gil -> "..gil)
yield("/echo fc -> "..fc)
yield("/echo mgp -> "..mgp)
yield("/echo ----- formatted for copy paste ----")
yield("/echo "..gil)
yield("/echo "..fc)
yield("/echo "..mgp)
