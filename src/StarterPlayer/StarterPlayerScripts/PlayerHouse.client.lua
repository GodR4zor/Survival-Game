--Services
local RP = game:GetService("ReplicatedStorage")

--Members
local PlayerLevelUp = RP.network.PlayerLevelUp
local LEVEL_CAP:number = 4

local homeStorage:Folder = RP.homeStorage

local function onPlayerLevelUp(level:number)
    for _, instance in workspace.Home:GetChildren() do
        instance:Destroy()
    end
    
    local home
    if level >= LEVEL_CAP then
       home = homeStorage:FindFirstChild(LEVEL_CAP):Clone()
    else
        home = homeStorage:FindFirstChild(level):Clone()
    end

    home.Parent = workspace.Home
end

--Listeners
PlayerLevelUp.OnClientEvent:Connect(onPlayerLevelUp)