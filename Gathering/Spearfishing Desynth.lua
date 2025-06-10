--[[
  Description: Spearfishing Auto Desynth
  The script allows you to have it running a visland route (while spearfishing) and when you get to a certain inventory amount it will pause for you and proceed to desynth all your collectables.
  Version: 5 (Now with a built in route, and ability to add your own!)
  Author: LegendofIceman
]]

--[[If you want to input your own route from visland, put it below here. It will take priority
over the default one that is included in this LUA script]]
routename = "Insert the name of your visland route here!"


--[[Route name below, it's in base64 (which in simple terms, means that the route is already in this LUA script 
This makes it to where you won't need to import the script to visland, and run it solely from this]]
earthbreak_aethersand = "H4sIAAAAAAAACu2VTU/cMBCG/wryOYz8Mf7KDRWQ9kBbqkpbinpwWZeN2sRVYkBotf+94yRbVIHUAycWbh5nMhk/ft/Jhr0PbWQ1Owl9Xn/vY/h5cBTzOvZD6FasYstw/zs1XR5YfblhH9PQ5CZ1rN6wL6yWyoHXwlXsgtWH2oBTqGzFvlJkLKBGVFsKUxcXx6zmFfsUVs0N1ZJAwVm6jW3sMqtFxRZdjn24yssmrz+UbIXI+b/7c685xrbprg/uAj0aqMlhne52edQd1f8Rfg3x4eWxZfrISZvyrpVFju28PBoz5uD8Jg55XpfCy9Dkh4olOk39u9StZhJ82vzctPGM8vi2esRJaA+I1okJlHFglRVWj6SMLJFD8zQp9X9ST1N6CVycKGdXExarQWhtJ/3YIibuxLPkI/dEPkqCcUUuIyYFxihuRkyapOTR4hum4jIBSpidyUgjikvpRk4oaFBxLl6fx7wHQxbDvx5Tzkg5zWiNILi19lnqEfthMq9AojE7TgocyqKlwslzMCike+NENyQ80ECSNH9GmyFoZSRhK6CsB+0d3/tf2bftH0ShbN45CQAA"

slots_remaining = 5
--How many slots do you want open before it starts to desynth? [Default is 5]

-- Starts the route/resumes it if you had it paused in visland
::Fishingstart::
  yield("/visland exectemp "..earthbreak_aethersand)
  yield("/visland exec "..routename)
  yield("/visland resume")
  yield("/wait 1")

-- Checks to see how much inventory space you have
::StartCount::
i_count = tonumber(GetInventoryFreeSlotCount())

-- Does a constant check to see if the current inventory amount is less than the amount of slots you wanted open
::InventoryTest::
while not (i_count <= slots_remaining) do
  --yield("/echo Slots Remaining: "..i_count)
  yield("/wait 1")
  i_count = tonumber(GetInventoryFreeSlotCount())
    if GetCharacterCondition(6) then
      if GetStatusStackCount(2778) >= 3 then
      yield("/ac \"Thaliak's Favor\"")
      end
    end
end
yield("/echo Inventory has reached "..i_count)
yield("/echo Time to Desynth")

-- test to see if you're still in the spearfishing menu
::GatherTest::
while GetCharacterCondition(6) do
  yield("/visland pause")
  yield("/wait 5")
end

-- Once out of spearfishing menu, dismounts and starts the process for desynthing the fish
::DesynthStart::
while (not GetCharacterCondition(6)) and not (GetCharacterCondition(39)) do
  yield("/visland pause")

  if GetCharacterCondition(4) then
    yield("/ac dismount")
    yield("/wait 3")
  end
  yield("/wait 0.5")

while (not GetCharacterCondition(6)) and (not GetCharacterCondition(39)) do
  if IsAddonVisible("PurifyResult") then
    yield("/pcall PurifyResult true 0")
    yield("/wait 4")
    yield("/echo Desynth all items in a row")
  elseif (not IsAddonVisible("PurifyResult")) and IsAddonVisible("PurifyItemSelector") then
    yield("/pcall PurifyItemSelector true 12 0")
    yield("/wait 4")
    yield("/echo Selecting first item")
  elseif (not IsAddonVisible("PurifyItemSelector")) and (not GetCharacterCondition(4)) then
    yield('/ac "Aetherial Reduction"')
    yield("/wait 0.5")
    yield("/echo Opening Desynth Menu")
  elseif IsAddonVisible("PurifyItemSelector") and GetCharacterCondition(4) then
    yield("/pcall PurifyItemSelector True -1")
    yield("/wait 0.5")
    yield("/echo Desynth window was open while on mount")
  elseif GetCharacterCondition(4) then
    yield("/ac dismount")
    yield("/wait 3")
    yield("/echo Dismount Test")
  end
 end
end 

-- checks to see if you're desynth'ing yet, then once it's done, resumes the route/process
::DesynthAll::
while GetCharacterCondition(39) do
  yield("/wait 3")
  end 
if not GetCharacterCondition(39) then
  yield("/pcall PurifyAutoDialog True -2")
  yield("/pcall PurifyItemSelector True -1")
  yield("/visland resume")
end

goto StartCount
