
--************************* START INIZER **************************
--*****************************************************************
-- Purpose: to have default .ini values and version control on configs
-- Personal ini file
-- if you want to use my ini file serializer just copy form start of inizer to end of inizer and look at how i implemented settings and go nuts :~D

-- Function to open a folder in Explorer
function openFolderInExplorer(folderPath)
    if folderPath then
        folderPath = '"' .. folderPath .. '"'
        os.execute('explorer ' .. folderPath)
    else
        yield("/echo Error: Folder path not provided.")
    end
end

function serialize(value)
    if type(value) == "boolean" then
        return tostring(value)
    elseif type(value) == "number" then
        return tostring(value)
    else -- Default to string
        return '"' .. tostring(value) .. '"'
    end
end

function deserialize(value)
    if value == "true" then
        return true
    elseif value == "false" then
        return false
    elseif tonumber(value) then
        return tonumber(value)
    else
        return value:gsub('^"(.*)"$', "%1")
    end
end

function read_ini_file()
    local variables = {}
    local file = io.open(filename, "r")
    if not file then
        return variables
    end

    for line in file:lines() do
        local name, val = line:match("([^=]+)=(.*)")
        if name and val then
            variables[name] = deserialize(val)
        end
    end
    file:close()
    return variables
end

function write_ini_file(variables)
    local file = io.open(filename, "w")
    if not file then
        yield("/echo Error: Unable to open file for writing: " .. filename)
        return
    end

    for name, value in pairs(variables) do
        file:write(name .. "=" .. serialize(value) .. "\n")
    end
    file:close()
end

function ini_check(varname, varvalue)
    local variables = read_ini_file()

    if variables["version"] and tonumber(variables["version"]) ~= vershun then
        yield("/echo Version mismatch. Recreating file.")
        variables = {version = vershun}
    end

    if variables[varname] == nil then
        variables[varname] = varvalue
        yield("/echo Initialized " .. varname .. " -> " .. tostring(varvalue))
    else
        yield("/echo Loaded " .. varname .. " -> " .. tostring(variables[varname]))
    end

    write_ini_file(variables)
    return variables[varname]
end

--*****************************************************************
--************************** END INIZER ***************************
--*****************************************************************


function become_feesher()
	--[[
	if GetItemCount(2571) > 0 then yield("/equipitem 2571") end --weathered fishing rod
	yield("/wait 0.5")
	if GetItemCount(35393) > 0 then yield("/equipitem 35393") end --integral fishing rod
	yield("/wait 0.5")
	--]]
	yield("/equipjob fsh")
	yield("/wait 0.5")
	--check if we can become fisher
	--[[
	if GetItemCount(35393) == 0 and GetItemCount(2571) == 0 and GetClassJobId() ~= 18 then
		visland_stop_moving()
		yield("/vnavmesh moveto -246.67446899414 16.199998855591 41.268531799316")
		visland_stop_moving()
		yield("/echo No rod so we buy one and equip it!")
		yield("/target Syneyhil")
		yield("/wait 2")
		yield("/interact")
		yield("/wait 2")
		yield("/callback SelectIconString true 1")
		yield("/wait 2")
		yield("/callback SelectString true 0")
		yield("/wait 2")
		yield("/callback Shop true 0 4 1")
		yield("/wait 1")
		yield("/callback Shop true -1")
		yield("/wait 1")
		visland_stop_moving()
		ungabunga()
	end
	--]]
	--[[
	if GetItemCount(2571) > 0 then yield("/equipitem 2571") end --weathered fishing rod
	yield("/wait 0.5")
	if GetItemCount(35393) > 0 then yield("/equipitem 35393") end --integral fishing rod
	yield("/wait 0.5")
	==]]
	yield("/equipjob fsh")
	yield("/wait 0.5")
	ungabunga()
	--[[
	if GetItemCount(2571) > 0 then yield("/equipitem 2571") end --weathered fishing rod
	yield("/wait 0.5")
	if GetItemCount(35393) > 0 then yield("/equipitem 35393") end --integral fishing rod
	yield("/wait 0.5")
	==]]
	yield("/equipjob fsh")
	yield("/wait 0.5")
end

function ungabunga()
	yield("/send ESCAPE")
	yield("/wait 1.5")
	if IsAddonReady("SelectYesno") then yield("/callback SelectYesno true 0") end
	yield("/send ESCAPE")
	yield("/wait 1.5")
	if IsAddonReady("SelectYesno") then yield("/callback SelectYesno true 0") end
	yield("/send ESCAPE")
	yield("/wait 1.5")
	if IsAddonReady("SelectYesno") then yield("/callback SelectYesno true 0") end
	yield("/send ESCAPE")
	yield("/wait 1")
	if IsAddonReady("SelectYesno") then yield("/callback SelectYesno true 0") end
	yield("/wait 3")
end

function zungazunga()
	yield("/send ESCAPE")
	yield("/wait 0.5")
	yield("/send ESCAPE")
	yield("/wait 0.5")
	yield("/send ESCAPE")
	yield("/wait 0.5")
end

function ungabungabunga()
	--don't bunga bunga if we are not ingame.. it breaks logging in
	while Svc.Condition[1] == false do
		yield("/wait 5") --wait 5 seconds to see if char condition 1 comes back.
	end
	if Svc.Condition[1] == true then
		tobungaorunga = 0
		while tobungaorunga == 0 do
			yield("/send ESCAPE")
			yield("/wait 1.5")
			if IsAddonReady("SelectYesno") then yield("/callback SelectYesno true 0") end
			yield("/send ESCAPE")
			yield("/wait 1.5")
			if IsAddonReady("SelectYesno") then yield("/callback SelectYesno true 0") end
			yield("/send ESCAPE")
			yield("/wait 1.5")
			if IsAddonReady("SelectYesno") then yield("/callback SelectYesno true 0") end
			yield("/send ESCAPE")
			yield("/wait 1")
			yield("/wait 3")
			if Player.Available == true then
				tobungaorunga = 1
			end
		end
	end
end

function generateRandomLetter(cappy)
    local uppercase = math.random(65, 90) -- ASCII codes for uppercase letters
    local lowercase = math.random(97, 122) -- ASCII codes for lowercase letters
    local choice = math.random(0, 1) -- Randomly choose between uppercase and lowercase
	if cappy == 2 then choice = 0 end
	if cappy == 3 then choice = 1 end
    if choice == 0 then
        return string.char(lowercase)
    else
        return string.char(uppercase)
    end
end

--0=no, 1=full randomize, 2=lowercase only, 3=uppercase only, 4=randomly full upper OR lowercase, 5=pick from emblem configuration list. remember this has to be the FC leader
function generateFiveDigitText(frocess_tags)
    local text = ""
	capper = frocess_tags
	if capper == 4 then
		local choice = math.random(0, 1) -- Randomly choose between uppercase and lowercase
		choice = choice + 2
	end
    for i = 1, 5 do
        text = text .. generateRandomLetter(capper)
    end
    return text
end

function WalkTo(x, y, z)
	PathfindAndMoveTo(x, y, z, false)
	countee = 0
	while (PathIsRunning() or PathfindInProgress()) do
		yield("/wait 0.5")
		--if Svc.ClientState.TerritoryType == 130 or Svc.ClientState.TerritoryType == 341 then --130 is uldah. dont need to jump anymore it paths properly. we will test anyways.
		countee = countee + 1
		--yield("/echo we are still pathfinding apparently -> countee -> "..countee)
		if gachi_jumpy == 1 and countee == 10 and Svc.ClientState.TerritoryType ~= 129 then --we only doing jumps if we configured for it
		--if Svc.ClientState.TerritoryType == 341 then --only need to jump in goblet for now
			yield("/gaction jump")
			countee = 0
			yield("/echo we are REALLY still pathfinding apparently")
		end
	end
end

function ZoneTransition()
	yield("/automove off")
	iswehehe = Player.Available
	iswoah = 0
    repeat 
        yield("/wait 0.5")
        yield("/echo Are we ready? -> "..iswoah.."/20")
		iswehehe = Player.Available 
		iswoah = iswoah + 1
		if 	iswoah == 5 then if IsAddonReady("SelectYesno") then yield("/callback SelectYesno true 0") end end
		if 	iswoah == 10 then if IsAddonReady("SelectYesno") then yield("/callback SelectYesno true 0") end end
		if 	iswoah == 15 then if IsAddonReady("SelectYesno") then yield("/callback SelectYesno true 0") end end
		if 	iswoah == 20 then
			iswehehe = false
			if IsAddonReady("SelectYesno") then yield("/callback SelectYesno true 0") end
		end
    until not iswehehe
	iswoah = 0
	zungazunga()
	yield("/automove off")
    repeat 
        yield("/wait 0.5")
        yield("/echo Are we ready? (backup check)-> "..iswoah.."/20")
		iswehehe = Player.Available 
		iswoah = iswoah + 1
		if 	iswoah == 5 then if IsAddonReady("SelectYesno") then yield("/callback SelectYesno true 0") end end
		if 	iswoah == 10 then if IsAddonReady("SelectYesno") then yield("/callback SelectYesno true 0") end end
		if 	iswoah == 15 then if IsAddonReady("SelectYesno") then yield("/callback SelectYesno true 0") end end
		if 	iswoah == 20 then
			iswehehe = true
			if IsAddonReady("SelectYesno") then yield("/callback SelectYesno true 0") end
		end
    until iswehehe
	zungazunga()
end

