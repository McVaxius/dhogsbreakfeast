-- Function to download a file from a URL using curl
function downloadFile(url, outputFile)
    local command = string.format('curl.exe -o "%s" "%s"', outputFile, url)
    os.execute(command)
end

-- URL of the text file on GitHub
--local url = "https://raw.githubusercontent.com/username/repository/master/textfile.txt"
local url = "https://raw.githubusercontent.com/Jaksuhn/SomethingNeedDoing/master/Community%20Scripts/Dungeons/arbitrary%20duty%20solver/arbitraryduty_McVaxius.lua"

-- Path where you want to save the file
local outputFile = "d:\\temp\\textfile.txt"

-- Download the file
downloadFile(url, outputFile)

