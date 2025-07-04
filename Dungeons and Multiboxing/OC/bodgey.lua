--extremely complex BOCHI helper script to assist passing over obstacles

dodgey_bodger = true

while dodgey_bodger do
	yield("/wait 5")
	if Svc.Condition[4] == true or Svc.Condition[10] == true then
		yield("/gaction jump")
		--yield("/echo wheeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee . i am jumping !!!!!!!!!!!!!.")
	end
end