function WalkToGC()
	yield("/echo processing GC travel request....")
    if GetPlayerGC() == 1 then --toilet
        if Svc.ClientState.TerritoryType ~= 129 and Svc.ClientState.TerritoryType ~= 128 then
			yield("/tp limsa")
			yield("/echo attempting to tp to limsa")
		    ZoneTransition()
			toiletvisitor = 0
			while Svc.ClientState.TerritoryType ~= 129 do  --sometimes things get stuck in limsa or pre-limsa this should solve it.
				yield("/tp limsa")
				ZoneTransition()
			end
			yield("/echo we in limsa")
			yield("/wait 5")
			while Svc.ClientState.TerritoryType ~= 128 do  --sometimes things get stuck in limsa or pre-limsa this should solve it.
				toiletvisitor = toiletvisitor + 1
				if toiletvisitor > 10 then
					yield("/pcraft stop all")
					yield("/vnav stop")
				end
				yield("/li aftcastle") 
				yield("/wait 5")
				ZoneTransition()
			end
			yield("/echo we in upper decks")
			zungazunga()
			if movementtype == 1 then --visland hackery
				yield("/visland exectemponce H4sIAAAAAAAACu2Wy07DMBBF/2XWkRU/Y2eHClQVaikFqTzEwlBXtZTEpXFAqOq/44ZE9LFDWSYrz53J6PrIGnsLE50bSGE4yGxeaohguHHVOigTV5gQzvX32tnCl5C+bGHqSuutKyDdwiOkWCEuZcIieIKUxSiO4BnShKCEYUV3IQpNRpeQhsRML2wVutB91dh9mtwUvs5MtV8tbbGAdKmz0kQwKrzZ6Hc/t3512/x+qDWeg7ty5b7aTLBVnrWoveIIrnLnWycjb/JmeVFXNMFdZUp/uL43H3Uwdm+NfO/deuCKRQMhKDc2ywauarYyc5U3x/bm2vo/X/vo2m2Oe+zFB5ubcaiLd9EZZsKRiqmK5QlniiRjuOfcFWeaIBnz5IwypxwT0R/njjAzgaSQmIsaNFVIhY+3sBnBVLAedkewhUAsID2b0JSJfnJ0NjkSjkigfHoRUkQEUbg/zB1hVhRRoqTgLWeScJr8subh0cFi2bP+F+vX3Q9/zfhXCwoAAA==")
				--yield("/vnav moveto") --wtf is this
				visland_stop_moving()
			end
		end
		if movementtype == 0 then --default navmesh
			WalkTo(94, 40.5, 74.5)
		end
    elseif GetPlayerGC() == 2 then --vampire coven
		while Svc.ClientState.TerritoryType ~= 132 do
			yield("/tp grid")
		    ZoneTransition()
		end
		if movementtype == 1 then --visland hackery
			yield("/li archers") 
		    ZoneTransition()
			yield("/visland exectemponce H4sIAAAAAAAACu2ZTW/bMAyG/4vOKUGJokT5NnRbUQztunZA94EdssVdDTRxlzgbhqL/ffRXP7CdBh11M2VHoJ+8eE1Sd+Z0ua5NZY4Ov2+blVmYo227v9WF03ZTa3i5/H3bNptuZ6rPd+as3TVd025MdWc+mMp6gRREFuajqQ4QKDCLtbwwn0wlBIFiTPca6V7HL02FC3O+XDV73YxAg5P2Z72uN91w52zZXV81m5WprpY3u3phjjddvV1+6y6b7vrt9POna1PmmuTuuv0139Hsdn9tMaRsF+bVuu3mTI67ej1dvhiemIJ3+3rXPb2+qH8MwUn7dVq+6Nrbw3azmljoypvm5uaw3U+vct7uu/p5epfLpnvMq49et9vne/SL75t1faLP4f3ib9pOIEQf3IwbIwZFHgfcMQFah6HgzoXbekAXgwsPvMX7INGNvB1EywV3PtzqH8k6P9BW2APl4IEYrRRV58KMEUiCpQmzw6Q2IgNsFnD6DxRR56Wtvj1atgrcpuBp/D6yatwic5F2JtiJgaI4HB1E7ZkT+TB+HclDQC/FR3LBFobgUhpZE3hkN5iKstYyJXr2vig7F+zAkKLEgbWFIIgcRssmBFW5wi8ukok1B3Ae/ezYQekqe5ppE1GKRdm5aHsPTCh9DzN4NvuUAobRRyxof4MFdjbYDgQTyT9Y2wQxavfui49kgk064bCB7GTaY9PoSI08BSqUM1FWj3CCkWfKVgvs+MCamC0W2Pm6GW1gtMrrG5hxIpISOnI8WwglH22xkFy8D7zW1T7JzNsBueTF+pE3QwwoEouZ5OLtELRHdNOA1YMldP34r6dNIKrtMs7Op27SPtEFbctn3E766eqkbgtiQ3Kl+svGm0kJE0ea3URsfz4z6RsholYmZaCdjXewYJmJJn1rp44auL6P788PgEPSqLh3Nt4RtLl5LE703IBJHWbAfSDq3+hj0XdO3iye7RPegj7wzNt6F32pTv6P95f7P8KvqWabHwAA")
			visland_stop_moving()
		end
		if movementtype == 0 then --default navmesh
			WalkTo(-68.5, -0.5, -8.5)
		end
    elseif GetPlayerGC() == 3 then --best place in game
		while Svc.ClientState.TerritoryType ~= 130 do
			yield("/tp ul'dah")
		    ZoneTransition()
		end
		if movementtype == 1 then --visland hackery
			yield("/li thaumaturge") 
		    ZoneTransition()
			yield("/visland exectemponce H4sIAAAAAAAACu2WSWvDMBCF/8ucXWFJI8v2raQLoaQ7pAs9uI1CBLGVxnJLCfnvnTgKTZdT8dE+6b2Rh6cPMWgF50VpIIfTQTOfQASnS9csSJ+7ypAcFx8LZytfQ/64gktXW29dBfkK7iA/4EoxybnECO4h58jiWEXwADkmLFGayzUpajQ8gjyO4LqY2IY6SUZi5N5MaSrfVi4LP5vaagL5tJjXJoJh5c2yePFj62cX4fd9L6SmhPXMve8qFK3+1aLNyyM4Lp3fJRl6U4blYbsjiKvG1H5/fWNeWzFyz8G+8W4xcNUkgCDnzM7nA9eEo1y7xpvv8caF9V+5NurELb/32Ji3tjQj2hevoz9Qo2KxEkptUYsNQgLNU4YpatWT7pB0xhQK/EH6gCdMaMGl7i91Z6hlxhKOQv9ALemuo85S1aPuDLVARoOaJnbLGneoNdmJFog96u5QayZRpRnuUGf0od4CzwRLBZWTHnh3E1swjsQ08OYEPNUyjO1YsSxBepn0wP8F/Gn9CUAVPgMlCgAA")
			visland_stop_moving()
		end
		if movementtype == 0 then --default navmesh
			--WalkTo(-129.5, -1.9, -151.6)
			--WalkTo(-116, 2, -136.9)
			WalkTo(-141.7, 4.1, -106.8)
		end
    end
end

function TargetedInteract(target)
    yield("/target "..target)
	yield("/wait 0.5")
	if Entity.Target then
		yield("/interact")
	end
	yield("/wait 1")
end

function DidWeLoadcorrectly()
	yield("/echo We loaded the functions file successfully!")
end

function CharacterSafeWait()
     yield("/echo 15 second wait for char swap")
	 yield("/wait 15")
	 yield("/waitaddon NamePlate<maxwait 600>")
 	 yield("/wait 5")
	 --ZoneTransition()
end

function force_equip()
 if do_we_force_equip == 1 then
	yield("/echo Forced equipment update has begun - hopefully you have /equiprecommended enabled and /updategearset in /tweaks, aka SimpleTweaks 1PP Plugin from Caraxi")
	yield("/equipguud") --dont worry about this just some personal thing i did becuase im silly
	yield("/equiprecommended")
	yield("/character")
	if IsAddonReady("Character") then yield("/callback Character true 15") end
	yield("/wait 0.5")
	if IsAddonReady("SelectYesno") then yield("/callback SelectYesno true 0") end
	yield("/character")
	if IsAddonReady("Character") then yield("/callback Character true 15") end
	if IsAddonReady("SelectYesno") then yield("/callback SelectYesno true 0") end
	yield("/updategearset")
	yield("/wait 3")
 end
end

function EntityPlayerPositionX()
	if Entity.Player.Position then return Entity.Player.Position.X end
	return 0
end

function EntityPlayerPositionY()
	if Entity.Player.Position then return Entity.Player.Position.Y end
	return 0
end

function EntityPlayerPositionZ()
	if Entity.Player.Position then return Entity.Player.Position.Z end
	return 0
end

