--[[
Author: slurpe
Link: https://discord.com/channels/1162031769403543643/1162799234874093661/1179870393901789306
Last update: 11-22-2023 9pm
Issue:
Version: 4.2
Updated code: adjust first fight Wharf Rat sometime will fall in hill issue, also shorten the fight

]]

function jobQuest1_1() -- Marauder to The Aftcastle teleport
yield("/echo jobQuest1_1() -- Marauder to The Aftcastle teleport")

yield("/visland execonce JobQuest1-1.1")

yield("/wait 9")


yield("/send Right <wait.0.5>")
yield("/send Right <wait.0.5>")
yield("/send Right <wait.0.5>")

--yield("/targetnpc <wait.1>")
yield("/target Aethernet Shard <wait.1>")
yield("/pinteract <wait.3>")
yield("/lockon on")
yield("/pinteract <wait.2>")
yield("/pcall SelectString true 0")
yield("/pcall TelepotTown false 11 1u <wait.1>") --
yield("/pcall TelepotTown false 11 1u <wait.1>")
yield("/wait 3")


end




function jobQuest1_2() -- The Aftcastle teleport to Baderon
yield("/echo jobQuest1_2() -- The Aftcastle teleport to Baderon")

yield("/visland execonce JobQuest1-1.2")
yield("/wait 1")
yield("/ac Sprint")
yield("/wait 17")

--[[
yield("/send Right <wait.0.5>")
yield("/send Right <wait.0.5>")
yield("/send Right <wait.0.5>")
]]

yield("/target Baderon <wait.1>")
--yield("/target Aethernet Shard <wait.1>")
yield("/pinteract <wait.6>")
 yield("/wait 6")

yield("/target Baderon <wait.1>")
yield("/lockon on")
yield("/pinteract <wait.6>")



--[[
yield("/lockon on")
yield("/pinteract <wait.2>")
yield("/pcall SelectString true 0")
yield("/pcall TelepotTown false 11 1u <wait.1>") --
yield("/pcall TelepotTown false 11 1u <wait.1>")
yield("/wait 3")
]]

end



function jobQuest1_3() -- The Aftcastle teleport to Baderon
yield("/echo jobQuest1_3() -- The Aftcastle teleport to Baderon")

yield("/visland execonce JobQuest1-1.3")

yield("/wait 5")


yield("/send Right <wait.0.5>")
-- yield("/send Right <wait.0.5>")
-- wyield("/send Right <wait.0.5>")


yield("/target Skaenrael <wait.1>")
--yield("/target Aethernet Shard <wait.1>")
yield("/pinteract <wait.1>")

yield("/click select_icon_string2")
yield("/wait 5")

yield("/visland execonce JobQuest1-1.4")
yield("/wait 11")

yield("/waitaddon _ActionBar <maxwait.600><wait.2>")

yield("/send Right <wait.1>")

yield("/hold W <wait.1>")
yield("/release W <wait.0.5>")

yield("/waitaddon _ActionBar <maxwait.600><wait.2>")
yield("/send Right <wait.1>")

--[[
yield("/hold W <wait.1>")
yield("/release W <wait.0.5>")
yield("/waitaddon _ActionBar <maxwait.600><wait.1>")
yield("/send Right <wait.1>")
]]



end






function jobQuest1_4() -- Way of the Marauder
yield("/echo jobQuest1_4() -- Way of the Marauder ")

yield("/visland execonce JobQuest1-1.5")
yield("/wait 11")

-- Fight 3/3 hunt monster - will run to three location and find monster name follow attack until reach to 3 fight ended

local monsterName = 'Wharf Rat'

for i = 1, 3 do


    if i == 1 then
    yield("/visland moveto 9.666 43.082 110.988 ")
    yield("/wait 1")
    elseif i == 2 then
    yield("/visland moveto 36.338 44.321 90.278 ")
    yield("/wait 6")
    elseif i == 3 then
    yield("/visland moveto 45.693 44.794 96.112 ")
    yield("/wait 2")
    end -- end if

    yield("/rotation Auto <wait.0.5>")
    repeat

        yield("/echo "..i.." "..monsterName)  -- change monster name
        -- Perform actions until the condition is met
        yield("/target "..monsterName.." <wait.0.5>")

        yield("/lockon on <wait.0.5>")
        yield("/automove on <wait.0.5>")


    until GetCharacterCondition(26)

    repeat
        -- Perform actions while the condition is false

        yield("/wait 5")

        yield("/automove off <wait.0.5>")
    until GetCharacterCondition(26) == false
    yield("/rotation Cancel <wait.0.5>")

