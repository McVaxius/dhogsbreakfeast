--[[
Author: slurpe
Link: https://discord.com/channels/1162031769403543643/1162799234874093661/1179870443197452328
Last update: 11-22-2023 9pm
Issue:
Version: 4.1
Updated code: add Press W, Release W, Limsa teleport D, W to hold rlease too


]]

function jobQuest3_1()  --  Axe in Stone part 2
yield("/echo jobQuest3_1()  --  Axe in Stone part 2")

-- Axe in the Stone - Megalocrab
yield("/visland execonce JobQuest2-1.2")
yield("/wait 20")

yield("/target Aethernet Shard <wait.1>" )
yield("/lockon on")
yield("/pinteract <wait.5>")
yield("/pcall SelectString true 0")
yield("/pcall TelepotTown false 11 8u <wait.1>") -- Lower La Noscea
yield("/pcall TelepotTown false 11 8u <wait.1>")
yield("/waitaddon _ActionBar <maxwait.600><wait.5>")


yield("/visland execonce JobQuest3-1.1")


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

yield("/targetnpc <wait.1>")
yield("/lockon on")
yield("/pinteract <wait.10>")


-- Fight 3/3 hunt monster - will run to three location and find monster name follow attack until reach to 3 fight ended

local monsterName = 'Aurelia'

for i = 1, 3 do


    if i == 1 then
    yield("/visland moveto 143.310 37.352 41.374 ")
    yield("/wait 3")
    elseif i == 2 then
    yield("/visland moveto 151.889 38.927 42.855 ")
    yield("/wait 3")
    elseif i == 3 then
    yield("/wait 20")
    yield("/visland moveto 143.310 37.352 41.374")
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

        yield("/wait 12")

        yield("/automove off <wait.1>")
    until GetCharacterCondition(26) == false
    yield("/rotation Cancel <wait.0.5>")

end  -- end of for loop
yield("/echo Done fighting 3/3")

-- end of Fight

--[[ old code use as backup
-- Aurelia
for i=1, 2 do
--yield("/echo "..i)

yield("/rotation Auto <wait.0.5>")
yield("/echo 1")
yield("/visland moveto 143.310 37.352 41.374 ")
yield("/wait 8")
yield("/rotation Cancel <wait.0.5>")

yield("/rotation Auto <wait.0.5>")
yield("/echo 2")
yield("/visland moveto 151.889 38.927 42.855 ")
yield("/wait 8")
yield("/rotation Cancel <wait.0.5>")

yield("/rotation Auto <wait.0.5>")
yield("/echo 3")
yield("/visland moveto 151.253 39.932 37.982 ")
yield("/wait 8")
yield("/rotation Cancel <wait.0.5>")

yield("/rotation Auto <wait.0.5>")
yield("/echo 4")
yield("/visland moveto 185.809 41.756 52.155 ")
yield("/wait 8")
yield("/rotation Cancel <wait.0.5>")

yield("/rotation Auto <wait.0.5>")
yield("/echo 5")
yield("/visland moveto 181.121 41.583 50.715 ")
yield("/wait 8")


yield("/wait 12")
yield("/rotation Cancel <wait.0.5>")
end -- for loop
]] -- end of old code use as backup




yield("/visland execonce JobQuest3-1.2")
yield("/wait 15")
yield("/click select_yes <wait.1>")
yield("/wait 5")


-- Quest fight
yield("/wait 5")
yield("/rotation Auto <wait.1>") -- Quest
for i=1, 1 do
--yield("/echo "..i)

yield("/rotation Auto <wait.0.5>")
yield("/echo 1")
yield("/visland moveto 161.235 33.576 93.705 ")
yield("/wait 25")
yield("/rotation Cancel <wait.0.5>")

yield("/rotation Auto <wait.0.5>")
yield("/echo 2")
yield("/visland moveto 177.837 31.892 74.761 ")
yield("/wait 25")
yield("/rotation Cancel <wait.0.5>")

yield("/rotation Auto <wait.0.5>")
yield("/echo 3")
yield("/visland moveto 176.722 32.617 71.844 ")
yield("/wait 25")
yield("/rotation Cancel <wait.0.5>")

yield("/rotation Auto <wait.0.5>")
yield("/echo 4")
yield("/visland moveto 193.424 37.285 65.168 ")
yield("/wait 30")

yield("/rotation Cancel <wait.0.5>")
yield("/waitaddon _ActionBar <maxwait.600><wait.10>")

 end -- for loop
