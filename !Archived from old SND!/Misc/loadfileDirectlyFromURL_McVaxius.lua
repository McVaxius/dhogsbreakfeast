-- Function to execute a Lua script fetched from a URL using curl
function executeScriptFromURL(url)
    -- Command to fetch the Lua script using curl
    local command = string.format('curl -s "%s"', url)

    -- Open a pipe to read the output of the command
    local pipe = io.popen(command)

    -- Read the output of the command (the Lua script)
    local scriptContent = pipe:read("*a")
    pipe:close()

    -- Load and execute the Lua script
    local loadedFunction, errorMessage = load(scriptContent)
    if loadedFunction then
        loadedFunction()  -- Execute the loaded function
        yield("/echo Script loaded and executed successfully.")
    else
        yield("/echo Error loading script:", errorMessage)
    end
end

-- URL of the Lua script to fetch and execute
local scriptURL = "https://raw.githubusercontent.com/Jaksuhn/SomethingNeedDoing/master/Community%20Scripts/Dungeons/arbitrary%20duty%20solver/arbitraryduty_McVaxius.lua"
--local scriptURL = "https://example.com/script.lua"

-- Execute the Lua script fetched from the URL
executeScriptFromURL(scriptURL)


