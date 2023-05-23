--Services
local Players = game:GetService("Players")
local RP = game:GetService("ReplicatedStorage")

--Members
local PlayerRequestUpgrade:RemoteEvent = RP.network.PlayerRequestUpgrade
local PlayerUpgradeUI:RemoteEvent = RP.network.PlayerUpgradeUI
local PlayerGui = Players.LocalPlayer:WaitForChild("PlayerGui")
local Hud = PlayerGui:WaitForChild("HUD")
local UpgradeUI:Frame = Hud:WaitForChild("UpgradeUI")
local Upgrade:Frame = UpgradeUI:WaitForChild("Upgrade")
local IconLIST:Frame = UpgradeUI:WaitForChild("IconLIST")
local UpgradeButton:TextButton = Upgrade:WaitForChild("UpgradeButton")
local ExitButton:TextButton = UpgradeUI:WaitForChild("ExitButton")

local StoneLabel:Frame = IconLIST:WaitForChild("Stone")
local WoodLabel:Frame = IconLIST:WaitForChild("Wood")
local CopperLabel:Frame = IconLIST:WaitForChild("Copper")

--Constant
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
    [5] = {
        Stone = "Max",
        Copper = "Max",
        Wood = "Max"
    },
}



--Texts
local StoneNumber:TextLabel = StoneLabel.number
local WoodNumber:TextLabel = WoodLabel.number
local CopperNumber:TextLabel = CopperLabel.number
local LevelLabel:TextLabel = UpgradeUI.NumberLevel

UpgradeUI.Visible = false

local function onLevelMax(level:number)
    level = level + 1
    if level == 5 then
        level = "Max"
    end

    return level
end

local function onExitUI(player:Player)
    UpgradeUI.Visible = false
    print("UI fechada!")
end

local function onRequestUpgrade(player:Player)
    PlayerRequestUpgrade:FireServer(player)
end

--UpgradeButton.MouseButton1Click:Connect()
PlayerUpgradeUI.OnClientEvent:Connect(function(level)
    local required = RESOURCES_REQUIRED[level + 1]

    if level > LEVEL_CAP then
        return
    end

    LevelLabel.Text = onLevelMax(level)
    StoneNumber.Text = required.Stone and required.Stone or 0
    CopperNumber.Text = required.Copper and required.Copper or 0
    WoodNumber.Text = required.Wood and required.Wood or 0

    UpgradeUI.Visible = true

end)
ExitButton.MouseButton1Click:Connect(onExitUI)
UpgradeButton.MouseButton1Click:Connect(onRequestUpgrade)

