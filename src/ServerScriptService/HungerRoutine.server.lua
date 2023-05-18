--Services
local Players = game:GetService("Players")
local SS = game:GetService("ServerStorage")
local RP = game:GetService("ReplicatedStorage")

--Members
local PlayerModule = require(SS.modules.PlayerModules)
local PlayerUnloaded:BindableEvent = SS.BindableEvents.PlayerUnloaded
local PlayerLoaded:BindableEvent = SS.BindableEvents.PlayerLoaded
local HungerUiUpdate:RemoteEvent = RP.network.HungerUiUpdate

local CORE_LOOP_INTERVAL = 3
local HUNGER_TIME = 1

--Functions
local function coreloop(player: Player)
    local isRuning = true
    PlayerUnloaded.Event:Connect(function(playerUnloaded:Player)
        if playerUnloaded == player then
            isRuning = false
        end
    end)

    HungerUiUpdate:FireClient(player, PlayerModule.GetHunger(player))
    wait(2)
    while true do
        if not isRuning then
            break
        end

        local hunger = PlayerModule.GetHunger(player)

        PlayerModule.SetHunger(player, hunger - HUNGER_TIME)

        --Hunger Update
        HungerUiUpdate:FireClient(player, PlayerModule.GetHunger(player))
       

        wait(CORE_LOOP_INTERVAL)
    end
end

local function onPlayerLoaded(player: Player)
    spawn(function()
        coreloop(player)
    end)
end

--Listeners
PlayerLoaded.Event:Connect(onPlayerLoaded)