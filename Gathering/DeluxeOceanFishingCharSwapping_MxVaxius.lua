--Please read this stuff its not hard the default config will die if you just copy paste so your gonna have to pass the test of reading. and uncommenting one of the two paths or modifying them

--log path - change this to a valid path. foreward slashes are actually backslashes, don't use backslashes unless you know how to escape them properly.

--UNCOMMENT ONE OF THESE TWO and or modify to your hearts content
--local folderPath = "F:/FF14/!gil/"
--local folderPath = os.getenv("appdata").."\\XIVLauncher\\pluginConfigs\\SomethingNeedDoing\\"

-- first char cardinality and variable declaration . useful for resuming at a later point in the list if you have to break the script for some reason such as reloading game or.. playing it haha
local feesh_c = 1

--define the fisherpeople here
local which_one = {
{"Firstname Lastname@Server", 0},
{"Firstname Lastname@Server", 0},
{"Firstname Lastname@Server", 0},
{"Firstname Lastname@Server", 0},
{"Firstname Lastname@Server", 0},
{"Firstname Lastname@Server", 0},
{"Firstname Lastname@Server", 0},
{"Firstname Lastname@Server", 0}
}

--[[
the above table works like this:
firstname last name@server, ?
? = 0, 1, 2, 3
0 means teleport to fc estate and try to get into FC entrance. 
1 means teleport to fc estate and use a nearby retainer bell (navmesh)
2 means teleport to limsa and go to the nearby bell
3 means teleport to gridania and go to the inn. make sure you have yesalready setup for the list item you need for that.

Required plogons
vnavmesh
visland
Autohook -> just setup a autocast thing. and get your versatile lure selected as bait :P the 10 free ones will take you to 100
autoretainer -> you need to NOT use "wait in lobby" in autoretainer, also turn multi on before starting the script or it wont get turned on until after the first ocean fishign happens.
liza's discard helper (make your own fish list)
something need doing (to run this script)
simpletweaks with equipjob command default setting is fine here. just turn it on
YesAlready
TextAdvance

Yesalready configs
"YesNo"
	/Repair all displayed items for.*/
	/Embark to the.*/
"Lists"
	/Register to board.*/
	/Retire to an inn room.*/
"Bothers"
	[x] Contents Finder Confirm  (auto confirm queueing)

Required script:
https://raw.githubusercontent.com/McVaxius/dhogsbreakfeast/refs/heads/main/_functions.lua

place into %AppData%\XIVLauncher\pluginConfigs\SomethingNeedDoing\
---------
---TODO
---------
--add in a (self generating) tracking file that checks levels of chars. if they are under 100 in DT they will be considered. and lowest level one will be selected

------------------------------------------------
------------------------------------------------
------------------------------------------------
------------------------------------------------
------------------------------------------------
------------------------------------------------
------------------------------------------------
--
checking charconditions
pre fishing condition 1
33 34 35 56 while watching cutscene intro
34 56 while waiting on prep ring to dissapear to let people start duty
6 34 56 while fishing
+42 sometimes (when reeling catch or casting) and 43 always once casted. 6 is always on while in gathering mode. while fishing
+35 for cutscene transitions to new areas
33 34 while looking at leave menu, 35 is off _> this is what we use
]]--

loadfiyel = os.getenv("appdata").."\\XIVLauncher\\pluginConfigs\\SomethingNeedDoing\\_functions.lua"
functionsToLoad = loadfile(loadfiyel)
functionsToLoad()
DidWeLoadcorrectly()

-- random number function
function getRandomNumber(min, max)
  return math.random(min,max)
end

-- main fishing function will run per set interval time
local feesh_char = "firstname lastname@server"  --placeholder don't change this variable

--for echoing later
smol_increment = 0

local function vich_one()
	if feesh_c == 0 then feesh_c = #which_one end
	if feesh_c > #which_one then feesh_c = 1 end
	feesh_char = which_one[feesh_c][1]
end

--prep the variable for the echo at the end
vich_one()

