--optional vnav stop on falling/jumping with new-snd
if Svc.Condition[48] then 
--yield("/vnav stop")
IPC.vnavmesh.Stop()
yield("/echo stopping vnav while we jump")
 end