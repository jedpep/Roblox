repeat wait() until game:IsLoaded()

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

function latestVersion()
    local LatestVersion = game:HttpGet("https://raw.githubusercontent.com/jedpep/Roblox/main/CoreGui/assets/version")
    return {(not isfile("Jedpep/CoreGui/version.txt")) or (readfile("Jedpep/CoreGui/version.txt") ~= LatestVersion), LatestVersion}
end

local IsLatestVersion = latestVersion()
if not IsLatestVersion[1] then
    delfolder("Jedpep/CoreGui/scripts")
    delfolder("Jedpep/CoreGui/assets")
    writefile("Jedpep/CoreGui/version.txt", IsLatestVersion[2])
end

for N, S in next, Settings do
    if S then
        loadstring(getScript(N..".lua"))()
    end
end
