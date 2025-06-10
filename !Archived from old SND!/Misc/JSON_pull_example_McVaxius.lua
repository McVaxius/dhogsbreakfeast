-- Function to extract first and last names from JSON string using a free WEB API. usecase is generating names
-- Mekretayners uses it for retainer names :~debug.debug

local function extractNames(jsonString)
    local first_name = jsonString:match('"first"%s*:%s*"([^"]+)"')
    local last_name = jsonString:match('"last"%s*:%s*"([^"]+)"')
    return first_name, last_name
end

-- Function to execute a Lua script fetched from a URL using curl
function executeScriptFromURL(url)
    -- Command to fetch the data using curl
    local command = string.format('curl -s "%s"', url)

    -- Open a pipe to read the output of the command
    local pipe = io.popen(command)

    -- Read the output of the command (the data)
    local data = pipe:read("*a")
    pipe:close()

    -- Extract first and last names
    local first_name, last_name = extractNames(data)

    -- Output the names
    if first_name and last_name then
        yield("/echo `First Name: " .. first_name .. ", Last Name: " .. last_name .. "`")
    else
        yield("/echo `Failed to extract names.`")
    end
end

-- API URL
local apiUrl = "https://randomuser.me/api/"

-- Execute the script to fetch and print the JSON response from the API URL
executeScriptFromURL(apiUrl)
