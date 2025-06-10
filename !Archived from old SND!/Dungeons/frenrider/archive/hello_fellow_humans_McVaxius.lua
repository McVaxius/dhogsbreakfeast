-- Specify the path to your text file
-- forward slashes are actually backslashes.
--to use this find the hfh_template.ini file and rename it to hfh_Yourcharfirstlast.ini   notice no spaces.
--so if your character is named Pomelo Pup'per then you would call the .ini file   hfh_PomeloPupper.ini
--also be sure to update the folder name as per your preference
--just remember it will strip spaces and apostrophes
tempchar = GetCharacterName()
--tempchar = tempchar:match("%s*(.-)%s*") --remove spaces at start and end only
tempchar = tempchar:gsub("%s", "")  --remove all spaces
tempchar = tempchar:gsub("'", "")   --remove all apostrophes
local filename = os.getenv("appdata").."\\XIVLauncher\\pluginConfigs\\SomethingNeedDoing\\hfh_"..tempchar..".ini"

-- Call the function to load variables from the file
loadVariablesFromFile(filename)

yield("/echo Hello Fellow humans !")

floop = idle_shitter_list[getRandomNumber(1,#HFHidle_shitter_list)]
yield(floop.." motion")
