--[[
  Description: need repeat spring if you have those or you adjust the wait timeonce on the boat run to edge start casting
    you need rotation solver - auto fight use rotation for each char
  Author: slurpe
  Link: https://discord.com/channels/1162031769403543643/1162799234874093661/1179872327115219144
]]

function MSQ1_1() --Dressed to Call
yield("/echo MSQ1-1()  --  Dressed to Call")


yield('/tp Summerford Farms <wait.5>')
yield("/waitaddon _ActionBar <maxwait.600><wait.5>")


yield("/macroicon Sprint")
yield("/ac Sprint")
yield("/ada generalaction 4")
yield("/wait 1")

yield("/visland moveto 215.074 112.979 -249.868 ")
yield("/wait 2")

yield("/visland moveto 200.290 112.521 -233.228 ")
yield("/wait 4")

yield("/visland moveto 206.279 112.838 -223.977 ")
yield("/wait 3")

yield("/target Staelwyrn <wait.1>")
yield("/lockon on")
yield("/pinteract <wait.5>")
yield("/echo Click the reward ")
yield("/wait 3")

yield("/pcall JournalResult true 0 5824 <wait.1>")  -- take Allagan Bronze piece
yield("/wait 3")



yield("/target Staelwyrn <wait.1>")
yield("/lockon on")
yield("/pinteract <wait.5>")


yield("/visland execonce MSQ1-1.1")

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
yield("/wait 1")
yield("/macroicon Sprint")
yield("/ac Sprint")
yield("/ada generalaction 4")
yield("/wait 23")

-- 3
yield("/echo 3")
yield("/macroicon Sprint")
yield("/ac Sprint")
yield("/ada generalaction 4")
yield("/wait 1")
yield("/macroicon Sprint")
yield("/ac Sprint")
yield("/ada generalaction 4")
yield("/wait 12")



yield("/target Stone Monument <wait.1>")
yield("/lockon on")
yield("/pinteract <wait.10>")

yield("/click select_yes <wait.1>")
yield("/wait 5")



-- Quest fight
yield("/wait 5")

for i=1, 1 do
--yield("/echo "..i)

yield("/rotation Auto <wait.0.5>")
yield("/echo 1")
yield("/visland moveto -55.484 26.818 -122.766 ")
yield("/wait 95")                                 -- time it next time
yield("/rotation Cancel <wait.0.5>")


yield("/rotation Cancel <wait.0.5>")
yield("/waitaddon _ActionBar <maxwait.600><wait.10>")

 end -- for loop

yield("/wait 3")




yield('/tp Summerford Farms <wait.5>')
yield("/waitaddon _ActionBar <maxwait.600><wait.5>")


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

yield("/target Staelwyrn <wait.1>")
yield("/lockon on")
yield("/pinteract <wait.5>")
yield("/echo Click the reward ")
yield("/wait 3")

yield("/pcall JournalResult true 0 4551 <wait.1>")  -- take potion
yield("/wait 3")


yield("/target Staelwyrn <wait.1>")
yield("/lockon on")
yield("/pinteract <wait.5>")
yield("/wait 3")


end

function MSQ1_2() -- Washed Up
yield("/echo MSQ1_2() -- Washed Up")


yield("/visland execonce MSQ1-1.2")

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
yield("/wait 22")

yield("/send Right")
yield("/send Right")
yield("/send Right")
yield("/send Right")

yield("/target Wauter <wait.1>")
yield("/lockon on")
yield("/pinteract <wait.5>")
yield("/wait 3")
yield("/click select_string1 <wait.1>")


yield("/visland execonce MSQ1-1.3")

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
yield("/wait 17")



yield("/target Sozai Rarzai <wait.1>")
yield("/lockon on")
yield("/pinteract <wait.5>")
yield("/wait 2")
yield("/click select_string1 <wait.1>")



yield("/visland execonce MSQ1-1.4")

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
yield("/wait 21")


yield("/target Sevrin <wait.1>")
yield("/lockon on")
yield("/pinteract <wait.5>")
yield("/wait 1")
-- yield("/click select_string1 <wait.1>")  -- don't have one check again (don't have)


yield("/visland execonce MSQ1-1.5")

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
yield("/wait 19")


yield("/target Aylmer <wait.1>")
yield("/lockon on")
yield("/pinteract <wait.5>")
yield("/wait 1")
yield("/click select_string1 <wait.1>")




yield("/visland execonce MSQ1-1.6")

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
yield("/wait 14")

yield("/send Left")
yield("/send Left")
yield("/send Left")
yield("/send Left")
yield("/send Left")
yield("/send Left")
yield("/wait 1")

