-- Script path: game:GetService("ReplicatedFirst").LoadingScreen
-- Decompile time: 4.60 ms

local Attribute, v1, v2, v3, v4
local Players = game:GetService("Players")
local ReplicatedFirst = game:GetService("ReplicatedFirst")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local Workspace = game:GetService("Workspace")
local u355 = {
    Held = {
        status = "Your island is still open on another server",
        note = "Waiting for it to finish saving there. Your island is safe and will load shortly.",
    },
    Unreadable = {
        status = "Waiting for Roblox's data service",
        note = "It's slow to answer right now. Your island is safe and we're still trying.",
    },
    Routing = {
        status = "Taking you to your island",
        note = "It's open on another server, so we're sending you there.",
    },
    Closed = {
        status = "The server your island was on has closed",
        note = "It will open here within 3 minutes. Your island is safe; stay on this screen.",
    },
    Updating = {
        status = "Finding a server on the latest version",
        note = "This one is running an older version of ABOVE. Your island is safe.",
    },
    Choosing = {status = "Your co-op is open on another server", note = "Choose where to play."},
}
local v5 = Color3.fromRGB(14, 16, 21)
local u41 = Color3.fromRGB(238, 240, 248)
local u46 = Color3.fromRGB(126, 133, 152)
local u51 = Color3.fromRGB(196, 202, 216)
local v6 = Color3.fromRGB(255, 214, 110)
local v7 = Color3.fromRGB(40, 44, 56)
local LocalPlayer = Players.LocalPlayer
local u342 = os.clock()

ReplicatedFirst:RemoveDefaultLoadingScreen()

local v8 = Instance.new("ScreenGui")
v8.Name = "LoadingScreen"
v8.IgnoreGuiInset = true
v8.ResetOnSpawn = false
v8.DisplayOrder = 10000
local Frame_2 = Instance.new("Frame")
Frame_2.Size = UDim2.fromScale(1, 1)
Frame_2.BackgroundColor3 = v5
Frame_2.BorderSizePixel = 0
Frame_2.Parent = v8
v5 = Instance.new("TextLabel")
v5.AnchorPoint = Vector2.new(0.5, 0.5)
v5.Position = UDim2.new(0.5, 0, 0.5, -18)
v5.Size = UDim2.fromOffset(400, 60)
v5.BackgroundTransparency = 1
v5.FontFace = Font.new("rbxasset://fonts/families/Ubuntu.json", Enum.FontWeight.Bold)
v5.Text = "ABOVE"
v5.AutoLocalize = false
v5.TextSize = 52
v5.TextColor3 = u41
v5.Parent = Frame_2
local Frame = Instance.new("Frame")
Frame.AnchorPoint = Vector2.new(0.5, 0.5)
Frame.Position = UDim2.new(0.5, 0, 0.5, 26)
Frame.Size = UDim2.fromOffset(140, 2)
Frame.BackgroundColor3 = v7
Frame.BorderSizePixel = 0
Frame.ClipsDescendants = true
Frame.Parent = Frame_2
local u554 = Instance.new("Frame")
u554.Size = UDim2.fromOffset(36, 2)
u554.BackgroundColor3 = v6
u554.BorderSizePixel = 0
u554.Parent = Frame
local u430 = Instance.new("TextLabel")
u430.AnchorPoint = Vector2.new(0.5, 0.5)
u430.Position = UDim2.new(0.5, 0, 0.5, 48)
u430.Size = UDim2.fromOffset(600, 22)
u430.BackgroundTransparency = 1
u430.FontFace = Font.new("rbxasset://fonts/families/Ubuntu.json", Enum.FontWeight.Regular)
u430.Text = "Loading the world"
u430.TextSize = 14
u430.TextColor3 = u46
u430.Parent = Frame_2
local TextLabel = Instance.new("TextLabel")
TextLabel.AnchorPoint = Vector2.new(0.5, 0)
TextLabel.Position = UDim2.new(0.5, 0, 0.5, 64)
TextLabel.Size = UDim2.fromOffset(560, 44)
TextLabel.BackgroundTransparency = 1
TextLabel.FontFace = Font.new("rbxasset://fonts/families/Ubuntu.json", Enum.FontWeight.Regular)
TextLabel.Text = ""
TextLabel.TextSize = 13
TextLabel.TextWrapped = true
TextLabel.TextYAlignment = Enum.TextYAlignment.Top
TextLabel.TextColor3 = u46
TextLabel.Visible = false
TextLabel.Parent = Frame_2
local TextButton = Instance.new("TextButton")
TextButton.AnchorPoint = Vector2.new(1, 1)
TextButton.Position = UDim2.new(1, -24, 1, -20)
TextButton.Size = UDim2.fromOffset(70, 28)
TextButton.BackgroundTransparency = 1
TextButton.FontFace = Font.new("rbxasset://fonts/families/Ubuntu.json", Enum.FontWeight.Medium)
TextButton.Text = "Skip"
TextButton.TextSize = 14
TextButton.TextColor3 = u46
TextButton.Visible = false
TextButton.Parent = Frame_2
v8.Parent = LocalPlayer:WaitForChild("PlayerGui")

