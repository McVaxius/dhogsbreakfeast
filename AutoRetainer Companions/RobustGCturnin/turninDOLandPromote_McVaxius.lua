--so this will go to your GC desk try a single DOL turn in, then try to run a promotion. then teleport back to FC Estate.
--this is meant to be used from where ever you are after you acquire the daily DOL item

--borrowed some code and ideas from the wonderful:  (make sure the _functions is in the snd folder)
--https://github.com/elijabesu/ffxiv-scripts/blob/main/snd/_functions.lua
loadfiyel = os.getenv("appdata").."\\XIVLauncher\\pluginConfigs\\SomethingNeedDoing\\_functions.lua"
functionsToLoad = loadfile(loadfiyel)
functionsToLoad()
DidWeLoadcorrectly()

yield("/wait 0.5")
--CharacterSafeWait()
yield("/echo Attempting to turn in DOL turnin item")
TeleportToGCTown()
ZoneTransition()
WalkToGC()

yield("Flames Rank :"..GetFlamesGCRank())
yield("Maelstrom Rank :"..GetMaelstromGCRank())
yield("Adders Rank :"..GetAddersGCRank())

yield("/echo movement stopped - time for GC turn ins")
--yield("<wait.15>")
--yield("/waitaddon SelectString<maxwait 600>")
yield("/visland stop")
yield("/wait 1")
yield("/target Personnel Officer")
yield("/wait 1")
yield("/send NUMPAD0")
yield("/callback SelectString true 0 <wait.1>")
yield("/send NUMPAD0")
yield("/wait 1")
yield("/send NUMPAD0")
yield("/wait 1")
yield("/callback GrandCompanySupplyList true 0 1 2")
yield("/wait 1")
yield("/send NUMPAD0")
yield("/wait 1")
yield("/send NUMPAD0")
yield("/wait 1")
yield("/send ESCAPE <wait.1.5>")
yield("/send ESCAPE <wait.1.5>")
yield("/wait 3")

GCrenk = GetFlamesGCRank()
if GetMaelstromGCRank() > GCrenk then
	GCrenk = GetMaelstromGCRank()
end
if GetAddersGCRank() > GCrenk then
	GCrenk = GetAddersGCRank()
end

if GCrenk < 4 then --we can go up to 4 safely if we are below it. if you put in the effort to finish GC log 1, go pop rank 5 :~D
	--try to promote
	yield("/wait 1")
	yield("/target Personnel Officer")
	yield("/wait 1")
	yield("/send NUMPAD0")
	yield("/wait 1")
	yield("/send NUMPAD2")
	yield("/wait 0.5")
	yield("/send NUMPAD0")
	yield("/wait 0.5")
	yield("/send NUMPAD0")
	yield("/send ESCAPE")
	yield("/wait 1.5")
	yield("/send ESCAPE")
	yield("/wait 1.5")
	yield("/wait 3")

	--wait for char condition 1
	while Svc.Condition[32] == true and Svc.Condition[35] == true do
		yield("/wait 1")
	end
	yield("/wait 2")
end

if GCrenk < 7 and GCrenk > 4 then --if we are above 4 and below 7 we can go up to 7
	--try to promote
	yield("/wait 1")
	yield("/target Personnel Officer")
	yield("/wait 1")
	yield("/send NUMPAD0")
	yield("/wait 1")
	yield("/send NUMPAD2")
	yield("/wait 0.5")
	yield("/send NUMPAD0")
	yield("/wait 0.5")
	yield("/send NUMPAD0")
	yield("/send ESCAPE")
	yield("/wait 1.5")
	yield("/send ESCAPE")
	yield("/wait 1.5")
	yield("/wait 3")

	--wait for char condition 1
	while Svc.Condition[32] == true and Svc.Condition[35] == true do
		yield("/wait 1")
	end
	yield("/wait 2")
end

-- Teleport back to FC House
yield("/tp Estate Hall")
yield("/wait 10")
yield("/waitaddon _ActionBar<maxwait 600>")
for i=1, 20 do
  yield("/send W")
end

yield("/send Right")
yield("/send Right")

yield("/target Entrance")
yield("/wait 1")
yield("/lockon on")
yield("/automove on")
yield("/wait 2.5")
yield("/automove off")
yield("/wait 1.5")