end  -- end of for loop
yield("/echo Done fighting 3/3")

-- end of Fight

yield("/wait 2")

-- Fight 3/3 hunt monster - will run to three location and find monster name follow attack until reach to 3 fight ended

local monsterName = 'Little Ladybug'

for i = 1, 3 do


    if i == 1 then
    yield("/visland moveto 40.360 44.330 101.218 ")
    yield("/wait 9")
    elseif i == 2 then
    yield("/visland moveto 78.910 46.516 179.343 ")
    yield("/wait 14")
    elseif i == 3 then
    yield("/visland moveto 78.910 46.516 179.343 ")
    yield("/wait 3")
    end -- end if

    yield("/rotation Auto <wait.0.5>")
    repeat

        yield("/echo "..i.." "..monsterName)  -- change monster name
        -- Perform actions until the condition is met
        yield("/target "..monsterName.." <wait.1>")

        yield("/lockon on <wait.0.5>")
        yield("/automove on <wait.1>")


    until GetCharacterCondition(26)

    repeat
        -- Perform actions while the condition is false

        yield("/wait 10")

        yield("/automove off <wait.1>")
    until GetCharacterCondition(26) == false
    yield("/rotation Cancel <wait.0.5>")

end  -- end of for loop
yield("/echo Done fighting 3/3")

-- end of Fight

yield("/wait 2")

-- Fight 3/3 hunt monster - will run to three location and find monster name follow attack until reach to 3 fight ended

local monsterName = 'Lost Lamb'

for i = 1, 3 do


    if i == 1 then
    yield("/visland moveto 50.119 48.094 190.237 ")
    yield("/wait 7")
    elseif i == 2 then
    yield("/visland moveto 59.972 49.513 194.274")
    yield("/wait 4")
    elseif i == 3 then
    yield("/visland moveto 58.105 48.594 190.892 ")
    yield("/wait 4")
    end -- end if

    yield("/rotation Auto <wait.0.5>")
    repeat

        yield("/echo "..i.." "..monsterName)  -- change monster name
        -- Perform actions until the condition is met
        yield("/target "..monsterName.." <wait.1>")

        yield("/lockon on <wait.0.5>")
        yield("/automove on <wait.1>")


    until GetCharacterCondition(26)

    repeat
        -- Perform actions while the condition is false

        yield("/wait 10")

        yield("/automove off <wait.1>")
    until GetCharacterCondition(26) == false
    yield("/rotation Cancel <wait.0.5>")

end  -- end of for loop
yield("/echo Done fighting 3/3")

-- end of Fight



--[[
yield("/wait 10")
yield("/rotation Auto <wait.1>")  -- rat

for i=1, 3 do
yield("/echo "..i)
yield("/visland moveto 28.157 43.654 149.881 ")
yield("/wait 4")

yield("/visland moveto 33.807 44.245 153.039 ")
yield("/wait 4")

yield("/visland moveto 33.807 44.245 153.039 ")
yield("/wait 4")

yield("/visland moveto 32.993 44.193 142.072 ")
yield("/wait 4")

yield("/visland moveto 32.945 44.150 148.847 ")
yield("/wait 3")
yield("/wait 10")
end -- for loop
yield("/rotation Cancel <wait.1>")


-- move to next point
yield("/visland moveto 34.237 44.255 149.491 ")
yield("/wait 5")
yield("/visland moveto 59.032 45.181 169.593 ")
yield("/wait 5")
yield("/visland moveto 56.135 47.545 187.850 ")
yield("/wait 5")

yield("/rotation Auto <wait.1>") -- sheep
for i=1, 2 do
yield("/echo "..i)
yield("/visland moveto 50.119 48.094 190.237 ")
yield("/wait 6")

yield("/visland moveto 53.716 50.184 195.878 ")
yield("/wait 6")

yield("/visland moveto 59.972 49.513 194.274 ")
yield("/wait 6")

yield("/visland moveto 55.226 46.197 184.424 ")
yield("/wait 6")

yield("/visland moveto 58.105 48.594 190.892 ")
yield("/wait 6")
yield("/wait 10")
end -- for loop
yield("/rotation Cancel <wait.1>")



-- move to next point
yield("/visland moveto 70.100 46.203 181.009 ")
yield("/wait 5")
yield("/visland moveto 85.798 47.099 180.684 ")
yield("/wait 5")

yield("/rotation Auto <wait.1>") -- lady bug
for i=1, 2 do
yield("/echo "..i)
yield("/visland moveto 88.936 47.171 176.120 ")
yield("/wait 9")

yield("/visland moveto 79.685 46.550 179.298 ")
yield("/wait 9")

yield("/visland moveto 88.388 47.814 186.031 ")
yield("/wait 9")
yield("/wait 10")
end -- for loop

yield("/rotation Cancel <wait.1>")
]] -- end of old code for reused