yield("/rotation Cancel <wait.1>")

yield("/wait 3")

yield("/visland execonce JobQuest3-1.3")


-- 1
yield("/wait 1")
yield("/echo 1")
yield("/macroicon Sprint")
yield("/ac Sprint")
yield("/ada generalaction 4")
yield("/wait 22")


-- Fight 3/3 hunt monster - will run to three location and find monster name follow attack until reach to 3 fight ended

local monsterName = 'Wild Dodo'

for i = 1, 3 do


    if i == 1 then
    yield("/visland moveto 310.140 47.919 -2.234")
    yield("/wait 3")
    elseif i == 2 then
    yield("/visland moveto 344.997 52.626 -35.160 ")
    yield("/wait 7")
    elseif i == 3 then
    yield("/visland moveto 364.592 52.418 -21.103 ")
    yield("/wait 7")
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

        yield("/wait 15")

        yield("/automove off <wait.1>")
    until GetCharacterCondition(26) == false
    yield("/rotation Cancel <wait.0.5>")

end  -- end of for loop
yield("/echo Done fighting 3/3")

-- end of Fight


--[[ old code use as backup
yield("/rotation Auto <wait.1>") -- Wild Dodo
for i=1, 2 do
--yield("/echo "..i)

yield("/rotation Auto <wait.0.5>")
yield("/echo 1")
yield("/visland moveto 299.938 48.143 0.933 ")
yield("/wait 10")
yield("/rotation Cancel <wait.0.5>")

yield("/rotation Auto <wait.0.5>")
yield("/echo 2")
yield("/visland moveto 303.377 48.935 -3.890 ")
yield("/wait 10")
yield("/rotation Cancel <wait.0.5>")

yield("/rotation Auto <wait.0.5>")
yield("/echo 3")
yield("/visland moveto 308.999 47.482 0.766 ")
yield("/wait 10")
yield("/rotation Cancel <wait.0.5>")

yield("/rotation Auto <wait.0.5>")
yield("/echo 4")
yield("/visland moveto 312.053 48.958 -7.619 ")
yield("/wait 10")
yield("/rotation Cancel <wait.0.5>")

yield("/rotation Auto <wait.0.5>")
yield("/echo 5")
yield("/visland moveto 362.213 51.658 -15.080 ")
yield("/wait 10")
yield("/rotation Cancel <wait.0.5>")

yield("/rotation Auto <wait.0.5>")
yield("/echo 6")
yield("/visland moveto 364.592 52.418 -21.103 ")
yield("/wait 10")
yield("/rotation Cancel <wait.0.5>")

yield("/rotation Auto <wait.0.5>")
yield("/echo 7")
yield("/visland moveto 371.336 52.220 -13.292 ")
yield("/wait 10")

yield("/wait 10")
yield("/rotation Cancel <wait.0.5>")
 end -- for loop
yield("/rotation Cancel <wait.1>")
]] -- end of old code use as backup



yield("/visland execonce JobQuest3-1.4")


-- 1
yield("/wait 1")
yield("/echo 1")
yield("/macroicon Sprint")
yield("/ac Sprint")
yield("/ada generalaction 4")
yield("/wait 21")


yield("/target Ahctkoen <wait.1>")
yield("/lockon on")
yield("/pinteract <wait.10>")




yield("/visland execonce JobQuest3-1.5")

-- 1
yield("/wait 1")
yield("/echo 1")
yield("/macroicon Sprint")
yield("/ac Sprint")
yield("/ada generalaction 4")
yield("/wait 17")


-- Fight 3/3 hunt monster - will run to three location and find monster name follow attack until reach to 3 fight ended

local monsterName = 'Tiny Mandragora'

for i = 1, 3 do


    if i == 1 then
    yield("/visland moveto 579.782 63.485 -160.081")
    yield("/wait 3")
    elseif i == 2 then
    yield("/visland moveto 581.467 63.721 -167.809 ")
    yield("/wait 3")
    elseif i == 3 then
    yield("/visland moveto 608.359 63.185 -154.235 ")
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

        yield("/wait 15")

        yield("/automove off <wait.1>")
    until GetCharacterCondition(26) == false
    yield("/rotation Cancel <wait.0.5>")

end  -- end of for loop
yield("/echo Done fighting 3/3")

-- end of Fight