yield("/target Eyrimhus <wait.1>")
yield("/lockon on")
yield("/pinteract <wait.5>")
yield("/wait 1")
yield("/click select_string1 <wait.1>")


yield("/wait 3")

yield('/tp Summerford Farms <wait.5>')
yield("/waitaddon _ActionBar <maxwait.600><wait.5>")


yield("/macroicon Sprint")
yield("/ac Sprint")
yield("/ada generalaction 4")
yield("/wait 1")

yield("/visland moveto 215.074 112.979 -249.868 ")
yield("/wait 2")

yield("/visland moveto 200.290 112.521 -233.228 ")
yield("/wait 4")

yield("/visland moveto 206.279 112.838 -223.977 ")
yield("/wait 2.5")

yield("/target Staelwyrn <wait.1>")
yield("/lockon on")
yield("/pinteract <wait.5>")
yield("/echo Click the reward ")
yield("/wait 3")

yield("/target Staelwyrn <wait.1>")
yield("/lockon on")
yield("/pinteract <wait.5>")
yield("/echo Click the reward ")
yield("/wait 3")



end

function MSQ1_3() -- Double Dealing
yield("/echo MSQ1_3() -- Double Dealing")


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

yield("/pinteract <wait.5>")
yield("/pcall SelectString true 0")
yield("/pcall TelepotTown false 11 7u <wait.1>") -- Lower La Noscea
yield("/pcall TelepotTown false 11 7u <wait.1>")
yield("/waitaddon _ActionBar <maxwait.600><wait.5>")

yield("/visland execonce MSQ1-1.7")

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
yield("/wait 20")

yield("/target Sevrin <wait.1>")
yield("/lockon on")
yield("/doubt <wait.5>")
yield("/wait 3")

yield("/visland execonce MSQ1-1.8")
yield("/wait 10")

-- Quest fight
yield("/wait 1")

for i=1, 1 do
--yield("/echo "..i)

yield("/rotation Auto <wait.0.5>")
yield("/echo 1")
yield("/visland moveto 191.301 46.258 124.413 ")
yield("/wait 30")                                 -- time it next time
yield("/rotation Cancel <wait.0.5>")


yield("/waitaddon _ActionBar <maxwait.600><wait.10>")

 end -- for loop


yield("/wait 3")


yield("/target Eyrimhus <wait.1>")
yield("/lockon on")
yield("/pinteract <wait.10>")
yield("/wait 3")


yield("/visland moveto 192.706 46.307 120.459 ")
yield("/wait 4")


yield("/target Sozai Rarzai <wait.1>")
yield("/lockon on")
yield("/pinteract <wait.10>")
yield("/wait 3")


yield("/target Aylmer <wait.1>")
yield("/lockon on")
yield("/pinteract <wait.10>")
yield("/wait 3")



yield("/visland moveto 133.098 45.740 133.987 ")
yield("/wait 11")

yield("/target Sevrin <wait.1>")
yield("/lockon on")
yield("/pinteract <wait.10>")
yield("/wait 3")

yield("/target Sack of Oranges <wait.1>")
yield("/lockon on")
yield("/pinteract <wait.10>")
yield("/wait 3")



yield("/visland moveto 179.243 64.483 291.560")

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
yield("/wait 20")

yield("/target Ossine <wait.1>")
yield("/lockon on")
yield("/pinteract <wait.10>")
yield("/wait 3")


yield('/tp Summerford Farms <wait.5>')
yield("/waitaddon _ActionBar <maxwait.600><wait.5>")


yield("/macroicon Sprint")
yield("/ac Sprint")
yield("/ada generalaction 4")
yield("/wait 1")

yield("/visland moveto 215.074 112.979 -249.868 ")
yield("/wait 2")

yield("/visland moveto 200.290 112.521 -233.228 ")
yield("/wait 4.5")

yield("/visland moveto 206.279 112.838 -223.977 ")
yield("/wait 3.5")

yield("/target Staelwyrn <wait.1>")
yield("/lockon on")
yield("/pinteract <wait.5>")
yield("/echo Click the reward ")
yield("/wait 3")

yield("/pcall JournalResult true 0 5824 <wait.1>")  -- take Allagan bronze piece
yield("/wait 3")




yield("/visland moveto 203.606 111.923 -215.275 ")
yield("/wait 2.5")

yield("/target Gurcant <wait.1>")
yield("/lockon on")
yield("/pinteract <wait.5>")
yield("/echo Click the reward ")
yield("/wait 3")

end

function MSQ1_4() -- Loam Maintenance still have problem double check
yield("/echo MSQ1_4() -- Loam Maintenance")



