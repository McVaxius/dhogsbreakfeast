--[[

  ***************
  * Description *
  ***************

  This is meant to be used for Alexander - The Burden of the Father (NORMAL NOT SAVAGE)
  It's setup to where you should be able to loop it as many time as you want, and be able to farm mats for GC seals
  Known classes to work: ALL
  Version: 3.3.1
    -> 3.3.1: Added some checks to wait till you're fully loaded out (in case of high ping) [Chest fix is next on the list for high ping]
    -> 3.3: Repair Functionality & Potentional duty load check (@leaf update)
  Created by: Ice, Class Support: Ellipsis | Menu Optimizing: Leaf

  Creators note: thank you Ellipsis for getting all the classes working, you did an amazing job. You deserve the credit here.

  *********************
  *  Required Plugins *
  *********************


  Plugins that are used are:
  -> Visland (for pathing) : https://puni.sh/api/repository/veyn
  -> NEW Vnavmesh (needed for visland) : https://puni.sh/api/repository/veyn  (this might be temporary, waiting on some news/update, but for now)
  -> Pandora (Setting "Open Chest") : https://love.puni.sh/ment.json
  -> RotationSolver : https://puni.sh/api/repository/croizat
  -> Something Need Doing [Expanded Edition] : https://puni.sh/api/repository/croizat
    -> In the SND window, press the question mark to make the help setting's menu open 
    -> Go to options tab -> /target -> DISABLE THIS!! "Stop macro if target not found (only applies to SND's targeting system')"

]]

--[[

  **************
  *  Settings  *
  **************
  ]]

  NumberofLoops = 5  -- How many loops do you wanna do
  rate = 0.3 -- Increase this at lower fps [0.3 works on 15fps+]
  timeoutThreshold = 15 -- Number of seconds to wait before timeout

  ManualSetDuty = false -- true | false option
  -- if you don't want to deal with the duty selection process, and select the duty yourself/turned on Unsync set this to true. If you want to just automate to the duty, set this to false.
  -- This assumes that you have EVERYTHING unlocked

  DutyFinderOrder = true -- true | false option
  -- If you have your duty from 50 at top, and 90 toward the bottom, leave this as true
  -- If you have your duty from 90 at top, and 50 toward the bottom, change this to false

  CastingDebug = false -- true | false option
  -- Just something for me to debug test w/

  ManualRepair = false -- if you want to repair between the loops that you do. [defaults is false | on is true]
  RepairAmount = 75 -- lowest point your gear will 
  
  

--[[

  ************
  *  Script  *
  *   Start  *
  ************

]]

--Visland Loops
Alex_Start = "H4sIAAAAAAAACk2PW2vDMAyF/4ueTXCyNJv9VrYO8tDdIVvHKKbVqKG2Rq3uQsh/nxJctjcd6dPRUQ83LiBYmO/xe12vH0FB534+yEdOYF97uKPk2VME28MzWF3oqrmYmaY2Cl7AlrqY1ea8qhWswJrCNGdaV4MoitheyYKCB7f1R3ErCxFL+sSAkadJGxkPbsOd591tpv/3cjgJlXb0dZpIGnF7d/uEf/gUsVSwCMSnwy1jyOV8IrK4P2LiXI/GnfPjt9lxVNd0uKS4zZ8LNjaffMClcHp4G34B1YIamzkBAAA="
Alex_Chest = "H4sIAAAAAAAACuWQSWvDMBCF/0qZsyMkR7It3UIX8CHdCLgLJYhkTASxVWy5C8b/vYpj40ALvRZ605t5enr6WrjWBYKCxR4/1ny9ggAy/flqTelqUM8t3NraOGNLUC08gAqJFDGXEQ/gERSjJKJcijCAJ1AzQZKEJiHrvLQlphegaAD3emsaH8aIF0v7hgWWrt+kpcNKb1xm3O5mcJ/Ohm6+U72z7+PGl/Fpud7XONn7hiyAy8K68eHUYTEcF71jEHcN1m44H4IzbdyUeFBXtjq35Xb4OD0OV6bApffRLviGZUYJo5IyGU9kBOeRkEcykgjJEhH/QzIhoaHkyURlLrk4UonIPJpTmZxQ4YfdyMVf/Y0Ljz3hH8i4CnXdVHi2sXmO1Z8D9dJ9Ad/rgrl7AwAA"

-- Values that are needed for the whole script
CurrentLoop = 1 -- This is just the loop counter itself, keeps tracks of how many you've done.
DutyCounter = 0
DutyFail = 0

if ManualSetDuty == true then
  DutyCounter = 1
end

::LoopTest::
if NumberofLoops >= CurrentLoop then
    yield("/echo Loop: "..CurrentLoop.." out of ".. NumberofLoops)
elseif NumberofLoops < CurrentLoop then
    goto StopLoop
end

repeat
yield("/wait 0.1")
until IsPlayerAvailable()

-- Repair Functionality
if ManualRepair == true then
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
end

repeat
yield("/wait 0.1")
until IsPlayerAvailable()

::DutyFinder::
if DutyFail == 4 then
    goto StopLoop

elseif DutyCounter == 0 then -- Initially setting up duty to loop Alexander - Burden of the Father (A4N)
    yield("/visland stop")
    --Open duty finder until it's visible
    while not IsAddonVisible("ContentsFinder") do
        yield("/dutyfinder")
        yield("/wait "..rate)
    end
    --wait till duty finder has finished loading
    while not IsAddonReady("ContentsFinder") do
        yield("/wait "..rate)
    end

