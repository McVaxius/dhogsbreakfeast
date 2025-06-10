--[[
    Name: AutoCollectables
    Description: General collectables script for MIN/BTN, based on auto gather collectables for the miner or botanist relic steps from Em
    Author: LeafFriend, Em
    Version: 0.1.1.1
]]

--[[
    <Changelog>
    0.1.1.1 - Added support for calling script in GatheringHelper
    0.1.1   - Refactored Ageless Words/Solid Reason code block into its own wrapper
            - Added above wrapper to low stat rotation
    0.1     - Initial Version
]]

--Settings
ignore_nodes_went = false       --Loop this script
nodes_went_threshold = 1        --How many times to loop this script before it terminates
interval_rate = 0.5             --Seconds to wait for each action
time_to_wait_after_gather = 0.1 --Seconds to wait after finishing gathering and before looking for the next gathering node

--Variables
max_base_scour_coll = 200
max_coll = 1000
scrutiny_gp = 200
action_one_more_gp = 300

--Prints given string into chat with script identifier
function Id_Print(string)
    yield("/echo [AutoCollectables] "..string)
end

--Wrapper for Gatherer class check and their respective ingame Actions
function class_check()
    if (GetClassJobId() == 17) then
        action_name_one_more = "Ageless Words"
        action_name_meticulous = "Meticulous Woodsman"
    elseif (GetClassJobId() == 16) then
        action_name_one_more = "Solid Reason"
        action_name_meticulous = "Meticulous Prospector"
    end
end

--Wrapper for running ingame Actions
function action(action_name)
    Id_Print("Using \""..action_name.."\"")
    yield("/action \""..action_name.."\"")
    yield("/wait "..interval_rate)

    while(GetCharacterCondition(42)) do yield("/wait "..interval_rate) end
  
    --Ensure Scrutiny is active
    if (action_name == "Scrutiny" and not HasStatus("Scrutiny")) then
        Id_Print("\"Scrutiny\" not active, Attempting again...")
        action(action_name)
    end

    yield("/wait "..interval_rate)
end

--Returns Collectability gain using Scour from Collectables UI
function scour_coll()
    local data
    repeat
        yield("/wait "..interval_rate)
        data = GetNodeText("GatheringMasterpiece", 97)
    until (type(data) == "string")
    return tonumber(data:sub(-3)) or 0
end

--Returns Collectability gain using Meticulous Woodsman/Prospector from Collectables UI
function meticulous_coll()
    local data
    repeat
        yield("/wait "..interval_rate)
        data = GetNodeText("GatheringMasterpiece", 73)
    until (type(data) == "string")
    return tonumber(data:sub(-3)) or 0
end

--Returns current Collectability of Collectable being gathered
function current_coll()
    return tonumber(GetNodeText("GatheringMasterpiece", 175)) or max_coll
end

--Returns available actions left before gathering node disappears
function actions_left()
    return tonumber(GetNodeText("GatheringMasterpiece", 55)) or 0
end

--Returns maximum actions possible at current gathering node
function max_actions()
    return tonumber(GetNodeText("GatheringMasterpiece", 53)) or 0
end

--Returns minimum Collectability for the current Collectable being gathered to be usable
function min_coll()
    return tonumber(GetNodeText("GatheringMasterpiece", 168, 0)) or 0
end

--Wrapper for gaining more gathering attempts to Collect
function gain_more_action() 
    while (GetGp() >= action_one_more_gp) do
        if (actions_left() < max_actions()) then action(action_name_one_more) end
        if (HasStatus("Eureka Moment")) then
            if (actions_left() > max_actions() - 1) then action("Collect") end
            action("Wise to the World")
        end
    end
end

--Wrapper for collecting current collectables at the end of rotations
function collect_all()
    while((actions_left() > 0) and IsAddonReady("GatheringMasterpiece")) do
        --Ends function if function called without any scouring
        if (current_coll() == 0) then return end

        Id_Print("Actions left: "..actions_left())
        action("Collect")
    end
end

--Standard Collectable Rotation
function standard()
    Id_Print("Doing Standard Rotation...")

    action("Scrutiny")
    action(action_name_meticulous)
    action("Scrutiny")
    action(action_name_meticulous)

    if (current_coll() == max_coll) then
    elseif (meticulous_coll() + current_coll() >= max_coll) then
        action(action_name_meticulous)
    else
        action("Scour")
    end
    if (actions_left() > 1) then 
        action("Collect")
    end

    gain_more_action()

    collect_all()
end

--[[
  Low Stat Rotation, for when not enough GP for Standard Rotation,
  or when maximum possible base Collectability gain (Scour without Scrutiny at max gathering) not reached
--]] 
function low_stat()
    Id_Print("Doing Low Stat Rotation...")

    action("Scrutiny")
    action("Scour")
    action("Scrutiny")

    if (meticulous_coll() >= scour_coll()) then
        action(action_name_meticulous)
    else
        action("Scour")
    end

    while (actions_left() > 1 and current_coll() < max_coll) do
        if (math.max(scour_coll(), meticulous_coll()) + current_coll() < max_coll) then
            action("Scrutiny")
        end

        if (meticulous_coll() >= scour_coll()) then
            action(action_name_meticulous)
        else
            action("Scour")
        end
    end

    gain_more_action()

    collect_all()
end

--Ephemeral Rotation, for when insufficient GP to do any other rotation and trying to get usable Collectables
function ephemeral()
    Id_Print("Doing Ephemeral Rotation...")

    while (current_coll() < min_coll() and actions_left() > 1) do
        if (meticulous_coll() >= scour_coll()) then
            action(action_name_meticulous)
        else
            action("Scour")
        end
    end
  
    collect_all()
end

function main()
    while(not IsAddonReady("GatheringMasterpiece")) do
        Id_Print("Waiting for node...")
        yield("/wait "..interval_rate)
    end

    Id_Print("At node.")
    current_gp = GetGp()
    Id_Print("Current GP: "..current_gp)
    class_check()
  
    --Logic for which rotation to perform
    if (scour_coll() == max_base_scour_coll and current_gp >= 2 * scrutiny_gp + action_one_more_gp) then
        standard()
    elseif (current_gp >= 3 * scrutiny_gp) then
        low_stat()
    else
        ephemeral()
    end
  
    Id_Print("Done gathering!")
    yield("/wait "..time_to_wait_after_gather)
end

Id_Print("----------Starting AutoCollectables----------")
nodes_went = 0
repeat
    main()
    nodes_went = nodes_went + 1
until ignore_nodes_went or nodes_went >= nodes_went_threshold
Id_Print("----------Stopping AutoCollectables----------")