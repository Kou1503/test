-- Script path: game:GetService("Players").TheKiller150306Alt.PlayerScripts.Client.Controllers.ShowcaseController
-- Decompile time: 4.52 ms

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local Workspace = game:GetService("Workspace")
local Shared = (game:GetService("ReplicatedStorage")):WaitForChild("Shared")
local Config = require(Shared.Config)
local Remotes = require(Shared.Remotes)
local u41 = require(script.Parent.Parent.Ui)
local v1 = {}
local LocalPlayer = Players.LocalPlayer
local u44 = false

local function label(a1, a2, a3, a4, a5)
    -- Line: 39
    -- upvalues: u41 (val)
    -- types: a1: userdata, a2: string, a3: number, a4: number, a5: boolean
    local TextLabel = Instance.new("TextLabel")
    TextLabel.AnchorPoint = Vector2.new(0.5, 0)
    TextLabel.Position = UDim2.new(0.5, 0, 0, a4)
    TextLabel.Size = UDim2.new(0.9, 0, 0, a3 + 8)
    TextLabel.BackgroundTransparency = 1
    TextLabel.Text = a2
    local Gold = if not a5 then Color3.fromRGB(236, 240, 250) else u41.Palette.Gold
    TextLabel.TextColor3 = Gold
    TextLabel.TextSize = a3
    local Bold = if not a5 then u41.Font.Medium else u41.Font.Bold
    TextLabel.FontFace = Bold
    TextLabel.TextWrapped = true
    TextLabel.Parent = a1

    return TextLabel
end

