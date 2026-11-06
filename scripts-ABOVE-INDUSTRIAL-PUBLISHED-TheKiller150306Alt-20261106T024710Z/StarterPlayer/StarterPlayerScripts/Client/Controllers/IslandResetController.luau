-- Script path: game:GetService("Players").TheKiller150306Alt.PlayerScripts.Client.Controllers.IslandResetController
-- Decompile time: 6.41 ms

local Players = game:GetService("Players")
local Shared = (game:GetService("ReplicatedStorage")):WaitForChild("Shared")
local Config = require(Shared.Config)
local Remotes = require(Shared.Remotes)
local u26 = require(script.Parent.Parent.Ui)
local BuildController = require(script.Parent.BuildController)
local u32 = {}
local LocalPlayer = Players.LocalPlayer
local u34 = nil
local u35 = nil
local u36 = nil
local u37 = nil
local u38 = nil
local u42 = Remotes.get(Remotes.RequestIslandReset)

local function cooldownText() -- Line: 42; upvalues: Config (val)
    local CooldownDays = Config.Player.IslandReset.CooldownDays

    if CooldownDays >= 2 then
        return (("%* days"):format((math.floor(CooldownDays + 0.5))))
    end

    local v1 = CooldownDays * 24

    if v1 >= 1 then
        return (("%* hours"):format((math.floor(v1 + 0.5))))
    end

    v1 = CooldownDays * 24 * 60

    if v1 >= 1 then
        return (("%* minutes"):format((math.floor(v1 + 0.5))))
    end

    return (("%* seconds"):format((math.floor(v1 * 60 + 0.5))))
end

local function settings() -- Line: 58; upvalues: Config (val)
    return Config.Player.IslandReset
end

local function typedCorrectly() -- Line: 62; upvalues: u36 (ref), Config (val)
    return (string.lower(u36.Text))
        == string.lower(Config.Player.IslandReset.ConfirmWord)
end

local function refreshConfirm() -- Line: 66; upvalues: u36 (ref), Config (val), u37 (ref)
    local v1 = (string.lower(u36.Text))
        == string.lower(Config.Player.IslandReset.ConfirmWord)
    local v2 = u37
    local v3 = if not v1 then Color3.fromRGB(38, 41, 52) else Color3.fromRGB(120, 38, 42)
    v2.BackgroundColor3 = v3
    v2 = u37
    v3 = if not v1 then Color3.fromRGB(104, 110, 128) else Color3.fromRGB(255, 220, 220)
    v2.TextColor3 = v3
    u37.AutoButtonColor = v1
end

function u32.close() -- Line: 77; upvalues: u35 (ref), BuildController (val)
    local Visible = false

    if u35 ~= nil then
        Visible = u35.Visible
    end

    if not Visible then
        return
    end

    u35.Visible = false
    BuildController.setUiOpen("IslandReset", false)
end

function u32.isOpen() -- Line: 73; upvalues: u35 (ref)
    local Visible = false

    if u35 ~= nil then
        Visible = u35.Visible
    end

    return Visible
end

local function open(a1, a2)
    -- Line: 87
    -- upvalues: u36 (ref), refreshConfirm (val), u38 (ref), u37 (ref), u35 (ref), BuildController (val)
    -- types: a1: number, a2: string?
    u36.Text = ""
    refreshConfirm()

    if a2 then
        u38.Text = a2
        u38.Visible = true
        u36.Visible = false
        u37.Visible = false
    elseif not (a1 > 0) then
        u38.Visible = false
        u36.Visible = true
        u37.Visible = true
    else
        local v1 = math.floor(a1 / 86400)
        local v2 = math.floor(a1 % 86400 / 3600)
        local v3 = u38
        local v4 = if not (v1 > 0) then
            ("You reset recently. You can do this again in %*h."):format(v2)
        else
            ("You reset recently. You can do this again in %*d %*h."):format(v1, v2)
        v3.Text = v4
        u38.Visible = true
        u36.Visible = false
        u37.Visible = false
    end

    u35.Visible = true
    BuildController.setUiOpen("IslandReset", true)
end

