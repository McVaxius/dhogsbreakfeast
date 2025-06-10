--[[
Author: slurpe
Link: https://discord.com/channels/1162031769403543643/1162799234874093661/1179870420191682771
Last update: 11-22-2023 9pm
Issue:
Version: 4.1
Updated code: add Press W, Release W, Limsa teleport D, W to hold rlease too


]]


function jobQuest2_1()  --  talk to Broenbhar get quest, talk to Rhotgeim, smash all the stone
yield("/echo jobQuest2_1()  --  talk to Broenbhar get quest, talk to Rhotgeim, smash all the stone")



yield("/visland execonce JobQuest2-1.1")
yield("/wait 1")
yield("/ac Sprint <wait.1>")
yield("/wait 18")

yield("/target Broenbhar <wait.1>")
yield("/lockon on")
yield("/pinteract <wait.5>")
yield("/wait 1")


yield("/visland execonce JobQuest2-1.2")
yield("/wait 20")

yield("/target Aethernet Shard <wait.1>" )
yield("/lockon on")
yield("/pinteract <wait.5>")
yield("/pcall SelectString true 0")
yield("/pcall TelepotTown false 11 7u <wait.1>") --
yield("/pcall TelepotTown false 11 7u <wait.1>")
yield("/waitaddon _ActionBar <maxwait.600><wait.5>")



-- Fight 3/3 hunt monster - will run to three location and find monster name follow attack until reach to 3 fight ended

local monsterName = 'Wharf Rat'

for i = 1, 3 do


    if i == 1 then
    yield("/visland moveto 9.666 43.082 110.988 ")
    yield("/wait 10")
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
    yield("/visland moveto 38.696 44.619 148.618 ")
    yield("/wait 3")
    elseif i == 2 then
    yield("/visland moveto 36.081 44.056 107.737 ")
    yield("/wait 10")
    elseif i == 3 then
    yield("/visland moveto -47.220 44.580 106.195 ")
    yield("/wait 14")
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






--[[ old code for backup

yield("/rotation Auto <wait.1>") -- lady bug and rat
for i=1, 2 do
yield("/echo "..i)
yield("/visland moveto 25.796 43.443 150.346 ")
yield("/wait 6")

yield("/visland moveto 30.189 43.996 155.676 ")
yield("/wait 6")

yield("/visland moveto 38.551 44.609 152.043 ")
yield("/wait 6")

yield("/visland moveto 39.720 44.717 147.899 ")
yield("/wait 6")

yield("/wait 10")
end -- for loop
yield("/rotation Cancel <wait.1>")



-- move to next point
yield("/visland moveto 36.983 44.132 105.429 ")
yield("/wait 5")

yield("/rotation Auto <wait.1>") -- lady bug and rat
for i=1, 2 do
yield("/echo "..i)
yield("/visland moveto 36.983 44.132 105.429 ")
yield("/wait 6")

yield("/visland moveto 38.076 44.209 96.794 ")
yield("/wait 6")

yield("/visland moveto 33.211 44.015 100.823 ")
yield("/wait 6")

yield("/visland moveto 37.064 44.129 104.188 ")
yield("/wait 6")

yield("/wait 10")
end -- for loop
yield("/rotation Cancel <wait.1>")



-- move to next point
yield("/visland moveto -47.220 44.580 106.195 ")
yield("/wait 5")

yield("/rotation Auto <wait.1>") -- lady bug and rat
for i=1, 2 do
yield("/echo "..i)
yield("/visland moveto -49.207 44.055 105.429 ")
yield("/wait 4")

yield("/visland moveto -47.054 44.507 105.501 ")
yield("/wait 4")

yield("/visland moveto -53.671 43.981 99.225")
yield("/wait 4")


yield("/wait 10")
end -- for loop
yield("/rotation Cancel <wait.1>")

]] -- end of old code for reused



-- move to next point
yield("/visland moveto -52.988 43.646 89.672 ")
yield("/wait 3")

yield("/visland moveto -57.022 45.387 59.802 ")
yield("/wait 6")

yield("/visland moveto -57.417 43.789 45.890 ")
yield("/wait 4")

