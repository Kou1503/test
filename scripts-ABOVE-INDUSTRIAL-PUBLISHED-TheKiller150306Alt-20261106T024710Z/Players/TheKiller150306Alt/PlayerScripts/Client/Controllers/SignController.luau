-- Script path: game:GetService("Players").TheKiller150306Alt.PlayerScripts.Client.Controllers.SignController
-- Decompile time: 3.45 ms

local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local Shared = (game:GetService("ReplicatedStorage")):WaitForChild("Shared")
local Remotes = require(Shared.Remotes)
local SignText = require(Shared.SignText)
local u31 = require(script.Parent.Parent.Ui)
local BuildController = require(script.Parent.BuildController)
local u37 = {}
local LocalPlayer = Players.LocalPlayer
local u39 = nil
local u40 = nil
local u41 = nil
local u42 = nil
local u43 = nil
local u47 = Remotes.get(Remotes.RequestSignText)

local function isOpen() -- Line: 32; upvalues: u40 (ref)
    local Visible = false

    if u40 ~= nil then
        Visible = u40.Visible
    end

    return Visible
end

function u37.close() -- Line: 36; upvalues: u40 (ref), u43 (ref), BuildController (val)
    local Visible = false

    if u40 ~= nil then
        Visible = u40.Visible
    end

    if not Visible then
        return
    end

    u40.Visible = false
    u43 = nil

    BuildController.setUiOpen("Sign", false)
end

local function submit() -- Line: 45; upvalues: u43 (ref), u47 (val), SignText (val), u41 (ref), u37 (val)
    local v1 = u43

    if not v1 then
        return
    end

    u47:FireServer(v1, (SignText.sanitize(u41.Text)))
    u37.close()
end

