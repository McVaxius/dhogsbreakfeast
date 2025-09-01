yield("/fellowship")
yield("/wait 0.3")
yield("/callback CircleList true 3")
yield("/wait 0.3")
--fcSizeL = Addons.GetAddon("MultipleHelpWindow"):GetNode(1, 3, 2, 3, 4).Text
--yield("/echo adadf -> "..fcSizeL)

Addons.GetAddon("MultipleHelpWindow"):GetNode(1, 3, 2, 3, 4).Text = "Large Buttfucks\r\r\uE0BB\r\rThank you for choosing the large buttfucks script. now i can\r provide some text here up to 500 characters apparently\r before SND complains and breaks.\r\r OR. Perhaps maybe not. seems I can't PULL more than 500 \rchars but i can shove more if i want.\r\r Formatting for now seems impossible also."
Addons.GetAddon("MultipleHelpWindow"):GetNode(1, 2, 2, 2).Text = "Large Buttfucks - Help"
Addons.GetAddon("MultipleHelpWindow"):GetNode(1, 5, 2, 3).Text = "Large Buttfucks"

--this stuff doesnt work as-is
--"Fellowships are gatherings of players who share common interests. With up to 1,000 members permitted in each fellowship, they provide an excellent way to connect and socialize with like-minded adventurers."
--Anyone can create their own fellowship or become a member of another. Fellowships are cross-world, and you can belong to a maximum of ten at any given time.
--To search for fellowships that are currently recruiting, select H��I��SocialIH from the H��I��main 


--[[
HowTo
Addons.GetAddon("HowTo"):GetNode(1, 8, 9).Text
]]--