-- Setting up Unsync if it wasn't already
    SetDFUnrestricted(true)
    --wait until duty finder settings has closed
    yield("/pcall ContentsFinder True 12 1") -- Clearing out any old duties
    --wait till old selections are cleared out
    repeat
        yield("/wait "..rate)
    until GetNodeText("ContentsFinder", 15) == "0/5 Selected"
    OpenRegularDuty(115)
    local timeout = 0
    repeat
        yield("/wait "..rate)
        timeout = timeout + 1
        if timeout > timeoutThreshold / rate then goto NOTALLUNLOCK end
    until GetNodeText("JournalDetail", 19) == "Alexander - The Burden of the Father"
    if DutyFinderOrder then
      yield("/pcall ContentsFinder True 3 27")
    else
      yield("/pcall ContentsFinder True 3 75")
    end
    timeout = 0
    repeat
        yield("/wait "..rate)
        timeout = timeout + 1
        if timeout > timeoutThreshold / rate then goto NOTALLUNLOCK end
    until GetNodeText("ContentsFinder", 14) == "Alexander - The Burden of the Father"
    
    ::NOTALLUNLOCK::
    if GetNodeText("ContentsFinder", 14) ~= "Alexander - The Burden of the Father" then
        for i = 1, 501 do
            yield("/pcall ContentsFinder True 3 "..i)
            yield("/wait "..rate)
            if GetNodeText("ContentsFinder", 14) == "Alexander - The Burden of the Father" then break end
        end
        yield("/wait "..rate)
    end

    yield("/pcall ContentsFinder True 12 0")
    DutyCounter = DutyCounter + 1
    repeat
        yield("/wait "..rate)
    until IsAddonVisible("ContentsFinderConfirm")

elseif DutyCounter == 1 then -- Quicker menu'ing here to load in
    yield("/visland resume")
    yield("/visland stop")
    --Open duty finder until it's visible
    while not IsAddonVisible("ContentsFinder") do
        yield("/dutyfinder")
        yield("/wait "..rate)
    end
    --wait till duty finder has finished loading
    while not IsAddonReady("ContentsFinder") do
        yield("/wait "..rate)
    end
  -- Setting up Unsync if it wasn't already
    SetDFUnrestricted(true)
    yield("/pcall ContentsFinder True 12 0") --Duty Load
    repeat
        yield("/wait "..rate)
    until IsAddonVisible("ContentsFinderConfirm")
elseif DutyCounter == 2 then
    yield("/echo Hmm... it seems like this has failed, so going to reset it")
    DutyCounter = 0
    DutyFail = DutyFail + 1
    goto DutyFinder
end


::DutyCommence::
yield("/pcall ContentsFinderConfirm True 8")
repeat
    yield("/wait "..rate)
until IsInZone(445) and IsAddonVisible("_Image")

::BattleInitialize::
manip_phase = 0
while not GetCharacterCondition(26) do
-- Target selection and movement logic
    local current_target = GetTargetName()
    if not current_target or current_target == "" then
        yield("/targetenemy")  -- Attempt to auto-target the next enemy
        current_target = GetTargetName()
        if current_target == "" then
            yield("/wait "..rate)
            if CastingDebug == true then
              yield("/e Target system is working, if it's targeting something here")
            end
        end
    end

    local enemy_max_dist = 40
    local dist_to_enemy = GetDistanceToTarget()
    if dist_to_enemy and dist_to_enemy > 0 then
        if dist_to_enemy <= enemy_max_dist then
            local enemy_x = GetTargetRawXPos()
            local enemy_y = GetTargetRawYPos()
            local enemy_z = GetTargetRawZPos()
            yield("/visland moveto " .. enemy_x .. " " .. enemy_y .. " " .. enemy_z)
            yield("/wait "..rate)
            yield("/rotation manual")
            if CastingDebug == true then 
              yield("/e Break B")
            end
        else
            yield("/visland stop")  -- Stop movement after reaching near the target
        end
    end
end

::StartofBattle::
--rotation
while GetCharacterCondition(26) do
    yield("/wait "..rate)
 -- Target selection and movement logic
    local current_target = GetTargetName() --Leaf: need find the setting to always zoom out or something
    if not current_target or current_target == "" then
        yield("/targetenemy")  -- Attempt to auto-target the next enemy
        current_target = GetTargetName()
        if current_target == "" then
            yield("/wait "..rate)
        end
    end

    while IsPlayerCasting() do
      if CastingDebug == true then
        yield("/e EY WATCH IT. I'M CASTING")
      end
      yield("/wait "..rate/3)
    end

    local enemy_max_dist = 40
    local dist_to_enemy = GetDistanceToTarget()
    if dist_to_enemy and dist_to_enemy > 0 then
        if dist_to_enemy <= enemy_max_dist then
            local enemy_x = GetTargetRawXPos()
            local enemy_y = GetTargetRawYPos()
            local enemy_z = GetTargetRawZPos()
            yield("/visland moveto " .. enemy_x .. " " .. enemy_y .. " " .. enemy_z)
            yield("/wait "..rate)
        else
            yield("/visland stop")  -- Stop movement after reaching near the target
        end
    end
end
-- This section might need an additional command to re-target or adjust positioning
-- if the enemy is beyond the max distance, depending on your needs.

yield("/rotation cancel")
yield("/visland exectemponce "..Alex_Chest)

repeat
    yield("/wait "..rate)
until IsMoving()

repeat
    yield("/wait "..rate)
until not IsVislandRouteRunning()

CurrentLoop = CurrentLoop + 1
yield("/echo Leaving the instance")
yield("/pdfleave")

repeat
    yield("/wait "..rate)
until not IsInZone(445) and not GetCharacterCondition(34) and not GetCharacterCondition(56) and not GetCharacterCondition(45)

goto LoopTest

::StopLoop::
if DutyFail < 4 then
    yield("/echo Alex Looping has completed")
elseif DutyFail >= 4 then
    yield("/echo It seems like it's failed, maybe lag?")
end