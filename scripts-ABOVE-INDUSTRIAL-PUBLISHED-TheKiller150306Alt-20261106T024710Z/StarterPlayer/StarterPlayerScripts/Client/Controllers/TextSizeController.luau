-- Script path: game:GetService("Players").TheKiller150306Alt.PlayerScripts.Client.Controllers.TextSizeController
-- Decompile time: 2.34 ms

local Players = game:GetService("Players")
local Shared = (game:GetService("ReplicatedStorage")):WaitForChild("Shared")
local Config = require(Shared.Config)
local u23 = require(script.Parent.Parent.Ui)
local v1 = {}
local u28 = setmetatable(
    {},
    {__mode = "k"}
)

local function hold(a1) -- Line: 34; upvalues: Config (val), u23 (val), u28 (val); types: a1: userdata
    if a1.TextScaled then
        return
    end

    local UITextSizeConstraint_2 = a1:FindFirstChildOfClass("UITextSizeConstraint")

    if UITextSizeConstraint_2 and UITextSizeConstraint_2.Name ~= "DesignedTextSize" then
        return
    end

    local UITextSizeConstraint = UITextSizeConstraint_2

    if not UITextSizeConstraint then
        UITextSizeConstraint = Instance.new("UITextSizeConstraint")
    end

    UITextSizeConstraint.Name = "DesignedTextSize"

    local function fit() -- Line: 44; upvalues: a1 (val), Config (upval), u23 (upval), UITextSizeConstraint (val)
        local v1 = math.max(1, a1.TextSize * Config.Appearance.MaxTextGrowth * (u23.layerScale(a1)))
        UITextSizeConstraint.MinTextSize = 1
        UITextSizeConstraint.MaxTextSize = math.max(1, (math.floor(v1 + 0.5)))
    end

    local v1 = math.max(1, a1.TextSize * Config.Appearance.MaxTextGrowth * (u23.layerScale(a1)))
    UITextSizeConstraint.MinTextSize = 1
    UITextSizeConstraint.MaxTextSize = math.max(1, (math.floor(v1 + 0.5)))
    UITextSizeConstraint.Parent = a1
    u28[a1] = fit

    if not UITextSizeConstraint_2 then
        (a1:GetPropertyChangedSignal("TextSize")):Connect(fit)

        ;(a1:GetPropertyChangedSignal("TextScaled")):Connect(function()
            -- Line: 56
            -- upvalues: a1 (val), UITextSizeConstraint (val)
            if a1.TextScaled then
                UITextSizeConstraint:Destroy()
            end
        end)
    end
end

local function consider(a1) -- Line: 64; upvalues: hold (val); types: a1: userdata
    if a1:IsA("TextLabel") or a1:IsA("TextButton") or a1:IsA("TextBox") then
        hold(a1)
    end
end

function v1.start() -- Line: 70; upvalues: Players (val), hold (val), consider (val), u23 (val), u28 (val)
    local PlayerGui = Players.LocalPlayer:WaitForChild("PlayerGui")

    for i, j in PlayerGui:GetDescendants() do
        if j:IsA("TextLabel") or j:IsA("TextButton") or j:IsA("TextBox") then
            hold(j)
        end
    end

    PlayerGui.DescendantAdded:Connect(function(a1) -- Line: 77; upvalues: consider (upval)
        task.defer(consider, a1)
    end)

    u23.onLayerScaleChanged(function() -- Line: 80; upvalues: u28 (upval)
        for i, j in u28 do
            if i.Parent then
                j()
            end
        end
    end)
end

return v1