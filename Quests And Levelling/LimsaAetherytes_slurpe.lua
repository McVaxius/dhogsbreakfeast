--[[
  Description: It teleport to Limsa then get a fishing spot, run to near by bell waiting for retainer. Then check is it on the boat yet once on the boat run to edge start casting
  Author: slurpe
  Link: https://discord.com/channels/1162031769403543643/1162799234874093661/1174830173355528211
]]

-- Talk to Swozblaet
function getAllAetheryte1()
yield("/visland execonce getAllAetheryte1")
yield("/wait 17")
yield("/at <wait.1>")

yield("/target Swozblaet <wait.1>")


yield("/lockon on")
--yield("/automove on <wait.2>")

yield("/pinteract <wait.3>")
end

-- all aetheryte - Hawkers' Alley
function getAllAetheryte2()
yield("/visland execonce getAllAetheryte2")
yield("/wait 14")

yield("/target Aethernet Shard <wait.1>")


yield("/lockon on")
--yield("/automove on <wait.2>")

yield("/pinteract <wait.5>")
end

-- all aetheryte - Arcanists' Guild
function getAllAetheryte3()
yield("/visland execonce getAllAetheryte3")
yield("/wait 23")


yield("/targetnpc <wait.1>")
--yield("/target Aethernet Shard <wait.3>")


yield("/lockon on")
--yield("/automove on <wait.2>")

yield("/pinteract <wait.5>")
end

function getAllAetheryte3_teleport()
yield("/targetnpc <wait.1>")
yield("/pinteract <wait.3>")
yield("/lockon on")
yield("/pinteract <wait.2>")
yield("/pcall SelectString true 0")
yield("/pcall TelepotTown false 11 6u <wait.1>") -- Hawkers' Alley
yield("/pcall TelepotTown false 11 6u <wait.1>")
end


-- all aetheryte - Fisherman's Guild
function getAllAetheryte4()
yield("/visland execonce getAllAetheryte4")
yield("/wait 52")

yield("/send Left")
yield("/send Left")

yield("/targetnpc <wait.1>")
--yield("/target Aethernet Shard<wait.1>")


yield("/lockon on")
--yield("/automove on <wait.2>")

yield("/pinteract <wait.5>")
end

function getAllAetheryte4_teleport()

yield("/targetnpc <wait.1>")
--yield("/target Aethernet Shard <wait.1>")
yield("/pinteract <wait.3>")
yield("/lockon on")
yield("/pinteract <wait.2>")
yield("/pcall SelectString true 0")
yield("/pcall TelepotTown false 11 0u <wait.1>") -- Limsa Lominsa Plaza
yield("/pcall TelepotTown false 11 0u <wait.1>")
end

-- all aetheryte - Lift Attendant
function getAllAetheryte5()
yield("/visland execonce getAllAetheryte5")
yield("/wait 23")

yield("/send Right")
yield("/send Right")

-- yield("/targetnpc <wait.1>")
yield("/target Grehfarr <wait.1>")

yield("/lockon on")
--yield("/automove on <wait.2>")

yield("/send NUMPAD0 <wait.2>")
yield("/send NUMPAD2 <wait.1>")
yield("/send NUMPAD0 <wait.1>")

end


-- all aetheryte - The Aftcastle
function getAllAetheryte6()
yield("/visland execonce getAllAetheryte6")
yield("/wait 17")


--yield("/targetnpc <wait.1>")
yield("/target Aethernet Shard <wait.1>")


yield("/lockon on")
--yield("/automove on <wait.2>")

yield("/pinteract <wait.5>")
end


-- all aetheryte - Culinarians' Guild
function getAllAetheryte7()
yield("/visland execonce getAllAetheryte7")
yield("/wait 47")


--yield("/targetnpc <wait.1>")
yield("/target Aethernet Shard <wait.1>")


yield("/lockon on")
--yield("/automove on <wait.2>")

yield("/pinteract <wait.5>")
end


-- all aetheryte - Marauders' Guild
function getAllAetheryte8()
yield("/visland execonce getAllAetheryte8")
yield("/wait 32")

yield("/echo done")
yield("/targetnpc <wait.1>")
-- yield("/target Aethernet Shard <wait.1>")


yield("/lockon on")
--yield("/automove on <wait.2>")

yield("/pinteract <wait.5>")
yield("/send NUMPAD0 <wait.5>")



end



-- all aetheryte - Guild Receptionist
function getAllAetheryte9()
yield("/visland execonce getAllAetheryte9")
yield("/wait 10")

yield("/echo done")
--yield("/targetnpc <wait.1>")
yield("/target Blauthota <wait.1>")


yield("/lockon on")
--yield("/automove on <wait.2>")

yield("/pinteract <wait.5>")
yield("/send NUMPAD0 <wait.5>")

-- talk 2nd time to access quest
yield("/target Blauthota <wait.1>")


yield("/lockon on")
--yield("/automove on <wait.2>")

yield("/pinteract <wait.5>")
yield("/send NUMPAD0 <wait.5>")


end


-- all aetheryte - Start Quest
function getAllAetheryte10()
yield("/visland execonce getAllAetheryte10")
yield("/wait 6")

yield("/echo done")
--yield("/targetnpc <wait.1>")
yield("/target Wyrnzoen <wait.1>")


yield("/lockon on")
--yield("/automove on <wait.2>")

yield("/pinteract <wait.5>")
yield("/send NUMPAD0 <wait.1>")

yield("/wait 6") -- before was wait 7
yield("/send NUMPAD0 <wait.1>")
yield("/send NUMPAD4 <wait.1>")
yield("/send NUMPAD0 <wait.1>")


end

getAllAetheryte1()
yield("/wait 2")

getAllAetheryte2()
yield("/wait 2")

getAllAetheryte3()
yield("/wait 2")

getAllAetheryte3_teleport()
yield("/wait 2")

getAllAetheryte4()
yield("/wait 2")

getAllAetheryte4_teleport()
yield("/wait 2")

getAllAetheryte5()
yield("/wait 2")

getAllAetheryte6()
yield("/wait 2")

getAllAetheryte7()
yield("/wait 2")

getAllAetheryte8()
yield("/wait 2")

getAllAetheryte9()
yield("/wait 2")

getAllAetheryte10()