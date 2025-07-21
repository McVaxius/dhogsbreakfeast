
-----------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------
--------EDIT THESE IN THE SND SETTINGS!---------------------------------------------------------------------------------------
--[=====[
[[SND Metadata]]
author: dhogGPT
version: 420.69.420
description: Farm mogtomes with your cousins.
plugin_dependencies:
- vnavmesh
- SimpleTweaksPlugin
configs:
  zcross_world:
    default: 0
    description: "Set this to 1 if you are the party leader in a Cross World Party"
    type: int
    min: 0
    max: 1
    required: true
  zduty_counter:
    default: 0
    description: "This is the Prae duty counter. \nSet it to 0 if its the first run of the day \n Daily reset time is 3 am EST or 12am PST"
    type: int
    min: 0
    max: 99
    required: true
  ztornclothes:
    default: 25
    description: "pct to try to repair at\n this is for npc repair.\nParty leader will repair at this pct\nRest of party will go try to repair no matter what (99 pct) if they are outside of duty for >20 seconds"
    type: int
    min: -1
    max: 99
    required: true
  zfinickyclothes:
    default: 0
    description: "0 = dont auto equip\n1 = autoequip, useful if you have bis that isnt max level\ndefault set to NOT equip so people can manage their BIS"
    type: int
    min: 0
    max: 1
    required: true
  zducttape:
    default: 33916
    description: "0 = itemID of repair material to check for self repair.\ncheck if we even have g8dm, otherwise dont waste time,\n10386 is g6dm if you wanna change it, 17837 is g7, 33916 is g8"
    type: number
    required: true
  zbm_preset:
    default: "none"
    description: "if you set it to none it wont use (v)bm(r) and instead it will use RSR. this is for the ai preset to use."
    type: string
    required: true
  zfeedme:
    default: 46003
    description: "itemID for food to eat\nuse simple tweaks ShowID to find it (turn it on and hover over item, it will be the number on the left in the square [] brackets)\nSet this to 6942069 if you want it to pull from a list and eat whatever is in the inventory when food timer is < 5 minutes"
    type: number
    required: true
  zfeedmeitem:
    default: "Canned Beesechussy"
    description: "call it whatever you want. doesn't affect anything"
    type: string
    required: true
  zfeedmesearch:
    default: true
    description: "do you want it to search for other foods if the selected one runs out?"
    type: boolean
    required: true
  zecho_level:
    default: 3
    description: "5 show nothing at all except critical moments\n4 only show duty counters\n3 only show important stuff\n2 show the progress messages\n1 show more\n0 show all"
    type: int
    min: 0
    max: 5
    required: true
  zitworksonmymachine:
    default: 0
    description: "0 means use ad start (pre-select regular mode+correct path first in ad)\n1 means use the callback and snd function method(s) for queueing into porta/prae\ntoggle this setting if queueing is weird or broken"
    type: int
    min: 0
    max: 1
    required: true
  zpottymouth:
    default: 0
    description: "itemID of a buff pot you want to use\nleave as 0 if you dont want to pot.\npots will be used on the first boss and on gauis"
    type: int
    required: true
  zpottywords:
    default: "Stale Hot Dog Water"
    description: "The name of the tonic/draught/etc i.e. Gemdraught of Strength III.  call it as you will doesn't affect anything"
    type: string
    required: true

[[End Metadata]]
--]=====]

--Don't edit these
duty_counter = Config.Get("zduty_counter")
tornclothes = Config.Get("ztornclothes")
finickyclothes = Config.Get("zfinickyclothes")
ducttape = Config.Get("zducttape")
bm_preset = Config.Get("zbm_preset")
feedme = Config.Get("zfeedme")
feedmeitem = Config.Get("zfeedmeitem")
zfeedmesearch = Config.Get("zfeedmesearch")
echo_level = Config.Get("zecho_level")
itworksonmymachine = Config.Get("zitworksonmymachine")
pottymouth = Config.Get("zpottymouth")
pottywords = Config.Get("zpottywords")