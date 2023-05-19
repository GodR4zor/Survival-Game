--Services:
local SocialService = game:GetService("SocialService")
local Players = game:GetService("Players")
local player = Players.LocalPlayer

--Members:
local PlayerGui = player:WaitForChild("PlayerGui")
local Hud = PlayerGui:WaitForChild("HUD")
local inviteButton:TextButton = Hud:WaitForChild("InviteButton")

local function canSendGameInvite(sendingPlayer)
    local success, canSend = pcall(function()
      return SocialService:CanSendGameInviteAsync(sendingPlayer)
    end)
    return success and canSend
  end
  
inviteButton.MouseButton1Click:Connect(function()
    
    local canInvite = canSendGameInvite(player)
    if canInvite then
      local success, errorMessage = pcall(function()
        SocialService:PromptGameInvite(player)
      end)
    end
  

end)