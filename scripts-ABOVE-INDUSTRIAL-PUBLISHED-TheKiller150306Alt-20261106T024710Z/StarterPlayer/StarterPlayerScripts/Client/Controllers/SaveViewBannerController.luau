-- Script path: game:GetService("StarterPlayer").StarterPlayerScripts.Client.Controllers.SaveViewBannerController
-- Decompile time: 1.02 ms

local Players = game:GetService("Players")
local v1 = {}
local u6 = nil

local function show(a1) -- Line: 16; upvalues: u6 (ref), Players (val)
    if u6 then
        u6:Destroy()

        u6 = nil
    end

    if type(a1) ~= "string" then
        return
    end

    local ScreenGui = Instance.new("ScreenGui")
    ScreenGui.Name = "SaveViewBanner"
    ScreenGui.ResetOnSpawn = false
    ScreenGui.IgnoreGuiInset = true
    ScreenGui.DisplayOrder = 100
    local TextLabel = Instance.new("TextLabel")
    TextLabel.AnchorPoint = Vector2.zero
    TextLabel.Position = UDim2.fromOffset(16, 64)
    TextLabel.Size = UDim2.fromOffset(0, 26)
    TextLabel.AutomaticSize = Enum.AutomaticSize.X
    TextLabel.BackgroundColor3 = Color3.fromRGB(150, 30, 40)
    TextLabel.BackgroundTransparency = 0.1
    TextLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    TextLabel.Font = Enum.Font.GothamBold
    TextLabel.TextSize = 14
    TextLabel.Text = if a1 ~= "fresh" then
        ("  VIEWING SAVE %*: READ-ONLY, NOTHING IS SAVED  "):format(a1)
    else
        "  FRESH PLAYER: READ-ONLY, NOTHING IS SAVED  "
    TextLabel.Active = false
    TextLabel.Parent = ScreenGui
    local UICorner = Instance.new("UICorner")
    UICorner.CornerRadius = UDim.new(0, 6)
    UICorner.Parent = TextLabel
    ScreenGui.Parent = Players.LocalPlayer:WaitForChild("PlayerGui")
    u6 = ScreenGui
end

function v1.start() -- Line: 53; upvalues: show (val)
    show(workspace:GetAttribute("ViewingSave"))

    ;(workspace:GetAttributeChangedSignal("ViewingSave")):Connect(function() -- Line: 55; upvalues: show (upval)
        show(workspace:GetAttribute("ViewingSave"))
    end)
end

return v1