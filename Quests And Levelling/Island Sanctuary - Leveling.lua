--[[
Version: 1.85.2 [Properly returning to base update, and resuming routes]
Author: LegendofIceman
This is a small version of the "Gathering Everything" script I'm working on, just meant to be a quick way of leveling up

Note: This does require flying atm, I'll work on making a non-flying verison in a bit. (When I get a second or need a breather from the other script lol.)
Requirements:
-> Visland (V)ery Island
]]

-- Settings
  ItemMax = 999
  ItemCountEcho = true
  LoopEcho = true
  ContinueLooping = true

-- If you are currently running the workshop and you have items being used in it, make sure to add the amount you're using in the shops here
  QuartzWorkShop = 0 
  IronWorkShop = 0 
  LeucograniteWorkShop = 0
  StoneWorkShop = 0
  QuartzArrayWorkShop = StoneWorkShop + IronWorkShop + QuartzWorkShop + LeucograniteWorkShop

  -- Array for the Route
  -- XP Route || Quarts | Iron | Durium Sand | Leucogranite
  QuartzArray = {6, 3, 2, 11}

-- Loop amount checker
  if QuartzArrayWorkShop == 0 then
    XPLoopAmount = 166
  end  

  if QuartzArrayWorkShop > 0 then
    XPLoopAmount = 166
    LoopTestA = 0
    LoopTestB = 0
    LoopTestC = 0
    if QuartzWorkShop > 0 then
      LoopTestA = math.ceil(QuartzWorkShop/QuartzArray[1])
    end
    if IronWorkShop > 0 then
      LoopTestB = math.ceil(IronWorkShop/QuartzArray[2])
    end
    if LeucograniteWorkShop > 0 then
      LoopTestC = math.ceil(LeucograniteWorkShop/QuartzArray[3])
    end
    
    HighestAmount = math.max(LoopTestA, LoopTestB, LoopTestC)
    XPLoopAmount = XPLoopAmount - HighestAmount
  end
   
  yield("/echo LoopAmount = "..XPLoopAmount)

-- Visland Routes for the script
  B2Quartz = "H4sIAAAAAAAACuVS20rEMBD9lWWe25A0aZvmQfAKfVh1RagXfAhuZAM2kSZVtPTfTdssK/gH+jZn5nDmzGEGuJStAgEn0qlVerTa9LLzX5BAIz/frDbegXgc4No67bU1IAa4A5GSMkeMlhVN4B4EwQRRTlgCDwEUGBFasXwM0BpVn4HACdzIre6DGEEBrO27apXxASZQG686+ewb7XdXkf2zFx0GT25nP/aTYCaovchXpw702WGQPG+t3y+uvWpjeTwzItj0yvlYT8KN1P6gOKEL251as42H46V5q1u1Djw8Jr9ioZQhxrN8DoVWJcowLeZQUspzxDFh/B+mkofrKlosv0IrjkrKC77kwqbXKbPiz+fyNH4DG0XUEmwDAAA="
  VQuartz = "H4sIAAAAAAAACu2WXW/TMBSG/0rk62D8bZ/cIT6kSgw2hNTBtIvQejRqE5fEBUHV/z6ns5MhddpVJSp65xOfnJw8On79btGHsraoQIzg7Ob6Mnvv3Po2u9qUrf/zctK6BuVoWv5eu6rxHSputujSdZWvwkaxRdeo4EJjwyTL0ZcQgMCUAc/RV1S84KAwMMV3IXSNnbxBBcnRp3JebUIphkNw4X7a2jZ+vzNpvG3LmZ9WfvGxz2YkFDPy753YcOs23xfZt1U5W2atmy1Dn93C/UqZocHwjbty1dnx9X3XNEdva+dTOxNv67h8tc+IwdXGdj6u+8LTsvJjxT5659rXrplHGOTh4eeqthchj+zyA6gU1proARWjSj+gEoRgEXgdBVW3trPlys5PhxNgDZyOM8UZ0WIkpaQ08jAqgpl8jhU5SOkkwDBsCEsDxDEQQxMWjRnXcJQB+rGXg+zOtXW5b+cUUAE23AwTJCVjiZQMGiXNmVQkJRlmeiRFQAyiZAJDRc/6nUgpLLmEARVw9ggV8Cc06T88fRJw/0sDKaMUJFIiXIL0LFQJlaKYEiUGTdcG4lBxACwJF+fzl6bKBHXqb7yIyug0VRyCC1XkOFbz5PyTlJgTLUefqUR0TxwkBn2WqQSKYm7YI1LUJJ/JwQR/LtUTsPjzI3W6NlMGxw09iEglSFK0mb0kGSGPc87++YvudncPgcau5jAPAAA="

-- Node Functions
  function QuartzNode()
    QuartzID = 37573
    QuartzCount = GetItemCount(QuartzID)
  end

  function Iron_DuriumNode()
    IronID = 37572
    DuriumID = 41630
    IronCount = GetItemCount(IronID)
    DuriumCount = GetItemCount(DuriumID)
  end

  function LeucograniteNode()
    LeucograniteID = 37574
    LeucograniteCount = GetItemCount(LeucograniteID)
  end

  -- These are Items that are shared across multiple nodes

  function StoneNode()
    StoneID = 37554
    StoneCount = GetItemCount(StoneID)
  end

