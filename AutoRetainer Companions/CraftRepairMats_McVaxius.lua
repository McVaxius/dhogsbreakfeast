--[[
  Description: Checks how much crystals you have and will stop when materials are low to not be able to craft and then turn multi back on. Meant for crafting repair mats via artisan quick synth
  Author: McVaxius
  Link: https://discord.com/channels/1162031769403543643/1162799234874093661/1162837829580230736
]]

--new way to get vctarget
VCtarget = 0
CrystalsUsed = 0
VCnum = 0

Fire_Crystal = GetItemCount(8)
Ice_Crystal = GetItemCount(9)
Wind_Crystal = GetItemCount(10)
Earth_Crystal = GetItemCount(11)
Lightning_Crystal = GetItemCount(12)
Water_Crystal = GetItemCount(13)
DarkMC = GetItemCount(10335)
Grade6DM = GetItemCount(10386)

tempMAKE = 0
--woodsmith
if (Wind_Crystal >= 5 and Ice_Crystal >=5) then
	if (Wind_Crystal >= Ice_Crystal) then
		VCtarget = VCtarget + math.floor(Ice_Crystal/5)
		CrystalsUsed = 5 * math.floor(Ice_Crystal/5)
	end
	if (Wind_Crystal < Ice_Crystal) then
		VCtarget = VCtarget + math.floor(Wind_Crystal/5)
		CrystalsUsed = 5 * math.floor(Wind_Crystal/5)
	end
	Wind_Crystal = Wind_Crystal - CrystalsUsed
	Ice_Crystal = Ice_Crystal - CrystalsUsed
	tempMAKE = CrystalsUsed / 5
	CrystalsUsed = 0
end
yield("/echo woodsmith repair kits: "..tempMAKE.." Total Kits: "..VCtarget)
tempMAKE = 0
--blacksmith	Fire_Crystal		Earth_Crystal
if (Fire_Crystal >= 5 and Earth_Crystal >=5) then
	if (Fire_Crystal >= Earth_Crystal) then
		VCtarget = VCtarget + math.floor(Earth_Crystal/5)
		CrystalsUsed = 5 * math.floor(Earth_Crystal/5)
	end
	if (Fire_Crystal < Earth_Crystal) then
		VCtarget = VCtarget + math.floor(Fire_Crystal/5)
		CrystalsUsed = 5 * math.floor(Fire_Crystal/5)
	end
	Fire_Crystal = Fire_Crystal - CrystalsUsed
	Earth_Crystal = Earth_Crystal - CrystalsUsed
	tempMAKE = CrystalsUsed / 5
	CrystalsUsed = 0
end
yield("/echo blacksmith repair kits: "..tempMAKE.." Total Kits: "..VCtarget)
tempMAKE = 0
--armorsmith	Ice_Crystal			Earth_Crystal
if (Ice_Crystal >= 5 and Earth_Crystal >=5) then
	if (Ice_Crystal >= Earth_Crystal) then
		VCtarget = VCtarget + math.floor(Earth_Crystal/5)
		CrystalsUsed = 5 * math.floor(Earth_Crystal/5)
	end
	if (Ice_Crystal < Earth_Crystal) then
		VCtarget = VCtarget + math.floor(Ice_Crystal/5)
		CrystalsUsed = 5 * math.floor(Ice_Crystal/5)
	end
	Ice_Crystal = Ice_Crystal - CrystalsUsed
	Earth_Crystal = Earth_Crystal - CrystalsUsed
	tempMAKE = CrystalsUsed / 5
	CrystalsUsed = 0
end
yield("/echo armorsmith repair kits: "..tempMAKE.." Total Kits: "..VCtarget)
tempMAKE = 0

--leathersmith	Earth_Crystal		Wind_Crystal
if (Earth_Crystal >= 5 and Wind_Crystal >=5) then
	if (Earth_Crystal >= Wind_Crystal) then
		VCtarget = VCtarget + math.floor(Wind_Crystal/5)
		CrystalsUsed = 5 * math.floor(Wind_Crystal/5)
	end
	if (Earth_Crystal < Wind_Crystal) then
		VCtarget = VCtarget + math.floor(Earth_Crystal/5)
		CrystalsUsed = 5 * math.floor(Earth_Crystal/5)
	end
	Earth_Crystal = Earth_Crystal - CrystalsUsed
	Wind_Crystal = Wind_Crystal - CrystalsUsed
	tempMAKE = CrystalsUsed / 5
	CrystalsUsed = 0
end
yield("/echo leathersmith repair kits: "..tempMAKE.." Total Kits: "..VCtarget)
tempMAKE = 0

