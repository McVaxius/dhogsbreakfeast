--purpose to update allgan tools with all your FC points from all of your FCs

--arrays so we can easily transfer between PC and configure for other lists of retainers
local chars_points = {
"name last@server",
"name last@server",
"name last@server",
"name last@server"
}

--total retainer abusers and starting the counter at 1
total_rcucks = 4
rcuck_count = 1


for _, char in ipairs(chars_points) do
	yield("/echo "..char)
	yield("/ays relog " ..char)
	yield("/wait 15")
	WaitForAddon("NamePlate", 600)
	 yield("/echo Processing Retainer Abuser FC points"..rcuck_count.."/"..total_rcucks)
	 rcuck_count = rcuck_count + 1
	yield("/wait 3")
	--yield("/autorun off")
	--Code for opening FC menu so allagan tools can pull the FC points
	yield("/freecompanycmd")
	yield("/wait 3")
--Then you need to /pyes the "Execute"
 end
yield("/wait 3")
--last one out turn off the lights
yield("/ays multi")
yield("/pcraft stop all")