yield("/visland execonce MSQ1-1.9")

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
yield("/wait 1")
yield("/macroicon Sprint")
yield("/ac Sprint")
yield("/ada generalaction 4")
yield("/wait 1")
yield("/echo 2")
yield("/macroicon Sprint")
yield("/ac Sprint")
yield("/ada generalaction 4")
yield("/wait 3")




yield("/target Rhotwyda <wait.1>")
yield("/lockon on")
yield("/pinteract <wait.5>")
yield("/wait 3")



yield("/visland execonce MSQ1-1.10")

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
yield("/wait 1")
yield("/macroicon Sprint")
yield("/ac Sprint")
yield("/ada generalaction 4")
yield("/wait 17")




-- Fight 3/3 hunt monster - will run to three location and find monster name follow attack until reach to 3 fight ended

local monsterName = 'Wounded Aurochs'

for i = 1, 4 do


    if i == 1 then
    yield("/visland moveto -167.988 43.981 -218.328 ")
    yield("/wait 3")
    elseif i == 2 then
    yield("/visland moveto -151.662 45.520 -200.890 ")
    yield("/wait 3")
    elseif i == 3 then
    yield("/visland moveto -138.780 45.340 -216.493 ")
    yield("/wait 3")
    elseif i == 4 then
    yield("/visland moveto -131.442 45.755 -213.177 ")
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

        yield("/wait 7")

        yield("/automove off <wait.1>")
    until GetCharacterCondition(26) == false
    yield("/rotation Cancel <wait.0.5>")

end  -- end of for loop
yield("/echo Done fighting 3/3")

-- end of Fight


yield("/wait 3")

yield("/visland moveto -132.842 45.428 -227.224 ")
yield("/wait 4")


yield("/target Blackloam <wait.1>")
yield("/lockon on")
yield("/pinteract <wait.10>")

yield("/wait 3")


yield("/visland moveto -122.726 45.974 -213.106 ")
yield("/wait 4")


yield("/target Blackloam <wait.1>")
yield("/lockon on")
yield("/pinteract <wait.10>")

yield("/wait 3")



yield("/visland moveto -128.941 46.660 -194.814 ")
yield("/wait 5")


yield("/target Blackloam <wait.1>")
yield("/lockon on")
yield("/pinteract <wait.10>")

yield("/wait 3")



yield("/visland execonce MSQ1-1.11")

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
yield("/wait 1")
yield("/macroicon Sprint")
yield("/ac Sprint")
yield("/ada generalaction 4")
yield("/wait 14")



yield("/target Pfrewahl <wait.1>")
yield("/lockon on")
yield("/pinteract <wait.5>")
yield("/echo Click the reward ")
yield("/wait 3")

yield("/pcall JournalResult true 0 5824 <wait.1>")  -- take Allagan bronze piece
yield("/wait 3")




yield("/target Pfrewahl <wait.1>")
yield("/lockon on")
yield("/pinteract <wait.5>")
yield("/echo Click the reward ")
yield("/wait 3")



end

function MSQ1_5() -- Plowshares to Swords
yield("/echo MSQ1_5() -- Plowshares to Swords")


yield("/visland moveto -46.874 55.113 -248.894 ")

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
yield("/wait 8")


-- maybe need to move last point to find the target
-- Fight 3/3 hunt monster - will run to three location and find monster name follow attack until reach to 3 fight ended

local monsterName = 'Grounded Raider'

for i = 1, 3 do


    if i == 1 then
    yield("/visland moveto -49.240 54.460 -242.862")
    yield("/wait 3")
    elseif i == 2 then
    yield("/visland moveto -59.493 53.693 -242.938")
    yield("/wait 3")
    elseif i == 3 then
    yield("/visland moveto -49.240 54.460 -242.862")
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

        yield("/wait 20")

        yield("/automove off <wait.1>")
    until GetCharacterCondition(26) == false
    yield("/rotation Cancel <wait.0.5>")

end  -- end of for loop
yield("/echo Done fighting 3/3")

-- end of Fight



yield("/visland execonce MSQ1-1.12")

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
yield("/wait 9")


-- maybe no need to do it twice
yield("/target Pfrewahl <wait.1>")
yield("/lockon on")
yield("/pinteract <wait.5>")
yield("/echo Click the reward ")
yield("/wait 3")




yield("/target Pfrewahl <wait.1>")
yield("/lockon on")
yield("/pinteract <wait.10>")
yield("/echo Click the reward ")
yield("/wait 3")

yield("/wait 3")


yield('/tp Summerford Farms <wait.5>')
yield("/waitaddon _ActionBar <maxwait.600><wait.5>")


yield("/macroicon Sprint")
yield("/ac Sprint")
yield("/ada generalaction 4")
yield("/wait 1")

yield("/visland moveto 215.074 112.979 -249.868 ")
yield("/wait 2")