--[[ old code use as backup
-- Tiny Mandragora
for i=1, 1 do
--yield("/echo "..i)

yield("/rotation Auto <wait.0.5>")
yield("/echo 1")
yield("/visland moveto 579.782 63.485 -160.081 ")
yield("/wait 15")
yield("/rotation Cancel <wait.0.5>")

yield("/rotation Auto <wait.0.5>")
yield("/echo 2")
yield("/visland moveto 581.467 63.721 -167.809 ")
yield("/wait 15")
yield("/rotation Cancel <wait.0.5>")

yield("/rotation Auto <wait.0.5>")
yield("/echo 3")
yield("/visland moveto 581.314 63.463 -159.352 ")
yield("/wait 15")
yield("/rotation Cancel <wait.0.5>")

yield("/rotation Auto <wait.0.5>")
yield("/echo 4")
yield("/visland moveto 613.575 62.710 -159.703 ")
yield("/wait 15")
yield("/rotation Cancel <wait.0.5>")

yield("/rotation Auto <wait.0.5>")
yield("/echo 5")
yield("/visland moveto 613.477 62.035 -152.192 ")
yield("/wait 15")
yield("/rotation Cancel <wait.0.5>")

-- remove last node
yield("/rotation Auto <wait.0.5>")
yield("/echo 6")
yield("/visland moveto 608.359 63.185 -154.235 ")
yield("/wait 15")


yield("/wait 15")
yield("/rotation Cancel <wait.0.5>")
 end -- for loop
]] -- end old code use as backup




yield("/visland execonce JobQuest3-1.6")

-- 1
yield("/wait 1")
yield("/echo 1")
yield("/macroicon Sprint")
yield("/ac Sprint")
yield("/ada generalaction 4")
yield("/wait 9")



yield("/target Roeganlona <wait.1>")
yield("/lockon on")
yield("/pinteract <wait.10>")



yield("/visland moveto 598.424 61.515 -108.217 ")
yield("/wait 4")

yield("/send Right <wait.1>")

yield("/hold W <wait.1>")
yield("/release W <wait.0.5>")

yield("/wait 5")

yield("/send Right <wait.1>")

yield("/hold W <wait.1>")
yield("/release W <wait.0.5>")

yield("/wait 5")

yield("/click select_string1 <wait.2>")
yield("/pcall HousingSelectBlock false 0 <wait.2>")

yield("/waitaddon _ActionBar <maxwait.600><wait.1>")



yield("/visland execonce JobQuest3-1.7")
yield("/wait 10")

yield("/target Storm Recruit <wait.1>")
yield("/lockon on")
yield("/pinteract <wait.10>")

yield("/target Storm Recruit <wait.1>")
yield("/lockon on")
yield("/pinteract <wait.10>")



yield("/visland execonce JobQuest3-1.8")
yield("/wait 10")

yield("/send Right <wait.1>")

yield("/hold W <wait.1>")
yield("/release W <wait.0.5>")
yield("/wait 3")

yield("/pcall SelectString true 1 <wait.1>")
yield("/wait 3")


yield("/visland execonce JobQuest3-1.9")

-- 1
yield("/wait 1")
yield("/echo 1")
yield("/macroicon Sprint")
yield("/ac Sprint")
yield("/ada generalaction 4")
yield("/wait 22")




yield("/target Ahctkoen <wait.1>") -- complete Where the Heart is Mist quest
yield("/lockon on")
yield("/pinteract <wait.10>")
yield("/wait 5")


-- Teleport back Lisma
yield("/tp Limsa Lominsa Lower Decks <wait.5>")
yield("/waitaddon _ActionBar <maxwait.600><wait.5>")
yield("/target Aetheryte <wait.7>")

yield("/hold D <wait.0.3>")
yield("/release D <wait.0.1>")

yield("/hold W <wait.1.5>")
yield("/release W <wait.0.1>")

yield("/lockon on")
yield("/automove on <wait.3>")

yield("/pinteract <wait.2>")
yield("/pcall SelectString true 0 <wait.1>")
yield("/pcall TelepotTown false 11 5u <wait.1>")
yield("/pcall TelepotTown false 11 5u <wait.1>")
yield("/waitaddon _ActionBar <maxwait.600><wait.5>")




yield("/visland execonce JobQuest1-1.7")
yield("/wait 8")

yield("/target Wyrnzoen <wait.1>")
yield("/lockon on")
yield("/pinteract <wait.5>")
yield("/pcall JournalResult true 0 3005 <wait.1>")

yield("/wait 5")

yield("/target Wyrnzoen <wait.1>")
yield("/lockon on")
yield("/pinteract <wait.10>")



end

jobQuest3_1()