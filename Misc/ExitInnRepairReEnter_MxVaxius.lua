--[[
repair at 15%
make sure we have more than 5k gil

turn off SND targeting in SND options
turn on targeting fix in simpletweaks

Yesalready configs
"YesNo"
	/Repair all displayed items for.*/
	/Exit.*/
"Lists"
	/Retire to an inn room.*/
]]
if NeedsRepair(15) and  GetItemCount(1) > 4999 then
--if GetItemCount(1) > 4999 then
	--Exit the inn room
	yield("/target Heavy Oaken Door")
	yield("/wait 1")
	yield("/lockon on")
	yield("/automove")
	yield("/wait 2")
	yield("/pinteract")
	yield("/wait 8")
	
	--find the repair npc
	yield("/target Erkenbaud")  --gridania
	yield("/target Leofrun")    --limsa
	yield("/target Zuzutyro")   --uldah
	yield("/wait 1")
	yield("/lockon on")
	yield("/automove")
	yield("/wait 2")
	yield("/wait 1")
	yield("/pinteract")
	yield("/wait 1")
	yield("/pcall SelectIconString true 1")
	yield("/wait 1")
	yield("/pcall Repair true 0")
	yield("/wait 1")
	yield("/pcall Repair true 1")
	yield("/wait 1")
	yield("/send ESCAPE <wait.1.5>")
	yield("/send ESCAPE <wait.1.5>")
	yield("/send ESCAPE <wait.1.5>")
	yield("/send ESCAPE <wait.1>")
	yield("/wait 3")
	
	--reenter the inn room
	yield("/target Antoinaut") --gridania
	yield("/target Mytesyn")   --limsa
	yield("/target Otopa")     --uldah
	yield("/wait 1")
	yield("/lockon on")
	yield("/automove")
	yield("/wait 2")
	yield("/wait 0.5")
	yield("/interact")
	yield("/wait 8")
end
