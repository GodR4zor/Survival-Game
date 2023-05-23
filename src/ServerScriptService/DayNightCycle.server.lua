local WAIT_INTERVAL = 1/15

local minutesAfterMidnight:number

while true do
    minutesAfterMidnight = game.Lighting:GetMinutesAfterMidnight() + 0.2
    game.Lighting:SetMinutesAfterMidnight(minutesAfterMidnight)

    wait(WAIT_INTERVAL)
end