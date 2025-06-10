--[[
  Description: Full automation of Diadem, to allow leveling of an item. You need to initially click the first item you want to gather here, but afterwards can just walk away.
               Now built to have both Botanist & Miner in the same script. Detects which class you're on, and has a built in route for both as well!
  
  Required Plugins:
    -> visland
    -> snd [Make sure to press the lua button when you import this]
    -> Pandora's Box
  Author: LegendofIceman
  Version: 6.2.4 [Tweaked BTN/Miner Route to be smoother/fixed potentional collision against the wall in the miner route]
  Class: Miner/BTN
  Link: https://discord.com/channels/1001823907193552978/1191076157882388581/1193291297067384873
]]

--When do you want to repair your own gear? From 0-100 (it's in percentage, but enter a whole value
Repair_Amount = 75


-- Miner Red Route
Miner_Red = "H4sIAAAAAAAACu2ZTWsjRxCG/4qYUwJy01VdVV2tW8gmYIjzsQScbMhBWBN2yEpjpHHCYvzfUy31SA4rwQSddiY+TUvNuPXw1lsf/Vx9v1zX1aJ60yxX9Xp2M7trNvV29sXsbb2afWfP8xkK4ePsy2pe3S8/PrbNpttVi9+eqx/bXdM17aZaPFe/VIsbkOiSaNJ59ast2fl59c4eggaH6oVebN1u6ts31cK+ertcNU/2Jsz77tq/6nW96Ww5r243Xb1dPnT3Tff+h7L79WflyHag3fv27/4bO4m97Y/lh1192r4/Hsyrb9Zt1//j265el8ev9jvK4qeneteV5/zi+2XTnd6YV9+226/bzar8an/48OdmXd/ZPv8yP8eEnMcYDkiC8xBRsOfCLsbEg7D4M1hCiP48mm378OfHWfvUPWzbx8+DEzj2WjihS4oUoeckDiGm85zCtDiRcWIl2INCFwJKPGAiNcmQcDzPCf7NCUYWZsnFhEEO+tHeehjASQDRSVoPOjWPOSDJIWRaocIFTTqow7BcCik4i2ad88fyw2xVP+YDfR6k1DFq7EklAlbhHhU49Ew0KKz8yCQkTiMfE3rSkHyxG0Z2SHKeineRJyYhcFGjP0QbOkDxdEKVnE8pDoq2kRmzqcSMmdNBQuSYRCnn+T0Y8Y4jwATBKDmA6PuCxx8zVorO3CfyILsZV8aKyVmvkMvjzASsmzBCxYbFW4B5P0wql+wGx2I30ZorDVCMGdSB2Y2eSJFeKgOnRoqtP1CJfQcG7FQR+zIomCEJXGrBRl0ys/066yZynt47s9XMCqXjYjCZRDPqV1xSSP9ZRWEsKiJ2nDBSYSVOPFJp4xlsvOH1ungbEynL+VxUhYbG6keUHhWZNam/qKsw5oizhBZMJ6VHRXHWnfaFEKEV0yldpSEay4jDakLieMRENlLEk2Grxuv61rFwYkfJKmg8lpASJPh0IoXE/kKDNuZAs7kHJ5JXZo0iBQsla/XJ41UC4lEIiMXGhSagEydNifIUpJ+cqXLQ6fUhEU0xFEtxTdEJhWNhFGz8KjQsqsZFxfxENMdRUUtMkK969lh8buwx/B9VC/BWSKcUXqlHQh5/HDhZdaThUv4asymDT9bOezliUdT+IixjsVx1XQUtI6mgPwEVo+BRP96Rv5TTJwbqBoLlcp9Ol4YUknUYRVRkUxFLYnF6oXYDye4w4HihQa7k9GC3ZIwEw64yRpW9rDxWp9zPW4PNWDHkVmzPhe32UAZeEp4PK0lpLGGFVvkB5LuLQkqC/fWkzLgFpkjq95d/ALvupM8sIwAA"

-- Botanist Pink Route
Botanist_Pink = "H4sIAAAAAAAACu2ZW2vbMBTHv4rx0wapkM5F0snbtm5QWLduDLoLezCt15o1dmncjlH63XdUy0kHLRTyVKfJS44tFOWXc/37uvxQLepyXu421XG9KHaK111ftc2yL14UB037u3jftPWsgED2pHhZzsrD6u9517T9spz/uC4PumXTN11bzq/Lr+V8Bygasl54Vn5T05nAUaL4WfldTQp619vAN2p3bb23W87trPxcHTeXuh8aNfa7q3pRt305d7Nyr+3ri+qoP2z604959d1r+fB6rOVp92e8o+fR3X5VZ8t6vfz2kLrl20XXj1+819eL/PHV7YpsfLqsl33+nDY+rJp+vWOy3nUXb7r2OP92O1z80izqfV1nb2YPkImR4kCGDY9MgolCgvczgf+ZwLSYMJgg0Q9IwMTA+h65sHLhR1Gx91BBDPF+MmeXy9Piqj6p+yodpjiv+qPTp4ErGmagFS4n5FduRAacj8+81ryQlBEADrxQUw+BY8zAHJoQCPwW5iKkYBzkTEQGgweJIxYwnils5EduWnGH7NWPXK5pZNiz4xUvZwDsM6+7vHw03kbKgZeCkBh8JoaMJrLdxh4AgzUgqcINXMR7xtwbIXkTLMJGgQcTCzzlJfoaeQVhgBUvtZ3frEGYGC8CrWlic0MFIUFIrMBrvg823HUuQVnjclOOOkJvnEv/9QAlBV1uMoHVwTSbb+REeC+ZRdVfXtRFf1HXTwOSug7g0BOANzqRBBkhOfUeoGdIhMGIkyF/KzCxAEJrSupY9nEd+MQiLAbDMdc1YOUiLqdprfwG7SOn24cijCYRYWJNxKyMJEiKxo2QdHjTQfgZEqMYklTjU4Q5w9otxlWy1g5JW4JtnNiYtGkWpJGLjrK5nQYOJkTeLMB4Wn0Qq9aGmPtGhKRIphwy4gKymxWzqeFS7YhtVia1WbJBAEZeanvyDrYx6FSaVT1kyNhImrFlHPtBvcpFv9m05qfmRlrqHefcTVrsNM5GXFZJ+gcy93biUtXIOJWPshqgOV0c3w67t7qSkMqTNoYtjDuw1qCEkMnwOMaSqP4tGGkbH5VYNt6JG7Vsy6gKyMBFxTStabhRTUvD3qSiy+pjtZStB1yq14Yk4A64rLqRl63F9fPmH++6l4n3HQAA"

-- Main loop, test to see if you're in the Diadem or not
::Wait::
while not IsInZone(886) do
  yield("/wait 10")
end
yield("/visland resume")
yield("/visland stop")
yield("/wait 3")

-- If you have the ability to repair your gear, this will allow you to do so. 
-- Currently will repair when your gear gets to 50% or below, but you can change the value to be whatever you would like
::RepairMode::
  if NeedsRepair(Repair_Amount) then
    yield("/generalaction repair")
    yield("/waitaddon Repair")
    yield("/pcall Repair true 0")
    yield("/wait 0.1")
    if IsAddonVisible("SelectYesno") then
      yield("/pcall SelectYesno true 0")
      yield("/wait 0.1")
    end
    while GetCharacterCondition(39) do yield("/wait 1") end
    yield("/wait 1")
    yield("/pcall Repair true -1")
  end

::JobTester::
Current_job = GetClassJobId()
if (Current_job == 17) or (Current_job == 16) then
  goto Enter
elseif (Current_job > 17) or (Current_job < 15) then
  yield("/echo Hmm... You're not on a gathering job, swtich to one and stop the script again.")
  yield("/snd stop")
end

-- If not in the Diadem, then if you're standing in front of the NCP "Aurvael", this will queue you into it
::Enter::
if IsInZone(886) then
  while GetCharacterCondition(34, false) and GetCharacterCondition(45, false) do
    if IsAddonVisible("ContentsFinderConfirm") then
      yield("/pcall ContentsFinderConfirm true 8")
    elseif GetTargetName()=="" then
      yield("/target Aurvael")
    elseif GetCharacterCondition(32, false) then
      yield("/pinteract")
    end
    if IsAddonVisible("Talk") then yield("/click talk") end
    if IsAddonVisible("SelectString") then yield("/pcall SelectString true 0") end
    if IsAddonVisible("SelectYesno") then yield("/pcall SelectYesno true 0") end
    yield("/wait 0.5")
  end
  while GetCharacterCondition(35, false) do yield("/wait 1") end
  while GetCharacterCondition(35) do yield("/wait 1") end
  yield("/wait 3")
end

-- Once in the Diadem, moves you to the starting point to start the gathering loop.
::Move::
if IsInZone(939) then
  while GetCharacterCondition(77, false) do
    if GetCharacterCondition(4, false) then
      yield("/mount \"Company Chocobo\"")
      yield("/wait 3")
    else
      yield("/generalaction jump")
      yield("/wait 0.5")
    end
  end
  yield("/visland movedir 0 20 0")
  yield("/wait 1")
  yield("/visland movedir 50 0 -50")
  yield("/wait 1")
  yield("/visland moveto -235 30 -435")
  yield("/wait 1")
  while IsMoving() do yield("/wait 1") end

  if Current_job == 17 then -- Botanist Route
  yield("/visland exectemp "..Botanist_Pink)
  elseif Current_job == 16 then -- Miner Route
  yield("/visland exectemp "..Miner_Red)
  end
end

goto Wait
