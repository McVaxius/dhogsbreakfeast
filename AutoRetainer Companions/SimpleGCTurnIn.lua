-- requres deliveroo, visland, autoretainer
-- requires lifestream if you use the short limsa route

local useShortLimsaRoute = true

local gridaniaRoute = "H4sIAAAAAAAACuWTW0vEMBCF/4rMcxuSNEnTvsmqyz6sN4T1gg/BRjZgE2mzipT+d6eXZUF/Qt/mzBwOJx+kg2tTWyhh3bjKeGfO1itIYGd+PoPzsYXypYPb0Lrogoeyg0couSRc5EWRwBOUjPAEnnGpCKNKZlmPMni7ucBbhrd7U7kD5jBCE9iGL1tbH6FEsfHRNuYt7lzc3wz+P7u5GdZp9+H7eMEemPZuPlp7so/lWAKXdYj2GBVtPY/no2MWdwfbxnkegnfGxVPioK5Cswq+mt9Mp+WDq+0WfbRP/hFJOSdKSy30yCQVJMupECMYRkmhtZJ8kWCkHsDITE5gGNFC8GICw4iijLF8kWCUJpnUhZq4UCIpk4Iq1IgmRWpM5sUCPtNr/wtlx33vgwQAAA=="

local uldahRoute = "H4sIAAAAAAAACuWUyWrDMBCGX6XM2R20y/KtpAs5pBst6UIPolGxILZKrLQUk3ev7NgNlD5BrdP80vAz8zGjFi5t5aCA+/XKlkcXM8hgab/eg69jA8VzC9eh8dGHGooWHqA4plwgFyTXGTwmyZApTo2UGTx1r1Kj4YbQXdKhdvNTKCgnGdzald8mR4pJLMKHq1wdoUhiXke3sa9x6WN51eX/uhsKTIU1ZfgcX1JFye3Nrht3SO/LpBmcVSG60Sq6aghP+oxB3GxdE4e4M15aHw+OnToPm1moV0P3ZH955yu3SHlkl/3BhiokRHcwEhvWtdpD4RIFlWqaTBhBrY0emUhhaP4zLlQiyYWaKBpKUGlO92g4mv7kAxrCUDNCpJwmG8bSR6Jzrno4Ytyl3KBRjCsxTSoiLRAXio1Q+okR48QoVIob8//RvOy+Ad4yiSa5BgAA"

local limsaRoute = "H4sIAAAAAAAACuWV20oDMRCGX0Xmeg2ZnLN3Ug8UrCeEesCLxUa64G6kmypS+u5Ou7vUFp/AzVUm+fmZ+chkVnBVVAFyuCyrpji6GEEG0+L7I5Z1aiB/XsFNbMpUxhryFTxAfuwUc4oLrzJ4hBwdM5wLLTJ4okuUzBtjpF1THOswPiWJ8BncFbNySYbIeAaT+BmqUCfIKRjXKSyK1zQt0/x6oz846/KjvJp5/OpvKCFyeyvem7CTb7PEDM6qmEJvlULVbU+2ii64XYYmdfuN8bQo085xE53HxSjWs6543h7el1WYkI6vsz/QSGa1RN2TEYjW2JaMcITNcuMHSUYRDK+FsFs0SjIplMXuzRAarawTe2TcUMgg01Yr7MF4Wn0vIUX8oJcGwoUz4QxyVOY3GKc7NNwyzp3zZphsnHbOCdmi4ZtSiYq1xEgN8rUYz9CjFQdAqH9QDvJb8dQvwluqtgUiaC61g8hq6hwl98fQv6Tysv4BPo+lD90IAAA="

local limsaShortRoute = "H4sIAAAAAAAACuWSzWoDIRSFXyXctYjOOOPorqR/gaZ/FCZt6UIaQ4SoJZqWMsy710mcBto3aF3dcz0cjh92cK2sBglXxgY1uVSb1eRiCgha9fnmjYsB5HMHtz6YaLwD2cECJOW4LqpG1AgeQTKCyXAYgieQvMK1ELTpk/JOz06TvWgQ3Kul2aU0igmCuX/XVrsIMomZi3qrXmNr4vpm8P/Y5YapVFj7j/EmtUlpK7UJ+mjfV6QIzqyPeoyK2ubxZO/I4m6nQ8zzENwqE4+Jgzr326l3y/xyclg+GKvnyUd69IsLLzFlhInqm8sBCcWiTuv/iESUWLCmKEciBa9KPn6UghFR/n0qL/0XIzi/0WcDAAA="

function GCTurnIn()
	yield("/deliveroo enable")
	yield("/wait 1")

	dellyroo = true
	dellyroo = DeliverooIsTurnInRunning()
	while dellyroo do
		yield("/wait 5")
		dellyroo = DeliverooIsTurnInRunning()
	end
end

function BackToEstate()
	yield("/wait 5")
	yield("/tp Estate Hall")
	yield("/wait 10")
	yield("/automove")
	yield("/wait 1")
	yield("/automove")
end

local chars = ARGetRegisteredEnabledCharacters()
for i = 0, chars.Count - 1 do
	yield("/ays relog " ..chars[i])
	yield("/wait 15")
	yield("/waitaddon NamePlate <maxwait.600> <wait.5>")
	TeleportToGCTown()
	yield("/wait 10")
	if GetPlayerGC() == 2 then
		yield("/visland exectemponce "..gridaniaRoute)
	elseif GetPlayerGC() == 1 then
		if useShortLimsaRoute then
			yield("/li aftcastle")
			yield("/wait 5")
			yield("/visland exectemponce "..limsaShortRoute)
		else
			yield("/visland exectemponce "..limsaRoute)
		end
	elseif GetPlayerGC() == 3 then
		yield("/visland exectemponce "..uldahRoute)
	end
	yield("/wait 3")
	while IsVislandRouteRunning() == true do
		yield("/wait 1")
	end
	GCTurnIn()
	BackToEstate()
end

yield("/ays multi")
yield("/pcraft stop")