end




function jobQuest1_5() -- Summerford Farms
yield("/echo jobQuest1_5() -- Summerford Farms")


yield("/visland execonce JobQuest1-1.6")

yield("/wait 1")
yield("/macroicon Sprint")
yield("/ac Sprint")
yield("/ada generalaction 4")

-- 1
yield("/wait 1")
yield("/echo 1")
yield("/macroicon Sprint")
yield("/ac Sprint")
yield("/ada generalaction 4")
yield("/wait 23")

-- 2
yield("/echo 2")
yield("/macroicon Sprint")
yield("/ac Sprint")
yield("/ada generalaction 4")
yield("/wait 2")
yield("/macroicon Sprint")
yield("/ac Sprint")
yield("/ada generalaction 4")
yield("/wait 23")

-- 3
yield("/echo 3")
yield("/macroicon Sprint")
yield("/ac Sprint")
yield("/ada generalaction 4")
yield("/wait 23")

-- 4
yield("/echo 4")
yield("/macroicon Sprint")
yield("/ac Sprint")
yield("/ada generalaction 4")
yield("/wait 10")


yield("/target Aetheryte <wait.1>")
yield("/lockon on")
yield("/pinteract <wait.10>")
yield("/waitaddon _ActionBar <maxwait.600><wait.5>")

yield("/target Aetheryte <wait.1>")
yield("/lockon on")
yield("/pinteract <wait.5>")

yield("/click select_string2 <wait.2>")
yield("/wait 2")
yield("/click select_yes <wait.2>")
yield("/wait 2")

yield("/macroicon Sprint")
yield("/ac Sprint")
yield("/ada generalaction 4")
yield("/wait 1")

yield("/visland moveto 215.074 112.979 -249.868 ")
yield("/wait 3")

yield("/visland moveto 200.290 112.521 -233.228 ")
yield("/wait 5")

yield("/visland moveto 206.279 112.838 -223.977 ")
yield("/wait 3")


--yield("/send Left <wait.1>")
--yield("/send Left <wait.1>")



yield("/target Staelwyrn <wait.1>")
yield("/lockon on")
yield("/pinteract <wait.5>")
yield("/echo Click the reward ")
yield("/wait 3")
--yield("/click select_string1 <wait.1>") -- check this is correct, pcall SelectString true 0
yield("/pcall JournalResult true 0 27634 <wait.1>")
yield("/wait 3")

yield("/send Right <wait.1>")
yield("/send Right <wait.1>")
yield("/target Staelwyrn <wait.1>")
yield("/lockon on")
yield("/pinteract <wait.5>")

yield("/wait 3")



-- Teleport back Lisma
yield("/tp Limsa Lominsa Lower Decks <wait.5>")
yield("/waitaddon _ActionBar <maxwait.600><wait.5>")
yield("/target Aetheryte <wait.6>")

yield("/hold D <wait.0.3>")
yield("/release D <wait.0.1>")

yield("/hold W <wait.1.5>")
yield("/release W <wait.0.1>")

yield("/lockon on")
yield("/automove on <wait.2>")

yield("/pinteract <wait.2>")
yield("/pcall SelectString true 0")
yield("/pcall TelepotTown false 11 5u <wait.1>")
yield("/pcall TelepotTown false 11 5u <wait.1>")
yield("/waitaddon _ActionBar <maxwait.600><wait.5>")


end


function jobQuest1_6() -- Report back  Marauder quest
yield("/echo jobQuest1_6() -- Report back  Marauder quest")

yield("/visland execonce JobQuest1-1.7")
yield("/wait 8")

yield("/target Wyrnzoen <wait.1>")
yield("/lockon on")
yield("/pinteract <wait.5>")
yield("/wait 5")

yield("/target Wyrnzoen <wait.1>")
yield("/lockon on")
yield("/pinteract <wait.5>")
yield("/wait 2")



end


--yield("/at")
yield("/wait 1")

 jobQuest1_1()
yield("/wait 2")
 jobQuest1_2() -- 2nd talk Baderon need check again
yield("/wait 2")
 jobQuest1_3()
yield("/wait 2")

 jobQuest1_4()
yield("/wait 2")

jobQuest1_5()
yield("/wait 2")



jobQuest1_6()