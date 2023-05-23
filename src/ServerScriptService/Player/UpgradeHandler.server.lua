 local Players = game:GetService("Players")
 local SS = game:GetService("ServerStorage")
 local RP = game:GetService("ReplicatedStorage")


 --Members
local PlayerLevelUp:RemoteEvent = RP.network.PlayerLevelUp
local PlayerInventoryUpdate:RemoteEvent = RP.network.PlayerInventoryUpdate
local PlayerRequestUpgrade:RemoteEvent = RP.network.PlayerRequestUpgrade
local PlayerUpgradeUI:RemoteEvent = RP.network.PlayerUpgradeUI
local PlayerModule = require(RP.modules.PlayerModules)

--CONSTANTS
local LEVEL_CAP = 4
local RESOURCES_REQUIRED = {

    
    [2] = {
        Stone = 50 * 2,
        Copper = 10 * 2,
        Wood = 100 * 2
    },

    [3] = {
        Stone = 50 * 3,
        Copper = 10 * 3,
        Wood = 100 * 3
    },

    [4] = {
        Stone = 50 * 4,
        Copper = 10 * 4,
        Wood = 100 * 4
    },
}



local function UpgradeRequest(player:Player)

    print("Executei")
    local level = PlayerModule.GetLevel(player)
    local inventory = PlayerModule.GetInventory(player)

    local required = RESOURCES_REQUIRED[level + 1]

    if level >= LEVEL_CAP then
        return print("Morri 1")
    end

    if inventory.Stone < required.Stone then
        return print("Morri 2")
    end

    if inventory.Copper < required.Copper then
        return print("Morri 3")
    end

    if inventory.Wood < required.Wood then
        return print("Morri 4")
    end

    inventory.Stone -= required.Stone
    inventory.Copper -= required.Copper
    inventory.Wood -= required.Wood

    PlayerModule.SetLevel(player, level + 1)

    PlayerLevelUp:FireClient(player, PlayerModule.GetLevel(player))
    PlayerInventoryUpdate:FireClient(player, PlayerModule.GetInventory(player))
    PlayerUpgradeUI:FireClient(player, PlayerModule.GetLevel(player))
    print("Upgrade")

end


PlayerRequestUpgrade.OnServerEvent:Connect(UpgradeRequest)