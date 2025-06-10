--[[
    Name: GatheringHelper
    Description: General gathering node recorder and movement script for MIN/BTN
    Author: LeafFriend, plottingCreeper (food and repair)
    Version: 0.1.3.4
    Needed Plugins: vnavmesh, Pandora
    Needed Plugin Settings: Pandora Quick Gather enabled, SND targeting system enabled
]]

--[[
    <Changelog>
    0.1.3.4 - Implemented enhanced search function with GetNearbyObjectNames()
            - Accounted for diving in VnavmeshMoveFly()
    0.1.3.3 - Added Ephemeral nodes to table of node names
    0.1.3.2 - Handle condition when diving for vnavmesh movement
    0.1.3.1 - Properly implement zone change script termination implementation
    0.1.3   - Implemented class checker to wipe found_nodes if class is changed and prompt if not DoL
            - Implemented food check before homing into found gathering node
            - Implemented gear condition checking
            - Implemented dislodging if char stuck in position moving
            - Implemented script termination if zone change is detected
    0.1.2   - Optimised node traversal
            - Re-enabled truncation for readbility
            - Removed lockon
            - Implemented dislodging if not moving
            - Implemented calling of collectable script if gathering collectables
            - Implemented script termination if inventory free slot threshold reached
    0.1.1   - Implemented VnavmeshMoveFly to determine whether to use /vnavmesh moveto or /vnavmesh flyto
    0.1     - Initial Version
]]

--[[
    <Usage>
    1. Change settings as wanted
    2. Run script in lua
    3. Find gathering nodes when starting or when prompted
    4. Script will register found nodes and go back to them after visiting all of them once
]]

--[[
    <TODO>
    - More Optimisation, eventually...
    -- Use plottingCreeper's MoveNear()
    - Implement node checker to wipe found_nodes if gathered item is not gatherable from current node
    - Implement randomised wait time
    - Implement verbose/rate-limiting Id_Print()
    - Implement distance-based mounting before moving to next node
    - Implement spiritbond checking
    - Implement Diadem aetheromatic auger usage
    - Implement better dislodgement logic
--]]

--Settings
---Food Settings
food_to_eat = false                   --Name of the food you want to use, in quotes. Set false otherwise.
                                      --Include <hq> if high quality. (i.e. "[Name of food] <hq>") DOES NOT CHECK ITEM COUNT YET
eat_food_threshold = 10               --Maximum number of times to check if food is consumed

---Repair Settings
do_repair = false                    --false, "npc" or "self". Add a number to set threshhold; "npc 10" to only repair if under 10%

---Gathering logic Settings
interval_rate = 1                     --Seconds to wait for each action
ping_radius = 50                      --Radius of the gathering node search
min_distance_to_dismount = 5          --Minimum distance before dismounting while travelling to gathering node
time_to_wait_after_gather = 3         --Seconds to wait after finishing gathering and before looking for the next gathering node
missing_node_distance_tolerance = 3   --Maximum distance before script considers node moving to is not interactable
moving_count_threshold = 15           --Maximum number of pings script will attempt before detecting it is stuck and attempt to dislodge itself
diadem_moving_count_threshold = 60    --Same as above, but for diadem
not_moving_count_threshold = 3        --Number of pings script will do before attempting to dislodge itself if it isn't moving
num_inventory_free_slot_threshold = 1 --Max number of free slots to be left before stopping script

---Collectables Settings
collectables_script_name = "AutoCollectables_SingleRun" --Name of collectables script in SND to run when collectable UI is detected




--Helper functions
function Set(list)
    local set = {}
    for _, l in ipairs(list) do set[l] = true end
    return set
end

function SetLength(set)
    local count = 0
    for _,_ in pairs(set) do
        count = count + 1
    end
    return count
end

function AddToSet(set, key)
    set[key] = true
end

function RemoveFromSet(set, key)
    set[key] = nil
end

function SetContains(set, key)
    return set[key] ~= nil
end

function PrintSet(set, label)
    local next = next
    if next(set) ~= nil then
        Id_Print("["..label.."]Set:")
        for k,_ in pairs(found_nodes) do
            Id_Print("["..label.."]"..tostring(k))
        end
    end
