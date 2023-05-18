--Services
local ProximityPrompt = game:GetService("ProximityPromptService")
local SS = game:GetService("ServerStorage")
local RP = game:GetService("ReplicatedStorage")

--Constants
local MININGOBJECT = "Mining"
local MINING_SOUND_ID = "rbxassetid://966898639"

--Members
local PlayerModule = require(SS.modules.PlayerModules)
local Animation:Animation = Instance.new("Animation")
Animation.AnimationId = "rbxassetid://13469952207"
local isRuning = false

local function onSoundMining()
    
    local miningSound = Instance.new("Sound")
    miningSound.SoundId = MINING_SOUND_ID
    local random = Random.new()
    local value = random:NextNumber(0.5, 1.1)

    --Grave do Som:
    miningSound.Pitch = value
    miningSound.Parent = workspace
    miningSound:Play()

end

local function onPromptTrigered(promptObject:ProximityPrompt, player)
    --Diferente
    if promptObject.Name ~= MININGOBJECT then
        return
    end
    
    local miningModel = promptObject.Parent
    local miningValue = miningModel:FindFirstChildWhichIsA("NumberValue")

    PlayerModule.AddToInvetory(player, miningValue.Name, miningValue.Value)

    print(PlayerModule.GetInventory(player))

    miningModel:Destroy()
end

local function onPromptHoldBegan(promptObject:ProximityPrompt, player:Player)
    if promptObject.Name ~= MININGOBJECT then
        return
    end

    isRuning = true

    local character = player.Character
    local humanoid = character.Humanoid

    local humanoidAnimator:Animator = humanoid.Animator
    local animationTrack = humanoidAnimator:LoadAnimation(Animation)

    while isRuning do
        onSoundMining()
        --Executa a animação com delay de 0.5
        animationTrack:Play(nil, nil, 1)
        wait(1)
    end

    
end

local function onPromptHoldEnded(promptObject:ProximityPrompt, player:Player)
    if promptObject.Name ~= MININGOBJECT then
        return
    end

    isRuning = false

    
end

--Listeners
ProximityPrompt.PromptTriggered:Connect(onPromptTrigered)
ProximityPrompt.PromptButtonHoldBegan:Connect(onPromptHoldBegan)
ProximityPrompt.PromptButtonHoldEnded:Connect(onPromptHoldEnded)