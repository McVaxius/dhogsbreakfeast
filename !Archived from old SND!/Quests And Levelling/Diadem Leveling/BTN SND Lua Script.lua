--[[
  Description: Full automation of Diadem, to allow leveling of an item. You need to initially click the first item you want to gather here, but afterwards can just walk away.
  Author: LegendofIceman
  Version: 5
  Class: Miner
  Link: https://discord.com/channels/1001823907193552978/1191076157882388581/1193291297067384873
]]


-- Insert the route name here that you named it in visland
routename = "Insert the name of your visland route here!"

-- Main loop, test to see if you're in the Diadem or not
::Wait::
while not IsInZone(886) do
  yield("/wait 10")
end
yield("/wait 3")

-- If you have the ability to repair your gear, this will allow you to do so. 
-- Currently will repair when your gear gets to 50% or below, but you can change the value to be whatever you would like
::RepairMode::
  if NeedsRepair(50) then
    yield("/generalaction repair")
    yield("/waitaddon Repair")
    yield("/pcall Repair true 0")
    yield("/wait 0.1")
    if IsAddonVisible("SelectYesno") then
      yield("/pcall SelectYesno true 0")
      yield("/wait 0.1")
    end
    while GetCharacterCondition(39) do yield("/wait 1") end
    yield("/wait 1")
    yield("/pcall Repair true -1")
  end

-- If not in the Diadem, then if you're standing in front of the NCP "Aurvael", this will queue you into it
::Enter::
if IsInZone(886) then
  while GetCharacterCondition(34, false) and GetCharacterCondition(45, false) do
    if IsAddonVisible("ContentsFinderConfirm") then
      yield("/pcall ContentsFinderConfirm true 8")
    elseif GetTargetName()=="" then
      yield("/target Aurvael")
    elseif GetCharacterCondition(32, false) then
      yield("/pinteract")
    end
    if IsAddonVisible("Talk") then yield("/click talk") end
    if IsAddonVisible("SelectString") then yield("/pcall SelectString true 0") end
    if IsAddonVisible("SelectYesno") then yield("/pcall SelectYesno true 0") end
    yield("/wait 0.5")
  end
  while GetCharacterCondition(35, false) do yield("/wait 1") end
  while GetCharacterCondition(35) do yield("/wait 1") end
  yield("/wait 3")
end

-- Once in the Diadem, moves you to the starting point to start the gathering loop.
::Move::
if IsInZone(939) then
  while GetCharacterCondition(77, false) do
    if GetCharacterCondition(4, false) then
      yield("/mount \"Company Chocobo\"")
      yield("/wait 3")
    else
      yield("/generalaction jump")
      yield("/wait 0.5")
    end
  end
  yield("/visland movedir 0 20 0")
  yield("/wait 1")
  yield("/visland movedir 50 0 -50")
  yield("/wait 1")
  yield("/visland moveto -235 30 -435")
  yield("/wait 1")
  while IsMoving() do yield("/wait 1") end
  yield("/visland exec "..routename)
end

goto Wait