end

function Queue(list)
    local queue = {}
    return {first = 0, last = -1}
end

function IsQueue(struct)
    return struct.first ~= nil and struct.last ~= nil
end

function QueueIsEmpty(queue)
    return queue.first > queue.last
end

function QueueLength(queue)
    local count = 0
    for _,_ in pairs(queue) do
        count = count + 1
    end
    return count - 2
end

function QueuePush(queue, value)
    local last = queue.last + 1
    queue.last = last
    queue[last] = value
end

function QueuePop(queue)
    local first = queue.first
    if first > queue.last then error("queue is empty") end
    local value = queue[first]
    queue[first] = nil        -- to allow garbage collection
    queue.first = first + 1
    return value
end

function QueueContains(queue, value)
    local first = queue.first
    if first > queue.last then return false end
    for _,v in pairs(queue) do
        if v == value then return true end
    end
    return false
end

function PrintQueue(queue, label)
    local next = next
    if next(queue) ~= nil then
        Id_Print("["..label.."]Queue:")
        for k,v in pairs(queue) do
            Id_Print("["..label.."]k: "..tostring(k)..", v: "..tostring(v))
        end
    end
end

function Split (inputstr, sep)
    if sep == nil then sep = "%s" end
    local t = {}
    for str in string.gmatch(inputstr, "([^"..sep.."]+)") do
        table.insert(t, str)
    end
    return t
end

--Global Variable Initialisation
gathering_node_names = {}
gathering_nodes = Set(gathering_node_names)
found_nodes = Set{}
nodes_went = Queue{}
current_target = ""
last_node_gathered = ""
moving_count = 0
not_moving_count = 0
last_job_id = 0
stop_main = false
current_zone = 0

--Wrappers & Functions
--Prints given string into chat with script identifier
function Id_Print(string)
    yield("/echo [GatheringHelper] "..string)
end

--Returns given number truncated to 1 decimal place
function Truncate1Dp(num)
    return ("%.1f"):format(num)
end

--Wrapper for class checking, node names to gather from and return current job_id
function ClassCheck()
    local job_id = GetClassJobId()
    if job_id == last_job_id then return job_id end
    --Change names of gathering nodes to gather from based on class
    repeat
        job_id = GetClassJobId()
        if job_id == 16 then      --MIN
            gathering_node_names = {
                "Mineral Deposit", "Rocky Outcrop",
                "Unspoiled Mineral Deposit", "Unspoiled Rocky Outcrop",
                "Legendary Mineral Deposit", "Legendary Rocky Outcrop",
            }
        elseif job_id == 17 then --BTN
            gathering_node_names = {
                "Mature Tree", "Lush Vegetation Patch",
                "Unspoiled Mature Tree", "Unspoiled Lush Vegetation Patch",
                "Legendary Mature Tree", "Legendary Lush Vegetation Patch",
                "Ephemeral Mature Tree", "Ephemeral Lush Vegetation Patch",
            }
        elseif job_id == 18 then --FSH
            gathering_node_names = {
                "Teeming Waters",
            }
        else --not a gatherer
            gathering_node_names = {}
            Id_Print("Not a Disciple of Land!")
            Id_Print("Change class to continue script")
            yield("/wait "..interval_rate)
        end
    until 16 <= job_id and job_id <= 18
    gathering_nodes = Set(gathering_node_names)
    --Empty found_nodes if job_id ~= last_job_id
    if job_id ~= last_job_id then found_nodes = Set{} end
    return job_id
end

--Wrapper for food checking, and if want to consume, consume if not fooded
function EatFood()
    if type(food_to_eat) == "string" and not HasStatus("Well Fed") then
        local eat_food_tick = 0
        repeat
            Id_Print("Eating "..food_to_eat)
            yield("/item "..food_to_eat)
            yield("/wait "..interval_rate)
            eat_food_tick = eat_food_tick + 1
        until HasStatus("Well Fed") or eat_food_tick >= eat_food_threshold
    end
end