yield("/visland moveto 200.290 112.521 -233.228 ")
yield("/wait 4")

yield("/visland moveto 206.279 112.838 -223.977 ")
yield("/wait 3.5")



yield("/target Staelwyrn <wait.1>")
yield("/lockon on")
yield("/pinteract <wait.5>")
yield("/echo Click the reward ")
yield("/wait 3")

yield("/pcall JournalResult true 0 5824 <wait.1>")  -- take Allagan bronze piece
yield("/wait 3")



yield("/target Staelwyrn <wait.1>")
yield("/lockon on")
yield("/pinteract <wait.5>")
yield("/echo Click the reward ")
yield("/wait 3")


end

function MSQ1_6() -- Just Deserts
yield("/echo MSQ1_6() -- Just Deserts")


yield("/visland execonce MSQ1-1.13")

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
yield("/wait 8")


yield("/send Right")
yield("/send Right")
yield("/send Right")
yield("/send Right")
yield("/wait 1")

yield("/target Grynewyda <wait.1>")
yield("/lockon on")
yield("/pinteract <wait.5>")
yield("/wait 1")



yield("/visland execonce MSQ1-1.14")

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
yield("/wait 1")
yield("/macroicon Sprint")
yield("/ac Sprint")
yield("/ada generalaction 4")
yield("/wait 1")
yield("/macroicon Sprint")
yield("/ac Sprint")
yield("/ada generalaction 4")
yield("/wait 23")

-- 3
yield("/echo 3")
yield("/wait 1")
yield("/macroicon Sprint")
yield("/ac Sprint")
yield("/ada generalaction 4")
yield("/wait 1")
yield("/macroicon Sprint")
yield("/ac Sprint")
yield("/ada generalaction 4")
yield("/wait 24")


yield("/target Aylmer <wait.1>")
yield("/lockon on")
yield("/pinteract <wait.5>")
yield("/wait 1")



yield("/visland execonce MSQ1-1.15")

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
yield("/wait 16")



yield("/target Eyrimhus <wait.1>")
yield("/lockon on")
yield("/pinteract <wait.5>")
yield("/wait 3")




yield("/visland execonce MSQ1-1.16")

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
yield("/wait 4")

yield("/target Sozai Rarzai <wait.1>")
yield("/lockon on")
yield("/pinteract <wait.5>")
yield("/wait 3")
yield("/click select_yes <wait.1>")


-- Quest fight
yield("/wait 5")
yield("/rotation Auto <wait.0.5>")
for i=1, 1 do
--yield("/echo "..i)


yield("/echo 1")
yield("/visland moveto -16.407 12.614 -451.040 ")
yield("/wait 40")



yield("/waitaddon _ActionBar <maxwait.600><wait.10>")

 end -- for loop
yield("/rotation Cancel <wait.0.5>")
yield("/wait 3")


yield("/wait 3")

yield('/tp Summerford Farms <wait.5>')
yield("/waitaddon _ActionBar <maxwait.600><wait.5>")


yield("/macroicon Sprint")
yield("/ac Sprint")
yield("/ada generalaction 4")
yield("/wait 1")

yield("/visland moveto 215.074 112.979 -249.868 ")
yield("/wait 2")

yield("/visland moveto 200.290 112.521 -233.228 ")
yield("/wait 4")

yield("/visland moveto 206.279 112.838 -223.977 ")
yield("/wait 2.5")

yield("/target Staelwyrn <wait.1>")
yield("/lockon on")
yield("/pinteract <wait.5>")
yield("/echo Click the reward ")
yield("/wait 3")


yield("/target Staelwyrn <wait.1>")
yield("/lockon on")
yield("/pinteract <wait.5>")
yield("/echo Click the reward ")
yield("/wait 3")



yield("/wait 2")

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
yield("/pcall TelepotTown false 11 1u <wait.1>")
yield("/pcall TelepotTown false 11 1u <wait.1>")
yield("/waitaddon _ActionBar <maxwait.600><wait.5>")



yield("/visland execonce JobQuest1-1.2")
yield("/wait 1")
yield("/ac Sprint")
yield("/wait 17")


yield("/target Baderon <wait.1>")
yield("/pinteract <wait.6>")
yield("/waitaddon _ActionBar <maxwait.600><wait.14>")



yield("/target Baderon <wait.1>")
yield("/lockon on")
yield("/pinteract <wait.6>")

end

--[[
MSQ1_1()
yield("/wait 3")

MSQ1_2()
yield("/wait 3")


MSQ1_3()
yield("/wait 3")


MSQ1_4()
yield("/wait 3")

MSQ1_5()
yield("/wait 3")

]]

MSQ1_6()

-- whole thing takes about 35-40mins