function fishing()  
--turn off multi for teleporting to limsa to queue for fishing
--	yield("/ays multi")

	--set the variable for the char to load
	vich_one()
	--feesh_c = feesh_c + 1

	yield("/echo Load -> "..feesh_char)
	
	--now we have to keep trying until we are on the right character.... just in case we are not.
	while feesh_char ~= GetCharacterName(true) do
		yield("/ays relog " ..feesh_char)
		yield("/wait 3")

		-- set the echo variable again so we can say what is next
		--vich_one()

		yield("/waitaddon _ActionBar<maxwait 600>")
	end

	--ok we made it to the right character. let us continue.
	
	-- Teleport to Lisma
	yield("/tp Limsa Lominsa Lower Decks")
	yield("/wait 5")
	yield("/waitaddon _ActionBar<maxwait 600>")
	
	--[[
	yield("/target Aetheryte <wait.2>")
	yield("/target Aetheryte <wait.2>")
	yield("/target Aetheryte <wait.2>")

	become_feesher()
	yield("/lockon on")
	yield("/automove on")
	yield("/send D")
	yield("/send D")
	yield("/wait 3")

	yield("/interact <wait.2>")
	yield("/callback SelectString true 0")
	yield("/callback TelepotTown false 11 3u <wait.1>") -- Arcanists' Guild
	yield("/callback TelepotTown false 11 3u <wait.1>")
	yield("/wait 10")
	]]

	yield("/ac sprint")
	become_feesher()
	--if all good then we move on to next part automagically
		
	--repair catte if we are at 50% durability or lower and have at least 5000 gil
	while NeedsRepair(50) and GetItemCount(1) > 4999 do
		PathfindAndMoveTo(-397.46423339844,3.0999958515167,78.562309265137,false) 
		visland_stop_moving()
		yield("/target Merchant & Mender")
		yield("/wait 1")
		yield("/lockon on")
		yield("/wait 1")
		yield("/interact")
		yield("/wait 1")
		yield("/callback SelectIconString true 1")
		yield("/wait 1")
		yield("/callback Repair true 0")
		yield("/wait 1")
		yield("/callback Repair true 1")
		yield("/wait 1")
		ungabunga()
	end
	 yield("/bait Versatile Lure")
	 
	--check if we have less than 3 versatile lures and more than 20000 gil if not we buy 20 of them!
	while GetItemCount(29717) < 3 and GetItemCount(1) > 20000 do
		PathfindAndMoveTo(-397.46423339844,3.0999958515167,78.562309265137,false) 
		visland_stop_moving()
		yield("/target Merchant & Mender")
		yield("/wait 1")
		yield("/lockon on")
		yield("/wait 1")
		yield("/interact")
		yield("/wait 1")
		yield("/callback SelectIconString true 0")
		yield("/wait 3")
		yield("/callback Shop true 0 3 10")
		yield("/wait 1")
		yield("/callback Shop true 0 3 10")
		yield("/wait 1")
		ungabunga()
	end
	
	yield("/bait Versatile Lure")
	 

	yield("/echo Current area"..Svc.ClientState.TerritoryType)
	zown = Svc.ClientState.TerritoryType
	fzown = Svc.ClientState.TerritoryType

	--dryskthota
	PathfindAndMoveTo(-409.42459106445,3.9999997615814,74.483444213867,false) 
	visland_stop_moving()
	PathfindAndMoveTo(-409.42459106445,3.9999997615814,74.483444213867,false) 
	visland_stop_moving()
	yield("/wait 1")
	fishqtest = false
	toolong = 0
	fishqtest = Svc.Condition[91]
	while (type(fishqtest) == "boolean" and fishqtest == false) do
		yield("/target Dryskthota")
		yield("/wait 2")
		yield("/interact")
		yield("/wait 2")
		yield("/wait 1")
		ungabunga()
		yield("/wait 10")
		fishqtest = Svc.Condition[91]
		toolong = toolong  + 1
		if Svc.Condition[34] == true then  --sometimes we queue instantly. dont wanna get stuck!
			fishqtest = true
		end
		if toolong > 30 then
			fishqtest = true
		end
	end

	yield("/bait Versatile Lure")
 
	--get current area
	--check if area has changed every 5 seconds.
	while (zown == fzown) and (toolong < 30) do
		fzown = Svc.ClientState.TerritoryType	
		yield("/wait 5")
	end
	--if so then wait for 30 seconds then start heading to the visland location
	yield("/wait 30")
	--yield("/visland execonce OceanFishing")
	--yield("/visland moveto 7.451 6.750 -4.043")

