 --[[
  Description: Better movement checking maybe if you have lots of visland stops
  Author: McVaxius
  Link: https://discord.com/channels/1162031769403543643/1162799234874093661/1177617580127694888
]]

 muuv = 1
 muuvX = Player.Entity.Position.X
 muuvY = Player.Entity.Position.Y
 muuvZ = Player.Entity.Position.Z
 while muuv == 1 do
    yield("/wait 1")
    if muuvX == Player.Entity.Position.X and muuvY == Player.Entity.Position.Y and muuvZ == Player.Entity.Position.Z then
        muuv = 0
    end
    muuvX = Player.Entity.Position.X
    muuvY = Player.Entity.Position.Y
    muuvZ = Player.Entity.Position.Z
 end