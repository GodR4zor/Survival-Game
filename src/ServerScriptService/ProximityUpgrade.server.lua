--Services
local ProximityPrompt = game:GetService("ProximityPromptService")
local RP = game:GetService("ReplicatedStorage")


--Members
local PlayerUpgradeUI:RemoteEvent = RP.network.PlayerUpgradeUI
local PlayerModule = require(RP.modules.PlayerModules)

local BUILDING_PROXIMITY = "Building"


local function onPromptTrigered(promptObject: ProximityPrompt, player:Player)
    if promptObject.Name ~= BUILDING_PROXIMITY then
        return
    end

    PlayerUpgradeUI:FireClient(player, PlayerModule.GetLevel(player))

end

ProximityPrompt.PromptTriggered:Connect(onPromptTrigered)