yield("/target Rhotgeim <wait.1>")
yield("/lockon on")
yield("/pinteract <wait.5>")
yield("/wait 1")




-- move to first set of Solid Rock
yield("/visland moveto -67.472 43.633 23.002 ")
yield("/wait 5")
yield("/targetnpc <wait.1>")
yield('/ac "Heavy Swing" <wait.2.5>')

yield("/wait 2")
yield("/targetnpc <wait.1>")
yield('/ac "Heavy Swing" <wait.2.5>')


yield("/visland moveto -73.411 43.327 6.368 ")
yield("/wait 5")
yield("/targetnpc <wait.1>")
yield('/ac "Heavy Swing" <wait.2.5>')

yield("/wait 2")
yield("/targetnpc <wait.1>")
yield('/ac "Heavy Swing" <wait.2.5>')



yield("/visland moveto -53.349 46.056 15.212 ")
yield("/wait 4")
yield("/targetnpc <wait.1>")
yield('/ac "Heavy Swing" <wait.2.5>')

yield("/wait 2")
yield("/targetnpc <wait.1>")
yield('/ac "Heavy Swing" <wait.2.5>')


-- Fight 1st hunt monster - will run to three location and find monster name follow attack until reach to 3 fight ended

local monsterName = 'Bee Cloud'

for i = 1, 1 do


    if i == 1 then
    yield("/visland moveto -57.444 45.793 5.352 ")
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


-- end of Fight

--[[ Old code as backup
yield("/rotation Auto <wait.1>") -- Bee Cloud 1
for i=1, 2 do
yield("/echo "..i)
yield("/visland moveto -57.444 45.793 5.352 ")
yield("/wait 6")

yield("/visland moveto -59.829 45.528 8.425 ")
yield("/wait 6")

yield("/wait 10")
end -- for loop
yield("/rotation Cancel <wait.1>")
]] -- end of old code as backup


yield("/visland moveto -57.557 43.808 45.148 ")
yield("/wait 8")

yield("/send Left <wait.1>")
yield("/send Left <wait.1>")

yield("/target Rhotgeim <wait.1>")
yield("/lockon on")
yield("/pinteract <wait.5>")
yield("/wait 1")


-- Fight 2nd Bee Cloud  hunt monster - will run to three location and find monster name follow attack until reach to 3 fight ended

local monsterName = 'Bee Cloud'

for i = 1, 1 do


    if i == 1 then
    yield("/visland moveto -40.283 45.475 43.010 ")
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


-- end of Fight

--[[ Old code as backup
yield("/rotation Auto <wait.1>") -- Bee Cloud 2
for i=1, 2 do
yield("/echo "..i)
yield("/visland moveto -40.283 45.475 43.010 ")
yield("/wait 6")

yield("/visland moveto -47.015 44.786 45.283 ")
yield("/wait 6")

yield("/visland moveto -44.491 45.521 38.804 ")
yield("/wait 6")

yield("/wait 10")
end -- for loop
yield("/rotation Cancel <wait.1>")
]] -- end of old code as backup



-- move to Second set of Solid Rock
yield("/visland moveto -13.220 46.418 32.051 ")
yield("/wait 7")
yield("/targetnpc <wait.1>")
yield('/ac "Heavy Swing" <wait.2.5>')

yield("/wait 2")
yield("/targetnpc <wait.1>")
yield('/ac "Heavy Swing" <wait.2.5>')


yield("/visland moveto -14.411 47.368 14.068 ")
yield("/wait 5")
yield("/targetnpc <wait.1>")
yield('/ac "Heavy Swing" <wait.2.5>')

yield("/wait 2")
yield("/targetnpc <wait.1>")
yield('/ac "Heavy Swing" <wait.2.5>')


yield("/visland moveto 0.097 48.210 10.111 ")
yield("/wait 4")
yield("/targetnpc <wait.1>")
yield('/ac "Heavy Swing" <wait.2.5>')

yield("/wait 2")
yield("/targetnpc <wait.1>")
yield('/ac "Heavy Swing" <wait.2.5>')


-- Fight 3rd hunt monster - will run to three location and find monster name follow attack until reach to 3 fight ended

local monsterName = 'Bee Cloud'