local function refreshCounter() -- Line: 54; upvalues: u42 (ref), u41 (ref), SignText (val)
    u42.Text = ("%* / %*"):format(#u41.Text, SignText.MaxLength)
end

function u37.open(a1, a2)
    -- Line: 58
    -- upvalues: u43 (ref), u41 (ref), SignText (val), u42 (ref), u40 (ref), u31 (val), BuildController (val)
    -- types: a1: string, a2: string
    u43 = a1
    u41.Text = SignText.sanitize(a2)
    u42.Text = ("%* / %*"):format(#u41.Text, SignText.MaxLength)
    u40.Visible = true

    u31.appear(u40)
    BuildController.setUiOpen("Sign", true)
    u41:CaptureFocus()
end

local function makeButton(a1, a2, a3)
    -- Line: 68
    -- upvalues: u31 (val), u40 (ref)
    -- types: a1: string, a2: number, a3: userdata
    local TextButton = Instance.new("TextButton")
    TextButton.Size = UDim2.fromOffset(96, u31.tap(30))
    TextButton.Position = UDim2.new(1, a2, 1, -(u31.tap(30) + 12))
    TextButton.BackgroundColor3 = a3
    TextButton.TextColor3 = Color3.new(1, 1, 1)
    TextButton.FontFace = u31.Font.Bold
    TextButton.TextSize = 13
    TextButton.Text = a1
    TextButton.AutoButtonColor = true
    TextButton.Parent = u40
    local UICorner = Instance.new("UICorner")
    UICorner.CornerRadius = UDim.new(0, 6)
    UICorner.Parent = TextButton

    return TextButton
end

function u37.start()
    -- Line: 85
    -- upvalues: BuildController (val), u37 (val), u39 (ref), LocalPlayer (val), u40 (ref), u31 (val), u41 (ref)
    -- upvalues: u42 (ref), SignText (val), u43 (ref), u47 (val), makeButton (val), submit (val), UserInputService (val)
    -- upvalues: Remotes (val)
    BuildController.registerClose("Sign", u37.close)

    u39 = Instance.new("ScreenGui")
    u39.Name = "AboveSign"
    u39.ResetOnSpawn = false
    u39.DisplayOrder = 60
    u39.Parent = LocalPlayer:WaitForChild("PlayerGui")
    u40 = Instance.new("CanvasGroup")
    u40.Size = UDim2.fromOffset(340, 150)
    u40.AnchorPoint = Vector2.new(0.5, 0.5)
    u40.Position = UDim2.fromScale(0.5, 0.5)

    u31.fitToScreen(u40)

    u40.BackgroundColor3 = Color3.fromRGB(20, 22, 28)
    u40.BorderSizePixel = 0
    u40.Visible = false
    u40.Parent = u39

    u31.closeButton(u40, 10, u37.close)

    local UICorner = Instance.new("UICorner")
    UICorner.CornerRadius = UDim.new(0, 10)
    UICorner.Parent = u40
    local UIStroke = Instance.new("UIStroke")
    UIStroke.Thickness = 1
    UIStroke.Color = Color3.fromRGB(46, 52, 66)
    UIStroke.Parent = u40
    local TextLabel = Instance.new("TextLabel")
    TextLabel.Size = UDim2.new(1, -28, 0, 22)
    TextLabel.Position = UDim2.fromOffset(14, 10)
    TextLabel.BackgroundTransparency = 1
    TextLabel.FontFace = u31.Font.Bold
    TextLabel.TextSize = 14
    TextLabel.TextXAlignment = Enum.TextXAlignment.Left
    TextLabel.TextColor3 = Color3.fromRGB(238, 240, 248)
    TextLabel.Text = "SIGN"
    TextLabel.Parent = u40
    u41 = Instance.new("TextBox")
    u41.AutoLocalize = false
    u41.Size = UDim2.new(1, -28, 0, 36)
    u41.Position = UDim2.fromOffset(14, 40)
    u41.BackgroundColor3 = Color3.fromRGB(32, 35, 44)
    u41.BorderSizePixel = 0
    u41.PlaceholderText = "LETTERS DIGITS SPACES"
    u41.Text = ""
    u41.TextColor3 = Color3.fromRGB(238, 240, 248)
    u41.PlaceholderColor3 = Color3.fromRGB(120, 126, 145)
    u41.TextSize = 16
    u41.FontFace = u31.Font.Bold
    u41.TextXAlignment = Enum.TextXAlignment.Left
    u41.ClearTextOnFocus = false
    u41.Parent = u40
    local UICorner_2 = Instance.new("UICorner")
    UICorner_2.CornerRadius = UDim.new(0, 6)
    UICorner_2.Parent = u41
    local UIPadding = Instance.new("UIPadding")
    UIPadding.PaddingLeft = UDim.new(0, 8)
    UIPadding.Parent = u41
    u42 = Instance.new("TextLabel")
    u42.Size = UDim2.fromOffset(80, 16)
    u42.Position = UDim2.new(1, -94, 0, 80)
    u42.BackgroundTransparency = 1
    u42.FontFace = u31.Font.Regular
    u42.TextSize = 12
    u42.TextXAlignment = Enum.TextXAlignment.Right
    u42.TextColor3 = Color3.fromRGB(120, 126, 145)
    u42.Text = ""
    u42.Parent = u40

    ;(u41:GetPropertyChangedSignal("Text")):Connect(function()
        -- Line: 163
        -- upvalues: SignText (upval), u41 (upval), u42 (upval)
        local v1 = SignText.sanitize(u41.Text)

        if v1 ~= u41.Text then
            u41.Text = v1
            u41.CursorPosition = #v1 + 1
        end

        u42.Text = ("%* / %*"):format(#u41.Text, SignText.MaxLength)
    end)

    u41.FocusLost:Connect(function(a1)
        -- Line: 171
        -- upvalues: u43 (upval), u47 (upval), SignText (upval), u41 (upval), u37 (upval)
        if a1 then
            local v1 = u43

            if not v1 then
                return
            end

            u47:FireServer(v1, (SignText.sanitize(u41.Text)))
            u37.close()
        end
    end)

    makeButton("WRITE", -220, Color3.fromRGB(58, 120, 78)).Activated:Connect(submit)
    ;(makeButton("CANCEL", -110, (Color3.fromRGB(70, 40, 46)))).Activated:Connect(u37.close)

    UserInputService.InputBegan:Connect(function(a1, a2) -- Line: 180; upvalues: u40 (upval), u37 (upval)
        if not a2 then
            local Visible = false

            if u40 ~= nil then
                Visible = u40.Visible
            end

            if Visible then
                if a1.KeyCode == Enum.KeyCode.Escape then
                    u37.close()
                end
            end
        end
    end)

    ;(Remotes.get(Remotes.SignEdit)).OnClientEvent:Connect(function(a1, a2) -- Line: 189; upvalues: u37 (upval)
        if type(a1) ~= "string" then
            return
        end

        u37.open(a1, if type(a2) ~= "string" then "" else a2)
    end)
end

return u37