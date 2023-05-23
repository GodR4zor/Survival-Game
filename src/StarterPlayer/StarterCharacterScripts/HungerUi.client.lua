--Services
local Players = game:GetService("Players")
local RP = game:GetService("ReplicatedStorage")

--Members
local HungerUiUpdate = RP.network.HungerUiUpdate
local PlayerGui = Players.LocalPlayer:WaitForChild("PlayerGui")
local Hud = PlayerGui:WaitForChild("HUD")

local leftBar:Frame = Hud:WaitForChild("leftBar")
local hungerUi:Frame = leftBar:WaitForChild("hungerUi")
local hungerBar:Frame = hungerUi:WaitForChild("foodBar")
local hungerPorcent:TextLabel = hungerUi:WaitForChild("hungerPorcent")

--Constants

local BAR_FULL_COLLOR:Color3 = Color3.fromRGB(154,255, 1)
local BAR_MID_COLLOR:Color3 = Color3.fromRGB(255,112, 10)
local BAR_LOW_COLLOR:Color3 = Color3.fromRGB(211, 3, 13)

--Listeners
HungerUiUpdate.OnClientEvent:Connect(function(hunger:number)
    hungerBar.Size = UDim2.fromScale(hunger/100, hungerBar.Size.Y.Scale)

    hungerPorcent.Text = ("%d%%"):format(hunger)

    if hungerBar.Size.X.Scale > 0.66 then
        hungerBar.BackgroundColor3 = BAR_FULL_COLLOR
    elseif hungerBar.Size.X.Scale > 0.33 and hungerBar.Size.X.Scale < 0.66 then
        hungerBar.BackgroundColor3 = BAR_MID_COLLOR
    else
        hungerBar.BackgroundColor3 = BAR_LOW_COLLOR
    end
    
end)