function u32.start()
    -- Line: 117
    -- upvalues: u34 (ref), LocalPlayer (val), u35 (ref), u26 (val), cooldownText (val), u38 (ref), u36 (ref)
    -- upvalues: Config (val), refreshConfirm (val), u37 (ref), u42 (val), u32 (val), Remotes (val), open (val)
    u34 = Instance.new("ScreenGui")
    u34.Name = "AboveIslandReset"
    u34.ResetOnSpawn = false
    u34.DisplayOrder = 70
    u34.Parent = LocalPlayer:WaitForChild("PlayerGui")
    u35 = Instance.new("CanvasGroup")
    u35.Size = UDim2.fromOffset(380, 250)
    u35.Position = UDim2.new(0.5, -190, 0.5, -125)

    u26.fitToScreen(u35)

    u35.BackgroundColor3 = u26.Palette.Card
    u35.BackgroundTransparency = 0.02
    u35.BorderSizePixel = 0
    u35.Visible = false
    u35.Active = true
    u35.Parent = u34

    u26.corner(u35, 10)
    u26.stroke(u35, Color3.fromRGB(120, 48, 52), 2)

    local TextLabel = Instance.new("TextLabel")
    TextLabel.Size = UDim2.new(1, -28, 0, 22)
    TextLabel.Position = UDim2.fromOffset(14, 14)
    TextLabel.BackgroundTransparency = 1
    TextLabel.Text = "RESET YOUR ISLAND"
    TextLabel.TextColor3 = Color3.fromRGB(255, 180, 180)
    TextLabel.FontFace = u26.Font.Bold
    TextLabel.TextSize = 16
    TextLabel.TextXAlignment = Enum.TextXAlignment.Left
    TextLabel.Parent = u35
    local TextLabel_2 = Instance.new("TextLabel")
    TextLabel_2.Size = UDim2.new(1, -28, 0, 96)
    TextLabel_2.Position = UDim2.fromOffset(14, 42)
    TextLabel_2.BackgroundTransparency = 1
    TextLabel_2.Text = "This clears your island back to the starter island, and it can't be undone.\n\n"
        .. "Anything you have placed is IN THE WORLD, not in your backpack: blocks, machines, chests "
            .. "and what's stored in them all go with the island. Your coins, backpack and progress stay.\n\n"
                .. ("You can only do this once every %*."):format((cooldownText()))
    TextLabel_2.TextColor3 = Color3.fromRGB(210, 215, 228)
    TextLabel_2.FontFace = u26.Font.Regular
    TextLabel_2.TextSize = 13
    TextLabel_2.TextXAlignment = Enum.TextXAlignment.Left
    TextLabel_2.TextYAlignment = Enum.TextYAlignment.Top
    TextLabel_2.TextWrapped = true
    TextLabel_2.Parent = u35
    u38 = Instance.new("TextLabel")
    u38.Size = UDim2.new(1, -28, 0, 40)
    u38.Position = UDim2.fromOffset(14, 150)
    u38.BackgroundTransparency = 1
    u38.Text = ""
    u38.TextColor3 = Color3.fromRGB(255, 214, 110)
    u38.FontFace = u26.Font.Bold
    u38.TextSize = 13
    u38.TextXAlignment = Enum.TextXAlignment.Left
    u38.TextWrapped = true
    u38.Visible = false
    u38.Parent = u35
    u36 = Instance.new("TextBox")
    u36.Size = UDim2.new(1, -28, 0, u26.tap(32))
    u36.Position = UDim2.fromOffset(14, 152)
    u36.BackgroundColor3 = Color3.fromRGB(32, 35, 44)
    u36.BorderSizePixel = 0
    u36.PlaceholderText = ("Type \"%*\" to confirm"):format(Config.Player.IslandReset.ConfirmWord)
    u36.Text = ""
    u36.TextColor3 = Color3.fromRGB(238, 240, 248)
    u36.PlaceholderColor3 = Color3.fromRGB(120, 126, 145)
    u36.TextSize = 14
    u36.FontFace = u26.Font.Bold
    u36.TextXAlignment = Enum.TextXAlignment.Left
    u36.ClearTextOnFocus = false
    u36.Parent = u35

    u26.corner(u36, 5)

    local UIPadding = Instance.new("UIPadding")
    UIPadding.PaddingLeft = UDim.new(0, 8)
    UIPadding.Parent = u36

    ;(u36:GetPropertyChangedSignal("Text")):Connect(refreshConfirm)

    u37 = Instance.new("TextButton")
    u37.Size = UDim2.fromOffset(150, u26.tap(30))
    u37.Position = UDim2.new(1, -164, 1, -(u26.tap(30) + 12))
    u37.BackgroundColor3 = Color3.fromRGB(38, 41, 52)
    u37.TextColor3 = Color3.fromRGB(104, 110, 128)
    u37.FontFace = u26.Font.Bold
    u37.TextSize = 13
    u37.Text = "RESET MY ISLAND"
    u37.AutoButtonColor = false
    u37.Parent = u35

    u26.corner(u37, 5)

    u37.Activated:Connect(function() -- Line: 212; upvalues: u36 (upval), Config (upval), u42 (upval)
        if (string.lower(u36.Text))
            == string.lower(Config.Player.IslandReset.ConfirmWord) then
            u42:FireServer(u36.Text)
        end
    end)

    local TextButton = Instance.new("TextButton")
    TextButton.Size = UDim2.fromOffset(90, u26.tap(30))
    TextButton.Position = UDim2.new(0, 14, 1, -(u26.tap(30) + 12))
    TextButton.BackgroundColor3 = Color3.fromRGB(44, 48, 60)
    TextButton.TextColor3 = Color3.fromRGB(210, 215, 228)
    TextButton.FontFace = u26.Font.Bold
    TextButton.TextSize = 13
    TextButton.Text = "CANCEL"
    TextButton.Parent = u35

    u26.corner(TextButton, 5)
    TextButton.Activated:Connect(u32.close)

    ;(Remotes.get(Remotes.IslandResetPrompt)).OnClientEvent:Connect(function(a1, a2)
        -- Line: 232
        -- upvalues: open (upval)
        local v1 = open
        local v2 = if type(a2) ~= "string" then nil else a2

        v1(if type(a1) ~= "number" then 0 else a1, v2)
    end)
end

return u32