for i = 1, 1 do


    if i == 1 then
    yield("/visland moveto 4.616 46.862 24.971 ")
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


-- end of Fight




--[[ Old code as backup
yield("/rotation Auto <wait.1>") -- Bee Cloud 3
for i=1, 2 do
yield("/echo "..i)
yield("/visland moveto 4.616 46.862 24.971 ")
yield("/wait 6")

yield("/visland moveto 4.809 47.621 17.263 ")
yield("/wait 6")

yield("/visland moveto -3.113 47.440 17.289 ")
yield("/wait 6")

yield("/wait 10")
end -- for loop
yield("/rotation Cancel <wait.1>")
]] -- end of old code as backup


yield("/visland moveto -40.283 45.475 43.010 ")
yield("/wait 8")


-- Fight 2nd Bee Cloud  hunt monster - will run to three location and find monster name follow attack until reach to 3 fight ended

local monsterName = 'Bee Cloud'

for i = 1, 1 do


    if i == 1 then
    yield("/visland moveto -40.283 45.475 43.010 ")
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


--[[ Old code as backup
yield("/rotation Auto <wait.1>") -- Bee Cloud 2
for i=1, 2 do
yield("/echo "..i)
yield("/visland moveto -40.283 45.475 43.010 ")
yield("/wait 6")

yield("/visland moveto -47.015 44.786 45.283 ")
yield("/wait 6")

yield("/visland moveto -44.491 45.521 38.804 ")
yield("/wait 6")

yield("/wait 10")
end -- for loop
yield("/rotation Cancel <wait.1>")
]] -- end of old code as backup


-- Final talk with Rhotegeim
yield("/visland moveto -57.557 43.808 45.148 ")
yield("/wait 4")

yield("/send Left <wait.1>")
yield("/send Left <wait.1>")

yield("/target Rhotgeim <wait.1>")
yield("/lockon on")
yield("/pinteract <wait.5>")
yield("/wait 1")


yield("/visland execonce JobQuest2-1.3")
yield("/ac Sprint <wait.1>")
yield("/wait 21")


-- Fight 3/3 hunt monster - will run to three location and find monster name follow attack until reach to 3 fight ended

local monsterName = 'Bogy'

for i = 1, 3 do


    if i == 1 then
    yield("/visland moveto -61.354 27.908 -108.731 ")
    yield("/wait 3")
    elseif i == 2 then
    yield("/visland moveto -59.605 27.625 -116.365 ")
    yield("/wait 3")
    elseif i == 3 then
    yield("/visland moveto -50.833 27.227 -126.388 ")
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


--[[  old code save for backup

yield("/rotation Auto <wait.1>") -- Bogy
for i=1, 1 do
yield("/echo "..i)
yield("/visland moveto -61.354 27.908 -108.731 ")
yield("/wait 17")

yield("/visland moveto -59.605 27.625 -116.365 ")
yield("/wait 17")


yield("/visland moveto -50.833 27.227 -126.388 ")
yield("/wait 17")


yield("/visland moveto -48.355 25.522 -144.536 ")
yield("/wait 17")


yield("/visland moveto -56.323 24.940 -154.447 ")
yield("/wait 18")

yield("/visland moveto -61.068 24.938 -154.536 ")
yield("/wait 18")

yield("/visland moveto -64.060 25.234 -149.340 ")
yield("/wait 18")

yield("/visland moveto -66.766 26.325 -129.917 ")
yield("/wait 30")

end -- for loop
yield("/rotation Cancel <wait.1>")

]]  -- old code save for backup end

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


yield("/visland execonce JobQuest1-1.7")
yield("/wait 8")

yield("/target Wyrnzoen <wait.1>")
yield("/lockon on")
yield("/pinteract <wait.5>")
yield("/wait 5")




yield("/visland execonce JobQuest2-1.4")
yield("/ac Sprint <wait.1>")
yield("/wait 16")



yield("/send Right <wait.1>")
yield("/send Right <wait.1>")

yield("/target Solkwyb <wait.1>")
yield("/lockon on")
yield("/pinteract <wait.5>")
yield("/wait 5")

end


jobQuest2_1()