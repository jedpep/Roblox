repeat wait() until game:IsLoaded()
local Library = require(game.ReplicatedStorage:WaitForChild("Framework"):WaitForChild("Library"))
while not Library.Loaded do
    wait()
end
wait(5)
Library = require(game.ReplicatedStorage.Library)
local Network = require(game:GetService("ReplicatedStorage").Library.Client.Network)
local Fire, Invoke = Network.Fire, Network.Invoke

local banSuccess, banError = pcall(function() 
    local Blunder = require(game:GetService("ReplicatedStorage"):WaitForChild("X", 10):WaitForChild("Blunder", 10):WaitForChild("BlunderList", 10))
    if not Blunder or not Blunder.getAndClear then LocalPlayer:Kick("Error while bypassing the anti-cheat! (Didn't find blunder)") end
    
    local OldGet = Blunder.getAndClear
    setreadonly(Blunder, false)
    local function OutputData(Message)
    print("-- PET SIM X BLUNDER --")
    print(Message .. "\n")
    end
    
    Blunder.getAndClear = function(...)
    local Packet = ...
        for i,v in next, Packet.list do
        if v.message ~= "PING" then
            OutputData(v.message)
            table.remove(Packet.list, i)
        end
    end
    return OldGet(Packet)
    end
    
    setreadonly(Blunder, true)
end)

if not banSuccess then
    LocalPlayer:Kick("Error while bypassing the anti-cheat! (".. banError ..")")
    return
end

local bypassSuccess, bypassError
bypassSuccess, bypassError = pcall(function()
    if not Library.Network then 
        LocalPlayer:Kick("Network not found, can't bypass!")
    end
    
    if not Library.Network.Invoke or not Library.Network.Fire then
        LocalPlayer:Kick("Network Invoke/Fire was not found! Failed to bypass!")
    end
    
    hookfunction(debug.getupvalue(Library.Network.Invoke, 1), function(...) return true end)
    
    local originalPlay = Library.Audio.Play
    Library.Audio.Play = function(...) 
        if checkcaller() then
            local audioId, parent, pitch, volume, maxDistance, group, looped, timePosition = unpack({ ... })
            if type(audioId) == "table" then
                audioId = audioId[Random.new():NextInteger(1, #audioId)]
            end
            if not parent then
                warn("Parent cannot be nil", debug.traceback())
                return nil
            end
            if audioId == 0 then return nil end
            
            if type(audioId) == "number" or not string.find(audioId, "rbxassetid://", 1, true) then
                audioId = "rbxassetid://" .. audioId
            end
            if pitch and type(pitch) == "table" then
                pitch = Random.new():NextNumber(unpack(pitch))
            end
            if volume and type(volume) == "table" then
                volume = Random.new():NextNumber(unpack(volume))
            end
            if group then
                local soundGroup = game.SoundService:FindFirstChild(group) or nil
            else
                soundGroup = nil
            end
            if timePosition == nil then
                timePosition = 0
            else
                timePosition = timePosition
            end
            local isGargabe = false
            if not pcall(function() local _ = parent.Parent end) then
                local newParent = parent
                pcall(function()
                    newParent = CFrame.new(newParent)
                end)
                parent = Instance.new("Part")
                parent.Anchored = true
                parent.CanCollide = false
                parent.CFrame = newParent
                parent.Size = Vector3.new()
                parent.Transparency = 1
                parent.Parent = workspace:WaitForChild("__DEBRIS")
                isGargabe = true
            end
            local sound = Instance.new("Sound")
            sound.SoundId = audioId
            sound.Name = "sound-" .. audioId
            sound.Pitch = pitch and 1
            sound.Volume = volume and 0.5
            sound.SoundGroup = soundGroup
            sound.Looped = looped and false
            sound.MaxDistance = maxDistance and 100
            sound.TimePosition = timePosition
            sound.RollOffMode = Enum.RollOffMode.Linear
            sound.Parent = parent
            if not require(game:GetService("ReplicatedStorage"):WaitForChild("Library"):WaitForChild("Client")).Settings.SoundsEnabled then
                sound:SetAttribute("CachedVolume", sound.Volume)
                sound.Volume = 0
            end
            sound:Play()
            getfenv(originalPlay).AddToGarbageCollection(sound, isGargabe)
            return sound
        end
        
        return originalPlay(...)
    end

end)

local SHU = loadstring(game:HttpGet("https://raw.githubusercontent.com/jedpep/Roblox/main/ServerHop.lua"))()

if not bypassSuccess then
    print(bypassError)
    LocalPlayer:Kick("Error while bypassing network, try again or wait for an update!")
    return
end

if workspace.__MAP.Areas:FindFirstChild("SandcastleEventCannon") then
    if workspace.__MAP.Areas:FindFirstChild("SandcastleEventCannon"):FindFirstChild("Holographic Cannon") then
        if not workspace.__MAP.Cannons:FindFirstChild("Sandcastle Event") then
            SHU.Jump(({"Normal","Low"})[math.random(1,2)])
            wait(1000)
        end
    end
end


if Library.WorldCmds.Get() ~= "Sandcastle Event" then
    Library.WorldCmds.Load("Sandcastle Event")
    print(Library.WorldCmds.HasLoaded())
end


local x50 = false
local x50Egg = nil
for i,v in pairs(workspace.__MAP.Eggs:GetChildren()) do
	print(v.Sign.Main.SurfaceGui.Title.Text)
	if v.Sign.Main.SurfaceGui.Title.Text:find(TargetMulti) then
		print(true)
		x50 = true
        x50Egg = v
	end
end
if not x50 then
	SHU.Jump(({"Normal","Low"})[math.random(1,2)])
else
    local embed = {
        {
            ["color"] = 16230400,
            ["title"] = ("Found %s egg!"):format(TargetMulti),
            ["author"] = {
                ["name"] = ("Server size: %s/%s"):format(#game.Players:GetChildren(), game.Players.MaxPlayers)
            },
            ["description"] = ("Join script: ```lua\ngame:GetService('TeleportService'):TeleportToPlaceInstance(6284583030, '%s', game.Players.LocalPlayer)```\n\nJoin through browser: ```js\nRoblox.GameLauncher.joinGameInstance(6284583030, '%s')```"):format(game.JobId, game.JobId),
            ["footer"] = {
                ["text"] = "JX Utilities • Sandcastle Egg Finder",
                ["icon_url"] = "https://media.discordapp.net/attachments/1108132899431137300/1109902689996910622/gpfp.png?width=675&height=675"
            },
        }
    }
    if SendWebhook then
        (syn and syn.request or http and http.request or http_request or fluxus and fluxus.request or getgenv().request or request) {
            Url = WebhookUrl,
            Method = "POST",
            Headers = {
                ["Content-Type"] = "application/json"
            },
            Body = game:GetService("HttpService"):JSONEncode{
                ["content"] = "",
                ["embeds"] = embed
            }
        }
    end
    if not StopWhenFound then
        SHU.Jump(({"Normal","Low"})[math.random(1,2)])
    end
    wait(3)
    if TeleportToEgg then
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(x50Egg.PrimaryPart.CFrame.p) + (x50Egg.PrimaryPart.CFrame.RightVector * 10)
        Fire("Performed Teleport")
    end
end