--Wrapper for repair check, return true if repaired
function RepairCheck()
    local repair_threshold
    function IsNeedRepair()
        if type(do_repair) ~= "string" then
            return false
        else
            repair_threshold = tonumber(string.gsub(do_repair, "%D", "")) or 99
            if NeedsRepair(tonumber(repair_threshold)) then
                if string.find(string.lower(do_repair), "self") then
                    return "self"
                else
                    return "npc"
                end
            else
                return false
            end
        end
    end

    local repair_token = IsNeedRepair()
    if repair_token then
        if repair_token == "self" then
            while GetCharacterCondition(4) do
                Id_Print("Attempting to dismount...")
                yield("/mount")
                yield("/wait "..interval_rate)
            end
            Id_Print("Attempting to self repair...")
            while not IsAddonVisible("Repair") do
                ExecuteGeneralAction(6)
                yield("/wait "..interval_rate * 0.1)
            end
            yield("/pcall Repair true 0")
            yield("/wait "..interval_rate)
            if IsAddonVisible("SelectYesno") then
                yield("/pcall SelectYesno true 0")
                yield("/wait "..interval_rate)
            end
            while GetCharacterCondition(39) do yield("/wait "..interval_rate * 0.1) end
            yield("/wait "..interval_rate)
            while IsAddonVisible("Repair") do
                ExecuteGeneralAction(6)
                yield("/wait "..interval_rate * 0.1)
            end
            if NeedsRepair(repair_threshold) then
                Id_Print("Self Repair failed!")
                Id_Print("Please place the appropriate Dark Matter in your inventory,")
                Id_Print("Or find a NPC mender.")
                return false
            end
        elseif repair_token == "npc" then
            Id_Print("Equipment below "..repair_threshold.."%!")
            Id_Print("Please go find a NPC mender.")
            return false
        end
    end
    return true
end

--Returns false if zone has changed since start of script
function CheckIfSameZoneSinceScriptStart()
    return current_zone == GetZoneID()
end

--Returns name and co-ordinates of target node in a string with format "<name>,<x-coord>,<y-coord>,<z-coord>"
function GetTargetNodeData()
    local name = GetTargetName()
    local x = Truncate1Dp(GetTargetRawXPos())
    local y = Truncate1Dp(GetTargetRawYPos())
    local z = Truncate1Dp(GetTargetRawZPos())
    return name..","..x..","..y..","..z
end

--Parse given string containing node name and co-ords and returns a table containing them
function ParseNodeDataString(string)
    return Split(string, ",")
end

--Returns displacement between given node as a string and current character position
function GetDistanceToNode(node)
    local given_node = ParseNodeDataString(node)
    return GetDistanceToPoint(tonumber(given_node[2]), tonumber(given_node[3]), tonumber(given_node[4]))
end

--Return the closest gathering node found thus far given by found_nodes, and not went to given by nodes_went
function FindNearestFoundNodeNotGathered()
    local least_distance_to_nodes_not_went = 10000000000000.0
    local node_with_least_distance_not_went = nil

    for node,_ in pairs(found_nodes) do
        if node ~= last_node_gathered and not QueueContains(nodes_went, node) then
            local distance_to_node = GetDistanceToNode(node)
            if distance_to_node < least_distance_to_nodes_not_went then
                node_with_least_distance_not_went = node
                least_distance_to_nodes_not_went = math.min(least_distance_to_nodes_not_went, distance_to_node)
            end
        end
    end
    return node_with_least_distance_not_went
end

--Return the appropriate moving_count_threshold after checking the current zone
function ZoneBasedMovingCountThreshold()
    local zone_id = GetZoneID()
    if zone_id == 939 then return diadem_moving_count_threshold
    else return moving_count_threshold end
end

--Wrapper to get nearest gathering node, replacing /tnpc
function GetNearestNode()
    local smallest_distance = 10000000000000.0
    local closest_node_name
    local nearby_gathering_nodes = GetNearbyObjectNames(ping_radius^2, 6)

    if nearby_gathering_nodes.Count > 0 then
        for i = 0, nearby_gathering_nodes.Count - 1 do
            repeat
                yield("/target "..nearby_gathering_nodes[i])
                yield("/wait "..interval_rate * 0.1)
            until GetTargetName()
            if GetDistanceToObject(GetTargetName()) < smallest_distance then
                smallest_distance = GetDistanceToObject(GetTargetName())
                closest_node_name = GetTargetName()
            end
        end
        if not closest_node_name then yield("/target "..closest_node_name) end
    end
