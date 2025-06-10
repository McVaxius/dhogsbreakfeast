--[[
  Description: while keeping companion window open and on skil tab itwill auto buy from the healer path.
    change the 14 2 to 14 1 for tank and 14 3 for dps
  Author: McVaxius
  Link: https://discord.com/channels/1162031769403543643/1162799234874093661/1184682700309803100
]]

--conditions 26 + 34 is when we will try to buy chocobo skills  "combat and bound by duty"
--also no cutscenes (cond 35) should be running

--we will use a 15 second loop as we aren't in any rush to spam buy these skills. we can even make it a 30 or 60 second check....
--also we should probably limit the buying attempts for level 30 to 50
while GetLevel() < 51 do
    yield("/echo 15 second wait - "..GetCharacterName().." is stil under level 51 so we keep going")
    yield("/wait 15")
    yield("/discardall")
    if GetLevel() > 25 then
        if GetCharacterCondition(26)==true then
            if GetCharacterCondition(34)==true then
                if GetCharacterCondition(35)==false then
                    yield("/echo Attempt to buy chocobro skills")
                    --insert callbacks here
                    --open menu?
                    --browse to buy tab?
                    yield("/callback BuddySkill false 14 2 0")
                    yield("/callback Buddy false 14 2 0")
                end
            end
        end
    end
end