local function play(a1)
    -- Line: 54
    -- upvalues: u44 (ref), Config (val), Remotes (val), Workspace (val), LocalPlayer (val), label (val), u41 (val)
    -- upvalues: RunService (val), TweenService (val)
    -- types: a1: userdata
    if not u44 and a1:IsA("Model") then
        local v1, v2
        u44 = true
        local Showcase = Config.Tutorial.Showcase
        local u240 = Remotes.get(Remotes.ShowcaseDone)
        local u244 = a1:Clone()
        u244.Name = "ShowcaseIslandLocal"
        local v3 = Vector3.new(Showcase.At.x, Showcase.At.y, Showcase.At.z)

        u244:PivotTo((CFrame.new(v3)))

        u244.Parent = Workspace
        local u252 = v3 + Vector3.new(4, 0, 0)
        local CurrentCamera = Workspace.CurrentCamera
        local CameraType = CurrentCamera.CameraType
        CurrentCamera.CameraType = Enum.CameraType.Scriptable
        local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")
        local u260 = {}

        for i, j in PlayerGui:GetChildren() do
            if j:IsA("ScreenGui") and j.Enabled then
                j.Enabled = false
                table.insert(u260, j)
            end
        end

        local ScreenGui = Instance.new("ScreenGui")
        ScreenGui.Name = "Showcase"
        ScreenGui.IgnoreGuiInset = true
        ScreenGui.ScreenInsets = Enum.ScreenInsets.None
        ScreenGui.DisplayOrder = 50
        ScreenGui.ResetOnSpawn = false
        ScreenGui.Parent = PlayerGui
        local v4 = {true, false}
        local v5 = nil
        local v6 = nil

        for k, n in v4, v5, v6 do
            v2 = Instance.new("Frame")
            v2.AnchorPoint = Vector2.new(0, if not n then 1 else 0)
            v2.Position = UDim2.fromScale(0, if not n then 1 else 0)
            v1 = if not n then
                UDim2.fromScale(1, 0.11)
            else
                (UDim2.fromOffset(0, 68)) + UDim2.fromScale(1, 0)
            v2.Size = v1
            v2.BackgroundColor3 = Color3.new(0, 0, 0)
            v2.BorderSizePixel = 0
            v2.Parent = ScreenGui
        end

        label(ScreenGui, Showcase.Title, 28, 18, true)

        local TextButton = Instance.new("TextButton")
        TextButton.AnchorPoint = Vector2.new(1, 1)
        TextButton.Position = UDim2.new(1, if not u41.TouchOnly then -24 else -64, 1, -18)
        TextButton.Size = UDim2.fromOffset(90, u41.tap(32))
        TextButton.BackgroundColor3 = Color3.fromRGB(40, 44, 56)
        TextButton.Text = Showcase.Skip
        TextButton.TextColor3 = Color3.fromRGB(236, 240, 250)
        TextButton.TextSize = u41.tapText(15)
        TextButton.FontFace = u41.Font.Bold
        TextButton.Parent = ScreenGui

        u41.corner(TextButton, 6)

        local Frame = Instance.new("Frame")
        Frame.Size = UDim2.fromScale(1, 1)
        Frame.BackgroundColor3 = Color3.new(0, 0, 0)
        Frame.BackgroundTransparency = 1
        Frame.ZIndex = 10
        Frame.Parent = ScreenGui
        local u155 = os.clock()
        local u156 = false
        local u166 = RunService.RenderStepped:Connect(function()
            -- Line: 127
            -- upvalues: u155 (val), Showcase (val), u252 (val), CurrentCamera (val)
            local v1 = math.clamp((os.clock() - u155) / Showcase.TourSeconds, 0, 1)
            local v2 = v1 * v1 * (3 - v1 * 2)
            v1 = math.rad(v2 * -140 + 250)
            local v3 = v2 * -38 + 110
            local v4 = v2 * -32 + 70
            CurrentCamera.CFrame = CFrame.lookAt(u252 + Vector3.new(math.cos(v1) * v3, v4, (math.sin(v1)) * v3), u252 + Vector3.new(0, 4, 0))
        end)

        local function finish()
            -- Line: 137
            -- upvalues: u156 (ref), TweenService (upval), Frame (val), u166 (val), u244 (val), ScreenGui (val)
            -- upvalues: CurrentCamera (val), CameraType (val), LocalPlayer (upval), u240 (val), u260 (val), u44 (upval)
            if u156 then
                return
            end

            u156 = true
            TweenService:Create(
                Frame,
                TweenInfo.new(0.35),
                {BackgroundTransparency = 0}
            ):Play()

            task.wait(0.35)
            u166:Disconnect()
            u244:Destroy()

            for i, j in ScreenGui:GetChildren() do
                if j ~= Frame then
                    j:Destroy()
                end
            end

            CurrentCamera.CameraType = if CameraType ~= Enum.CameraType.Scriptable then
                CameraType
            else
                Enum.CameraType.Custom
            local Character = LocalPlayer.Character
            local Humanoid = Character and Character:FindFirstChildOfClass("Humanoid")

            if Humanoid then
                CurrentCamera.CameraSubject = Humanoid
            end

            u240:FireServer()

            for k, n in u260 do
                if n.Parent then
                    n.Enabled = true
                end
            end

            TweenService:Create(
                Frame,
                TweenInfo.new(0.35),
                {BackgroundTransparency = 1}
            ):Play()

            task.wait(0.35)
            ScreenGui:Destroy()

            u44 = false
        end

        TextButton.Activated:Connect(function() -- Line: 171; upvalues: finish (val)
            task.spawn(finish)
        end)

        task.delay(Showcase.TourSeconds, finish)
    end
end

function v1.start() -- Line: 177; upvalues: LocalPlayer (val), play (val)
    local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")
    PlayerGui.ChildAdded:Connect(function(a1) -- Line: 179; upvalues: play (upval)
        if a1.Name == "ShowcaseDelivery" then
            local v1
            local v2 = -1
            local v3 = 0

            while a1.Parent do
                if not (v3 < 6) then
                    break
                end

                v1 = #a1:GetDescendants()

                if v1 == v2 then
                    break
                end

                v2 = v1
                task.wait(0.4)

                v3 = v3 + 0.4
            end

            if a1.Parent then
                play(a1)
            end
        end
    end)

    local ShowcaseDelivery = PlayerGui:FindFirstChild("ShowcaseDelivery")

    if ShowcaseDelivery then
        task.defer(play, ShowcaseDelivery)
    end
end

return v1