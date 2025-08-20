if IPC.Questionable.IsQuestLocked("764") then
    yield("/echo Quest 764 is locked and cannot be started")
else
    IPC.Questionable.ClearQuestPriority()
    IPC.Questionable.AddQuestPriority("764")
    yield("/echo Quest 764 added to priority list")
end
yield("/qst start")
while IPC.Questionable.GetCurrentQuestId() == "764" do
    coroutine.yield() -- wait until quest changes / completes
end
IPC.Questionable.ClearQuestPriority()
yield("/echo Quest 764 finished, queue cleared")
