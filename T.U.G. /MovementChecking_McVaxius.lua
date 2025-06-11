 --[[
  Description: Better movement checking maybe if you have lots of visland stops
  Author: McVaxius
  Link: https://discord.com/channels/1162031769403543643/1162799234874093661/1177617580127694888
]]

 muuv = 1
 muuvX = GetPlayerRawXPos()
 muuvY = GetPlayerRawYPos()
 muuvZ = GetPlayerRawZPos()
 while muuv == 1 do
    yield("/wait 1")
    if muuvX == GetPlayerRawXPos() and muuvY == GetPlayerRawYPos() and muuvZ == GetPlayerRawZPos() then
        muuv = 0
    end
    muuvX = GetPlayerRawXPos()
    muuvY = GetPlayerRawYPos()
    muuvZ = GetPlayerRawZPos()
 end