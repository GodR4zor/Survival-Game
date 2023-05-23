--Services
local ProximityPrompt = game:GetService("ProximityPromptService")
local SS = game:GetService("ServerStorage")
local RP = game:GetService("ReplicatedStorage")

--Constants
local MININGOBJECT = "Mining"
local MINING_SOUND_ID = "rbxassetid://966898639"

--Members
local PlayerInventoryUpdate:RemoteEvent = RP.network.PlayerInventoryUpdate
local PlayerModule = require(RP.modules.PlayerModules)
local Animation:Animation = Instance.new("Animation")
Animation.AnimationId = "rbxassetid://13529888796"
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
    
    local miningModel:Model = promptObject.Parent
    local miningCFrame = miningModel.PrimaryPart.CFrame
    local miningClone:Model = miningModel:Clone()
    local miningValue = miningModel:FindFirstChildWhichIsA("NumberValue")
    local miningFolder = miningModel.Parent

    PlayerModule.AddToInvetory(player, miningValue.Name, miningValue.Value)

    PlayerInventoryUpdate:FireClient(player, PlayerModule.GetInventory(player))


    miningModel:Destroy()

    delay(10, function()
        print("Cheguei Aqui!")
        miningClone.Parent = miningFolder
        miningClone.PrimaryPart.CFrame = miningCFrame
    end)

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

    local startTime = os.clock()

    while isRuning do
        onSoundMining()
        local elapsedTime = os.clock() - startTime
        animationTrack:Play(nil, nil, 0.5 + elapsedTime * 0.1)
        wait(4)

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