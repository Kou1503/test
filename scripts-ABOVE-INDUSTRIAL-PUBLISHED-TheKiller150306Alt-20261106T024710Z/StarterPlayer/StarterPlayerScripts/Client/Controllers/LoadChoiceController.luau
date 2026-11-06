-- Script path: game:GetService("Players").TheKiller150306Alt.PlayerScripts.Client.Controllers.LoadChoiceController
-- Decompile time: 3.63 ms

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local Shared = (game:GetService("ReplicatedStorage")):WaitForChild("Shared")
local Remotes = require(Shared.Remotes)
local u28 = require(script.Parent.Parent.Ui)
local v1 = {}
local LocalPlayer = Players.LocalPlayer
local u31 = nil
local u32 = nil

local function close() -- Line: 29; upvalues: u32 (ref), u31 (ref)
    if u32 then
        u32:Disconnect()

        u32 = nil
    end

    if u31 then
        u31:Destroy()

        u31 = nil
    end
end

local function text(a1, a2, a3, a4, a5)
    -- Line: 40
    -- upvalues: u28 (val)
    -- types: a1: userdata, a2: string, a3: number, a4: userdata, a5: boolean
    local TextLabel = Instance.new("TextLabel")
    TextLabel.BackgroundTransparency = 1
    TextLabel.Size = UDim2.fromScale(1, 0)
    TextLabel.AutomaticSize = Enum.AutomaticSize.Y
    TextLabel.Text = a2
    TextLabel.TextWrapped = true
    TextLabel.TextSize = a3
    TextLabel.TextColor3 = a4
    local Bold = if not a5 then u28.Font.Regular else u28.Font.Bold
    TextLabel.FontFace = Bold
    TextLabel.Parent = a1

    return TextLabel
end

