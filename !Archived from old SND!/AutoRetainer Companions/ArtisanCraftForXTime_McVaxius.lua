--[[
  Description: Craft for xHxM in Artisan before resuming multi
  Author: McVaxius
  Link: https://discord.com/channels/1162031769403543643/1162799234874093661/1164363368228990976
]]

--how long to craft for
gotime = "1h40m"
--os.time() and os.difftime()
start_time = os.time()

-- Function to convert time string to seconds
function convertTimeToSeconds(timeStr)
    local hours, minutes = timeStr:match("(%d+)h(%d+)m")
    hours = tonumber(hours) or 0
    minutes = tonumber(minutes) or 0
    local seconds = hours * 3600 + minutes * 60
    return seconds
end

-- Convert and assign to gosecondtime
gosecondtime = convertTimeToSeconds(gotime)

-- Print the result
print("Equivalent seconds: " .. gosecondtime)

--old way
--yield("<wait."..gosecondtime..".0")

--new way
while gosecondtime > 0 do
    yield("/echo "..gosecondtime.." seconds left till multi")
    gosecondtime = gosecondtime - 1
    yield("<wait.1.0>")
end

yield("/xltoggleprofile Artisan")
yield("/callback SynthesisSimple true -1")
yield("<wait.5.0>")
yield("/stopcrafting")
yield("<wait.5.0>")
yield("/ays multi")