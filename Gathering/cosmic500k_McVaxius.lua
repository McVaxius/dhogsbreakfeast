--[[
cycle between jobs to get 500k while afk in cosmic using ice cosmic.

requires icecosmic, simpletweaks job change, artisan, etc
--]]

cosmic = "shit content"
shit_content = 0 --counter

--pick the jobs you want it to cycle through. don't include the current job. only start with the "next" one you want it to do.

took_my_job =
{
"CRP",
"BSM",
"ARM",
"GSM",
"LTW",
"WVR",
"ALC",
"CUL"
}

dook_muh_jorb = 0

while cosmic == "shit content" do
	yield("/wait 5")
	yield("/echo waiting ..... still crafting or searching")
	if Svc.Condition[1] == false then shit_content = 0 end
	if Svc.Condition[1] == true then
		shit_content = shit_content + 1
		yield("/echo waiting ....."..shit_content.."/10 ticks")
	end
	if shit_content > 10 then -- 50 seconds should be long enough that we aren't still cycling missions.
		dook_muh_jorb = dook_muh_jorb + 1
		shit_content = 0
		yield("/echo swapping to ---> "..took_my_job[dook_muh_jorb])
		yield("/equipjob "..took_my_job[dook_muh_jorb])
		yield("/wait 5")
		yield("/ice start")
	end
end