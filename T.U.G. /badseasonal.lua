--we doing some seasonal and getting stuck at some step
while Svc.ClientState.TerritoryType ~= nil and Svc.ClientState.TerritoryType == 137 do
   yield("/wait 5")
   yield("/send NUMPAD0")
end