--Services
local Players = game:GetService("Players")
local SS = game:GetService("ServerStorage")

--Members
local PlayerModule = require(SS.modules.PlayerModules)

local CORE_LOOP_INTERVAL = 5
local HUNGER_TIME = 1

--Functions
local function onPlayerAdded(player: Player)
    spawn(function()
        wait(2)
        while true do
            if PlayerModule.IsLoaded(player) then
                local hunger = PlayerModule.GetHunger(player)

                PlayerModule.SetHunger(player, hunger - HUNGER_TIME)
    
                print(hunger)
                wait(CORE_LOOP_INTERVAL)
            end
        end
    end)

end

local function onPlayerRemoving(player: Player)
    
end

--Listeners
Players.PlayerAdded:Connect(onPlayerAdded)
Players.PlayerRemoving:Connect(onPlayerRemoving)