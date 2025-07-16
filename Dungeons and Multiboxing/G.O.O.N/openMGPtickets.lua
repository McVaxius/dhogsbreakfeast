require("dfunc")

if type(GetItemCount(16784)) == "number" then
	while GetItemCount(16784) > 0 and (Svc.Condition[34] == false or Svc.Condition[26] == false) do
		Inventory.GetInventoryItem(tonumber(16784)):Use()
		yield("/wait 0.5")
	end
end