-- Item Count Check/Shop Amount Check
  function StoneShop()
    StoneAmount = ItemMax-(ItemAmount*LoopAmount)
    if StoneAmount < 0 then 
      StoneAmount = 0
    end
    if StoneWorkShop > 0 then
      StoneAmount = StoneAmount + StoneWorkShop
    end
    StoneSend = (StoneCount-StoneAmount)
  end

  function IronShop()
    IronAmount = ItemMax-(ItemAmount*LoopAmount)
    if IronWorkShop > 0 then
      IronAmount = IronAmount + IronWorkShop
    end
    IronSend = (IronCount-IronAmount)
  end

  function QuartzShop()
    QuartzAmount = ItemMax-(ItemAmount*LoopAmount)
    if QuartzWorkShop > 0 then
      QuartzAmount = QuartzAmount + QuartzWorkShop
    end
    QuartzSend = (QuartzCount-QuartzAmount)
  end

  function LeucograniteShop()
    LeucograniteAmount = ItemMax-(ItemAmount*LoopAmount)
    if LeucograniteWorkShop > 0 then
      LeucograniteAmount = LeucograniteAmount + LeucograniteWorkShop
    end
    LeucograniteSend = (LeucograniteCount-LeucograniteAmount)
  end

-- Shop Selling Functions

  function StoneSell()
    yield("/pcall MJIDisposeShop True 12 2 <wait.0.5>")
    yield("/pcall MJIDisposeShopShipping True 11 "..StoneSend)
    yield("/pcall SelectYesno True 0")
    yield("/wait 1.5")
  end

  function IronSell()
    yield("/pcall MJIDisposeShop True 12 24 <wait.0.5>")
    yield("/pcall MJIDisposeShopShipping True 11 "..IronSend)
    yield("/pcall SelectYesno True 0")
    yield("/wait 1.5")
  end

  function QuartzSell()
    yield("/pcall MJIDisposeShop True 12 25 <wait.0.5>")
    yield("/pcall MJIDisposeShopShipping True 11 "..QuartzSend)
    yield("/pcall SelectYesno True 0")
    yield("/wait 1.5")
  end

  function LeucograniteSell()
    yield("/pcall MJIDisposeShop True 12 26 <wait.0.5>")
    yield("/pcall MJIDisposeShopShipping True 11 "..LeucograniteSend)
    yield("/pcall SelectYesno True 0")
    yield("/wait 1.5")
  end

-- Setup for moving to the shop, and getting ready to sell the items
  function Sellingitemsto()
    yield("/visland moveto -268 40 226")
    yield("/wait 1")
    MovingTest()

    yield("/visland moveto -267.281 41 216.883")
    yield("/wait 1")
    MovingTest()

    yield("/visland moveto -267.065 41 209.221")
    yield("/wait 1")
    MovingTest()

    yield("/target Enterprising Exporter <wait.0.5>")
    yield("/pint <wait.0.5>")
    yield("/pcall SelectString True 0 <wait.1.0>")
  end

  function LeavingShop()
    yield("/pcall MJIDisposeShop False -2")

   yield("/visland moveto -268 40 226")
   yield("/wait 1")
   MovingTest()
  end

-- Checks to see how far you are from in front of the main workshop, if a certain distance, will teleport you in front of It
  function IslandReturn()

  yield("/pcall _ActionContents True 9 1 <wait.0.5>")
  while GetCharacterCondition(27) do
    yield("/wait 1")
  end
  yield("/wait 1")
  while GetCharacterCondition(45) do
    yield("/wait 1")
  end

  yield("/wait 1")
  end

-- Distance Test
function DistanceToBase()  
  Distance_Test = GetDistanceToPoint(-268, 40, 226)
end

-- Moving Test
  function MovingTest()
    while IsMoving() do 
      yield("/wait 1")
    end
  end

-- Visland Route Check 
  function VislandCheck()
    while IsVislandRouteRunning() do
      yield("/wait 3")
    end
  end

-- Start of the Loop
::Shop::
  
  yield("/visland stop")
  yield("/visland resume")

  IslandReturn()

  DistanceToBase()

  if Distance_Test > 4 then
    goto Shop 
  end

  CurrentLoop = 1
  LoopAmount = XPLoopAmount
  ItemAmount = QuartzArray[1]
  QuartzNode()
  QuartzShop()

  ItemAmount = QuartzArray[2]
  Iron_DuriumNode()
  IronShop()

  ItemAmount = QuartzArray[3]
  LeucograniteNode()
  LeucograniteShop()

  ItemAmount = QuartzArray[4]
  StoneNode()
  StoneShop()

  if ItemCountEcho == true then
    yield("/echo --- Spacer --- ")
    yield("/echo Quartz Send = "..QuartzSend)
    yield("/echo Iron Send = "..IronSend)
    yield("/echo Leucogranite Send = "..LeucograniteSend)
    yield("/echo Stone Send = "..StoneSend)
  end

  if StoneSend > 999 then
    StoneSend = 999
  end

    Sellingitemsto()
    
    if (QuartzSend > 0) then
      QuartzSell()
    end
    if (IronSend > 0) then
      IronSell()
    end
    if LeucograniteSend > 0 then
      LeucograniteSell()
    end
    if StoneSend > 0 then
      StoneSell()
    end
    
    LeavingShop()

yield("/visland exectemponce "..B2Quartz.." <wait.1.0>")
VislandCheck()

::LoopTime::

  while CurrentLoop <= LoopAmount do
    yield("/visland exectemponce "..VQuartz.." <wait.1.0>")
    
    VislandCheck()
    CurrentLoop = CurrentLoop + 1
    
    if LoopEcho == true then
      yield("/echo Current Loop: "..CurrentLoop)
    end
  end

if ContinueLooping == true then
  goto Shop
end