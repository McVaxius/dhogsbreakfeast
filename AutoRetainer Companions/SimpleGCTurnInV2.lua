-- requres deliveroo, vnavmesh, autoretainer, lifestream
-- now with no configs and no running into aetherytes

function GCTurnIn()
  yield("/deliveroo enable")
  yield("/wait 1")

  dellyroo = true
  dellyroo = DeliverooIsTurnInRunning()
  while dellyroo do
    yield("/wait 5")
    dellyroo = DeliverooIsTurnInRunning()
  end
end

function BackToEstate()
  yield("/wait 5")
  yield("/tp Estate Hall")
  while IsInHousingDistrict() == false do
    yield("/wait 1")
  end
  yield("/automove")
  yield("/wait 1")
  yield("/automove")
end

function IsInGCTown()
  return (IsInZone(129) or IsInZone(132) or IsInZone(130)) and IsPlayerAvailable();
end

function IsInHousingDistrict()
  return (IsInZone(341) or IsInZone(340) or IsInZone(339) or IsInZone(641) or IsInZone(979)) and IsPlayerAvailable();
end

local chars = ARGetRegisteredEnabledCharacters()
for i = 0, chars.Count - 1 do
  yield("/ays relog " ..chars[i])
  yield("/wait 5")
  while IsPlayerAvailable() == false do
    yield("/wait 1")
  end
  TeleportToGCTown()
  while IsInGCTown() == false or NavIsReady() == false do
    yield("/wait 1")
  end
  if GetPlayerGC() == 2 then
    PathMoveTo(-67.7, -0.5, -8.6)
  elseif GetPlayerGC() == 1 then
    yield("/li aftcastle")
    while IsInZone(128) == false or IsPlayerAvailable() == false do
      yield("/wait 1")
    end
    PathMoveTo(93.4, 40.3, 75.3)
  elseif GetPlayerGC() == 3 then
    PathMoveTo(-142.2, 4.1, -106.6)
  end
    yield("/wait 3")
  while PathIsRunning() == true do
    yield("/wait 1")
  end
  GCTurnIn()
  BackToEstate()
end

yield("/ays multi")
yield("/pcraft stop")