local function show(a1)
    -- Line: 54
    -- upvalues: u32 (ref), u31 (ref), Remotes (val), u28 (val), text (val), RunService (val), LocalPlayer (val)
    local name_2, v1

    if u32 then
        u32:Disconnect()

        u32 = nil
    end

    if u31 then
        u31:Destroy()

        u31 = nil
    end

    local choices_2 = if type(a1.choices) ~= "table" then {} else a1.choices
    local coopName = if type(a1.coopName) ~= "string" then "your co-op" else a1.coopName
    local seconds_2 = if type(a1.seconds) ~= "number" then 30 else a1.seconds
    local u36 = Remotes.get(Remotes.LoadChoiceAnswer)
    local ScreenGui = Instance.new("ScreenGui")
    ScreenGui.Name = "LoadChoice"
    ScreenGui.IgnoreGuiInset = true
    ScreenGui.ResetOnSpawn = false
    ScreenGui.DisplayOrder = 10001
    u31 = ScreenGui
    local Frame = Instance.new("Frame")
    Frame.AnchorPoint = Vector2.new(0.5, 0.5)
    Frame.Position = UDim2.fromScale(0.5, 0.5)
    Frame.Size = UDim2.fromOffset(340, 0)
    Frame.AutomaticSize = Enum.AutomaticSize.Y
    Frame.BackgroundColor3 = Color3.fromRGB(24, 27, 34)
    Frame.BorderSizePixel = 0
    Frame.Parent = ScreenGui

    u28.corner(Frame, u28.Radius.Card)

    local UIPadding = Instance.new("UIPadding")
    local v2 = nil

    for i, j in {"PaddingTop", "PaddingBottom", "PaddingLeft", "PaddingRight"}, nil, v2 do
        UIPadding[j] = (UDim.new(0, 16))
    end

    UIPadding.Parent = Frame
    local UIListLayout = Instance.new("UIListLayout")
    UIListLayout.Padding = UDim.new(0, 8)
    UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
    UIListLayout.Parent = Frame
    local v3 = text(Frame, if not a1.full then ("%* is open on another server"):format(coopName) else ("%*'s server is full"):format(coopName), 17, u28.Palette.Gold, true)
    v3.LayoutOrder = 1
    v3 = text(Frame, if not a1.full then "Join it there, or play another of your islands instead." else "Try again, or play another of your islands for now.", 13, u28.Palette.Text, false)
    v3.LayoutOrder = 2
    local u142 = {}

    local function choose(a1, a2) -- Line: 107; upvalues: u142 (val), u36 (val); types: a1: number, a2: userdata
        for i, j in u142 do
            j.Active = false
            j.AutoButtonColor = false
        end

        a2.Text = "Taking you there..."
        u36:FireServer(a1)
    end

    local function button(a1, a2, a3, a4)
        -- Line: 115
        -- upvalues: u28 (upval), Frame (val), u142 (val), u36 (val)
        -- types: a1: number, a2: string, a3: boolean, a4: number
        local TextButton = Instance.new("TextButton")
        TextButton.LayoutOrder = a1
        TextButton.Size = UDim2.new(1, 0, 0, u28.tap(36))
        local Gold = if not a3 then Color3.fromRGB(44, 49, 60) else u28.Palette.Gold
        TextButton.BackgroundColor3 = Gold
        local Text = if not a3 then u28.Palette.Text else Color3.fromRGB(24, 27, 34)
        TextButton.TextColor3 = Text
        local Bold = if not a3 then u28.Font.Medium else u28.Font.Bold
        TextButton.FontFace = Bold
        TextButton.TextSize = 14
        TextButton.Text = a2
        TextButton.TextTruncate = Enum.TextTruncate.AtEnd
        TextButton.BorderSizePixel = 0
        TextButton.Parent = Frame

        u28.corner(TextButton, u28.Radius.Row)
        table.insert(u142, TextButton)

        TextButton.Activated:Connect(function()
            -- Line: 129
            -- upvalues: TextButton (val), a4 (val), u142 (upval), u36 (upval)
            if TextButton.Active then
                for i, j in u142 do
                    j.Active = false
                    j.AutoButtonColor = false
                end

                TextButton.Text = "Taking you there..."
                u36:FireServer(a4)
            end
        end)
    end

    button(3, if not a1.full then ("Join %*"):format(coopName) else "Try again", true, 0)

    if #choices_2 > 0 then
        v2 = text(Frame, "or play", 12, u28.Palette.Dim, false)
        v2.LayoutOrder = 4
    end

    local v4 = nil
    local v5 = nil

    for k, n in choices_2, v4, v5 do
        name_2 = if type(n) ~= "table" then
            "Island"
        else
            if type(n.name) ~= "string" then "Island" else n.name
        v1 = if not n.coop then name_2 else ("%* (co-op)"):format(name_2)

        button(4 + k, v1, false, k)
    end

    local u204 = text(Frame, "", 12, u28.Palette.Faint, false)
    u204.LayoutOrder = 100
    local u209 = os.clock() + seconds_2
    u32 = RunService.Heartbeat:Connect(function()
        -- Line: 149
        -- upvalues: u209 (val), u204 (val), a1 (val), coopName (val)
        local v1 = math.max(0, (math.ceil(u209 - (os.clock()))))
        local v2 = if not a1.full then
            ("Joining %* in %*s"):format(coopName, v1)
        else
            ("Trying again in %*s"):format(v1)
        u204.Text = v2
    end)
    ScreenGui.Parent = LocalPlayer:WaitForChild("PlayerGui")
end

function v1.start() -- Line: 157; upvalues: Remotes (val), show (val), u32 (ref), u31 (ref)
    (Remotes.get(Remotes.LoadChoice)).OnClientEvent:Connect(function(a1)
        -- Line: 158
        -- upvalues: show (upval), u32 (upval), u31 (upval)
        if type(a1) == "table" then
            show(a1)
            return
        end

        if u32 then
            u32:Disconnect()

            u32 = nil
        end

        if u31 then
            u31:Destroy()

            u31 = nil
        end
    end)
end

return v1