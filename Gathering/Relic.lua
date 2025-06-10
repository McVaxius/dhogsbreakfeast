--[[
  Description: auto gather collectables for the miner or botanist relic steps
  Author: gabibbomannaro 
  Link: https://discord.com/channels/1162031769403543643/1162799234874093661/1174327265870483456
]]

if (GetClassJobId() == 17) then
 action_name_one_more = "Ageless Words"
 action_name_meticulous = "Meticulous Woodsman"
elseif (GetClassJobId() == 16) then
 action_name_one_more = "Solid Reason"
 action_name_meticulous = "Meticulous Prospector"
end

function action(action_name)
  yield("/action \""..action_name.."\"")
  yield("/wait 1")
  while(GetCharacterCondition(42)) do
    yield("/wait 0.2")
  end
  yield("/wait 0.5")
end

function current_coll()
  return tonumber(GetNodeText("GatheringMasterpiece", 134))
end

function actions_left()
  return tonumber(GetNodeText("GatheringMasterpiece", 55))
end

function collect_all()
  while((actions_left() > 0) and IsAddonVisible("GatheringMasterpiece")) do
    yield("/echo Actions left: "..actions_left())
    action("Collect")
  end
end

function full_loop()
  yield("/echo Doing high GP gathering loop...")

  action("Scrutiny")
  action(action_name_meticulous)
  action("Scrutiny")
  action(action_name_meticulous)

  if current_coll() == 1000 then
    action("Collect")
  elseif current_coll() > 800 then
    action(action_name_meticulous)
  else
    action("Scour")
  end

  action(action_name_one_more)
  if current_coll() < 1000 then
    action(action_name_meticulous)
  end

  if (HasStatus("Eureka Moment")) then
    if actions_left() > 3 then
      action("Collect")
    end
    action("Wise to the World")
  end

  collect_all()
end

function limited_loop()
  yield("/echo Doing low GP loop...")
  action("Scour")
  action(action_name_meticulous)
  action(action_name_meticulous)
  if (current_coll() < 570) then
    action(action_name_meticulous)
  end
  collect_all()
end

function main()
  while(not IsAddonVisible("GatheringMasterpiece")) do
    yield("/echo Waiting for node...")
    yield("/wait 1")
  end

  yield("/echo At node.")
  current_gp = GetGp()
  yield("/echo Current GP: "..current_gp)

  if (current_gp > 700) then
    full_loop()
  else
    limited_loop()
  end
  yield("/echo Done gathering!")
  yield("/wait 3")
end

while(true) do
  main()
end