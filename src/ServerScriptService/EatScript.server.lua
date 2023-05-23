--Services
local ProximityPrompt = game:GetService("ProximityPromptService")
local SS = game:GetService("ServerStorage")
local RP = game:GetService("ReplicatedStorage")

--Constants
local EATOBJECT = "Eat"
local HungerUiUpdate = RP.network.HungerUiUpdate

--Members
local PlayerModule = require(RP.modules.PlayerModules)


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
    
    local foodModel:Model = promptObject.Parent
    local foodFolder = foodModel.Parent
   -- local foodPosition = foodModel.Position
    local foodClone = foodModel:Clone()
    local foodValue = foodModel.foodValue.Value

    onSoundEat()

    local currentHunger = PlayerModule.GetHunger(player)
    PlayerModule.SetHunger(player, currentHunger + foodValue )

    --FireUI
    HungerUiUpdate:FireClient(player, PlayerModule.GetHunger(player))

    foodModel:Destroy()

    delay(6, function()
        foodClone.Parent = foodFolder
    end)
    
end

--Listeners
ProximityPrompt.PromptTriggered:Connect(onPromptTrigered)