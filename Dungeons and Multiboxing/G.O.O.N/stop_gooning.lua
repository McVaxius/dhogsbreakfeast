--[[
just easier way to cleanup shit and turn off gooning for personal use.

/snd run stop_gooning

--]]

yield("/ad stop")
yield("/bmrai off")
yield("/rotation cancel")
yield("/bmrai followtarget off")
if IPC.Automaton.IsTweakEnabled("AutoQueue") == true then IPC.Automaton.SetTweakState("AutoQueue", false) end
if IPC.Automaton.IsTweakEnabled("EnhancedDutyStartEnd") == true then IPC.Automaton.SetTweakState("EnhancedDutyStartEnd", false) end
Instances.DutyFinder.IsUnrestrictedParty = false
Instances.DutyFinder.IsLevelSync = false
yield("/echo Let's clean up")
yield("/snd stop all")