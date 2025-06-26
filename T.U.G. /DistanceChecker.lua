--yield("/echo "..GetPlayerRawXPos().." "..GetPlayerRawZPos().."")
loadfiyel = os.getenv("appdata").."\\XIVLauncher\\pluginConfigs\\SomethingNeedDoing\\_functions.lua"
functionsToLoad = loadfile(loadfiyel)
functionsToLoad()

function distance(x1, y1, z1, x2, y2, z2)
if type(x1) ~= "number" then x1 = 0 end
if type(y1) ~= "number" then y1 = 0 end
if type(z1) ~= "number" then z1 = 0 end
if type(x2) ~= "number" then x2 = 0 end
if type(y2) ~= "number" then y2= 0 end
if type(z2) ~= "number" then z2 = 0 end
zoobz = math.sqrt((x2 - x1)^2 + (y2 - y1)^2 + (z2 - z1)^2)
if type(zoobz) ~= "number" then
zoobz = 0
end
    --return math.sqrt((x2 - x1)^2 + (y2 - y1)^2 + (z2 - z1)^2)
    return zoobz
end

nemm = GetTargetName()
bistance = distance(GetPlayerRawXPos(), GetPlayerRawYPos(), GetPlayerRawZPos(), GetObjectRawXPos(nemm),GetObjectRawYPos(nemm),GetObjectRawZPos(nemm))

yield("/echo "..GetPlayerRawXPos()..", "..GetPlayerRawYPos()..", "..GetPlayerRawZPos().."")
yield("/echo "..GetZoneID())
yield("Distance to target -> "..bistance)