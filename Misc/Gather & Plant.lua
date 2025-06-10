--[[Quick and dirty Gather/Plant script. It will interact to collect (default wait 1.5s) and interact again to plant (default wait 2.0s) all [sprouts] within 4.6 units (interact range). 
So position yourself and start the macro. 

Requires "Auto-select Gardening Soil/Seeds" in Pandora, and probably YesAlready and TextAdvance.
]]

-- Define wait times (adjust as needed)
local HarvestInteractWait = 1.5
local PlantInteractWait = 2.0

local targetList = {}

-- Loop through targets and record if within interact range
for i = 0, 24 do
    yield("/target  <list." .. i .. "><wait.0.1>")

-- If a target is too far in the distance we lose target before we can check GetDistanceToTarget(), so ignore 0.0
    if GetDistanceToTarget() <= 4.6 and GetDistanceToTarget() > 0.0 then
        table.insert(targetList, i)
    end
end

-- Interact with targets for harvesting and then planting
for _, index in ipairs(targetList) do  
    -- Harvesting
    yield("/target  <list." .. index .. "><wait.0.1>")
    yield("/pinteract")
    yield("/wait " .. HarvestInteractWait)

    -- Planting
    yield("/target  <list." .. index .. "><wait.0.1>")
    yield("/pinteract")
    yield("/wait " .. PlantInteractWait)
end