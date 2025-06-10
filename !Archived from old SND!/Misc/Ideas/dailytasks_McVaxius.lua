--[[
2024-08-10
small update. SND can now run scripts after AR so we can do this even easier than ever.

What is this ?
A vague idea for now.... of a kind of manager script that does various things based on certain rules, continually so you can just fire and forget it.
*you fire up the script and hope it doesnt fail and sit there idle somewhere with a LUA error :(
*it will return chars safely home to bell/fc entrance and resume autoretainer in between activities
*maybe this would be better as a plugin not as a script.

******************************
Stuff I think is possible now
******************************
*check for certain FC buffs every 12 hours with a specific set of array of chars (in case you are managing multiple active FC)
*run cuff-a-cur for x hours a day at a specific time y on specific char with a base64 visland route to get to the machine inside of a fc room, aprtment, house or fc house
*run HOH intuition farm for x hours a day on a specific char
*run fishing every 2 hours on a rotating list of chars
*visit + enter personal house every 5 days at specific time y for list of characters

************************************************************
I'm not sure if its possible or needs some slash commands?
************************************************************
*run TT for x hours a day or x matches a day at a specific time y on a specific char
		*confirmed possible
*attempts to buys 5 stack of fuel @ any FC that is below x value. checks every 12 hours
		*confirmed possible

****************************************************************************************************
Stuff that would be nice but technically annoying to do since we need more stuff for it to "happen"
****************************************************************************************************
*visit the personal island once a week and somehow do the island stuff and then leave
*play mini cactpot daily on a list of chars at y time
*play jumbo cactpot weekly on a list of chars at y time
*play (lose on purpose) verminion x5  weekly on a list of chars at y time
]]