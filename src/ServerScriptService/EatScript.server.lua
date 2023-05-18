--Services
local ProximityPrompt = game:GetService("ProximityPromptService")
local SS = game:GetService("ServerStorage")
local RP = game:GetService("ReplicatedStorage")

--Constants
local EATOBJECT = "Eat"
local HungerUiUpdate = RP.network.HungerUiUpdate

--Members
local PlayerModule = require(SS.modules.PlayerModules)


local function onSoundEat()
    local EatSound:Sound = Instance.new("Sound")
    EatSound.SoundId = "rbxassetid://1398544778"
    EatSound.Parent = workspace

    EatSound:Play()

    delay(2, function()
        EatSound:Destroy()
        
    end)


end

local function onPromptTrigered(promptObject:ProximityPrompt, player)
    --Diferente
    if promptObject.Name ~= EATOBJECT then
        return
    end
    
    local foodModel = promptObject.Parent
    local foodValue = foodModel.foodValue.Value

    onSoundEat()

    local currentHunger = PlayerModule.GetHunger(player)
    PlayerModule.SetHunger(player, currentHunger + foodValue )

    --FireUI
    HungerUiUpdate:FireClient(player, PlayerModule.GetHunger(player))

    foodModel:Destroy()
    
end

--Listeners
ProximityPrompt.PromptTriggered:Connect(onPromptTrigered)