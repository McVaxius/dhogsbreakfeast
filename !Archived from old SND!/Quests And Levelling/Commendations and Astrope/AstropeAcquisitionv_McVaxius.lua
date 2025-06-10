yield("/cl")
--add instructions
--which plugins
--etc
--SimpleTweaks -> Hide Guildhest Objective Popup
--
--.ini file name sure no spaces between ?,?
--last 3 rows have to have same roles just change the folder path and master there . you can insert as many rows of slaves as you like. but you need at least 1 slave

--Automaton
--auto leave when duty done
--auto target Bockman

--DISCLAIMER - wrote this back in january then never tested it. it probably doesn't work and i dont care about astrope anymore so please go ahead and mess around with it

local filename = os.getenv("appdata").."\\XIVLauncher\\pluginConfigs\\SomethingNeedDoing\\AstropeConfig.ini"
local repeat_guildhest = 100
local repeated_guildhest = 0
local are_we_master = 0 --off by default
local nameofmaster = "nobodyatall"
local mynem = "asdf"
local ourindex = 1 --where in the table did we appear??!?
local masterindex = 1 --where is the master
local readytoqueue = 0  --defaulting to 0 as we have new logic. master only queues if a slave is queueing not when they are waiting. slave only queues if master is in waiting
local astrope = {}  -- Initialize an empty table
local writestatusroot = "c:\tempwrite"
local readstatusroot = "c:\tempread"
local tablechanged = 0 --by default the table hasn't been changed

--beeg inn
-- Function to load variables from a file
function loadVariablesFromFile(filename)
    local file = io.open(filename, "r")
    if file then
        for line in file:lines() do
            -- Remove single-line comments (lines starting with --) before processing
            line = line:gsub("%s*%-%-.*", "")
            -- Extract variable name and value
            local variable, value = line:match("(%S+)%s*=%s*(.+)")
            if variable and value then
                -- Convert the value to the appropriate type (number or string)
                value = tonumber(value) or value
                _G[variable] = value  -- Set the global variable with the extracted name and value
            end
        end
        io.close(file)
    else
        yield("/echo Error: Unable to open variable file " .. filename)
    end
end

function load_table_from_file(file_path)
    local file = io.open(file_path, "r")  -- Open the file in read mode
    if file then
        astrope = {}  -- Initialize an empty table
        for line in file:lines() do  -- Iterate over each line in the file
            if line ~= "" then  -- Skip empty lines
                local row = {}  -- Initialize an empty table for each row
                for value in line:gmatch("[^,]+") do  -- Split the line by comma
                    table.insert(row, value)  -- Insert each value into the row table
					--yield("/echo value "..value)
                end
                table.insert(astrope, row)  -- Insert the row into the main table
            end
        end
        file:close()  -- Close the file
        return astrope  -- Return the loaded table
    else
        yield("/echo Error: Unable to open table file '" .. file_path .. "'")
        return nil
    end
end

-- Specify the path to your text file
-- forward slashes are actually backslashes.
--also be sure to update the folder name as per your preference
--just remember it will strip spaces and apostrophes on status files  so Bob Your'uncle would be AstropeStatusBobYouruncle.status
--tempchar = tempchar:match("%s*(.-)%s*") --remove spaces at start and end only
--tempchar = tempchar:gsub("%s", "")  --remove all spaces
--tempchar = tempchar:gsub("'", "")   --remove all apostrophes
--local numElements = #astrope --this will give us number of elements in the table in case we want it for something

-- Call the function to load variables from the file
yield("/echo First load of data")
--loadVariablesFromFile(filename)
load_table_from_file(filename)
yield("/echo Data Loaded")