function visland_stop_moving()
 do_we_force_equip = force_equipstuff or 1  --default is on, unless we specify the global force_equipstuff in the calling script
 muuv = 1
 muuvstop = 0
 muuvX = EntityPlayerPositionX()
 muuvY = EntityPlayerPositionY()
 muuvZ = EntityPlayerPositionZ()
 while muuv == 1 do
	yield("/wait 1")
	muuvstop = muuvstop + 1
	if muuvX == EntityPlayerPositionX() and muuvY == EntityPlayerPositionY() and muuvZ == EntityPlayerPositionZ() then
		muuv = 0
	end
	muuvX = EntityPlayerPositionX()
	muuvY = EntityPlayerPositionY()
	muuvZ = EntityPlayerPositionZ()
	if muuvstop > 50 then
		if math.abs(muuvX - EntityPlayerPositionX()) < 2 and math.abs(muuvY - EntityPlayerPositionY()) < 2 and math.abs(muuvZ - EntityPlayerPositionZ()) < 2 then
			muuv = 0 --we need an escape clause here otherwise some situations we will never achieve success sometimes we are stuck near the target but not quite there.
		end
	end
 end
 yield("/wait 1")
 --yield("/echo movement stopped - time for GC turn ins or whatever")
 yield("/echo movement stopped safely - script proceeding to next bit")
 yield("/visland stop")
 yield("/vnavmesh stop")
 yield("/automove off")
 yield("/wait 1")
 --added becuase simpletweaks is slow to update :(
 --[[
 if do_we_force_equip == 1 then
	yield("/character")
	yield("/wait 1")
 	if IsAddonReady("Character") then yield("/callback Character true 12") end
	yield("/wait 1")
	yield("/callback RecommendEquip true 0")
	yield("/wait 1")
 end
 --]]
 force_equip()
end

function return_to_limsa_bell()
	yield("/tp Limsa Lominsa")
	ZoneTransition()
	yield("/wait 2")
	yield("/wait 1")
	if IsAddonReady("SelectYesno") then yield("/callback SelectYesno true 0") end
	PathfindAndMoveTo(-125.440284729, 18.0, 21.004405975342, false)
	visland_stop_moving() --added so we don't accidentally end before we get to the inn person
end

function return_to_inn()
	yield("/tp New Gridania")
	ZoneTransition()
	yield("/wait 2")
	PathfindAndMoveTo(48.969123840332, -1.5844612121582, 57.311756134033, false)
	visland_stop_moving() --added so we don't accidentally end before we get to the inn person
	yield("/visland exectemponce H4sIAAAAAAAACu3WS4/TMBAA4L9S+RxGfo0fuaEFpBUqLLtIXUAcDPVSS01cEgeEqv53nDSlWxAHUI65eWxnNPlkjb0nr1zlSUm+NGHt6uAWO9ek4LaLFBehrklBVu7HLoY6taT8sCc3sQ0pxJqUe3JPSmnAKsu4LMg7Uj5hgEZKxXhB3pMSNQjGNKpDDmPtr5+Rkom8duvWocv5GNCCLOM3X/k6kTIHNy5tHkK9JmVqOl+Q6zr5xn1Oq5A2r/vv6eXcWH0us93E76eVXF/O/uC27aMUQ9GsIM+rmPwpVfLVOHw67BiDN51v0+Pxnf86BMv4aZy+S3F3Fev1qJFnXobt9ip245/cxi75y/JWLqRzXX30IjaXOfrJt6Hyy7yPHoo/vFGBEGj1kZuCNohIe/7srQwgo8hm7qm4FQObDzQ/cUtpKcU+ztwawQqrZ+3JtCVIjsIctTkwTRH1YG0E5GNOJc7ak2nz3D14Bj9yK1BaS4sDt0VApZWdtSdr3AwYNxbHVmKASmWVPnIzKkFwTs3fvMV8Uf6jt8TcrM3wEjl7SzNyCxDa6rmZTHa8uQWRH4LmzP3rYDPUcr4kp5PWoASXVv0uzYAzIebH339Kfzz8BLifXG8MDQAA")
	visland_stop_moving() --added so we don't accidentally end before we get to the inn person
	yield("/target Antoinaut")
	yield("/wait 0.5")
	if Entity.Target then
		yield("/interact")
	end
end

function return_to_fc()
	--yield("/tp Estate Hall") --old way
	--yield("/tp Estate Hall (Free Company)") --new way notice the brackets
	yield("/li fc") --this also respects house regisrtations in lifestream
	yield("/wait 1")
	--yield("/waitaddon Nowloading<maxwait 600>")
	ZoneTransition()
--	yield("/wait 15")
	yield("/waitaddon NamePlate<maxwait 600>")
	yield("/wait 5")
end

function return_to_lair()
	--yield("/tp Estate Hall")
	yield("/tp Estate Hall (Private)")
	yield("/wait 1")
	--yield("/waitaddon Nowloading<maxwait 600>")
--	yield("/wait 15")
	ZoneTransition()
	yield("/waitaddon NamePlate<maxwait 600>")
	yield("/wait 5")
	return_fc_entrance() --does the same thing just enters target
	open_house_door() --opens the door to house
	--wait a bit then go back to fc house
end

function double_check_nav(x3, y3, z3)
	x1 = EntityPlayerPositionX()
	y1 = EntityPlayerPositionY()
	z1 = EntityPlayerPositionZ()
	yield("/wait 2")
	if (x1 - EntityPlayerPositionX()) == 0 and (y1 - EntityPlayerPositionY()) == 0 and (z1 - EntityPlayerPositionZ()) == 0 then
		--yield("/vnav rebuild")
		NavRebuild()
		while not NavIsReady() do
			yield("/echo waiting on navmesh to finish rebuilding the mesh")
			yield("/wait 1")
		end
		yield("/vnav moveto " .. x3 .. " " .. y3 .. " " .. z3)
	end
end

function NavRebuild()
	IPC.vnavmesh.Rebuild()
end

function NavIsReady()
	return IPC.vnavmesh.IsReady()
end

function double_check_navGO(x3, y3, z3)
	x1 = EntityPlayerPositionX()
	y1 = EntityPlayerPositionY()
	z1 = EntityPlayerPositionZ()
	yield("/wait 2")
	if (x1 - EntityPlayerPositionX()) == 0 and (y1 - EntityPlayerPositionY()) == 0 and (z1 - EntityPlayerPositionZ()) == 0 then
		--yield("/vnav rebuild")
		yield("/vnav moveto " .. x3 .. " " .. y3 .. " " .. z3)
	end
end


function return_fc_entrance()
	--saw a weirdness where vnav never finished.. no errors and error traps. need more analysis. wasn't life stream the char isnt registered in it
	yield("/echo attempting to enter nearby entrance to house")
	yield("/hold W")
	yield("/wait 1")
	yield("/release W")
	yield("/target Entrance")
	yield("/wait 1")
	yield("/echo vnavving over")
	if Entity.Target then
		yield("/vnav moveto "..Entity.Target.Position.X.." "..Entity.Target.Position.Y.." "..Entity.Target.Position.Z)
	end
	yield("/gaction jump")
	yield("/target Entrance")
	yield("/wait 1")
	yield("/echo vnavving over!")
	if Entity.Target then
		yield("/vnav moveto "..Entity.Target.Position.X.." "..Entity.Target.Position.Y.." "..Entity.Target.Position.Z)
	end
	yield("/wait 1")
	yield("/gaction jump")
	yield("/echo double check")
	if Entity.Target then
		double_check_nav(Entity.Target.Position.X,Entity.Target.Position.Y,Entity.Target.Position.Z)
		visland_stop_moving()
	end
	yield("/target Entrance")
	yield("/wait 1")
end

function open_house_door()
	yield("/target Entrance")
	yield("/wait 1")
	if Entity.Target then
		yield("/interact")
	end
	yield("/wait 1")
	if IsAddonReady("SelectYesno") then yield("/callback SelectYesno true 0") end
	if Entity.Target then
		yield("/interact")
	end
	yield("/wait 1")
	if IsAddonReady("SelectYesno") then yield("/callback SelectYesno true 0") end
end

function return_fc_near_bell()
	yield("/target \"Summoning Bell\"")
	yield("/wait 2")
	--PathfindAndMoveTo(GetObjectRawXPos("Summoning Bell"), GetObjectRawYPos("Summoning Bell"), GetObjectRawZPos("Summoning Bell"), false)
	if Entity.Target then
		WalkTo(GetObjectRawXPos("Summoning Bell"), GetObjectRawYPos("Summoning Bell"), GetObjectRawZPos("Summoning Bell"))
		visland_stop_moving() --added so we don't accidentally end before we get to the bell
	end
end

function are_we_dol()
	is_it_dol = false
	yield("/echo Our job is "..tostring(GetClassJobId()))
	if type(GetClassJobId()) == "number" and GetClassJobId() > 7 and GetClassJobId() < 19 then
		is_it_dol = true
		yield("/echo We are a Disciple of the (H/L)and")
	end
	return is_it_dol
end

function which_cj()
	highest_cj = 0
	highest_cj_level = 0
	yield("/echo Time to figure out which job ID to switch to !")
	for i=0,7 do
		if tonumber(GetLevel(i)) ~= nil then
			if tonumber(GetLevel(i)) > highest_cj_level then
				highest_cj_level = GetLevel(i)
				highest_cj = i
				yield("/echo Oh my maybe job->"..i.." lv->"..tostring(highest_cj_level).." is the highest one?")
			end
		end
	end
	for i=19,29 do
		if tonumber(GetLevel(i)) ~= nil then
			if tonumber(GetLevel(i)) > highest_cj_level then
				highest_cj_level = GetLevel(i)
				highest_cj = i
				yield("/echo Oh my maybe job->"..i.." lv->"..tostring(highest_cj_level).." is the highest one?")
			end
		end
	end
	return tonumber(highest_cj)
end

function job_short(which_cj)
	yield("/echo Time to figure out which job shortname to switch to !")
	if which_cj == -1 then shortjob = "adv" end
	if which_cj == 1 then shortjob = "gld" 
		if GetItemCount(4542) > 0 then
			shortjob = "pld"
		end
	end
	if which_cj == 0 then shortjob = "pgl" 
		if GetItemCount(4543) > 0 then
			shortjob = "mnk"
		end
	end
	if which_cj == 2 then shortjob = "mrd" 
		if GetItemCount(4544) > 0 then
			shortjob = "war"
		end
	end
	if which_cj == 4 then shortjob = "lnc" 
		if GetItemCount(4545) > 0 then
			shortjob = "drg"
		end
	end
	if which_cj == 3 then shortjob = "arc" 
		if GetItemCount(4546) > 0 then
			shortjob = "brd"
		end
	end
	if which_cj == 6 then shortjob = "cnj" 
		if GetItemCount(4547) > 0 then
			shortjob = "whm"
		end
	end
	if which_cj == 5 then shortjob = "thm" 
		if GetItemCount(4548) > 0 then
			shortjob = "blm"
		end
	end
	if which_cj == 19 then shortjob = "rog" 
		if GetItemCount(7886) > 0 then
			shortjob = "nin"
		end
	end
	if which_cj == 20 then shortjob = "mch" end
	if which_cj == 21 then shortjob = "drk" end
	if which_cj == 22 then shortjob = "ast" end
	if which_cj == 23 then shortjob = "sam" end
	if which_cj == 24 then shortjob = "rdm" end
	if which_cj == 25 then shortjob = "blu" end
	if which_cj == 26 then shortjob = "gnb" end
	if which_cj == 27 then shortjob = "dnc" end
	if which_cj == 28 then shortjob = "rpr" end
	if which_cj == 29 then shortjob = "sge" end
	return shortjob
end

function enter_workshop()
	--[[ for later
	yield("/freecompanycmd")
	yield("/wait 1")
	fcPoints = string.gsub(GetNodeText("FreeCompany", 15),"",""):gsub(",", "")
	--]]

	--workshop ids gob 424, shiro 653, mist 423, emp 984, lav 425
	attempts = 0 --we will do a max of 5 attempts - and if we are still not inside, we will end SND entirely so it doesnt get caught in buy loop after.
    zoneczec = Svc.ClientState.TerritoryType
	
	while zoneczec ~= 424 and zoneczec ~= 425 and zoneczec ~= 423 and zoneczec ~= 653 and zoneczec ~= 984 and attempts < 5 do
		--attempt to enter house
		yield("/wait 0.5")
		yield("/target Entrance")
		yield("/wait 0.5")
		yield("/interact")
		yield("/wait 5")
		--attemmpt to enter workshop
		yield("/target \"Entrance to Additional Chambers\"")
		--check to make sure we actually targeted the door to additional rooms.
		if GetTargetName() == "Entrance to Additional Chambers" then
			yield("/wait 0.5")
			yield("/lockon")
			yield("/automove")
			visland_stop_moving()
			yield("/interact")
			yield("/wait 1")
			yield("/callback SelectString true 0")
			yield("/wait 5")
		end
		attempts = attempts + 1
		zoneczec = Svc.ClientState.TerritoryType
	end	
end

function clean_inventory()
	--* automarket is gone with api 12 - sorry friendskis
--[[--RIP Automarket
	
	--oh yeah you'll need this. and asking about it on punish will result in right click -> block.
	--https://raw.githubusercontent.com/ffxivcode/DalamudPlugins/main/repo.json
	--*start cleaning??? need slash command
	--*loop every 5 seconds and check if we have the right char condition to resume whatever we were doing.
	--/automarket start|stop
	zungazunga()
	yield("/target Summoning Bell")
	yield("/wait 1")
	yield("/lockon on")
	yield("/automove on") --sometimes it takes a while to path over 3.5 seconds worked in testing and even 1.5 and 2.5 seconds worked but we gonna do 5 seconds to cover all issues
	yield("/wait 5")
	yield("/interact")
	yield("/automarket start")
	yield("/wait 5")
	yield("/target Summoning Bell")
	yield("/wait 1")
	yield("/interact")
--	yield("/automarket start")
	exit_cleaning = 0
	while Svc.Condition[50] == false and exit_cleaning < 20 do
		yield("/wait 1")
		exit_cleaning = exit_cleaning + 1
		yield("/echo Waiting for repricer to start -> "..exit_cleaning.."/20")
	end
	exit_cleaning_RS = 0
	exit_cleaning_RL = 0
	exit_cleaning_ISR = 0
	--forced_am = 0
	--bungaboard = SetClipboard("123123123")
	while Svc.Condition[50] == true and exit_cleaning_RS < 10 and exit_cleaning_RL < 10 and exit_cleaning_ISR < 10 do
		yield("/wait 2")
--		exit_cleaning = exit_cleaning + 1
		flandom = getRandomNumber(1,20)
		--yield("/echo Waiting for repricer to end -> "..exit_cleaning.." seconds duration so far flandom -> "..flandom)
		yield("/echo Repricer Addon Fallback - RetainerSell -> "..exit_cleaning_RS.."/10 - RetainerList -> "..exit_cleaning_RL.."/10 - ItemSearchResult -> "..exit_cleaning_ISR.."/10")
		if IsAddonVisible("RetainerSell") then
			exit_cleaning_RS = exit_cleaning_RS + 1
		end
		if not IsAddonVisible("RetainerSell") or IsAddonVisible("IemSearchResult") then
			exit_cleaning_RS = 0
		end
		if IsAddonVisible("IemSearchResult") then
			exit_cleaning_ISR = exit_cleaning_RL + 1
		end
		if not IsAddonVisible("IemSearchResult") then
			exit_cleaning_ISR = 0
		end
		if IsAddonVisible("RetainerList") then
			exit_cleaning_RL = exit_cleaning_RL + 1
		end
		if not IsAddonVisible("RetainerList") then
			exit_cleaning_RL = 0
		end
	end

	yield("/automarket stop")
	yield("/wait 1")

	CharacterSafeWait()
	zungazunga()

	if exit_cleaning > 9 then
		ungabungabunga()
	end
	
--]]--RIP AUTOMARKET
end

function getRandomNumber(min, max)
  return math.random(min,max)
end

function round(n)
  return math.floor(n + 0.5)
end

function try_to_buy_fuel(restock_amt)
    zoneczec = Svc.ClientState.TerritoryType
	--only try to actually buy fuel if we are in the workshop
	if zoneczec == 424 or zoneczec == 425 or zoneczec == 423 or zoneczec == 653 or zoneczec == 984 then
		--target mammet
		yield("/wait 5")
		yield("/target mammet")
		yield("/wait 0.5")
		yield("/lockon")
		yield("/automove")
		visland_stop_moving()
		--open mammet menu
		yield("/automove off")
		yield("/interact")
		yield("/wait 2")
		yield("/callback SelectIconString true 0")
		yield("/wait 2")
		--buy exactly restock_amt final value for fuel
		--grab current fuel total
		curFuel = GetItemCount(10155)
		oldFuel = curFuel + 1
		buyfail = 0 --counter

		--get and set FC points
		yield("/freecompanycmd")
		yield("/wait 1")
		fcpoynts = Addons.GetAddon("FreeCompany"):GetNode(1, 4, 16, 17)
		clean_fcpoynts = fcpoynts.Text:gsub(",", "")
		numeric_fcpoynts = tonumber(clean_fcpoynts)

		restock_amt = restock_amt - curFuel
		if numeric_fcpoynts < 100 then
			yield("/echo We don't have enough FC points to even buy 1 tank of Fuel")
			loggabunga("FUTA_"," - Not enough FC points to buy fuel -> "..FUTA_processors[hoo_arr_weeeeee][1][1])
		end
		while numeric_fcpoynts > 100 and GetItemCount(10155) < restock_amt do --can we buy at least 1 fuel tank?
				buyamt = 99
				if numeric_fcpoynts < 9900 then
					buyamt = round(numeric_fcpoynts / 100)
				end
				numeric_fcpoynts = numeric_fcpoynts - (buyamt * 100)
				yield("/echo Attempting to buy "..buyamt.." Fuel Tanks")
				yield("/callback FreeCompanyCreditShop false 0 0u "..buyamt.."u") 
				yield("/wait 1")
	--[[ --this is obselete now we have the FC point amount
			while curFuel < restock_amt do
				buyamt = 99 --this can be set to 231u if you want but i wouldn't recommend it as it shows on lodestone
				if (restock_amt - curFuel) < 99 then
					buyamt = restock_amt - curFuel
				end
				yield("/callback FreeCompanyCreditShop false 0 0u "..buyamt.."u") 
				yield("/wait 0.5")
				if IsAddonReady("SelectYesno") then yield("/callback SelectYesno true 0") end
				yield("/wait 1")
				--if IsAddonReady("SelectYesno") then yield("/callback SelectYesno true 0") end
				oldFuel = curFuel
				curFuel = GetItemCount(10155)
				yield("/echo Current Fuel -> "..curFuel.." Old Fuel -> "..oldFuel)
				if oldFuel < curFuel then
					buyfail = 0
				end
				if oldFuel == curFuel then
					buyfail = buyfail + 1
					yield("/echo We might be out of FC points ?")
					if buyfail > 3 then
						curFuel = restock_amt
						yield("/echo we ran out of FC points before finishing our purchases :(")
					end
				end
			end
	--]]
			yield("/echo We now have "..GetItemCount(10155).." Ceruelum Fuel Tanks")
		end
		ungabunga()
	end
end


function serializeTable(t, indent)
    indent = indent or ""
    local result = "{\n"
    local innerIndent = indent .. "  "

    for k, v in pairs(t) do
        result = result .. innerIndent
        if type(k) == "number" then
            result = result .. "[" .. k .. "] = "
        else
            result = result .. "[" .. tostring(k) .. "] = "
        end

        if type(v) == "table" then
            result = result .. serializeTable(v, innerIndent)
        elseif type(v) == "string" then
            result = result .. "\"" .. v .. "\""
        else
            result = result .. tostring(v)
        end

        result = result .. ",\n"
    end

    result = result .. indent:sub(1, -3) .. "}" -- Remove last comma and add closing brace
    return result
end


-- Function to deserialize a table
function deserializeTable(str)
    local func = load("return " .. str)
    return func()
end

function readSerializedData(filePath)
    local file, err = io.open(filePath, "r")
    if not file then
        yield("/echo Error opening file for reading: " .. err)
        return nil
    end
    local data = file:read("*all")
    file:close()
    return data
end

-- Function to print table contents
function printTable(t, indent)
    indent = indent or ""
    if type(t) ~= "table" then
        yield("/echo " .. indent .. tostring(t))
        return
    end
    
    for k, v in pairs(t) do
        local key = tostring(k)
        if type(v) == "table" then
            yield("/echo " .. indent .. key .. " =>")
            printTable(v, indent .. "  ") -- Recursive call with increased indent
        else
            yield("/echo " .. indent .. key .. " => " .. tostring(v))
        end
    end
end

function tablebunga(filename, tablename, path)
    local fullPath = path .. filename
    yield("/echo Debug: Full file path = " .. fullPath)
    
    local file, err = io.open(fullPath, "w")
    if not file then
        yield("/echo Error opening file for writing: " .. err)
        return
    end

    local tableToSerialize = _G[tablename]
    --yield("/echo Debug: Table to serialize = " .. tostring(tableToSerialize))

    if type(tableToSerialize) == "table" then
        local serializedData = serializeTable(tableToSerialize)
        --yield("/echo Debug: Serialized data:\n" .. serializedData)
        file:write(serializedData)
        file:close()
        yield("/echo Successfully wrote table to " .. fullPath)
    else
        yield("/echo Error: Table '" .. tablename .. "' not found or is not a table.")
    end
end

function FUTA_return()
		--limsa aetheryte
	if FUTA_processors[hoo_arr_weeeeee][1][2] == 4 then
		return_to_limsa_bell()
		yield("/wait 8")
	end
	
	--if we are tp to inn. we will go to gridania yo
	if FUTA_processors[hoo_arr_weeeeee][1][2] == 3 then
		return_to_inn()
		yield("/wait 8")
	end
	
	--options 1 and 2 and 7 are fc estate entrance or fc state bell so thats only time we will tp to fc estate
	if FUTA_processors[hoo_arr_weeeeee][1][2] == 0 or FUTA_processors[hoo_arr_weeeeee][1][2] == 1 or FUTA_processors[hoo_arr_weeeeee][1][2] == 7 then
		return_to_fc()
	end
	
	--option 5 or 6 personal home and bell near personal home
	if FUTA_processors[hoo_arr_weeeeee][1][2] == 5 or FUTA_processors[hoo_arr_weeeeee][1][2] == 6 then
		return_to_lair()
	end

	--normal small house shenanigans
	if FUTA_processors[hoo_arr_weeeeee][1][2] == 0 or FUTA_processors[hoo_arr_weeeeee][1][2] == 5 then
		return_fc_entrance()	
	end

	--retainer bell nearby shenanigans
	if FUTA_processors[hoo_arr_weeeeee][1][2] == 1 or FUTA_processors[hoo_arr_weeeeee][1][2] == 6 then
		return_fc_near_bell()
	end	
end

function loggabunga(filename, texty)
	local file = io.open(folderPath .. filename .. "_log.txt", "a")
	if file then
		currentTime = os.date("*t")
		formattedTime = string.format("%04d-%02d-%02d %02d:%02d:%02d", currentTime.year, currentTime.month, currentTime.day, currentTime.hour, currentTime.min, currentTime.sec)
		file:write(formattedTime..texty.."\n")
		file:close()
	end
end

function GetAddersGCRank()
	return Player.GCRankTwinAdders
end

function GetFlamesGCRank()
	return Player.GCRankImmortalFlames
end

function GetMaelstromGCRank()
	return Player.GCRankMaelstrom
end

function SetFlamesGCRank(hehe)
	GCRankImmortalFlames = hehe
end

function SetAddersGCRank(hehe)
	Player.GCRankTwinAdders = hehe
end

function SetMaelstromGCRank(hehe)
	GCRankMaelstrom = hehe
end

function check_GC_RANKS(renkk)
	if GetAddersGCRank() < renkk and GetFlamesGCRank() < renkk and GetMaelstromGCRank() < renkk then
		loggabunga("FUTA_",logfile_differentiator.." - GC ranks below rank "..renkk.." main GC -> Adders - "..GetAddersGCRank().." - Maelstrom - "..GetMaelstromGCRank().." - Flames - "..GetFlamesGCRank().." - Charname -> "..FUTA_processors[hoo_arr_weeeeee][1][1])
	end
end

function check_ro_helm()
	--check for red onion helms and report in to a log file if there is one
	if GetItemCount(2820) > 0 then
		yield("/echo RED ONION HELM DETECTED")
		if FUTA_processors[hoo_arr_weeeeee][3][2] > 0 then
			FUTA_processors[hoo_arr_weeeeee][3][2] = 100 --force a cleaning next round as this will choke up the cleaning agent
		end
		loggabunga("FUTA_"," - Red Onion Helm detected on -> "..FUTA_processors[hoo_arr_weeeeee][1][1])
	end
end

function _distance(x1, y1, z1, x2, y2, z2) --not wanting overlap with script distance()
	if type(x1) ~= "number" then x1 = 0 end
	if type(y1) ~= "number" then y1 = 0 end
	if type(z1) ~= "number" then z1 = 0 end
	if type(x2) ~= "number" then x2 = 0 end
	if type(y2) ~= "number" then y2	= 0 end
	if type(z2) ~= "number" then z2 = 0 end
	zoobz = math.sqrt((x2 - x1)^2 + (y2 - y1)^2 + (z2 - z1)^2)
	if type(zoobz) ~= "number" then
		zoobz = 0
	end
    --return math.sqrt((x2 - x1)^2 + (y2 - y1)^2 + (z2 - z1)^2)
    return zoobz
end

function delete_my_items_please(how)
	if how == 0 then
		yield("/echo not deleting or desynthing items")
		--* here we can check for distance to a retainer bell and go to it if its within 10 yalms
		--*let's only do this while we AREN'T on a boat and after considering the problems with it. for now we gonna comment it out as its an annoying problem
		--[[
		yield("/target bell")
		yield("/wait 1")
		nemm = "Summoning Bell"
		poostance = _distance(EntityPlayerPositionX(), EntityPlayerPositionY(), EntityPlayerPositionZ(), GetObjectRawXPos(nemm),GetObjectRawYPos(nemm),GetObjectRawZPos(nemm))
		if poostance < 11 then
			yield("/vnav moveto "..GetObjectRawXPos(nemm).." "..GetObjectRawYPos(nemm).." "..GetObjectRawZPos(nemm))
			yield("/wait 4")
		end
		yield("/ays itemsell") --npc AND retainer selling --* this actually doesn't work yet. we'd need to stop AR entirely and then re enable it.  this is doable but can be a problem as it will run post ar process again
			--figured it out - if we have salvage to sell, then we have a reason to reset AR
		--]]
	end 
	if how == 1 then
		yield("/echo Attempting to delete items")
		yield("/discardall")
	end
	if how == 2 then
		yield("/echo Attempting to desynth items")
		yield("/echo i dont know how to do this yet--*")
	end
end

function grab_aetheryte()
	yield("/target Aetheryte")
	yield("/wait 2")
	yield("/interact")
	yield("/wait 2")
	yield("/interact")
	yield("/wait 10")
end

function GetItemCount(itemId)
	asdf = Inventory.GetHqItemCount(itemId) + Inventory.GetItemCount(itemId)
	return asdf
end

function GetGil()
	return Inventory.GetItemCount(1)
end
function GetObjectRawXPos(name)
	--yield("/echo debug getorxpos")
	if Entity.GetEntityByName(name) == nil then return 0 end
	return Entity.GetEntityByName(name).Position.X
end

function GetObjectRawYPos(name)
	if Entity.GetEntityByName(name) == nil then return 0 end
	return Entity.GetEntityByName(name).Position.Y
end

function GetObjectRawZPos(name)
	if Entity.GetEntityByName(name) == nil then return 0 end
	return Entity.GetEntityByName(name).Position.Z
end

function GetLevel(pjob)
	pjob = pjob or 9000 --9000 is just so we know they didn't pass something over. there is probably better way but i dont think very hard about these things
	if pjob < 9000 then
		return Player.GetJob(pjob + 1).Level
	end
	if pjob == 9000 then
		return Player.Job.Level
	end
end

function GetClassJobId()
	return Svc.ClientState.LocalPlayer.ClassJob.RowId
end

function GetStatusTimeRemaining(statusID)
    local player = Svc.ClientState.LocalPlayer
    if not player then
    --    yield("/echo Player is nil")
        return 0
    end

    local statuses = player.StatusList
    if not statuses then
   --     yield("/echo StatusList is nil")
        return 0
    end

    --for i = 0, 29 do -- max 30 statuses
    for i = 0, statuses.Length - 1 do
        local status = statuses[i]
        if status and status.StatusId == statusID then
			if status.StatusId == 895 then
				--yield("/echo we invuln")
				return 1
			end
            return status.RemainingTime or 0
        end
    end
    return 0
end

function GetFullStatusList()
	local player = Svc.ClientState.LocalPlayer
	if not player then
		yield("/echo Player is nil")
		return
	end

	local statuses = player.StatusList
	if not statuses then
		yield("/echo StatusList is nil")
		return
	end

	--for i = 0, 29 do
	for i = 0, statuses.Length - 1 do
		local status = statuses[i]
		if status and status.StatusId ~= 0 then
			yield(string.format("/echo [%d] ID: %d  Time: %.2f", i, status.StatusId, status.RemainingTime or 0))
		end
	end
end

--[[fake and non working
function GetPartyStatusTimeRemaining(pID, statusID)
	local pm = Svc.GroupManager:GetPartyMember(0)
	if pm and pm.StatusManager then
		local sm = pm.StatusManager
		for i = 0, sm.StatusCount - 1 do
			local s = sm:GetStatus(i)
			if s and s.StatusId ~= 0 then
				yield(string.format("/echo Buff %d = ID:%d Time:%.2f", i, s.StatusId, s.RemainingTime or 0))
			end
		end
	end
end

function GetFullPartyStatusList()
	for i = 0, Svc.GroupManager.MemberCount - 1 do
		local member = Svc.GroupManager:GetPartyMember(i)
		if member then
			local sm = member.StatusManager
			if sm then
				for j = 0, sm.StatusCount - 1 do
					local s = sm:GetStatus(j)
					if s and s.StatusId ~= 0 then
						yield(string.format(
							"/echo Member[%d] Status[%d]: ID=%d Time=%.2f Stack=%d",
							i, j, s.StatusId, s.RemainingTime or 0, s.StackCount or 0
						))
					end
				end
			end
		end
	end
end
--]]

function IsAddonReady(name)
	return Addons.GetAddon(name).Ready
end

function IsAddonVisible(name)
	return Addons.GetAddon(name).Exists
end

function IsPlayerAvailable()
    return Player.Available
end

function RestoreYesAlready()
	IPC.YesAlready.SetPluginEnabled(true)
end

function PauseYesAlready()
	IPC.YesAlready.SetPluginEnabled(false)
end

homeworld_lookup = {
	[0] = "crossworld",
	[1] = "reserved1",
	[2] = "c-contents",
	[3] = "c-whiteae",
	[4] = "c-baudinii",
	[5] = "c-contents2",
	[6] = "c-funereus",
	[16] = "",
	[21] = "Ravana",
	[22] = "Bismarck",
	[23] = "Asura",
	[24] = "Belias",
	[25] = "Chaos",
	[26] = "Hecatoncheir",
	[27] = "Moomba",
	[28] = "Pandaemonium",
	[29] = "Shinryu",
	[30] = "Unicorn",
	[31] = "Yojimbo",
	[32] = "Zeromus",
	[33] = "Twintania",
	[34] = "Brynhildr",
	[35] = "Famfrit",
	[36] = "Lich",
	[37] = "Mateus",
	[38] = "Shemhazai",
	[39] = "Omega",
	[40] = "Jenova",
	[41] = "Zalera",
	[42] = "Zodiark",
	[43] = "Alexander",
	[44] = "Anima",
	[45] = "Carbuncle",
	[46] = "Fenrir",
	[47] = "Hades",
	[48] = "Ixion",
	[49] = "Kujata",
	[50] = "Typhon",
	[51] = "Ultima",
	[52] = "Valefor",
	[53] = "Exodus",
	[54] = "Faerie",
	[55] = "Lamia",
	[56] = "Phoenix",
	[57] = "Siren",
	[58] = "Garuda",
	[59] = "Ifrit",
	[60] = "Ramuh",
	[61] = "Titan",
	[62] = "Diabolos",
	[63] = "Gilgamesh",
	[64] = "Leviathan",
	[65] = "Midgardsormr",
	[66] = "Odin",
	[67] = "Shiva",
	[68] = "Atomos",
	[69] = "Bahamut",
	[70] = "Chocobo",
	[71] = "Moogle",
	[72] = "Tonberry",
	[73] = "Adamantoise",
	[74] = "Coeurl",
	[75] = "Malboro",
	[76] = "Tiamat",
	[77] = "Ultros",
	[78] = "Behemoth",
	[79] = "Cactuar",
	[80] = "Cerberus",
	[81] = "Goblin",
	[82] = "Mandragora",
	[83] = "Louisoix",
	[84] = "",
	[85] = "Spriggan",
	[86] = "Sephirot",
	[87] = "Sophia",
	[88] = "Zurvan",
	[90] = "Aegis",
	[91] = "Balmung",
	[92] = "Durandal",
	[93] = "Excalibur",
	[94] = "Gungnir",
	[95] = "Hyperion",
	[96] = "Masamune",
	[97] = "Ragnarok",
	[98] = "Ridill",
	[99] = "Sargatanas",
	[100] = "",
	[101] = "",
	[102] = "",
	[103] = "",
	[104] = "",
	[105] = "",
	[106] = "",
	[107] = "",
	[108] = "",
	[109] = "",
	[110] = "b-tirica",
	[111] = "b-contents",
	[112] = "b-chiriri",
	[113] = "b-contents2",
	[114] = "b-jugularis",
	[115] = "e-regia",
	[116] = "e-pialii",
	[117] = "e-contents",
	[118] = "e-contents2",
	[119] = "e-coloria",
	[120] = "e-gouldiae",
	[121] = "e-contents3",
	[122] = "e-contents4",
	[123] = "e-trichroa",
	[124] = "e-hyperion",
	[126] = "e-ragnarok",
	[127] = "e-ridill",
	[128] = "e-sargatanas",
	[129] = "",
	[130] = "",
	[131] = "",
	[132] = "",
	[133] = "",
	[134] = "",
	[135] = "",
	[136] = "",
	[137] = "",
	[138] = "",
	[139] = "",
	[140] = "",
	[141] = "b-contents3",
	[142] = "b-cyanoptera",
	[144] = "",
	[145] = "",
	[153] = "z-cinereus",
	[154] = "z-vanellus",
	[155] = "z-contents3",
	[156] = "z-japonicus",
	[157] = "z-dauma",
	[158] = "z-contents",
	[159] = "z-contents2",
	[160] = "",
	[161] = "",
	[162] = "",
	[163] = "",
	[164] = "",
	[165] = "",
	[166] = "",
	[167] = "",
	[168] = "",
	[169] = "",
	[170] = "",
	[171] = "",
	[172] = "",
	[173] = "",
	[174] = "",
	[175] = "",
	[176] = "",
	[177] = "",
	[178] = "",
	[179] = "",
	[180] = "",
	[181] = "",
	[182] = "",
	[183] = "",
	[184] = "",
	[185] = "",
	[186] = "",
	[187] = "",
	[188] = "",
	[189] = "",
	[190] = "",
	[191] = "",
	[201] = "Nacontents01",
	[202] = "Nacontents02",
	[203] = "Nacontents03",
	[204] = "Nacontents04",
	[205] = "Nacontents05",
	[206] = "Nacontents06",
	[207] = "Nacontents07",
	[208] = "Nacontents08",
	[209] = "Nacontents09",
	[210] = "Nacontents10",
	[211] = "Nacontents11",
	[212] = "Nacontents12",
	[213] = "Nacontents13",
	[214] = "Nacontents14",
	[215] = "Nacontents15",
	[216] = "Nacontents16",
	[217] = "Nacontents17",
	[218] = "Nacontents18",
	[219] = "Nacontents19",
	[220] = "Nacontents20",
	[221] = "Nacontents21",
	[222] = "Nacontents22",
	[223] = "Nacontents23",
	[224] = "Nacontents24",
	[225] = "Jpcontents01",
	[226] = "Jpcontents02",
	[227] = "Jpcontents03",
	[228] = "Jpcontents04",
	[229] = "Jpcontents05",
	[230] = "Jpcontents06",
	[231] = "Jpcontents07",
	[232] = "Jpcontents08",
	[233] = "Jpcontents09",
	[234] = "Jpcontents10",
	[235] = "Jpcontents11",
	[236] = "Jpcontents12",
	[237] = "Jpcontents13",
	[238] = "Jpcontents14",
	[239] = "Jpcontents15",
	[240] = "Jpcontents16",
	[241] = "Jpcontents17",
	[242] = "Jpcontents18",
	[243] = "Jpcontents19",
	[244] = "Jpcontents20",
	[245] = "Jpcontents21",
	[246] = "Jpcontents22",
	[247] = "Jpcontents23",
	[248] = "Jpcontents24",
	[249] = "Jpcontents25",
	[250] = "Jpcontents26",
	[251] = "Jpcontents27",
	[252] = "Jpcontents28",
	[253] = "Jpcontents29",
	[254] = "Jpcontents30",
	[255] = "Nacontents25",
	[256] = "Nacontents26",
	[257] = "Nacontents27",
	[258] = "Nacontents28",
	[259] = "Nacontents29",
	[260] = "Nacontents30",
	[261] = "Nacontents31",
	[262] = "Nacontents32",
	[263] = "Nacontents33",
	[264] = "Nacontents34",
	[265] = "Jpcontents31",
	[266] = "Jpcontents32",
	[267] = "Jpcontents33",
	[268] = "Jpcontents34",
	[269] = "Jpcontents35",
	[270] = "Jpcontents36",
	[271] = "Nacontents36",
	[272] = "Nacontents37",
	[273] = "Nacontents38",
	[274] = "Nacontents39",
	[275] = "Nacontents40",
	[276] = "Nacontents41",
	[277] = "Nacontents42",
	[278] = "Nacontents43",
	[279] = "Nacontents44",
	[280] = "Nacontents45",
	[300] = "Occontents01",
	[301] = "Occontents02",
	[302] = "Occontents03",
	[303] = "Occontents04",
	[304] = "Occontents05",
	[305] = "",
	[306] = "",
	[307] = "",
	[308] = "",
	[309] = "",
	[310] = "",
	[311] = "Eucontents01",
	[312] = "Eucontents02",
	[313] = "Eucontents03",
	[314] = "Eucontents04",
	[315] = "Eucontents05",
	[316] = "Eucontents06",
	[317] = "Eucontents07",
	[318] = "Eucontents08",
	[319] = "",
	[320] = "",
	[321] = "Eucontents11",
	[322] = "Eucontents12",
	[323] = "Eucontents13",
	[324] = "Eucontents14",
	[325] = "Eucontents15",
	[326] = "Eucontents16",
	[327] = "Eucontents17",
	[328] = "Eucontents18",
	[329] = "",
	[330] = "",
	[331] = "Eucontents21",
	[332] = "Eucontents22",
	[333] = "Eucontents23",
	[334] = "Eucontents24",
	[335] = "Eucontents25",
	[336] = "Eucontents26",
	[337] = "Eucontents27",
	[338] = "Eucontents28",
	[339] = "",
	[340] = "",
	[341] = "",
	[342] = "",
	[343] = "",
	[344] = "",
	[345] = "",
	[346] = "",
	[347] = "",
	[348] = "",
	[349] = "",
	[350] = "",
	[351] = "",
	[352] = "",
	[353] = "",
	[354] = "",
	[355] = "",
	[356] = "",
	[357] = "",
	[358] = "",
	[359] = "",
	[360] = "",
	[361] = "",
	[362] = "",
	[363] = "",
	[364] = "",
	[365] = "",
	[366] = "",
	[367] = "",
	[368] = "",
	[369] = "",
	[370] = "",
	[371] = "",
	[372] = "",
	[373] = "",
	[374] = "",
	[375] = "",
	[376] = "",
	[377] = "",
	[378] = "",
	[379] = "",
	[380] = "",
	[381] = "",
	[382] = "",
	[383] = "",
	[384] = "",
	[385] = "",
	[386] = "",
	[387] = "",
	[388] = "",
	[389] = "",
	[390] = "",
	[391] = "",
	[392] = "",
	[393] = "",
	[394] = "",
	[395] = "",
	[396] = "",
	[397] = "",
	[398] = "",
	[399] = "",
	[400] = "Sagittarius",
	[401] = "Phantom",
	[402] = "Alpha",
	[403] = "Raiden",
	[404] = "Marilith",
	[405] = "Seraph",
	[406] = "Halicarnassus",
	[407] = "Maduin",
	[408] = "Cuchulainn",
	[409] = "Kraken",
	[410] = "Rafflesia",
	[411] = "Golem",
	[412] = "Titania",
	[413] = "Innocence",
	[414] = "Pixie",
	[415] = "Tycoon",
	[416] = "Wyvern",
	[417] = "Lakshmi",
	[418] = "Eden",
	[419] = "Syldra",
	[420] = "",
	[421] = "",
	[422] = "",
	[423] = "",
	[424] = "",
	[425] = "",
	[426] = "",
	[427] = "",
	[428] = "",
	[429] = "",
	[430] = "",
	[431] = "",
	[432] = "",
	[433] = "",
	[434] = "",
	[435] = "",
	[436] = "",
	[437] = "",
	[438] = "",
	[439] = "",
	[440] = "",
	[441] = "",
	[442] = "",
	[443] = "",
	[444] = "",
	[445] = "",
	[446] = "",
	[447] = "",
	[448] = "",
	[449] = "",
	[450] = "",
	[451] = "",
	[452] = "",
	[453] = "",
	[454] = "",
	[455] = "",
	[456] = "",
	[457] = "",
	[458] = "",
	[459] = "",
	[460] = "",
	[461] = "",
	[462] = "",
	[463] = "",
	[464] = "",
	[465] = "",
	[466] = "",
	[467] = "",
	[468] = "",
	[469] = "",
	[470] = "",
	[471] = "",
	[472] = "",
	[473] = "",
	[474] = "",
	[475] = "",
	[476] = "",
	[477] = "",
	[478] = "",
	[479] = "",
	[480] = "",
	[481] = "",
	[482] = "",
	[483] = "",
	[484] = "",
	[485] = "",
	[486] = "",
	[487] = "",
	[488] = "",
	[489] = "",
	[490] = "",
	[491] = "",
	[492] = "",
	[493] = "",
	[494] = "",
	[495] = "",
	[496] = "",
	[497] = "",
	[498] = "",
	[499] = "",
	[576] = "",
	[577] = "",
	[578] = "",
	[579] = "",
	[580] = "",
	[581] = "",
	[582] = "",
	[583] = "",
	[584] = "",
	[585] = "",
	[586] = "",
	[630] = "",
	[631] = "",
	[632] = "",
	[633] = "",
	[634] = "",
	[635] = "",
	[636] = "",
	[637] = "",
	[638] = "",
	[639] = "",
	[640] = "",
	[641] = "",
	[642] = "",
	[643] = "",
	[644] = "",
	[645] = "",
	[646] = "",
	[647] = "",
	[648] = "",
	[649] = "",
	[650] = "",
	[651] = "",
	[652] = "",
	[653] = "",
	[654] = "",
	[655] = "",
	[656] = "",
	[657] = "",
	[658] = "",
	[659] = "",
	[1024] = "",
	[1025] = "",
	[1040] = "DiPingGuan",
	[1041] = "MiWuShiDi",
	[1042] = "LaNuoXiYa",
	[1043] = "ZiShuiZhanQiao",
	[1044] = "HuanYingQunDao",
	[1045] = "MoDuNa",
	[1046] = "MoShouLingYu",
	[1047] = "FengMoDong",
	[1048] = "TaiyangHaiAn",
	[1049] = "XiaoMaiJiuGang",
	[1050] = "YinLeiHu",
	[1051] = "ShengXiaTan",
	[1052] = "PuTaoJiuGang",
	[1053] = "HeiYiSenLin",
	[1054] = "QingLinQuan",
	[1055] = "JinChuiTaiDi",
	[1056] = "HongChaChuan",
	[1057] = "YiXiuJiaDe",
	[1058] = "XueSongYuan",
	[1059] = "YaoJingLing",
	[1060] = "MengYaChi",
	[1061] = "ZhiZhangXiaGu",
	[1062] = "MiYueZhiTa",
	[1063] = "MoLaBiWan",
	[1064] = "YueYaWan",
	[1065] = "YaoLanShu",
	[1066] = "QiaoMingDong",
	[1067] = "NiMuHe",
	[1068] = "HuangJinGu",
	[1069] = "BaiLingTi",
	[1070] = "TianLangXingDengTa",
	[1071] = "ZhuoReZouLang",
	[1072] = "SiYuJuMu",
	[1073] = "YueYingDao",
	[1074] = "ShuiJingTa",
	[1075] = "MengXiangGong",
	[1076] = "BaiJinHuanXiang",
	[1077] = "HeiJinHu",
	[1078] = "LongXiPuBu",
	[1079] = "ShiWeiTa",
	[1080] = "TongLingTongShan",
	[1081] = "ShenYiZhiDi",
	[1082] = "ShiJiuDaQiao",
	[1083] = "YongHengChuan",
	[1084] = "HaiWuShaTan",
	[1085] = "HeFengLiuDi",
	[1086] = "ZeMeiErYaoSai",
	[1087] = "JuShiQiu",
	[1088] = "JianDouLingYu",
	[1089] = "HeiChenYiZhan",
	[1090] = "ShuiLianYan",
	[1091] = "LingHangMingDeng",
	[1092] = "HaiCiShiKu",
	[1093] = "FeiCuiHu",
	[1094] = "XiongXinGuangChang",
	[1095] = "KuErZhaSi",
	[1096] = "LiuShaMiGong",
	[1097] = "FangXiangTang",
	[1098] = "HuaMiZhanQiao",
	[1099] = "LanWuYongQuan",
	[1100] = "ShenLingShengYu",
	[1101] = "BaiYunYa",
	[1102] = "HaiJiangShuiQu",
	[1103] = "YuanLingYouShu",
	[1104] = "ShaZhongLuTing",
	[1105] = "JieMeiQiu",
	[1106] = "JingYuZhuangYuan",
	[1107] = "ZuJiGu",
	[1108] = "ShanHuTa",
	[1109] = "HengDuanYa",
	[1110] = "ShuiShangTingYuan",
	[1111] = "WuXianHuiLang",
	[1112] = "JinDingChi",
	[1113] = "LvRenZhanQiao",
	[1114] = "LongWenYan",
	[1115] = "HaiManQiaoLang",
	[1116] = "YuanQuanZhiTi",
	[1117] = "MiShiTa",
	[1118] = "RiShengMen",
	[1119] = "XiFengJia",
	[1120] = "ShenLiZhiMen",
	[1121] = "FuXiaoZhiJian",
	[1122] = "HaiLangDong",
	[1123] = "XiangShuYuan",
	[1124] = "MoNvKaFeiGuan",
	[1125] = "JuLongShouYingDi",
	[1126] = "DiYuHeGu",
	[1127] = "FuRongYuanZhuo",
	[1128] = "ShenWoJiao",
	[1129] = "HuangJinGuangChang",
	[1130] = "WanZhiMuChang",
	[1131] = "QiMuQuan",
	[1132] = "JingChiZhanQiao",
	[1133] = "BaiOuTA",
	[1134] = "XiaoShiWangDu",
	[1135] = "KuaTianQiao",
	[1136] = "ShengRenLei",
	[1137] = "JianFeng",
	[1138] = "HouWeiTa",
	[1139] = "BaiYinJiShi",
	[1140] = "LaiShengHuiLang",
	[1141] = "BaoFengLuMen",
	[1142] = "YouLingHu",
	[1143] = "ShiLvHu",
	[1144] = "HuangHunWan",
	[1145] = "XiaoALaMiGe",
	[1146] = "FangLangShenLiTang",
	[1147] = "JingJiSen",
	[1148] = "LangYanQiu",
	[1149] = "ShengRenLvDao",
	[1150] = "BuHuiZhanQuan",
	[1151] = "JiuTeng",
	[1152] = "RongYaoXi",
	[1153] = "JingShu",
	[1154] = "YuMenYiXue",
	[1155] = "YiWangLvZhou",
	[1156] = "YanDiLing",
	[1157] = "GeYongLieGu",
	[1158] = "LiuShaWu",
	[1159] = "BaJianShiQianTing",
	[1160] = "Bahamute",
	[1161] = "Zhushenhuanghun",
	[1162] = "Wangzhezhijian",
	[1163] = "Luxingniao",
	[1164] = "Shenshengcaipansuo",
	[1165] = "Bingtiangong",
	[1166] = "Longchaoshendian",
	[1167] = "HongYuHai",
	[1168] = "HuangJinGang",
	[1169] = "YanXia",
	[1170] = "ChaoFengTing",
	[1171] = "ShenQuanHen",
	[1172] = "BaiYinXiang",
	[1173] = "YuZhouHeYin",
	[1174] = "WoXianXiRan",
	[1175] = "ChenXiWangZuo",
	[1176] = "MengYuBaoJing",
	[1177] = "HaiMaoChaWu",
	[1178] = "RouFengHaiWan",
	[1179] = "HuPoYuan",
	[1180] = "TaiYangHaiAn2",
	[1181] = "YongHengChuan2",
	[1182] = "MoSHouLingYu2",
	[1183] = "YinLeiHu2",
	[1184] = "HeFengLiuDi2",
	[1185] = "YaoJingLing2",
	[1186] = "YiXiuJiaDe2",
	[1188] = "XiaoMaiJiuGang2",
	[1189] = "YueYingDao2",
	[1190] = "PuTaoJiuGang2",
	[1191] = "ShenLingShengYu2",
	[1192] = "ShuiJingTa2",
	[1194] = "FeiCuiHu2",
	[1195] = "DiPingGuan2",
	[1196] = "MiWuShiDi2",
	[1197] = "KuErZhaSi2",
	[1198] = "ZhiZhangXiaGu2",
	[1199] = "ShanHuTa2",
	[1200] = "YaMaWuLuoTi",
	[1201] = "HongChaChuan2",
	[1202] = "SaLeiAn",
	[1203] = "JiaLeiMa",
	[1536] = "",
	[1537] = "",
	[1552] = "sdocontents1",
	[1553] = "sdocontents2",
	[1554] = "sdocontents3",
	[1555] = "sdocontents4",
	[1556] = "sdocontents5",
	[1557] = "sdocontents6",
	[1558] = "sdocontents7",
	[1559] = "sdocontents8",
	[1560] = "sdocontents9",
	[1561] = "sdocontents10",
	[1562] = "sdocontents11",
	[1563] = "sdocontents12",
	[1564] = "sdocontents13",
	[1565] = "sdocontents14",
	[1566] = "sdocontents15",
	[1567] = "sdocontents16",
	[1568] = "sdocontents17",
	[1569] = "sdocontents18",
	[1570] = "sdocontents19",
	[1571] = "sdocontents20",
	[1572] = "sdocontents21",
	[1573] = "sdocontents22",
	[1574] = "sdocontents23",
	[1575] = "sdocontents24",
	[1576] = "sdocontents25",
	[1577] = "sdocontents26",
	[1578] = "sdocontents27",
	[1579] = "sdocontents28",
	[1580] = "sdocontents29",
	[1581] = "sdocontents30",
	[1582] = "sdocontents31",
	[1583] = "sdocontents32",
	[1584] = "sdocontents33",
	[1585] = "sdocontents34",
	[1586] = "sdocontents35",
	[1587] = "sdocontents36",
	[1588] = "sdocontents37",
	[1589] = "sdocontents38",
	[1590] = "sdocontents39",
	[1591] = "sdocontents40",
	[1592] = "sdocontents41",
	[1593] = "sdocontents42",
	[1594] = "sdocontents43",
	[1595] = "sdocontents44",
	[1596] = "sdocontents45",
	[1597] = "sdocontents46",
	[1598] = "sdocontents47",
	[1599] = "sdocontents48",
	[1600] = "sdocontents49",
	[1601] = "sdocontents50",
	[1602] = "sdocontents51",
	[1603] = "sdocontents52",
	[1604] = "sdocontents53",
	[1605] = "sdocontents54",
	[1606] = "sdocontents55",
	[1607] = "sdocontents56",
	[1608] = "sdocontents57",
	[1609] = "sdocontents58",
	[1610] = "sdocontents59",
	[1611] = "sdocontents60",
	[1612] = "sdocontents61",
	[1613] = "sdocontents62",
	[1614] = "sdocontents63",
	[1615] = "sdocontents64",
	[1616] = "sdocontents65",
	[1617] = "sdocontents66",
	[1618] = "sdocontents67",
	[1619] = "sdocontents68",
	[1620] = "sdocontents69",
	[1621] = "sdocontents70",
	[1622] = "sdocontents71",
	[1623] = "sdocontents72",
	[1624] = "sdocontents73",
	[1625] = "sdocontents74",
	[1626] = "sdocontents75",
	[1627] = "sdocontents76",
	[1628] = "sdocontents77",
	[1629] = "sdocontents78",
	[1630] = "sdocontents79",
	[1631] = "sdocontents80",
	[1632] = "sdocontents81",
	[1633] = "sdocontents82",
	[1634] = "sdocontents83",
	[1635] = "sdocontents84",
	[1636] = "sdocontents85",
	[1637] = "sdocontents86",
	[1638] = "sdocontents87",
	[1639] = "sdocontents88",
	[1640] = "sdocontents89",
	[1641] = "sdocontents90",
	[1642] = "sdocontents91",
	[1643] = "sdocontents92",
	[1644] = "sdocontents93",
	[1645] = "sdocontents94",
	[1646] = "sdocontents95",
	[1647] = "sdocontents96",
	[1648] = "sdocontents97",
	[1649] = "sdocontents98",
	[1650] = "sdocontents99",
	[1651] = "sdocontents100",
	[1652] = "sdocontents101",
	[1653] = "sdocontents102",
	[1654] = "sdocontents103",
	[1655] = "sdocontents104",
	[1656] = "sdocontents105",
	[1657] = "sdocontents106",
	[1658] = "sdocontents107",
	[1659] = "sdocontents108",
	[1660] = "sdocontents109",
	[1661] = "sdocontents110",
	[1662] = "sdocontents111",
	[1663] = "sdocontents112",
	[1664] = "sdocontents113",
	[1665] = "sdocontents114",
	[1666] = "sdocontents115",
	[1667] = "sdocontents116",
	[1668] = "sdocontents117",
	[1669] = "sdocontents118",
	[1670] = "sdocontents119",
	[1671] = "sdocontents120",
	[2048] = "",
	[2049] = "",
	[2050] = "KrBahamut",
	[2051] = "KrIfrit",
	[2052] = "KrGaruda",
	[2053] = "KrRamuh",
	[2054] = "KrOdin",
	[2055] = "KrUltima",
	[2056] = "KrMandragora",
	[2057] = "KrTonberry2",
	[2058] = "KrExcalibur",
	[2059] = "KrPhoenix",
	[2060] = "KrAlexander",
	[2061] = "KrTitan",
	[2062] = "KrLeviathan",
	[2063] = "KrShiva",
	[2064] = "KrBehemoth",
	[2065] = "KrGilgamesh",
	[2066] = "KrSabotender",
	[2067] = "KrUnicorn",
	[2068] = "KrRagnarok",
	[2069] = "KrRamia",
	[2070] = "KrNewPublic1",
	[2071] = "KrNewPublic2",
	[2072] = "KrNewPublic3",
	[2073] = "KrNewPublic4",
	[2074] = "KrNewPublic5",
	[2075] = "KrCarbuncle",
	[2076] = "KrChocobo",
	[2077] = "KrMoogle",
	[2078] = "KrTonberry",
	[2079] = "KrCaitsith",
	[2080] = "KrFenrir",
	[2081] = "KrOmega",
	[2560] = "",
	[2561] = "",
	[2562] = "krcontents1",
	[2563] = "krcontents2",
	[2564] = "krcontents3",
	[2565] = "krcontents4",
	[2566] = "krcontents5",
	[2567] = "krcontents6",
	[2568] = "krcontents7",
	[2569] = "krcontents8",
	[2570] = "krcontents9",
	[2571] = "krcontents10",
	[2572] = "krcontents11",
	[2573] = "krcontents12",
	[2574] = "krcontents13",
	[2575] = "krcontents14",
	[2576] = "krcontents15",
	[2577] = "krcontents16",
	[2578] = "krcontents17",
	[2579] = "krcontents18",
	[2580] = "krcontents19",
	[2581] = "krcontents20",
	[2582] = "krcontents21",
	[2583] = "krcontents22",
	[3000] = "Cloudtest01",
	[3001] = "Cloudtest02",
	[3500] = "Clcontents01",
	[3501] = "Clcontents02",
	[3502] = "Clcontents03",
	[4000] = "",
	[4001] = "",
	[4002] = "",
	[4003] = "",
	[4004] = "",
	[4020] = "",
	[4021] = "",
	[4022] = "",
	[4023] = "",
	[4024] = "",
	[4025] = "",
	[4026] = "",
	[4027] = "",
	[9000] = "",
	[10000] = "crossworld_range",
	[10001] = "crossworld",
	[10002] = "crossworld",
	[10003] = "crossworld",
	[10004] = "crossworld",
	[10005] = "crossworld",
	[10006] = "crossworld",
	[10007] = "crossworld",
	[10008] = "crossworld",
	[10009] = "crossworld",
	[10010] = "crossworld",
	[10011] = "crossworld",
	[10012] = "crossworld",
	[10013] = "crossworld",
	[10014] = "crossworld",
	[10015] = "crossworld",
	[10016] = "crossworld",
	[10017] = "crossworld",
	[10018] = "crossworld",
	[10019] = "crossworld",
	[10020] = "crossworld",
	[10098] = "crossworld",
	[65534] = "outofrange1",
	[65535] = "outofrange2"
}

function GetCharacterName(im_a_cheeky_monkey)
	if Entity.Player and Entity.Player.Name then
		if im_a_cheeky_monkey == nil then im_a_cheeky_monkey = false end
		if im_a_cheeky_monkey == false then
			return Entity.Player.Name
		end
		if im_a_cheeky_monkey == true then
			pen = Entity.Player.Name
			penworld = homeworld_lookup[Entity.Player.HomeWorld]
			pen = pen .. "@" .. penworld
			return pen
		end
	end
	return "Wefailed Togetaname"
end

function DeliverooIsTurnInRunning()
	return IPC.Deliveroo.IsTurnInRunning()
end

function HasPlugin(name)
  for plugin in luanet.each(Svc.PluginInterface.InstalledPlugins) do
    if plugin.InternalName == name then
      return true
    end
  end
  return false
--	return IPC.IsInstalled(name)
end

function GetInventoryFreeSlotCount()
	--yield("/e " ..tostring(Inventory.GetInventoryContainer(luanet.enum(InventoryType, 'Inventory1')).FreeSlots))
	--return Inventory.GetInventoryContainer(luanet.enum(InventoryType, 'Inventory1')).FreeSlots
	return Inventory.GetFreeInventorySlots()
end

function GetPlayerGC()
	return Player.GrandCompany
end

function PathfindAndMoveTo(x, y, z, tralse)
	import ("System.Numerics")
	IPCUPCWEALLPC = Vector3(x, y, z)
	IPC.vnavmesh.PathfindAndMoveTo(IPCUPCWEALLPC, tralse)
end

function PathtoTarget()
	if Entity.Target and Entity.Target.Name then
		PathfindAndMoveTo(Entity.Target.Position.X,Entity.Target.Position.Y,Entity.Target.Position.Z,false)
	end
end

function PathtoName(nemm)
	PathfindAndMoveTo(GetObjectRawXPos(nemm),GetObjectRawYPos(nemm),GetObjectRawZPos(nemm),false)
end

function PathIsRunning()
	return IPC.vnavmesh.IsRunning()
end

function PathfindInProgress()
	return IPC.vnavmesh.PathfindInProgress()
end

function ClearTarget()
    if Entity.Player and Entity.Player.ClearTarget then
        Entity.Player:ClearTarget()
    else
        yield("/echo Failed to clear target: Entity.Player or ClearTarget missing")
    end
end


function mydistto(x2, y2, z2)
	x1 = EntityPlayerPositionX()
	y1 = EntityPlayerPositionY()
	z1 = EntityPlayerPositionZ()
	if type(x1) ~= "number" then x1 = 0 end
	if type(y1) ~= "number" then y1 = 0 end
	if type(z1) ~= "number" then z1 = 0 end
	if type(x2) ~= "number" then x2 = 0 end
	if type(y2) ~= "number" then y2	= 0 end
	if type(z2) ~= "number" then z2 = 0 end
	zoobz = math.sqrt((x2 - x1)^2 + (y2 - y1)^2 + (z2 - z1)^2)
	if type(zoobz) ~= "number" then
		zoobz = 0
	end
    --return math.sqrt((x2 - x1)^2 + (y2 - y1)^2 + (z2 - z1)^2)
    return zoobz
end

function GetPlayerRawXPos()
	return EntityPlayerPositionX()
end

function GetPlayerRawYPos()
	return EntityPlayerPositionY()
end

function GetPlayerRawZPos()
	return EntityPlayerPositionZ()
end

function GetTargetName()
    local returntarget = "nyetnyetnyetnyetnyetnyet"
    if Entity.Target and Entity.Target.Name then
        returntarget = Entity.Target.Name
    end
    return returntarget
end

function GetCharacterCondition(zup)
	return Svc.Condition[zup]
end

function NeedsRepair(pcct)
	repairList = Inventory.GetItemsInNeedOfRepairs(pcct)
	if repairList.Count == 0 then
		return false
	else
		return true
	end
end

function GetZoneID()
	return Svc.ClientState.TerritoryType
end

function GetBuddyTimeRemaining()	
	ctime = 0
	if InSanctuary() == false then
		ctime = Instances.Buddy.CompanionInfo.TimeLeft or 0
	end
	return ctime
end

function IsPartyMemberMounted(frend)
    local ent = Entity.GetEntityByName(frend)
    if ent and ent.IsMounted ~= nil then
        return ent.IsMounted
    end
    return false -- or nil, if you want to signal "unknown"
end


function TargetClosestEnemy()
	--* who knows
	yield("/send TAB")
end

function GetPartyMemberName(gpmi)
	return Entity.GetPartyMember(gpmi).Name
end

function InSanctuary()
	if Player.CanMount then return false end
	if Player.CanMount == false then return true end
end

function HasFlightUnlocked()
	return Player.CanFly
end


function IsInFate()
	asdf = false
	if Fates.CurrentFate and Fates.CurrentFate.InFate then
		asdf = true
	end
	return asdf
	--yield("/echo we in fate -> "..asdf)
end

function PandoraSetFeatureState(zfeatureName, zenabled)
	IPC.PandorasBox.SetFeatureEnabled(zfeatureName, zenabled)
end

function DropboxSetItemQuantity(id, hq, quantity)
	IPC.Dropbox.SetItemQuantity(id, hq, quantity)
end

function DropboxIsBusy()
	return IPC.Dropbox.IsBusy()
end

function DropboxStart()
	IPC.Dropbox.BeginTradingQueue()
end

function GetContentTimeLeft()
--	if Svc.Condition[34] == false then return 0 end
--	if Svc.Condition[34] == true and InstancedContent.ContentTimeLeft > 0 then return InstancedContent.ContentTimeLeft end
	return InstancedContent.ContentTimeLeft --turns out we don't need to nil check this one.
end

function WaitForTarget(limit,waitt) --incremenets of 0.1
	limitcounter = 10 or limit
	counterlimit = 0
	actualwaitt = 10 or waitt
	while counterlimit < limitcounter do
		counterlimit = counterlimit + 1
		yield("/wait 0.1")
		if Entity.Target and Entity.Target.Name then
			counterlimit = limitcounter
		end
	end
	waitcount = 0
	while waitcount < actualwaitt do
		yield("/wait 0.1")
		waitcount = waitcount + 1
	end
end

function OpenRegularDuty(x)
	Instances.DutyFinder:OpenRegularDuty(x)
end

function BroCheck(index)
	--check if anyone is dead
	return Entity.GetPartyMember(index).CurrentHp
end

--code from Erisen @ https://discord.com/channels/1001823907193552978/1196163718216679514/1391171759621017731
--Erisen — 6:27 PM
--looks like there should just be a .IsDead or .IsTargetable which might be what you want to check for
function closest_thing(name)
    if EntityWrapper == nil then
        EntityWrapper = load_type('SomethingNeedDoing.LuaMacro.Wrappers.EntityWrapper')
    end
    local closest = nil
    local distance = nil
    for i=0,Svc.Objects.Length-1 do
        local obj = Svc.Objects[i]
        if obj~=nil and obj.Name.TextValue == name then
            local t_distance = mydistto(obj)
            if closest == nil then
                closest = obj
                distance = t_distance
            elseif t_distance < distance then
                closest = obj
                distance = t_distance
            end
        end
    end
    return EntityWrapper(closest)
end
function load_type(type_path)
    local assembly = mysplit(type_path)
--    log_debug("Loading assembly", assembly)
    luanet.load_assembly(assembly)
--    log_debug("Wrapping type", type_path)
    local type_var = luanet.import_type(type_path)
--    log_debug("Wrapped type", type_var)
    return type_var
end
function mysplit(inputstr)
    for str in string.gmatch(inputstr, "[^%.]+") do
        return str
    end
end


--[[
code from nonu https://discord.com/channels/1001823907193552978/1196163718216679514/1385624616734691339
function FindNearestObjectByName(targetName)
    local player = Svc.ClientState.LocalPlayer
    local closestObject = nil
    local closestDistance = math.huge

    for i = 0, Svc.Objects.Length - 1 do
        local obj = Svc.Objects[i]
        if obj ~= nil and obj.Position ~= nil and obj.Name ~= nil then
            local name = obj.Name.TextValue
            if string.find(string.lower(name), string.lower(targetName)) then
                local distance = GetDistance(obj.Position, player.Position)
                if distance < closestDistance then
                    closestDistance = distance
                    closestObject = obj
                end
            end
        end
    end

    if closestObject then
        local name = closestObject.Name.TextValue
        local pos = closestObject.Position
        LogInfo("[NonuLuaLib] Found nearest '%s': %s (%.2f units) | XYZ: (%.3f, %.3f, %.3f)",
            targetName, name, closestDistance, pos.X, pos.Y, pos.Z)
    else
        LogInfo("[NonuLuaLib] No object matching '%s' found nearby.", targetName)
    end

    return closestObject, closestDistance
end
--]]

function waitforcombat(x)
	xx = 0
	while Svc.Condition[26] == false and xx < x do  
		yield("/wait 0.1")
		xx = xx + 1
		yield("/send TAB")
		yield("/ac Shield Lob")
	end
	yield("/vnav stop")
end

function WaitForAddon(x, t)
	t = t or 180 --default 3 minutes maxwait
	yield("/waitaddon "..x.."<maxwait "..t..">")
end

function ChooseAndClickDuty(x)
	Instances.DutyFinder:OpenRegularDuty(x)
	yield("/waitaddon ContentsFinder<maxwait 10>")
	yield("/callback ContentsFinder true 12 1")
	yield("/wait 2")
	x = x - 1
	if x == 829 then x = 4 end --decumana
	yield("/callback ContentsFinder true 3 "..x)
	yield("/wait 2")
	yield("/dutyfinder")
end

food_list = { --list in order of least wanted to most wanted
  --default
  {4745, "Orange Juice"},

  --f2p from kugane
  {12855, "Grilled Sweetfish"},
  {19816, "Popoto Soba"},
  {19822, "Grilled Turban"},

  --6.4
  {39872, "Baked Eggplant"},

  --7.0
  {44182, "Pineapple Orange Jelly"},

  --7.2
  {44178, "Moqecka"},
  {46003, "Mate Cookie"}
}

function Available_Food_ID()
	for i=1,#food_list do
		zitemcount = GetItemCount(food_list[i][1])
		if zitemcount > 0 then
			local zfeedme = food_list[i][1]
			local zfeedmeitem = food_list[i][2]
			yield("/echo Found ->"..zitemcount.."x"..food_list[i][1].."->"..food_list[i][2])
			return zfeedme, zfeedmeitem
		end
		yield("/wait 0.1")
	end
	return 4745,"Orange Juice"
end


function GetInternalNames() --get all plugin internalnames for use with isinstalled etc.
	for plugin in luanet.each(Svc.PluginInterface.InstalledPlugins) do
		if plugin.IsLoaded then
			yield("/echo " .. plugin.Name)
		end
	end
end

function GetInternalNamesIPC() --get all plugin internalnames for use with isinstalled etc. IPC ones
	local rawPlugins = IPC.GetAvailablePlugins()
	local plugins = {}

	-- Convert .NET array to Lua table
	for i = 0, rawPlugins.Length - 1 do
		table.insert(plugins, rawPlugins:GetValue(i))
	end

	-- Now safe to iterate
	for i = 1, #plugins do
		yield("/echo " .. plugins[i])
	end
end

function GetInternalCommands() --get all subcommands for all plugins
	for name, plugin in pairs(IPC) do
		if type(plugin) == "table" then
			yield("/echo === " .. name .. " ===")
			for k, v in pairs(plugin) do
				yield("/echo    " .. k)
			end
		end
	end
end

function GetIPCRegisteredTables()
	-- Iterate all registered IPC plugin tables
	for name, plugin in pairs(IPC) do
		-- Make sure it's a table (i.e., an actual plugin container)
		if type(plugin) == "table" then
			yield("/echo === IPC Plugin: " .. name .. " ===")

			-- Optional: List functions inside each plugin
			for funcName, func in pairs(plugin) do
				if type(func) == "function" then
					yield("/echo    function: " .. funcName)
				else
					-- Also show non-function fields if any
					yield("/echo    field: " .. funcName .. " (" .. type(func) .. ")")
				end
			end
		end
	end
end


function PartialPluginNameSearchExample()
	local guesses = {
	  "BossModReborn",
	  "BossMod",
	  "bossmodreborn",
	  "rebornbossmod",
	  "ACTOverlay",
	  "cactbot",
	  "SomeOtherRebornPlugin",
	  "raidemulator",
	  "triggevent",
	  "triggernometry",
	  "reboot",
	  "reborn",
	  "rebornplugin",
	  "rebornpluginframework",
	  "overlayplugin",
	  "bosmodreborn",
	}

	for _, guess in ipairs(guesses) do
	  local success, result = pcall(function()
		return Svc.PluginInterface.InstalledPlugins
	  end)

	  local found = false

	  if success then
		for plugin in luanet.each(result) do
		  if plugin.InternalName and plugin.InternalName:lower():find(guess:lower(), 1, true) then
			yield("/echo Found match: " .. plugin.InternalName .. " (Display: " .. plugin.Name .. ")")
			found = true
		  end
		end
	  end

	  if not found then
		yield("/echo Guess not matched: " .. guess)
	  end
	end
end

function food_deleter(feedme, feedmeitem, echo_level, foodsearch)
	--[[
	--Food check!
	feedme, feedmeitem  = food_deleter(feedme,feedmeitem,echo_level,feedmesearch)
	--]]
	echo_level = echo_level or 3 --catch non calls to this if calling script doesn't check it
	statoos = GetStatusTimeRemaining(48)
	zfeedme = feedme
	zfeedmeitem = feedmeitem
	entittyname = GetCharacterName(false) or "Nobodyin Particular"
	EGHP = Entity.GetEntityByName(entittyname).CurrentHp or 0
	
	if type(GetItemCount(zfeedme)) == "number" then
		foidme = GetItemCount(zfeedme)
		if foidme > 0 and statoos < 90 and (Svc.Condition[34] == false or Svc.Condition[26] == false) then --refresh food if we are below 15 minutes left
			if EGHP > 10 then
				Inventory.GetInventoryItem(tonumber(zfeedme)):Use()
				if echo_level < 4 then yield("/echo Attempting to eat "..zfeedmeitem) end
			end
			if EGHP == 0 then yield("/echo We are dead or unavailable -- waiting.....") end
			yield("/wait 0.5")
		end
		if foidme == 0 and zfeedme ~= 4745 and foodsearch == true then --if we ran out but still have more food that isn't "orange juice"
			zfeedme, zfeedmeitem = Available_Food_ID()
		end
	end
	
	return zfeedme, zfeedmeitem
end