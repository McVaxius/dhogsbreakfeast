--[[

  ***************
  * Description *
  ***************

  Teleports you to Idyllshire (or if you're standing in front of an aetheryte) and takes you to the Alex Vendor to trade your raid pieces -> gear,
  which then takes you to your personal Grand Company and turns them into what you have selected from Deliveroo.

  If you have OTP on, and you have your company aetheryte tickets, you can do this loop for free wihtout costing you any gil.

  *********************
  *  Required Plugins *
  *********************

  -> Teleporter | 1st Party Plugin
  -> Pandora (Enable "Auto-select Turn-ins & Automatically Confirm") | 
  -> Lifestream 
  -> Deliveroo [If you need the link, here --> https://plugins.carvel.li/]
  -> vnavmesh (replaced visland)

  -> YesAlready

  **************
  *  IMPORTANT *
  *   SETTING  *
  **************

  -> YesAlready -> Yes/No -> Add this:  You cannot currently equip this item. Proceed with the transaction?
  Yes, you can zone lock this to strictly Idyllshire if you would like (I did)

  -> YesAlready -> Bothers -> Scroll near the VERY bottom and make sure "ShopExchangeItemDialog" is checkmarked

  Version: 3.2 Inventory Buying Fix
]]

--[[

  **************
  *  Settings  *
  **************

]]
--[[!! If you're shop is skipping buying items, increase this value. 
Default is 1 cause that's worked for me, but 5 has helped others as well]]
Alex_Shop_Timer = 1

-- If you would like it to buy the max amount of items that it can on each run
-- DO NOTE. This will buy multiple "unique" items to turn in to the GC
-- No, you can't equip them, it's just meant to speed up the spending/buying process
-- It's off by default, so nobody freak out
MaxInventory = false


--[[

  ************
  *  Script  *
  *   Start  *
  ************

]]

::Functions::

  function TeleportTest()
    while GetCharacterCondition(27) do 
      yield("/wait 1") 
    end
    yield("/wait 1")
    while GetCharacterCondition(45) or GetCharacterCondition(51) do 
      yield("/wait 3") 
    end
  end

  function AetheryteTeleport()
    while GetCharacterCondition(32) do
     yield("/wait 1")
    end
    yield("/wait 1")
    while GetCharacterCondition(45) or GetCharacterCondition(51) do
     yield("/wait 1") 
    end
  end

  function DistanceToVendor()
    if IsInZone(478) then -- Idyllshire
      Distance_Test = GetDistanceToPoint(-19.277, 211, -36.076)
    elseif IsInZone(132) then -- Gridania
      Distance_Test = GetDistanceToPoint(-67.769, -0.501, -8.502)
    elseif IsInZone(128) then -- Limsa Upper
      Distance_Test = GetDistanceToPoint(93.219, 40.275, 75.265)
    elseif IsInZone(130) then -- Ul' dah
      Distance_Test = GetDistanceToPoint(-142.361, 4.1, -106.919)
    end
  end

--tarnished gordian item ids, hardcoded.
  LensID = 12674
  ShaftID = 12675
  CrankID = 12676
  SpringID = 12677
  PedalID = 12678
  BoltID = 12680
  LimsaTicketID = 21069
  GridaniaTicketID = 21070
  UldahTicketID = 21071

  --initialize item counts
  LensCount = GetItemCount(LensID)
  ShaftCount = GetItemCount(ShaftID)
  CrankCount = GetItemCount(CrankID)
  SpringCount = GetItemCount(SpringID)
  PedalCount = GetItemCount(PedalID)
  BoltCount = GetItemCount(BoltID)
  LimsaGCTicket = GetItemCount(LimsaTicketID)
  GridaniaGCTicket = GetItemCount(GridaniaTicketID)
  UldahGCTicket = GetItemCount(UldahTicketID)

::IdyllshireTurnin::

  while IsInZone(478) == false and GetCharacterCondition(27) == false do
    yield("/tp Idyllshire")
    yield("/wait 1.0")
  end

  TeleportTest()

  if IsInZone(478) == false and GetCharacterCondition(27) == false then
    yield("/echo Hmm.... either you moved, or the teleport failed, lets try that again")
    yield("/wait 1")
    goto IdyllshireTurnin
  end

  if IsInZone(478) then
  
    DistanceToVendor()
    if Distance_Test > 1 then
      if GetCharacterCondition(4) == false then
        yield('/gaction "Mount Roulette"')
         yield("/wait 3")
      end
      yield("/vnavmesh moveto -19.277 211 -36.076")
    end
  end

::SabinaTest::

  DistanceToVendor()

  while Distance_Test > 1 do
    yield ("/wait 0.5")
    DistanceToVendor()
  end

  yield("/ac dismount")
  yield("/wait 2")
  yield("/target Sabina")
  yield("/wait 0.35")
  yield("/pint Sabina")
  yield("/wait 1.0")
  yield("/pcall SelectIconString True 0")
  yield("/wait 1.0")
  yield("/pcall SelectString True 0")
  yield("/wait 1.0")
  yield("/pcall SelectString True 0")
  yield("/wait 1.0")

  Shop_Menu = 1
  Gordian_Part = 1

::ShopInitialize::
  i_count = GetInventoryFreeSlotCount()
  -- In order it goes | Shop | Shaft 1/2 | Crank 1/2 | Spring 1/2 | Pedal 1/2 | Bolt 1/2 | Stop
  if Shop_Menu == 1 then
  Shop1Array = {3, 3, 5, 6, 8, 9, 11, 12, 14, 15, 22, 23}
  Alex_Shop = 3
  Alex_Shaft1 = 3
  Alex_Shaft2 = 5
  Alex_Crank1 = 6
  Alex_Crank2 = 8
  Alex_Spring1 = 9
  Alex_Spring2 = 11
  Alex_Pedal1 = 12
  Alex_Pedal2 = 14
  Alex_Bolt1 = 15
  Alex_Bolt2 = 22
  Alex_Stop = 23
  elseif Shop_Menu == 2 then
    Gordian_Part = 1
    Alex_Shop = 2
    Alex_Shaft1 = 2
    Alex_Shaft2 = 3
    Alex_Crank1 = 4
    Alex_Crank2 = 5
    Alex_Spring1 = 6
    Alex_Spring2 = 7
    Alex_Pedal1 = 8
    Alex_Pedal2 = 9
    Alex_Bolt1 = 10
    Alex_Bolt2 = 13
    Alex_Stop = 14
  elseif Shop_Menu == 3 then
    Gordian_Part = 1
    Alex_Shop = 2
    Alex_Shaft1 = 2
    Alex_Shaft2 = 3
    Alex_Crank1 = 4
    Alex_Crank2 = 5
    Alex_Spring1 = 6
    Alex_Spring2 = 7
    Alex_Pedal1 = 8
    Alex_Pedal2 = 9
    Alex_Bolt1 = 10
    Alex_Bolt2 = 17
    Alex_Stop = 18
  end

::BuyingItems::
  -- this is moreso a footnote to myself. The Gordian_Part == 1 is to break the sequence after it gets done w/ the shop ENTIRELY.
  while (Alex_Shop < Alex_Stop) do
  
    ShaftCount = GetItemCount(ShaftID) -- 4
    CrankCount = GetItemCount(CrankID) -- 2 
    SpringCount = GetItemCount(SpringID) -- 4
    PedalCount = GetItemCount(PedalID) -- 2 
    BoltCount = GetItemCount(BoltID) -- 1
  
    i_count = GetInventoryFreeSlotCount()
  
    if i_count == 0 then
      Alex_Shop = Alex_Stop
  -- Shaft Section
    elseif (ShaftCount <=3 and Alex_Shop >= Alex_Shaft1 and Alex_Shop <= Alex_Shaft2) then
      Alex_Shop = Alex_Crank1
      -- yield("/echo Shaft Count: "..ShaftCount)
      -- yield("/echo Should be moving to next menu")
      -- yield("/echo Shop Menu: "..Alex_Shop)
    elseif (ShaftCount >= 4 ) and (Alex_Shop >= Alex_Shaft1 and Alex_Shop <= Alex_Shaft2) then
      yield("/pcall ShopExchangeItem True 0 "..Alex_Shop.." 1")
      Alex_Shop = Alex_Shop + 1
      --yield("/echo Shop Menu: "..Alex_Shop) -- Just Debugging Stuff
      yield("/wait "..Alex_Shop_Timer)
      i_count = GetInventoryFreeSlotCount()
      if Shop_Menu == 3 and MaxInventory == true and Alex_Shop == Alex_Shaft2 then
         ShaftCount = GetItemCount(ShaftID)
		 if i_count > math.floor(ShaftCount/4) then
           i_count = math.floor(ShaftCount/4)
         end
		 yield("/e Shaft Send Amount = "..i_count)
         yield("/pcall ShopExchangeItem True 0 "..Alex_Shop.." "..i_count)
         yield("/wait "..Alex_Shop_Timer)
         Alex_Shop = Alex_Shop + 1
         yield("/wait "..Alex_Shop_Timer)
         ShaftCount = GetItemCount(ShaftID)
         i_count = GetInventoryFreeSlotCount()
      end

  -- Crank Section
    elseif (CrankCount <=1) and (Alex_Shop >= Alex_Crank1 and Alex_Shop <= Alex_Crank2) then
      Alex_Shop = Alex_Spring1
      -- yield("/echo Crank Count: "..CrankCount)
      -- yield("/echo Should be moving to Shaft"
    elseif (CrankCount >= 2) and (Alex_Shop >= Alex_Crank1 and Alex_Shop <= Alex_Crank2) then
      yield("/pcall ShopExchangeItem True 0 "..Alex_Shop.." 1")
      Alex_Shop = Alex_Shop + 1
      --yield("/echo Shop Menu: "..Alex_Shop)
      yield("/wait "..Alex_Shop_Timer)
      i_count = GetInventoryFreeSlotCount()
      if Shop_Menu == 3 and MaxInventory == true and Alex_Shop == Alex_Crank2 and (ShaftCount <= 3) then
         CrankCount = GetItemCount(CrankID)
		 if i_count > math.floor(CrankCount/2) then
           i_count = math.floor(CrankCount/2)
         end
		 yield("/e Crank Send Amount = "..i_count)
         yield("/pcall ShopExchangeItem True 0 "..Alex_Shop.." "..i_count)
         yield("/wait "..Alex_Shop_Timer)
         Alex_Shop = Alex_Shop + 1
         yield("/wait "..Alex_Shop_Timer)
         CrankCount = GetItemCount(CrankID)
         i_count = GetInventoryFreeSlotCount()
      end

  -- Springs Section
     elseif (SpringCount <=3) and (Alex_Shop >= Alex_Spring1 and Alex_Shop <= Alex_Spring2) then
       Alex_Shop = Alex_Pedal1
       -- yield("/echo Spring Count: "..SpringCount)
       -- yield("/echo Should be moving to Crank")
     elseif (SpringCount >=4) and (Alex_Shop >= Alex_Spring1 and Alex_Shop <= Alex_Spring2) then
       yield("/pcall ShopExchangeItem True 0 "..Alex_Shop.." 1")
       Alex_Shop = Alex_Shop + 1
       --yield("/echo Shop Menu: "..Alex_Shop)
       yield("/wait "..Alex_Shop_Timer)
       i_count = GetInventoryFreeSlotCount()
      if Shop_Menu == 3 and MaxInventory == true and Alex_Shop == Alex_Spring2 and (ShaftCount <= 3 and CrankCount <=1) then
         SpringCount = GetItemCount(SpringID)
		 if i_count > math.floor(SpringCount/4) then
           i_count = math.floor(SpringCount/4)
         end
         yield("/e Spring Send Amount = "..i_count)
         yield("/pcall ShopExchangeItem True 0 "..Alex_Shop.." "..i_count)
         yield("/wait "..Alex_Shop_Timer)
         Alex_Shop = Alex_Shop + 1
         yield("/wait "..Alex_Shop_Timer)
         SpringCount = GetItemCount(SpringID)
         i_count = GetInventoryFreeSlotCount()
      end
  
  -- Pedal Check Section
     elseif (PedalCount <= 1) and (Alex_Shop >= Alex_Pedal1 and Alex_Shop <= Alex_Pedal2) then
       Alex_Shop = Alex_Bolt1
       -- yield("/echo Pedal Count: "..PedalCount)
        -- yield("/echo Should be moving to Springs")
       yield("/wait 0.2")
     elseif (PedalCount >= 2) and (Alex_Shop >= Alex_Pedal1 and Alex_Shop <= Alex_Pedal2) then
       yield("/pcall ShopExchangeItem True 0 "..Alex_Shop.." 1")
       Alex_Shop = Alex_Shop + 1
       --yield("/echo Shop Menu: "..Alex_Shop)
       yield("/wait "..Alex_Shop_Timer)
       i_count = GetInventoryFreeSlotCount()
      if Shop_Menu == 3 and MaxInventory == true and Alex_Shop == Alex_Pedal2 and (ShaftCount <= 3 and CrankCount <=1 and SpringCount <= 3) then
         PedalCount = GetItemCount(PedalID)
		 if i_count > math.floor(PedalCount/2) then
           i_count = math.floor(PedalCount/2)
         end
		 yield("/e Pedal Send Amount = "..i_count)
         yield("/pcall ShopExchangeItem True 0 "..Alex_Shop.." "..i_count)
         yield("/wait "..Alex_Shop_Timer)
         Alex_Shop = Alex_Shop + 1
         yield("/wait "..Alex_Shop_Timer)
         PedalCount = GetItemCount(PedalID)
         i_count = GetInventoryFreeSlotCount()
      end
      
  -- Bolt Section
    -- If no bolts, then it stops
    elseif (BoltCount == 0) and (Alex_Shop >= Alex_Bolt1 and Alex_Shop <= Alex_Bolt2) then
      Alex_Shop = Alex_Stop
      -- yield("/echo Bolt Count: "..BoltCount)
      -- yield("/echo Should be moving to Pedals")
    elseif (BoltCount >= 1) and (Alex_Shop >= Alex_Bolt1 and Alex_Shop <= Alex_Bolt2) then
      yield("/pcall ShopExchangeItem True 0 "..Alex_Shop.." 1")
      Alex_Shop = Alex_Shop + 1
      --yield("/echo Shop Menu: "..Alex_Shop)
      yield("/wait "..Alex_Shop_Timer)
      i_count = GetInventoryFreeSlotCount()
      if Shop_Menu == 3 and MaxInventory == true and Alex_Shop == Alex_Bolt2 and (ShaftCount <= 3 and CrankCount <=1 and SpringCount <= 3 and PedalCount <= 1) then
         BoltCount = GetItemCount(BoltID)
		 if i_count > BoltCount then
           i_count = BoltCount
         end
		 yield("/e Bolt Send Amount = "..i_count)
         yield("/pcall ShopExchangeItem True 0 "..Alex_Shop.." "..i_count)
         yield("/wait "..Alex_Shop_Timer)
         Alex_Shop = Alex_Shop + 1
         yield("/wait "..Alex_Shop_Timer)
         BoltCount = GetItemCount(BoltID)
      end
    end
  end
	  
  -- Time to swap menu's  
    if (Alex_Shop == Alex_Stop) and (Shop_Menu == 1) then
      -- yield("/echo DOW 1 Menu is completed")

      Shop_Menu = (Shop_Menu + 1)

      -- yield("/echo Shop Menu is Currently: "..Shop_Menu)

      yield("/pcall ShopExchangeItem True -1")
      yield("/wait 1")
      yield("/pcall SelectString True 1")
      yield("/wait 1.5")

      goto ShopInitialize

    elseif (Alex_Shop == Alex_Stop) and (Shop_Menu == 2) then
      -- yield("/echo DOW 2 Menu is completed")
    
      Shop_Menu = (Shop_Menu + 1)

      -- yield("/echo Shop Menu is Currently: "..Shop_Menu)

      yield("/pcall ShopExchangeItem True -1")
      yield("/wait 1")
      yield("/pcall SelectString True 2")
      yield("/wait 1.5")

      goto ShopInitialize

    elseif (Alex_Shop == Alex_Stop and Shop_Menu == 3) then
      --yield("/echo DOM Menu is completed")

      Gordian_Part = Gordian_Part + 1
      Shop_Menu = (Shop_Menu + 1)

      --yield("/echo Shop Menu is Currently: "..Shop_Menu)

      yield("/pcall ShopExchangeItem True -1")
      yield("/wait 1")
      yield("/pcall SelectString True 7")
      yield("/wait 1.5")
    end


::TicketsPlease::
  LimsaGCTicket = GetItemCount(LimsaTicketID)
  GridaniaGCTicket = GetItemCount(GridaniaTicketID)
  UldahGCTicket = GetItemCount(UldahTicketID)

::GrandCompanyTurnin::

  if (LimsaGCTicket >= 1) then 
    yield("/item Maelstrom aetheryte ticket")
    yield("/wait 1.0")
  elseif (GridaniaGCTicket >= 1) then
    yield("/item Twin Adder aetheryte ticket")
    yield("/wait 1.0")
  elseif (UldahGCTicket >= 1) then
    yield("/item Immortal Flames aetheryte ticket")
    yield("/wait 1.0")
  elseif (LimsaGCTicket == 0) or (GridaniaGCTicket == 0) or (UldahGCTicket == 0) then
    TeleportToGCTown()
    yield("/wait 1.0")
  end


  TeleportTest()

  if IsInZone(478) == true and GetCharacterCondition(27) == false then
    yield("/echo Hmm.... either you moved, or the teleport failed, lets try that again")
    yield("/wait 1")
    goto GrandCompanyTurnin
  end

::GrandCompanyCheck::
  if (LimsaGCTicket >= 1) then 
    goto LimsaAetheryteTicket
  elseif (GridaniaGCTicket >= 1) then
    goto GridaniaAetheryteTicket
  elseif (UldahGCTicket >= 1) then
    goto UldahAetheryteTicket
  elseif IsInZone(129) and (LimsaGCTicket == 0) then -- Limsa's GC
    goto LimsaLower
  elseif IsInZone(130) and (GridaniaGCTicket == 0) then -- Ul'dah's GC
    goto Uldah
  elseif IsInZone(132) and (UldahGCTicket == 0) then -- Grdiania's GC
    goto Gridania
  end

::LimsaLower::
  if IsInZone(129) then -- Limsa's Lower, moving to the upper to get to the GC
    yield("/target Aetheryte")
    yield("/lockon")
    yield("/automove")
    yield("/wait 1.0")
    yield("/automove")
    yield("/li The Aftcastle")
    yield("/wait 1")
      while GetCharacterCondition(32) do
        yield("/wait 1")
      end
      while GetCharacterCondition(45) or GetCharacterCondition(51) do
        yield("/wait 1") 
      end
  end

  if IsInZone(128) then -- Limsa Upper
    yield("/vnavmesh moveto 93.9 40.175 75.409")
    yield("/wait 0.5")
    goto WalkingtoGC
  end

::Uldah::
  if IsInZone(130) then
    DistanceToVendor()
    yield("/vnavmesh moveto -142.361 4.1 -106.919")
    yield("/wait 0.5")
    goto WalkingtoGC
  end

::Gridania::
  if IsInZone(132) then
    yield("/vnavmesh moveto -67.757 -0.501 -8.393")
    yield("/wait 0.5")
    goto WalkingtoGC
  end

::LimsaAetheryteTicket::
  if IsInZone(128) then -- Limsa Upper
    yield("/vnavmesh moveto 93.9 40.175 75.409")
    yield("/wait 0.5")
    goto WalkingtoGC
  end

::GridaniaAetheryteTicket::
  if IsInZone(132) then
    yield("/vnavmesh moveto -67.757 -0.501 -8.393")
    yield("/wait 0.5")
    goto WalkingtoGC
  end

::UldahAetheryteTicket::
  if IsInZone(130) then
    yield("/vnavmesh moveto -142.361 4.1 -106.919")
    yield("/wait 0.5")
    goto WalkingtoGC
  end

::WalkingtoGC::
  DistanceToVendor()

  while Distance_Test > 1 do
    yield ("/wait 0.5")
    DistanceToVendor()
  end

::GCTurnin::
  yield("/deliveroo enable")
  yield("/wait 0.5")

  while DeliverooIsTurnInRunning() do
    yield("/wait 1")
  end

::InventoryCheck::

  ShaftCount = GetItemCount(ShaftID) -- 4
  CrankCount = GetItemCount(CrankID) -- 2 
  SpringCount = GetItemCount(SpringID) -- 4
  PedalCount = GetItemCount(PedalID) -- 2 
  BoltCount = GetItemCount(BoltID) -- 1

  if (ShaftCount <= 3 and CrankCount <= 1 and SpringCount <=3 and PedalCount <=1 and BoltCount == 0) then
  yield("/visland stop")
  goto StoppingScript
  elseif (ShaftCount >= 4 or CrankCount >= 2 or SpringCount >= 4 or PedalCount >= 2 or BoltCount >= 1) then
  yield("/visland stop")
  goto IdyllshireTurnin
end

::StoppingScript::
yield("/echo Turnins have finished, thanks for using")