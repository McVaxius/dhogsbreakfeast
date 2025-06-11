--this script illustrates a creative use for regex and command line interaction from the OS

function ping(host)
    local pingCommand = string.format("ping %s", host)
    os.execute(pingCommand.." > ping_output.txt")

    -- Read the output of the ping command from the file
    local file = io.open("ping_output.txt", "r")
    if not file then
        yield("/echo Failed to open ping_output.txt")
        return
    end

    local result = file:read("*all")
    file:close()

    -- Output the result for debugging
    yield("/echo Ping result: " .. result)

    -- Extracting ping time from the result
    local pingTime = result:match("time=(%d+%.?%d*)")
    if pingTime then
        yield("/echo Ping to "..host..": "..pingTime.." ms")
    else
        yield("/echo Unable to determine ping time.")
    end

    -- Delete the temporary file
    os.remove("ping_output.txt")
end

-- Example usage:
--ping("google.com") -- Pinging google.com
ping("204.2.29.82") -- a ff14 server