--[[ old way
	local randomNum = getRandomNumber(1,8)
    if randomNum == 1 then yield("/visland moveto 6.641 6.711 -0.335")
		elseif randomNum == 2 then yield("/visland moveto 7.451 6.750 -4.043")
		elseif randomNum == 3 then yield("/visland moveto 7.421 6.750 -5.462")
		elseif randomNum == 4 then yield("/visland moveto 7.391 6.711 -7.936")
		elseif randomNum == 5 then yield("/visland moveto -7.450 6.711 -8.982")
		elseif randomNum == 6 then yield("/visland moveto -7.548 6.750 -6.590")
		elseif randomNum == 7 then yield("/visland moveto -7.482 6.739 -2.633")
		elseif randomNum == 8 then yield("/visland moveto -7.419 6.711 -0.113")
	end	
	]]
	--new way
		local randomNum = getRandomNumber(113,4043)
		randomNum = (randomNum * -1) / 1000
		yield("/visland moveto 7.451 6.750 "..randomNum)
	--keep checking for that original area - once it is back. turn /ays multi back on
	--also spam fishing
	omadamkhoneh = 0 --counter to stop trying to move to edge since it will do bad stuff outside of instance after
	while (zown ~= fzown) do
		omadamkhoneh = omadamkhoneh + 1
		fzown = Svc.ClientState.TerritoryType
		if omadamkhoneh > 100 then
			visland_stop_moving()
			omadamkhoneh = -200  --we dont want this to trigger again
		end
		if Svc.Condition[43]==false then
		   yield("/discardall")
		   yield("/wait 5")
		end
		if Svc.Condition[43]==false then
			if Svc.ClientState.TerritoryType ~= 132 then
				yield("/ac cast")
				yield("/wait 1")
			end
		end
		--try to exit the completion window faster
		if IsAddonVisible("IKDResult") then
			yield("/wait 15")
			yield("/callback IKDResult false 0")
		end
		if Svc.Condition[33]==true then
			if Svc.Condition[34]==true then
				if Svc.Condition[35]==false then
				--LEAVE MENU!!!!!!!!
				yield("/send NUMPAD0")
				yield("/wait 1")
				yield("/send NUMPAD0")
				yield("/wait 1")
				end
			end
		end
		yield("/wait 1")
	end
	visland_stop_moving()
	yield("/wait 30")
	ungabungabunga()
	yield("/waitaddon NamePlate<maxwait 600>")
	
	--if we are tp to limsa bell
	if which_one[feesh_c][2] == 2 then
		return_to_limsa_bell()
		yield("/wait 8")
	end
	
	--if we are tp to inn. we will go to gridania yo
	if which_one[feesh_c][2] == 3 then
		yield("/tp New Gridania")
		ZoneTransition()
		yield("/wait 2")
		PathfindAndMoveTo(48.969123840332, -1.5844612121582, 57.311756134033, false)
		visland_stop_moving() --added so we don't accidentally end before we get to the inn person
		yield("/visland exectemponce H4sIAAAAAAAACu3WS4/TMBAA4L9S+RxGfo0fuaEFpBUqLLtIXUAcDPVSS01cEgeEqv53nDSlWxAHUI65eWxnNPlkjb0nr1zlSUm+NGHt6uAWO9ek4LaLFBehrklBVu7HLoY6taT8sCc3sQ0pxJqUe3JPSmnAKsu4LMg7Uj5hgEZKxXhB3pMSNQjGNKpDDmPtr5+Rkom8duvWocv5GNCCLOM3X/k6kTIHNy5tHkK9JmVqOl+Q6zr5xn1Oq5A2r/vv6eXcWH0us93E76eVXF/O/uC27aMUQ9GsIM+rmPwpVfLVOHw67BiDN51v0+Pxnf86BMv4aZy+S3F3Fev1qJFnXobt9ip245/cxi75y/JWLqRzXX30IjaXOfrJt6Hyy7yPHoo/vFGBEGj1kZuCNohIe/7srQwgo8hm7qm4FQObDzQ/cUtpKcU+ztwawQqrZ+3JtCVIjsIctTkwTRH1YG0E5GNOJc7ak2nz3D14Bj9yK1BaS4sDt0VApZWdtSdr3AwYNxbHVmKASmWVPnIzKkFwTs3fvMV8Uf6jt8TcrM3wEjl7SzNyCxDa6rmZTHa8uQWRH4LmzP3rYDPUcr4kp5PWoASXVv0uzYAzIebH339Kfzz8BLifXG8MDQAA")
		visland_stop_moving() --added so we don't accidentally end before we get to the inn person
		yield("/target Antoinaut")
		yield("/wait 0.5")
		yield("/interact")
	end
	
	--options 1 and 2 are fc estate entrance or fc state bell so thats only time we will tp to fc estate
	if which_one[feesh_c][2] == 0 or which_one[feesh_c][2] == 1 then
		--yield("/tp Estate Hall (Free Company)")
		yield("/waitaddon NamePlate<maxwait 600>")
		yield("/li fc")
		yield("/wait 1")
		--yield("/waitaddon Nowloading<maxwait 600>")
		yield("/wait 15")
		yield("/waitaddon NamePlate<maxwait 600>")
	end

	--normal small house shenanigans
	if which_one[feesh_c][2] == 0 then
		yield("/hold W")
		yield("/wait 1")
		yield("/release W")
		yield("/hold W")
		yield("/wait 1")
		yield("/lockon on")
		yield("/hold W")
		yield("/wait 2.5")
		yield("/interact")
		yield("/automove off")
		yield("/wait 1.5")
		yield("/hold Q")
		yield("/wait 1")
		yield("/interact")
		yield("/release Q")
		yield("/interact")
		yield("/hold Q")
		yield("/wait 1")
		yield("/interact")
		yield("/release Q")
		yield("/interact")
		yield("/wait 1")
	end

	--retainer bell nearby shenanigans
	if which_one[feesh_c][2] == 1 then
		yield("/target \"Summoning Bell\"")
		yield("/wait 2")
		PathfindAndMoveTo(GetObjectRawXPos("Summoning Bell"), GetObjectRawYPos("Summoning Bell"), GetObjectRawZPos("Summoning Bell"), false)
		visland_stop_moving() --added so we don't accidentally end before we get to the bell
	end
	feesh_c = feesh_c + 1
