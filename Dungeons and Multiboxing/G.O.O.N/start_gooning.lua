--[[
***********************************************************************************************************************************************
***this should be in the (Automaton) enhance duty/start end as /pcraft run start_gooning, obviously make the script in SND for this to work.***
***********************************************************************************************************************************************

in SND make a script called start_gooning
past this into it
click the lua button
set this to run when entering a duty in automaton enhanced duty start/end
type this or copy paste it into there:

/pcraft run start_gooning

--]]

yield("/wait 1")

--loop wait for is char ready 
while IsPlayerAvailable() == false do
	yield("/echo waiting on player")
	yield("/wait 1")
end

yield("/ad stop")

yield("/wait 1")
yield("/hold W <wait.1.0>")
yield("/release W")

--yield("/echo ad start")
yield("/ad start")
yield("/vbm ai cfg on")
yield("/bmrai on")
yield("/rotation auto")
--yield("/echo let's start gooning!")