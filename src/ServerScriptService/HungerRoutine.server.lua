--Services
local Players = game:GetService("Players")
local SS = game:GetService("ServerStorage")
local RP = game:GetService("ReplicatedStorage")

--Members
local PlayerModule = require(RP.modules.PlayerModules)
local PlayerUnloaded:BindableEvent = SS.BindableEvents.PlayerUnloaded
local PlayerLoaded:BindableEvent = SS.BindableEvents.PlayerLoaded
local HungerUiUpdate:RemoteEvent = RP.network.HungerUiUpdate
local PlayerDead:RemoteEvent = RP.network.PlayerDead

local CORE_LOOP_INTERVAL = 3
local HUNGER_TIME = 1
local PLAYER_PUNISHIMENT = 0.1
local runningCoreLoops = {}

--Functions
local function coreloop(player: Player)
    if runningCoreLoops[player] then
        return -- A coreloop já está em execução para esse jogador
    end

    runningCoreLoops[player] = true

    local isRuning = true
    PlayerUnloaded.Event:Connect(function(playerUnloaded:Player)
        if playerUnloaded == player then
            isRuning = false
        end
    end)

    HungerUiUpdate:FireClient(player, PlayerModule.GetHunger(player))
    while true do
        if not isRuning then
            break
        end

        local hunger = PlayerModule.GetHunger(player)

        PlayerModule.SetHunger(player, hunger - HUNGER_TIME)

        --Hunger Update
       
        if PlayerModule.GetHunger(player) <= 0 then

            PlayerDead:FireClient(player)
        
            local inventory = PlayerModule.GetInventory(player)
        
            inventory.Stone = math.floor(inventory.Stone - (inventory.Stone * PLAYER_PUNISHIMENT))
            inventory.Copper = math.floor(inventory.Copper - (inventory.Copper * PLAYER_PUNISHIMENT))
            inventory.Wood = math.floor(inventory.Wood - (inventory.Wood * PLAYER_PUNISHIMENT))
            print(inventory)
        
            PlayerModule.SetHunger(player, 100)
        end

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