end --of fishing()

while true do 
  local currentTime = os.date("*t")
  local formattedTime = string.format("%04d-%02d-%02d %02d:%02d:%02d", currentTime.year, currentTime.month, currentTime.day, currentTime.hour, currentTime.min, currentTime.sec)
	
	if Svc.Condition[1]==false then
		yield("/wait 30")  -- Wait for 30 seconds because we are at the login screen
	end
	
	--secret variable
	wheeequeheeheheheheheehhhee = 0
	
	--The next 2 lines of code copied from https://raw.githubusercontent.com/plottingCreeper/FFXIV-scripts-and-macros/main/SND/FishingRaid.lua
	--line 319 to line 320
	--thanks botting creeper!
    if os.date("!*t").hour%2==0 and os.date("!*t").min<15 then
      if os.date("!*t").min>=1 then
		wheeequeheeheheheheheehhhee = 1
	  end
    end

   --if taskTimes[currentTime.hour] and taskTimeMin[currentTime.min]  then
   if wheeequeheeheheheheheehhhee == 1 then
	if Svc.Condition[31]==false then
		if Svc.Condition[32]==false then
			 --yield("/ays multi")
			 yield("/ays multi d")
		 	 ungabungabunga() -- we really really try hard to be safe here
			 yield("/waitaddon _ActionBar<maxwait 600>")
			 fishing()
			 --drop a log file entry on the charname + Level
			 -- Define the folder path
			--feesh_c = feesh_c - 1
			--vich_one()
			-- Open a file in write mode within the specified folder
			local file = io.open(folderPath .. "FeeshLevels.txt", "a")

			if file then
				-- Write text to the file
				--file:write("Hello, this is some text written to a file using Lua!\n")
				currentTime = os.date("*t")
				formattedTime = string.format("%04d-%02d-%02d %02d:%02d:%02d", currentTime.year, currentTime.month, currentTime.day, currentTime.hour, currentTime.min, currentTime.sec)
				feesh_c = feesh_c - 1
				file:write(formattedTime.." - ".."["..feesh_c.."] - "..feesh_char.." - Fisher Lv - "..GetLevel().."\n")
				feesh_c = feesh_c + 1
				--file:write("Writing to files in Lua is straightforward.\n")
				-- Close the file handle
				file:close()
				--print("Text has been written to '" .. folderPath .. "output.txt'")
				yield("/echo Text has been written to '" .. folderPath .. "FeeshLevels.txt'")
			else
				--print("Error: Unable to open file for writing")
				yield("/echo Error: Unable to open file for writing")
				--file:write("Error: Unable to open file for writing\n")
			end
			--feesh_c = feesh_c + 1
			vich_one()
 			--yield("/ays multi")
 			yield("/ays multi e")
		end
	end
   end  -- end if

  yield("/wait 0.3")  -- Wait for 0.3 second before checking again
  smol_increment = smol_increment + 1
  tempfeesh = "asdf"
  if smol_increment > 180 then
	smol_increment = 0
	feesh_c = feesh_c + 1
	vich_one()
	tempfeesh = feesh_char
	feesh_c = feesh_c - 1
	vich_one()
	yield("/echo Next = "..tempfeesh..", "..feesh_c.."/"..#which_one.." Last -> "..feesh_char)
  end
end -- while loop
