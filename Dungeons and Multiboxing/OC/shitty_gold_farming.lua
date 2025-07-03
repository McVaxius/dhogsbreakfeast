--[[
shitty gold farming in west caves
7.2, 19.4

requires a party of 4 (max) around KL 20
--]]

loadfiyel = os.getenv("appdata").."\\XIVLauncher\\pluginConfigs\\SomethingNeedDoing\\_functions.lua"
functionsToLoad = loadfile(loadfiyel)
functionsToLoad()

im_a_lazy_fuck = true
goatfuck = "Lesser Cry of Havoc"

while im_a_lazy_fuck == true do
	yield("/wait 0.1")
	floop = 0
	if GetCharacterCondition(26) then
		yield("/vnav stop")
	end
	while GetCharacterCondition(26) == false do
--		floop = floop + 1
		yield("/wait 0.1")
		yield("/ac sprint")
		yield("/ac Shield Lob")
		if floop == 0 then
			yield("/target \"Lesser Cry of Havoc\"")
			nemm = "Lesser Cry of Havoc"
		end
		if floop > 0 then
			yield("/target Geshunpest")
			nemm = "Geshunpest"
			floop = 0
		end
		PathtoName(nemm)
		--PathtoTarget()
	end
end