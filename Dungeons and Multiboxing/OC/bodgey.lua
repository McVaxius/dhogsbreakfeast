--extremely complex BOCHI helper script to assist passing over obstacles

dodgey_bodger = true

while dodgey_bodger do
	yield("/wait 5")
	if Svc.Condition[4] == true and IPC.vnavmesh.IsRunning() then
		yield("/gaction jump")
	end
end