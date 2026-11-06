-- Script path: game:GetService("Players").TheKiller150306Alt.PlayerScripts.Client.Controllers.ScrollBarController
-- Decompile time: 0.95 ms

local Players = game:GetService("Players")
local Shared = (game:GetService("ReplicatedStorage")):WaitForChild("Shared")
local Config = require(Shared.Config)
local u22 = require(script.Parent.DeviceMode)
local v1 = {}

local function style(a1) -- Line: 21; upvalues: Config (val); types: a1: userdata
    if a1.ScrollBarThickness <= 0 then
        return
    end

    local ScrollBar = Config.Touch.ScrollBar
    a1.ScrollBarThickness = math.max(a1.ScrollBarThickness, ScrollBar.Thickness)
    a1.ScrollBarImageColor3 = Color3.fromRGB(ScrollBar.Rgb[1], ScrollBar.Rgb[2], ScrollBar.Rgb[3])
    a1.ScrollBarImageTransparency = 0
    a1.VerticalScrollBarInset = Enum.ScrollBarInset.ScrollBar
    a1.HorizontalScrollBarInset = Enum.ScrollBarInset.ScrollBar
end

local function consider(a1) -- Line: 33; upvalues: style (val); types: a1: userdata
    if a1:IsA("ScrollingFrame") then
        task.defer(style, a1)
    end
end

function v1.start() -- Line: 40; upvalues: u22 (val), Players (val), style (val), consider (val)
    if not u22.touchOnly() then
        return
    end

    local PlayerGui = Players.LocalPlayer:WaitForChild("PlayerGui")

    for i, j in PlayerGui:GetDescendants() do
        if j:IsA("ScrollingFrame") then
            task.defer(style, j)
        end
    end

    PlayerGui.DescendantAdded:Connect(consider)
end

return v1