end

--Wrapper to handle data as needed
function HandleDataAsNeeded()
    local do_pop = false
    for k,_ in pairs(found_nodes) do
        if k == last_node_gathered and QueueContains(nodes_went, k) then do_pop = true end
    end
    if do_pop then
        QueuePop(nodes_went)
    end
end

--Wrapper to add node to given set or queue
function AddNodeDataToSetOrQueue(node, set_or_queue, name_of_set_or_queue)
    if set_or_queue == nil or node == nil or ParseNodeDataString(node)[1] == "" then return end
    local name_of_set_or_queue = name_of_set_or_queue or "NAMENOTGIVEN"

    if IsQueue(set_or_queue) then --Given struct is Queue
        if not QueueContains(set_or_queue, node) then QueuePush(set_or_queue, node) end
    else                          --Given struct is Set (or not Queue)
        if not SetContains(set_or_queue, node) then AddToSet(set_or_queue, node) end
    end
end

--Wrapper to handle vnavmesh Movement
function VnavmeshMoveFly(x, y, z, force_moveto)
    local force_moveto = force_moveto or false
    if not force_moveto and ((GetCharacterCondition(4) and GetCharacterCondition(77)) or GetCharacterCondition(81)) then
        yield("/vnavmesh flyto "..x.. " "..y.." "..z)
    else
        yield("/vnavmesh moveto "..x.. " "..y.." "..z)
    end
end

--Wrapper to handle dismount if within given minimum distance to dismount
function CheckDistanceToDismount(node)
    if GetDistanceToNode(node) < min_distance_to_dismount and GetCharacterCondition(4) then
        yield("/mount")
        yield("/vnavmesh stop")
        yield("/wait "..interval_rate * 0.1)
    end
end

--Wrapper handling when player stopped moving
function ActionsIfDetectedNotMoving()
    Id_Print("Detected not moving...")
    Id_Print("Attempting to dislodge...")
    --Implement random coord base on current player position
    VnavmeshMoveFly(Truncate1Dp(GetPlayerRawXPos()+math.random(-5, 5)),
        Truncate1Dp(GetPlayerRawYPos()+math.random(-5, 5)), Truncate1Dp(GetPlayerRawZPos()+math.random(-5, 5)), true)
    yield("/wait "..interval_rate * 3)
end

