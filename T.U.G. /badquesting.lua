while 1==1 do
    if Svc.Condition[26] ==false then
    yield("/send KEY_1")
    if (Svc.Condition[4] == true or Svc.Condition[10] == true) and IPC.vnavmesh.IsRunning() then
        yield("/gaction jump")
    end
    end
    yield("/wait 5")
end