--clothsmith	Lightning_Crystal	Wind_Crystal
if (Lightning_Crystal >= 5 and Wind_Crystal >=5) then
	if (Lightning_Crystal >= Wind_Crystal) then
		VCtarget = VCtarget + math.floor(Wind_Crystal/5)
		CrystalsUsed = 5 * math.floor(Wind_Crystal/5)
	end
	if (Lightning_Crystal < Wind_Crystal) then
		VCtarget = VCtarget + math.floor(Lightning_Crystal/5)
		CrystalsUsed = 5 * math.floor(Lightning_Crystal/5)
	end
	Lightning_Crystal = Lightning_Crystal - CrystalsUsed
	Wind_Crystal = Wind_Crystal - CrystalsUsed
	tempMAKE = CrystalsUsed / 5
	CrystalsUsed = 0
end
yield("/echo clothsmith repair kits: "..tempMAKE.." Total Kits: "..VCtarget)
tempMAKE = 0

--goldsmith		Fire_Crystal		Wind_Crystal
if (Fire_Crystal >= 5 and Wind_Crystal >=5) then
	if (Fire_Crystal >= Wind_Crystal) then
		VCtarget = VCtarget + math.floor(Wind_Crystal/5)
		CrystalsUsed = 5 * math.floor(Wind_Crystal/5)
	end
	if (Fire_Crystal < Wind_Crystal) then
		VCtarget = VCtarget + math.floor(Fire_Crystal/5)
		CrystalsUsed = 5 * math.floor(Fire_Crystal/5)
	end
	Fire_Crystal = Fire_Crystal - CrystalsUsed
	Wind_Crystal = Wind_Crystal - CrystalsUsed
	tempMAKE = CrystalsUsed / 5
	CrystalsUsed = 0
end
yield("/echo goldsmith repair kits: "..tempMAKE.." Total Kits: "..VCtarget)
tempMAKE = 0

--foodsmith		Fire_Crystal		Water_Crystal
if (Fire_Crystal >= 5 and Water_Crystal >=5) then
	if (Fire_Crystal >= Water_Crystal) then
		VCtarget = VCtarget + math.floor(Water_Crystal/5)
		CrystalsUsed = 5 * math.floor(Water_Crystal/5)
	end
	if (Fire_Crystal < Water_Crystal) then
		VCtarget = VCtarget + math.floor(Fire_Crystal/5)
		CrystalsUsed = 5 * math.floor(Fire_Crystal/5)
	end
	Fire_Crystal = Fire_Crystal - CrystalsUsed
	Water_Crystal = Water_Crystal - CrystalsUsed
	tempMAKE = CrystalsUsed / 5
	CrystalsUsed = 0
end
yield("/echo foodsmith repair kits: "..tempMAKE.." Total Kits: "..VCtarget)
tempMAKE = 0


--drugsmith		Lightning_Crystal		Water_Crystal
if (Lightning_Crystal >= 5 and Water_Crystal >=5) then
	if (Lightning_Crystal >= Water_Crystal) then
		VCtarget = VCtarget + math.floor(Water_Crystal/5)
		CrystalsUsed = 5 * math.floor(Water_Crystal/5)
	end
	if (Lightning_Crystal < Water_Crystal) then
		VCtarget = VCtarget + math.floor(Lightning_Crystal/5)
		CrystalsUsed = 5 * math.floor(Lightning_Crystal/5)
	end
	Lightning_Crystal = Lightning_Crystal - CrystalsUsed
	Water_Crystal = Water_Crystal - CrystalsUsed
	tempMAKE = CrystalsUsed / 5
	CrystalsUsed = 0
end
yield("/echo drugsmith repair kits: "..tempMAKE.." Total Kits: "..VCtarget)
tempMAKE = 0




--Code for checking for repair mats
VCnum = GetItemCount(10373)
--old way
--VCtarget = 3000
VCtotal = VCnum + VCtarget

yield("/echo Number of repair mats right now: "..GetItemCount(10373))
yield("/echo Number of repair mats to make: "..VCtarget)
yield("/echo Total Number of repair mats after make: "..VCtotal)
tempg6 = 0
tempDMC = 0
while (VCnum < VCtotal) do
	--dont do anything just wait
    yield("<wait.5.0>")
    VCnum = GetItemCount(10373)
	tempg6 = GetItemCount(10386)
	tempDMC = GetItemCount(10335)
	--if g6dm or dmc runs below craftable amounts we will assume its exit time also
	if (tempg6 < 6 or tempDMC < 1) then
		VCnum = VCtotal + 1
	end
end
yield("<wait.5.0>")
yield("/xltoggleprofile Artisan")
yield("/callback SynthesisSimple true -1")
yield("<wait.5.0>")
yield("/stopcrafting")
yield("<wait.5.0>")
yield("/ays multi")
