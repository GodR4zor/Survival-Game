--Services
local Players = game:GetService("Players")
local RP  = game:GetService("ReplicatedStorage")

--Members
local MiningUiUpdate:RemoteEvent = RP.network.MiningUiUpdate
local PlayerGui = Players.LocalPlayer:WaitForChild("PlayerGui")
local Hud = PlayerGui:WaitForChild("HUD")
local leftBar:Frame = Hud:WaitForChild("leftBar")
local InventoryFrame:Frame = leftBar:WaitForChild("Inventory")
local InventoryButton:ImageButton = InventoryFrame:WaitForChild("InventoryButton")

local InventoryUi:Frame = Hud:WaitForChild("Inventory")
local InventoryUiOriginPosition = InventoryUi.Position.X.Scale
InventoryUi.Position = UDim2.fromScale(-1, InventoryUi.Position.Y.Scale)
InventoryUi.Visible = false

--
local StoneNumberLabel:TextLabel = InventoryUi.Stone.Number
local CopperNumberLabel:TextLabel = InventoryUi.Cooper.Number
local WoodNumberLabel:TextLabel = InventoryUi.Wood.Number


InventoryFrame.MouseEnter:Connect(function()
end)

InventoryFrame.MouseLeave:Connect(function()
end)

local debouncing = false

InventoryButton.MouseButton1Click:Connect(function()
    if not debouncing then
        debouncing = true

        print("Open Inventory")
        InventoryUi.Visible = not InventoryUi.Visible
        if InventoryUi.Visible == true then
            InventoryUi:TweenPosition(UDim2.fromScale(InventoryUiOriginPosition, InventoryUi.Position.Y.Scale), Enum.EasingDirection.Out, Enum.EasingStyle.Quint)
            print("Executado")
        else
            InventoryUi.Position = UDim2.fromScale(-1, InventoryUi.Position.Y.Scale)
        end

        wait(1)

        debouncing = false

    end
end)

MiningUiUpdate.OnClientEvent:Connect(function(inventory:table)

    StoneNumberLabel.Text = inventory.Stone and inventory.Stone or 0
    CopperNumberLabel.Text = inventory.Cooper and inventory.Cooper or 0
    WoodNumberLabel.Text = inventory.Wood and inventory.Wood or 0

end)