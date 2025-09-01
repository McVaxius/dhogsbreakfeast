yield("/fellowship")
yield("/wait 0.3")
yield("/callback CircleList true 3")
yield("/wait 0.3")
--fcSizeL = Addons.GetAddon("MultipleHelpWindow"):GetNode(1, 3, 2, 3, 4).Text
--yield("/echo adadf -> "..fcSizeL)

Addons.GetAddon("MultipleHelpWindow"):GetNode(1, 3, 2, 3, 4).Text = "Large Buttfucks\r\rThank you for choosing the large buttfucks script. now i can\r provide some text here up to 500 characters apparently\r before SND complains and breaks.\r\r or perhaps maybe not. seems I can't PULL more than 500 \rchars but i can shove more if i want."
Addons.GetAddon("MultipleHelpWindow"):GetNode(1, 2, 2, 2).Text = "Large Buttfucks - Help"
Addons.GetAddon("MultipleHelpWindow"):GetNode(1, 5, 2, 3).Text = "Large Buttfucks"