local function hackjobdashboard()
	if tablechanged == 1 then -- so that we aren't spam refreshing when the table isn't changed yet
		--hackjob dashboard lets go
		yield("/cl")
		yield("/echo ****************Dashboard************** rows -> "..#astrope)
		for i = 1, #astrope do
			local name = astrope[i][1]
			local role = astrope[i][2]
			local status = astrope[i][3]
			yield("/echo Row " .. i .. ": Name - " .. name .. ", Role - " .. role .. ", Status - " .. status)
			if GetCharacterName() == name then
				if role == "master"  then
					are_we_master = 1
					nameofmaster = name
					nameofmaster = nameofmaster:gsub("%s", "")  --remove all spaces
					nameofmaster = nameofmaster:gsub("'", "")   --remove all apostrophes
				end
				ourindex = i
				mynem = name
				mynem = mynem:gsub("%s", "")  --remove all spaces
				mynem = mynem:gsub("'", "")   --remove all apostrophes
			end
			if role == "master"  then
				masterindex = i
			end
			if  role == "writestatusroot" then
				yield("/echo writestatusroot found")
				writestatusroot = name
			end
			if role == "readstatusroot" then
				yield("/echo readstatusroot found")
				readstatusroot = name
			end
		--yield("/echo Number of Chars:"..numElements)
		end
		yield("/echo ourindex:"..ourindex)
		yield("/echo nameofmaster:"..nameofmaster)
		yield("/echo are_we_master:"..are_we_master)
		yield("/echo readstatusroot:"..readstatusroot)  --where we are reading statuses from in case its not the same place where we are writing since we are only going to update our own status
		yield("/echo writestatusroot:"..writestatusroot)--where we are writing statuses to in case its not the same as where we read them from
		--end of hackjob dashboard
		tablechanged = 0
	end
end

--cleanup the variables a bit.  maybe well lowercase them later too hehe.
--char_snake = char_snake:match("^%s*(.-)%s*$"):gsub('"', '')
--enemy_snake = enemy_snake:match("^%s*(.-)%s*$"):gsub('"', '')

--begin main loop

local function write_astrope_status(astropestatus)
    -- Open the file in write mode, overwriting existing content but ONLY if we have changed the value.
	-- this will reduce file i/o
	if astrope[ourindex][3] != astropestatus then
		tablechanged = 1 --for the dashboard
		local file, error_message = io.open(writestatusroot .. mynem .. ".astrope", "w")
		if file then
			-- Write new content to the file
			file:write(astropestatus)
			-- Close the file
			file:close()
		else
			-- Failed to open the file
			yield("/echo Failed to open the write status file: " .. (error_message or "Unknown error"))
		end
	end
    -- Update the status in the astrope table
    astrope[ourindex][3] = astropestatus -- Self status
end

local function grabstatuses()
	--now for this fun stuff. remember to ignore the last 3 in the array
	--so now we need to iterate through the array again
	funnyname = "asdfasdf asdfsadf"
	rolemod = 2 --init rolemod, 2 for slaves, since they will need to check master status
	if are_we_master == 1 then
		rolemod = 3
	end
	for i = 1, (#astrope - rolemod) do
		funnyname = astrope[i][1] --grab the name
		funnyname = funnyname:gsub("%s", "")  --remove all spaces
		funnyname = funnyname:gsub("'", "")   --remove all apostrophes
		-- Open the file in read mode
		local file, error_message = io.open(readstatusroot .. funnyname .. ".astrope", "r")
		if file then
			-- Read content from the file
			local content = file:read("*all")
			-- Close the file
			file:close()
			-- Return the content
			--return content
			if content == "duty" and i ~= ourindex then
				readytoqueue = 0
			end
			if i == masterindex then
				astrope[masterindex][3] = content
			end
		else
			-- Failed to open the file
			yield("/echo Failed to open the read status file: " .. (error_message or "Unknown error"))
			--return nil
		end
	end
end

yield("/echo Begin Main Loop")
hackjobdashboard()

while repeated_guildhest < repeat_guildhest do
	--char conditions
	--34 duty
	--91 queueing
	--yield("/callback ContentsFinder true 12 0") is the same for both queuein and cancelling queue . facepalm

	readytoqueue = 1 --always be ready unless pulling data from statuses indicates otherwise

	hackjobdashboard() --display the status
	yield("/wait 1") --debug change to 1 second later once its working well
	
	--grab file statuses for each char if any are not waiting/queuing then we are going to set readytoqueue = 0
	grabstatuses()
	
	--master loop
	if are_we_master == 1 then
		--we slid into the wrong duty - leave and lockout!
		if GetZoneID() ~= 43 and GetCharacterCondition(34) then --not under armor AND in duty
		write_astrope_status("locked")
		LeaveDuty()
		yield("/wait 1")
		end
		
		--open a new loop and check for timeout timer until its at 0 then resume main loop?????????
		--output remaining timer to screen????????
		if GetPenaltyRemainingInMinutes() > 0 then
			yield("/echo We are in time out!"
			yield("/wait 5")
			write_astrope_status("locked")
			while GetPenaltyRemainingInMinutes() > 0 do
				yield("/echo We have been naughty - "..GetPenaltyRemainingInMinutes().." minutes remaining!"
				yield("/wait 60")
			end
			yield("/wait 5")
			yield("/echo We are out of time out!"
		end
	
		--master checks slaves if any of them are in queue state, then we queue write_astrope_status("queueing"). otherwise master waits  write_astrope_status("waiting")
		--this is already done by the getstatus
		
		if readytoqueue == 1 and GetCharacterCondition(34) == false and GetCharacterCondition(91) == false then
			yield("/dutyfinder")
			yield("/wait 1")
			yield("/callback ContentsFinder true 12 0")
			yield("/wait 2")
			write_astrope_status("queue")
		end
	end
	
	--slave loop
	if are_we_master == 0 then
		 --if master is in duty or in locked mode and we aren't then stop queing and go into wait mode
		if (astrope[masterindex][3] == "duty" or astrope[masterindex][3] == "locked") and GetCharacterCondition(34) == false and GetCharacterCondition(91) == true then
			--cancel queue if we are queued and need to cancel
			yield("/dutyfinder")
			yield("/wait 1")
			yield("/callback ContentsFinder true 12 0")
			yield("/wait 2")
			write_astrope_status("waiting")
		end
	
		--if master is in wait mode, we can queue, dont care about other states
		--also check if we aren't in duty at the moment
		--note to self. we may want to check ready to queue here in case we want to only do full sync
		--if (astrope[masterindex][3] == "waiting" or astrope[masterindex][3] == "queue") and GetCharacterCondition(34) == false and GetCharacterCondition(91) == false and readytoqueue == 1 then
		if (astrope[masterindex][3] == "waiting" or astrope[masterindex][3] == "queue") and GetCharacterCondition(34) == false and GetCharacterCondition(91) == false then
			yield("/dutyfinder")
			yield("/wait 1")
			yield("/callback ContentsFinder true 12 0")
			yield("/wait 2")
			write_astrope_status("queue")
		end
		
		--if master reaches done state then /pcraft stop
		if astrope[masterindex][3] == "done" and GetCharacterCondition(34) == false then
			yield("/echo We finished! I guess")
			yield("/wait 15")
			--maybe throw multi back on here and a /li
			--yield("/li")
			yield("/wait 20")
			--yield("/ays multi")
			yield("/pcraft stop")
		end
	end

	--shared check at the end so we aren't double writing status in single pass
	--if we are inside
	if GetZoneID() == 43 and GetCharacterCondition(34) then
		yield("/rotation Manual")
		write_astrope_status("duty")
		--autofollow bockman with configuration in automaton?.. add notes at the start instructions at start for this.
	end
	--if we are outside
	if GetZoneID() ~= 43 and GetCharacterCondition(34) == false and GetCharacterCondition(91) == false then
		yield("/rotation Cancel")
		write_astrope_status("waiting")
	end

	--check if we changed areas and do what needs to be done
	we_are_in = GetZoneID() --where are we?
	if type(we_are_in) ~= "number" then
		we_are_in = we_were_in --its an invalid type so lets just default it and wait 10 seconds
		yield("/echo invalid type for area waiting 10 seconds")
		yield("/wait 10")
	end
	if we_are_in ~= we_were_in then
		yield("/wait 1")
		if GetCharacterCondition(34) == true then 
			yield("/rotation Manual")
			repeated_guildhest = repeated_guildhest + 1
		end
		yield("/echo guildhest has begun!")
		we_were_in = we_are_in --record this as we are in this area now
	end
	hackjobdashboard()
end
----------------------------------------------
if are_we_master == 1 then
	write_astrope_status("done")
end
----------------------------------------------