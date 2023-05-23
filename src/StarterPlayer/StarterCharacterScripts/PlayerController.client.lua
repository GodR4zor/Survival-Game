--Services
local RP = game:GetService("ReplicatedStorage")
local SS = game:GetService("ServerStorage")
local Players = game:GetService("Players")

--Members
local PlayerDead:RemoteEvent = RP.network.PlayerDead
local Player = Players.LocalPlayer

local function onPlayerHunger0(player)
    local character = Player.Character
    local humanoid = character.Humanoid
    if humanoid then
        humanoid.Health -= 100
    end

end

--Listeners
PlayerDead.OnClientEvent:Connect(onPlayerHunger0)


