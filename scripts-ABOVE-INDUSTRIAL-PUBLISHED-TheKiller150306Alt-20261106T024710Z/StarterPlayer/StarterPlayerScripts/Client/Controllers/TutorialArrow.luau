-- Script path: game:GetService("Players").TheKiller150306Alt.PlayerScripts.Client.Controllers.TutorialArrow
-- Decompile time: 1.49 ms

local Shared = (game:GetService("ReplicatedStorage")):WaitForChild("Shared")
local Prefabs = require(Shared.Prefabs)
local u12 = {}
u12.Color = Color3.fromHex("#a3a600")
u12.Scale = 0.6
local u21 = CFrame.Angles(1.5707963267948966, 0, 0)

function u12.make(a1, a2, a3)
    -- Line: 27
    -- upvalues: Prefabs (val), u12 (val)
    -- types: a1: userdata, a2: vector, a3: number
    local v1 = Prefabs.clone(Prefabs.EffectsCategory, "TutorialArrow")
    local BasePart = if not v1 then
        nil
    else
        if not v1:IsA("BasePart") then v1:FindFirstChildWhichIsA("BasePart", true) else v1

    if v1 and BasePart then
        for i, j in v1:GetDescendants() do
            if j:IsA("BasePart") then
                j.Anchored = true
                j.CanCollide = false
                j.CanQuery = false
                j.CanTouch = false
                j.CastShadow = false
            end
        end

        BasePart.Color = u12.Color
        BasePart.Material = Enum.Material.Neon

        if not v1:IsA("Model") then
            BasePart.Size = BasePart.Size * u12.Scale
        else
            v1:ScaleTo((v1:GetScale()) * u12.Scale)
        end

        v1.Parent = a1
        local v2 = {
            part = BasePart,
            at = a2
                + Vector3.new(0, (math.max(BasePart.Size.X, BasePart.Size.Y, BasePart.Size.Z)) / 2 + 0.8, 0),
            phase = a3,
        }

        u12.move({v2})

        return v2
    end

    if v1 then
        v1:Destroy()
    end

    return nil
end

function u12.move(a1) -- Line: 65; upvalues: u21 (val); types: a1: table
    local v1
    local v2 = os.clock()

    for i, j in a1 do
        v1 = math.sin(v2 * 3 + j.phase) * 0.35
        j.part.CFrame = (CFrame.new(j.at + Vector3.new(0, v1, 0)))
            * CFrame.Angles(0, v2 * 1.5 + j.phase, 0)
            * u21
    end
end

return u12