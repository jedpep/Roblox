Settings = {
    ServerhopButton         = true;
    RejoinButton            = true;
    AdvancedServerhopButton = true;
}

function getScript(file)
    local ScriptPath = "Jedpep/CoreGui/scripts"

    makefolder("Jedpep/CoreGui")
    makefolder("Jedpep/CoreGui/scripts")
    if not isfile(ScriptPath.."/"..file) then
        local req = game:HttpGet(("https://raw.githubusercontent.com/jedpep/Roblox/main/CoreGui/scripts/%s"):format(file))
		writefile(ScriptPath.."/"..file, req)
    end
    return readfile(ScriptPath.."/"..file)
end

for N, S in next, Settings do
    if S then
        loadstring(getScript(N..".lua"))()
    end
end