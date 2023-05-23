local PlayerModule = {}

--Services
local Players = game:GetService("Players")
local DataStoreService = game:GetService("DataStoreService")
local SS = game:GetService("ServerStorage")
local RP = game:GetService("ReplicatedStorage")


--Members
local playerCached = {} ---Dicionário com todos os jogadores no server
local database = DataStoreService:GetDataStore("Survival")
local PlayerLoaded:BindableEvent = SS.BindableEvents.PlayerLoaded
local PlayerUnloaded:BindableEvent = SS.BindableEvents.PlayerUnloaded
local HungerUiUpdate:RemoteEvent =  RP.network.HungerUiUpdate
local PlayerInventoryUpdate:RemoteEvent = RP.network.PlayerInventoryUpdate
local PlayerLevelUp:RemoteEvent = RP.network.PlayerLevelUp

local PLAYER_DATA_DEFAULT = {
    hunger = 100,
    inventory = { 
        Stone = 0,
        Copper = 0,
        Wood = 0
    },
    level = 1
}

--Functions

local function hungerRegularize(hunger:number)

    if hunger  > 100 then
        hunger = 100
    end

    if hunger < 0 then
        hunger = 0
    end

    return hunger
end


function PlayerModule.GetLevel(player)
    return playerCached[player.UserId].level
end

function PlayerModule.SetLevel(player:Player, level:number)
    playerCached[player.UserId].level = level
end

function PlayerModule.SetHunger(player:Player, hunger:number)
    playerCached[player.UserId].hunger = hunger
end

---Get Hunger of Player
function PlayerModule.GetHunger(player:Player):number
    local hunger = hungerRegularize(playerCached[player.UserId].hunger)
    return hunger
end

--Get Inventory
function PlayerModule.GetInventory(player)
    return playerCached[player.UserId].inventory
end

--Set Inventory
function PlayerModule.SetInventory(player:Player, inventory:table)
    playerCached[player.UserId].inventory = inventory
end

--Add to inventory
function PlayerModule.AddToInvetory(player:Player, key:string, value:number)
    local inventory = playerCached[player.UserId].inventory

    --Caso inventário exista, adiciona o valor
    if inventory[key] then
        inventory[key] += value
        return
    end

    --Caso o invetário não exista, atribui ao invetário
    inventory[key] = value
end

local function onPlayerAdded(player:Player)
    player.CharacterAdded:Connect(function(_)
        local data = database:GetAsync(player.UserId)
        if not data then
            data = PLAYER_DATA_DEFAULT
        end
        playerCached[player.UserId] = data

        --Player Loaded
        print(playerCached[player.UserId])

        HungerUiUpdate:FireClient(player, PlayerModule.GetHunger(player))
        PlayerInventoryUpdate:FireClient(player, PlayerModule.GetInventory(player))
        PlayerLevelUp:FireClient(player, PlayerModule.GetLevel(player) )

        PlayerLoaded:Fire(player)


    end)
end

local function onPlayerRemoving(player:Player)

    PlayerUnloaded:Fire(player)
    print("Jogador removido")
    database:SetAsync(player.UserId, playerCached[player.UserId])
    playerCached[player.UserId] = nil
end

--region Listeners
Players.PlayerAdded:Connect(onPlayerAdded)
Players.PlayerRemoving:Connect(onPlayerRemoving)


return PlayerModule