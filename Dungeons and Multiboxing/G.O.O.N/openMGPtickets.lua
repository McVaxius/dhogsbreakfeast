require("dfunc")

yield ("/echo Opening MGP tickets until we have ~ 9.9M")

dMGP = 0
mMGP = 9900000

if type(GetItemCount(16784)) == "number" then
	while GetItemCount(16784) > 0 and GetItemCount(29) < mMGP and (Svc.Condition[34] == false or Svc.Condition[26] == false) do
		Inventory.GetInventoryItem(tonumber(16784)):Use()
		xMGP = GetItemCount(29)
		if dMGP < xMGP then 
			yield("/echo Current MGP -> "..xMGP)
			dMGP = xMGP
		end
		yield("/wait 0.5")
	end
end

yield("/echo Current MGP -> "..GetItemCount(29))