--Script logic
function main()
--[[
    --Prints out found nodes
    PrintSet(found_nodes, "DEBUG0")
    Id_Print("[DEBUG0]len(found_nodes): "..SetLength(found_nodes))
    --Prints out nodes went
    PrintQueue(nodes_went, "DEBUG0")
    Id_Print("[DEBUG0]len(nodes_went): "..QueueLength(nodes_went))
    Id_Print("[DEBUG0]last_node_gathered: "..last_node_gathered)
--]]

    --Pre-gather Checks
    ---Check if need repairs at start
    ---Check if there's inventory space left
    ---Check if zone has changed
    ::BEFORE_GATHER::
    if not RepairCheck()
        or GetInventoryFreeSlotCount() <= num_inventory_free_slot_threshold
        or not CheckIfSameZoneSinceScriptStart() then
            if GetInventoryFreeSlotCount() <= num_inventory_free_slot_threshold then
                Id_Print("Inventory free slot threshold reached.")
            end
            if not CheckIfSameZoneSinceScriptStart() then
                Id_Print("Zone change detected.")
            end

        stop_main = true
        return
    end

    --Check for nearest node not went to if any
    ::FIND_NEXT_NODE::
    last_job_id = ClassCheck()
    nextNodeToMoveTo = FindNearestFoundNodeNotGathered()

    --Find nearest gathering node
    ::MOVE_NEXT_NODE::
    repeat
        last_job_id = ClassCheck()
        if not CheckIfSameZoneSinceScriptStart() then goto BEFORE_GATHER end

        if nextNodeToMoveTo == nil then
            Id_Print("Traversed all found nodes!")
            Id_Print("Go find another!")
            yield("/wait "..interval_rate)
        else
            if not IsMoving() then
                VnavmeshMoveFly(ParseNodeDataString(nextNodeToMoveTo)[2],
                    ParseNodeDataString(nextNodeToMoveTo)[3], ParseNodeDataString(nextNodeToMoveTo)[4])
                Id_Print("Moving to "..nextNodeToMoveTo)
                yield("/wait "..interval_rate)
            end

            if IsMoving() then
                moving_count = moving_count + 1
            else
                not_moving_count = not_moving_count + 1
            end
            if GetDistanceToNode(nextNodeToMoveTo) < missing_node_distance_tolerance
                and not gathering_nodes[GetTargetName()] then
                Id_Print("Gathering Node not Found!")
                AddNodeDataToSetOrQueue(nextNodeToMoveTo, nodes_went, "nodes_went")
                yield("/vnavmesh stop")
                moving_count = 0
                goto CHECK_DATA
            elseif moving_count > ZoneBasedMovingCountThreshold() then
                ActionsIfDetectedNotMoving()
                moving_count = 0
            elseif not_moving_count > not_moving_count_threshold then
                ActionsIfDetectedNotMoving()
                not_moving_count = 0
            end
        end

        Id_Print("Pinging for nearby Gathering Nodes...")
        GetNearestNode()
        yield("/wait "..interval_rate)
    until gathering_nodes[GetTargetName()]

    Id_Print("Gathering Node found!")
    yield("/vnavmesh stop")
    yield("/automove off")
    if not GetCharacterCondition(6) then EatFood() end
    moving_count = 0
    not_moving_count = 0

    repeat
        current_target = GetTargetNodeData()
        yield("/wait "..interval_rate * 0.1)
    until current_target ~= nil and ParseNodeDataString(current_target)[1] ~= ""
    if not SetContains(found_nodes, current_target) then Id_Print("New Gathering Node: "..current_target) end
    AddNodeDataToSetOrQueue(current_target, found_nodes, "found_nodes")

    --Movement logic, also dismounts if mounted when close enough
    ::HOME_IN_NEXT_NODE::
    repeat
        last_job_id = ClassCheck()
        if not CheckIfSameZoneSinceScriptStart() then goto BEFORE_GATHER end
        CheckDistanceToDismount(current_target)
        if not IsMoving() then
            VnavmeshMoveFly(ParseNodeDataString(current_target)[2],
                ParseNodeDataString(current_target)[3], ParseNodeDataString(current_target)[4])
            Id_Print("Moving to Target...")
            yield("/wait "..interval_rate)
        end

        if IsMoving() then
            moving_count = moving_count + 1
        else
            not_moving_count = not_moving_count + 1
        end
        if moving_count > ZoneBasedMovingCountThreshold() then
            ActionsIfDetectedNotMoving()
            moving_count = 0
        elseif not_moving_count > not_moving_count_threshold then
            ActionsIfDetectedNotMoving()
            not_moving_count = 0
        end

        yield("/wait "..interval_rate)
    until GetCharacterCondition(6)

    ::START_GATHER::
    Id_Print("Starting to gather from current gathering node...")
    AddNodeDataToSetOrQueue(current_target, nodes_went, "nodes_went")
    last_node_gathered = current_target
    yield("/vnavmesh stop")
    yield("/pinteract")

    --Wait for gathering to finish
    ::FINISH_GATHER::
    repeat
        --if is collectable, run collectables script
        if IsAddonVisible("GatheringMasterpiece") then
            yield("/runmacro "..collectables_script_name)
            yield("/wait "..interval_rate * 0.1)
        end

        yield("/wait "..interval_rate * 0.1)
    until not GetCharacterCondition(6)
    Id_Print("Finished gathering from current gathering node!")
    Id_Print("Waiting for "..time_to_wait_after_gather.."s before moving on...")
    yield("/wait "..time_to_wait_after_gather)

    ::CHECK_DATA::
    HandleDataAsNeeded(found_nodes, nodes_went, last_node_gathered)
end

--Run script
Id_Print("----------Starting GatheringHelper----------")
current_zone = GetZoneID()
while not stop_main do
    main()
end
Id_Print("----------Stopping GatheringHelper----------")