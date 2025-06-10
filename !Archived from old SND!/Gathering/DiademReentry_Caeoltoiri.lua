--[[
  Description: Diadem Re entry
  Author: 
  Link: https://discord.com/channels/1162031769403543643/1162799234874093661/1192553288646787226
]]

routename = "paste route name here"

::Wait::
while not IsInZone(886) do
  yield("/wait 10")
end
yield("/visland stop")
yield("/wait 3")

::Enter::
if IsInZone(886) then
  if NeedsRepair(99) then
    while not IsAddonVisible("Repair") do
      yield("/generalaction repair")
      yield("/wait 0.5")
    end
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
  while GetCharacterCondition(34, false) and GetCharacterCondition(45, false) do
    if IsAddonVisible("ContentsFinderConfirm") then
      yield("/pcall ContentsFinderConfirm true 8")
    elseif GetTargetName()=="" then
      yield("/target Aurvael")
    elseif GetCharacterCondition(32, false) then
      yield("/pinteract")
    elseif IsAddonVisible("Talk") then
      yield("/click talk")
    elseif IsAddonVisible("SelectString") then
      yield("/pcall SelectString true 0")
    elseif IsAddonVisible("SelectYesno") then
      yield("/pcall SelectYesno true 0")
    end
    yield("/wait 0.5")
  end
  while GetCharacterCondition(35, false) do yield("/wait 1") end
  while GetCharacterCondition(35) do yield("/wait 1") end
  yield("/wait 3")
end

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
