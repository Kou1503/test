-- Script path: game:GetService("ReplicatedStorage").Shared.Seats
-- Decompile time: 0.39 ms

return {
    release = function(a1) -- Line: 16; types: a1: userdata?
        local Humanoid = if not a1 then nil else a1:FindFirstChildOfClass("Humanoid")
        local SeatPart = if not Humanoid then nil else Humanoid.SeatPart

        if a1 and Humanoid and SeatPart then
            for i, j in SeatPart:GetChildren() do
                if j:IsA("Weld")
                    and j.Name == "SeatWeld"
                    and j.Part1 ~= nil
                    and j.Part1:IsDescendantOf(a1) then
                    j:Destroy()
                end
            end

            Humanoid.Sit = false

            return true
        end

        return false
    end,
}