print("[ABOVE] load screen up")

local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")
PlayerGui.ScreenOrientation = Enum.ScreenOrientation.LandscapeSensor
local u370 = false

TextButton.Activated:Connect(function() -- Line: 192; upvalues: u370 (ref)
    u370 = true
end)

local u236 = RaycastParams.new()
u236.FilterType = Enum.RaycastFilterType.Exclude

local function standingOnSomething() -- Line: 199; upvalues: LocalPlayer (val), u236 (val), Workspace (val)
    local Character = LocalPlayer.Character
    local HumanoidRootPart = Character and Character:FindFirstChild("HumanoidRootPart")

    if HumanoidRootPart and HumanoidRootPart:IsA("BasePart") then
        u236.FilterDescendantsInstances = {Character}
        return Workspace:Raycast(HumanoidRootPart.Position, Vector3.new(0, -40, 0), u236) ~= nil
    end

    return false
end

local function waitingOn() -- Line: 210; upvalues: LocalPlayer (val), u355 (val)
    local Attribute = LocalPlayer:GetAttribute("LoadWaiting")

    if type(Attribute) == "string" and u355[Attribute] then
        return Attribute
    end

    return nil
end

local function ready()
    -- Line: 215
    -- upvalues: LocalPlayer (val), u355 (val), u430 (val), TextLabel (val), u41 (val), u51 (val), u46 (val)
    -- upvalues: standingOnSomething (val)
    local v1
    local Attribute = LocalPlayer:GetAttribute("LoadWaiting")

    if not (if type(Attribute) ~= "string" then nil else if not u355[Attribute] then nil else Attribute) then
        TextLabel.Visible = false
        u430.TextColor3 = u46
        u430.TextSize = 14
        u430.FontFace = Font.new("rbxasset://fonts/families/Ubuntu.json", Enum.FontWeight.Regular)

        if not game:IsLoaded() then
            u430.Text = "Loading the world"
            return false
        end

        if LocalPlayer:GetAttribute("Restored") ~= true then
            u430.Text = "Loading your island"
            return false
        end

        if not standingOnSomething() then
            u430.Text = "Almost there"
            return false
        end

        return true
    end

    local v2 = u355[v1]
    local v3 = LocalPlayer:GetAttribute("LoadAttempt")
    local Attribute_2 = LocalPlayer:GetAttribute("LoadAttempts")
    local status_2 = if type(v3) ~= "number" or type(Attribute_2) ~= "number" then
        v2.status
    else
        ("%* (%*/%*)"):format(v2.status, v3, Attribute_2)
    u430.Text = status_2
    TextLabel.Text = v2.note
    TextLabel.Visible = true
    u430.TextColor3 = u41
    u430.TextSize = 16
    u430.FontFace = Font.new("rbxasset://fonts/families/Ubuntu.json", Enum.FontWeight.Medium)
    TextLabel.TextColor3 = u51
    TextLabel.TextSize = 14

    return false
end

local v9 = RunService.RenderStepped:Connect(function() -- Line: 254; upvalues: u342 (val), u554 (val), Frame (val)
    u554.Position = UDim2.fromOffset((math.sin(((os.clock()) - u342) * 2.4) + 1) / 2 * (Frame.Size.X.Offset - u554.Size.X.Offset), 0)
end)
local v10 = u342

while true do
    v1 = os.clock()
    v2 = v1 - u342
    Attribute = LocalPlayer:GetAttribute("LoadWaiting")

    if (if type(Attribute) ~= "string" then nil else if not u355[Attribute] then nil else Attribute)
        ~= nil then
        v10 = v1
    end

    v4 = false

    if v2 >= 4 then
        v4 = not v3
    end

    TextButton.Visible = v4
    v4 = if not v3 then 12 <= v1 - v10 else v2 >= 300

    if u370 and not v3 then
        break
    end

    if v4 then
        break
    end

    if ready() and v2 >= 1.2 then
        break
    end

    task.wait(0.1)
end

v10 = TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
TweenService:Create(
    Frame_2,
    v10,
    {BackgroundTransparency = 1}
):Play()

for i, j in {v5, u430, TextLabel, TextButton} do
    TweenService:Create(
        j,
        v10,
        {TextTransparency = 1}
    ):Play()
end

TweenService:Create(
    Frame,
    v10,
    {BackgroundTransparency = 1}
):Play()

TweenService:Create(
    u554,
    v10,
    {BackgroundTransparency = 1}
):Play()

task.wait(0.5)
v9:Disconnect()
v8:Destroy()

v9 = if not u370 then if not ready() then "timeout" else "ready" else "skipped"
local v11 = (game:GetService("ReplicatedStorage")):WaitForChild("Remotes", 30)
local v12 = v11 and v11:WaitForChild("LoadScreenClosed", 30)

if v12 and v12:IsA("RemoteEvent") then
    v12:FireServer(v9)
end