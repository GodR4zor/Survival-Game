local PlayerModule = {}

--Services
local Players = game:GetService("Players")
local DataStoreService = game:GetService("DataStoreService")

local PLAYER_DATA_DEFAULT = {
    hunger = 100,
    inventory = {},
    level = 1
}

--Members
local playerCached = {} ---Dicionário com todos os jogadores no server
local database = DataStoreService:GetDataStore("Survival")

--Functions

function PlayerModule.IsLoaded(player:Player)
    local isloaded = playerCached[player.UserId] and playerCached[player.UserId] or false
    return isloaded
end

function PlayerModule.SetHunger(player:Player, hunger:number)
    playerCached[player.UserId].hunger = hunger
end

---Get Hunger of Player
function PlayerModule.GetHunger(player:Player):number
    return playerCached[player.UserId].hunger
end


local function onPlayerAdded(player:Player)
    player.CharacterAdded:Connect(function(_)
        local data = database:GetAsync(player.UserId)
        if not data then
            data = PLAYER_DATA_DEFAULT
        end
        playerCached[player.UserId] = data
    end)
end

local function onPlayerRemoving(player:Player)
    print("Jogador removido")
    database:SetAsync(player.UserId, playerCached[player.UserId])
    playerCached[player.UserId] = nil
end

--region Listeners
Players.PlayerAdded:Connect(onPlayerAdded)
Players.PlayerRemoving:Connect(onPlayerRemoving)


return PlayerModule