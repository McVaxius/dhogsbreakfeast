--[[
Author: slurpe
Link: https://discord.com/channels/1162031769403543643/1162799234874093661/1179870475564884038
Last update: 11-22-2023 9pm
Issue:
Version: 4.1
Updated code: add Press W, Release W, Limsa teleport D, W to hold rlease too


]]

function jobQuest4_1()  --  Wake of Destgruction part 1
yield("/echo jobQuest4_1()  --  Wake of Destgruction part 1")

yield("/visland execonce JobQuest4-1.1")
yield("/ac Sprint <wait.1>")
yield("/wait 7")

yield("/target Aethernet Shard <wait.2>" )
yield("/lockon on")
yield("/pinteract <wait.5>")
yield("/pcall SelectString true 0")
yield("/pcall TelepotTown false 11 0u <wait.1>") -- Lower La Noscea
yield("/pcall TelepotTown false 11 0u <wait.1>")
yield("/waitaddon _ActionBar <maxwait.600><wait.5>")




yield("/target Aetheryte <wait.6>")

yield("/hold D <wait.0.3>")
yield("/release D <wait.0.1>")

yield("/hold W <wait.1.5>")
yield("/release W <wait.0.1>")

yield("/lockon on")
yield("/automove on <wait.2>")

yield("/pinteract <wait.2>")
yield("/pcall SelectString true 1")
yield("/pcall TelepotTown false 11 5u <wait.1>")
yield("/pcall TelepotTown false 11 5u <wait.1>")
--yield("/waitaddon _ActionBar <maxwait.600><wait.5>")

-- go into residental area
yield("/wait 6")

yield("/click select_string1 <wait.2>")
yield("/pcall HousingSelectBlock false 0 <wait.2>")

yield("/waitaddon _ActionBar <maxwait.600><wait.1>")
yield("/wait 2")


-- exit residental area
yield("/visland moveto -9.997 48.342 -169.565 ")
yield("/wait 7")


yield("/send Right <wait.1>")

yield("/hold W <wait.1.5>")
yield("/release W <wait.0.1>")

yield("/wait 2")
yield("/pcall SelectString true 1 <wait.1>")
yield("/wait 5")



-- running to the monster area
yield("/visland execonce JobQuest4-1.2")

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
yield("/wait 19")



-- Fight 3/3 Galago - will run to three location and find monster name follow attack until reach to 3 fight ended
for i = 1, 3 do


    if i == 1 then
    yield("/visland moveto 392.447 75.633 -325.528 ")
    yield("/wait 3")
    elseif i == 2 then
    yield("/visland moveto 395.597 76.546 -332.991 ")
    yield("/wait 3")
    elseif i == 3 then
    yield("/visland moveto 399.603 75.795 -328.837 ")
    yield("/wait 3")
    end -- end if

   yield("/rotation Auto <wait.0.5>")
    repeat

        yield("/echo "..i.." Galago")
        -- Perform actions until the condition is met
        yield("/target Galago <wait.1>")

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



--[[    use above check combat for loop, this is old code as backup
-- Galago
for i=1, 2 do
--yield("/echo "..i)

yield("/rotation Auto <wait.0.5>")
yield("/echo 1")
yield("/visland moveto 392.447 75.633 -325.528 ")
yield("/wait 12")
yield("/rotation Cancel <wait.0.5>")

yield("/rotation Auto <wait.0.5>")
yield("/echo 2")
yield("/visland moveto 395.597 76.546 -332.991 ")
yield("/wait 12")
yield("/rotation Cancel <wait.0.5>")

yield("/rotation Auto <wait.0.5>")
yield("/echo 3")
yield("/visland moveto 399.603 75.795 -328.837 ")
yield("/wait 12")
yield("/rotation Cancel <wait.0.5>")

yield("/rotation Auto <wait.0.5>")
yield("/echo 4")
yield("/visland moveto 397.107 76.674 -334.592 ")
yield("/wait 12")
yield("/rotation Cancel <wait.0.5>")

yield("/rotation Auto <wait.0.5>")
yield("/echo 5")
yield("/visland moveto 391.560 76.356 -330.360 ")
yield("/wait 12")
yield("/rotation Cancel <wait.0.5>")

yield("/rotation Auto <wait.0.5>")
yield("/echo 6")
yield("/visland moveto 394.569 75.620 -325.974 ")
yield("/wait 12")


yield("/wait 15")
yield("/rotation Cancel <wait.0.5>")
end -- for loop

]]



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
yield("/wait 3")



end

function jobQuest4_2()  --  Wake of Destgruction part 2
yield("/echo jobQuest4_2()  --  Wake of Destgruction part 2")

yield('/tp Summerford Farms <wait.5>')
yield("/waitaddon _ActionBar <maxwait.600><wait.5>")



yield("/visland execonce JobQuest4-1.3")

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
yield("/wait 6")



yield("/target Overturned Wain <wait.1>")
yield("/lockon on")
yield("/pinteract <wait.10>")



-- plainstriders


yield("/rotation Auto <wait.0.5>")
yield("/echo 1")
yield("/visland moveto -98.240 42.168 -303.442 ")
yield("/wait 40")
yield("/rotation Cancel <wait.0.5>")

yield("/rotation Auto <wait.0.5>")
yield("/echo 2")
yield("/visland moveto -101.988 41.646 -304.280 ")
yield("/wait 20")
yield("/rotation Cancel <wait.0.5>")





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
yield("/pcall JournalResult true 0 3539 <wait.1>")

yield("/wait 5")


end

jobQuest4_1()
yield("/wait 5")
jobQuest4_2()