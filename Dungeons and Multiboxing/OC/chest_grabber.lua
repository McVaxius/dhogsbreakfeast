--passing by a chest? grab it.

require("dfunc")

grabbyhands = 1
sidechest = 0

nemm = {
	"Bronze Treasure Coffer",
	"Silver Treasure Coffer",
	"Gold Treasure Coffer"
}

while grabbyhands == 1 do
	if GetCharacterCondition(26) == false then
		for i=1,#nemm do
			sidechest = mydistto(GetObjectRawXPos(nemm[i]),GetObjectRawYPos(nemm[i]),GetObjectRawZPos(nemm[i]))
			if sidechest > 0 and sidechest < 10 then
				yield("/vnavmesh moveto "..GetObjectRawXPos(nemm[i]).." "..GetObjectRawYPos(nemm[i]).." "..GetObjectRawZPos(nemm[i]))
				yield("/target \""..nemm[i].."\"")
				if sidechest < 2 then
					yield("/interact")
				end
			end
		end
	end
	yield("/wait 2")
end