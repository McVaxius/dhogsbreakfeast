--add this to 'OnDutyCompleted'
if Svc.ClientState.TerritoryType == 1044 then --only do this in Prae
	while Svc.Condition[34] do
		yield("/wait 0.1")
	end
end

sock_watcher = 0

while Svc.Condition[34] == false and sock_watcher < 50 do
	yield("/wait 6")
	sock_watcher = sock_watcher + 1
end

if sock_watcher > 49 then
	yield("/echo Looks like the sock ripped.  Let's get a new sock")
	yield("/ad stop")
	yield("/snd start goon")
end