-- Script path: game:GetService("Players").TheKiller150306Alt.PlayerScripts.Client.Controllers.TutorialController
-- Decompile time: 18.14 ms

local v1
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local DeviceMode = require(script.Parent.DeviceMode)
local Shared = (game:GetService("ReplicatedStorage")):WaitForChild("Shared")
local Config = require(Shared.Config)
local Remotes = require(Shared.Remotes)
local u46 = require(script.Parent.Parent.Ui)
local ObjectiveController = require(script.Parent.ObjectiveController)
local HotbarController = require(script.Parent.HotbarController)
local BuildController = require(script.Parent.BuildController)
local ControlGlyphs = require(script.Parent.ControlGlyphs)
local KeyBinds = require(script.Parent.KeyBinds)
local TutorialArrow = require(script.Parent.TutorialArrow)
local GuideBeam = require(script.Parent.GuideBeam)
local NewPlayerView = require(script.Parent.NewPlayerView)
local WelcomeController = require(script.Parent.WelcomeController)
local LocalPlayer = Players.LocalPlayer
local u98 = Color3.fromRGB(255, 210, 40)
local u99 = nil
local u100 = {}
local u101 = nil
local u102 = {}

local function clearMarks() -- Line: 58; upvalues: u99 (ref), u100 (val), u102 (val), u101 (ref)
    if u99 then
        u99:Destroy()

        u99 = nil
    end

    table.clear(u100)
    table.clear(u102)

    if u101 then
        u101:Disconnect()

        u101 = nil
    end
end

local function moveArrows() -- Line: 71; upvalues: TutorialArrow (val), u100 (val)
    TutorialArrow.move(u100)
end

local function arrow3dOver(a1, a2)
    -- Line: 76
    -- upvalues: TutorialArrow (val), u100 (val)
    -- types: a1: userdata, a2: number
    local v1 = TutorialArrow.make(a1, a1.Position + Vector3.new(0, a1.Size.Y / 2, 0), a2 * 0.9)

    if not v1 then
        return false
    end

    table.insert(u100, v1)

    return true
end

local function arrowOver(a1) -- Line: 85; upvalues: u98 (val), TweenService (val); types: a1: userdata
    local UIStroke
    local BillboardGui = Instance.new("BillboardGui")
    BillboardGui.Name = "Arrow"
    BillboardGui.Adornee = a1
    BillboardGui.Size = UDim2.fromOffset(36, 52)
    BillboardGui.StudsOffset = Vector3.new(0, 3.5999999046325684, 0)
    BillboardGui.AlwaysOnTop = false
    BillboardGui.LightInfluence = 0
    BillboardGui.MaxDistance = 250
    BillboardGui.Parent = a1
    local Frame = Instance.new("Frame")
    Frame.AnchorPoint = Vector2.new(0.5, 0)
    Frame.Position = UDim2.fromScale(0.5, 0)
    Frame.Size = UDim2.fromOffset(10, 26)
    Frame.BackgroundColor3 = u98
    Frame.BorderSizePixel = 0
    Frame.Parent = BillboardGui
    local Frame_2 = Instance.new("Frame")
    Frame_2.AnchorPoint = Vector2.new(0.5, 0.5)
    Frame_2.Position = UDim2.new(0.5, 0, 0, 32)
    Frame_2.Size = UDim2.fromOffset(24, 24)
    Frame_2.Rotation = 45
    Frame_2.BackgroundColor3 = u98
    Frame_2.BorderSizePixel = 0
    Frame_2.Parent = BillboardGui

    for i, j in {Frame, Frame_2} do
        UIStroke = Instance.new("UIStroke")
        UIStroke.Color = Color3.fromRGB(60, 44, 10)
        UIStroke.Thickness = 2
        UIStroke.Parent = j
    end

    TweenService:Create(
        BillboardGui,
        TweenInfo.new(0.55, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut, -1, true),
        {StudsOffset = Vector3.new(0, 4.400000095367432, 0)}
    ):Play()
end

local function timerOver(a1, a2) -- Line: 132; upvalues: u46 (val), u102 (val); types: a1: userdata, a2: number
    local BillboardGui = Instance.new("BillboardGui")
    BillboardGui.Name = "Timer"
    BillboardGui.Adornee = a1
    BillboardGui.Size = UDim2.fromOffset(84, 30)
    BillboardGui.StudsOffset = Vector3.new(0, 6, 0)
    BillboardGui.AlwaysOnTop = true
    BillboardGui.LightInfluence = 0
    BillboardGui.MaxDistance = 160
    BillboardGui.Parent = a1
    local TextLabel = Instance.new("TextLabel")
    TextLabel.Size = UDim2.fromScale(1, 1)
    TextLabel.BackgroundTransparency = 1
    TextLabel.FontFace = u46.Font.Bold
    TextLabel.TextSize = 20
    TextLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    TextLabel.TextStrokeColor3 = Color3.fromRGB(20, 22, 28)
    TextLabel.TextStrokeTransparency = 0.2
    TextLabel.Text = ""
    TextLabel.Parent = BillboardGui

    table.insert(
        u102,
        {label = TextLabel, at = a2}
    )
end

local function tickTimers() -- Line: 158; upvalues: u102 (val)
    local label, v1, v2, v3
    local ServerTimeNow = workspace:GetServerTimeNow()
    local v4 = nil
    local v5 = nil

    for i, j in u102, v4, v5 do
        v1 = math.ceil(j.at - ServerTimeNow)
        v2 = if not (v1 > 0) then "Ready!" else ("%*s"):format(v1)

        if j.label.Text ~= v2 then
            j.label.Text = v2
            label = j.label
            v3 = if not (v1 > 0) then
                Color3.fromRGB(150, 235, 160)
            else
                Color3.fromRGB(255, 255, 255)
            label.TextColor3 = v3
        end
    end
end

local function showMarks(a1, a2)
    -- Line: 170
    -- upvalues: u99 (ref), u100 (val), u102 (val), u101 (ref), u98 (val), TutorialArrow (val), arrowOver (val)
    -- upvalues: timerOver (val), RunService (val), moveArrows (val)
    -- types: a1: table, a2: table?
    local Part, SelectionBox, v1, v2, v3

    if u99 then
        u99:Destroy()

        u99 = nil
    end

    table.clear(u100)
    table.clear(u102)

    if u101 then
        u101:Disconnect()

        u101 = nil
    end

    local Folder = Instance.new("Folder")
    Folder.Name = "TutorialMarks"
    local v4 = nil
    local v5 = nil

    for i, j in a1, v4, v5 do
        Part = Instance.new("Part")
        Part.Name = "Mark"
        Part.Anchored = true
        Part.CanCollide = false
        Part.CanQuery = false
        Part.CanTouch = false
        Part.Transparency = 1
        Part.Size = Vector3.new(3.049999952316284, 3.049999952316284, 3.049999952316284)
        Part.CFrame = CFrame.new(j)
        Part.Parent = Folder
        SelectionBox = Instance.new("SelectionBox")
        SelectionBox.Adornee = Part
        SelectionBox.Color3 = u98
        SelectionBox.LineThickness = 0.07
        SelectionBox.SurfaceColor3 = u98
        SelectionBox.SurfaceTransparency = 0.8
        SelectionBox.Parent = Part
        v2 = #Folder:GetChildren()
        v3 = TutorialArrow.make(Part, Part.Position + Vector3.new(0, Part.Size.Y / 2, 0), v2 * 0.9)

        if v3 then
            table.insert(u100, v3)

            v1 = true
        else
            v1 = false
        end

        if not v1 then
            arrowOver(Part)
        end

        v1 = if not v6 then nil else v6[#Folder:GetChildren()]

        if type(v1) == "number" then
            timerOver(Part, v1)
        end
    end

    Folder.Parent = workspace
    u99 = Folder

    if #u100 > 0 then
        TutorialArrow.move(u100)

        u101 = RunService.RenderStepped:Connect(moveArrows)
    end
end

local u110 = nil
local u111 = {}
local u112 = false

local function loadingScreenUp() -- Line: 220; upvalues: LocalPlayer (val)
    local PlayerGui = LocalPlayer:FindFirstChildOfClass("PlayerGui")
    local v1 = false

    if PlayerGui ~= nil then
        v1 = PlayerGui:FindFirstChild("LoadingScreen") ~= nil
    end

    return v1
end

local function lookAtWater(a1, a2)
    -- Line: 225
    -- upvalues: u111 (val), u112 (ref), LocalPlayer (val), Config (val), WelcomeController (val), u110 (ref)
    -- upvalues: RunService (val), UserInputService (val), TweenService (val)
    -- types: a1: string, a2: vector
    if not u111[a1] and not u112 then
        u111[a1] = true
        u112 = true

        task.spawn(function()
            -- Line: 231
            -- upvalues: LocalPlayer (upval), Config (upval), WelcomeController (upval), a2 (val), u110 (upval)
            -- upvalues: a1 (val), u112 (upval), RunService (upval), UserInputService (upval), TweenService (upval)
            local PlayerGui, v1
            local v2 = os.clock() + 30

            while true do
                PlayerGui = LocalPlayer:FindFirstChildOfClass("PlayerGui")
                v1 = false

                if PlayerGui ~= nil then
                    v1 = PlayerGui:FindFirstChild("LoadingScreen") ~= nil
                end

                if not v1 or not (os.clock() < v2) then
                    break
                end

                task.wait(0.25)
            end

            task.wait(Config.Tutorial.Guide.Camera.WelcomeGraceSeconds)

            v2 = os.clock() + 600

            while WelcomeController.pending() do
                if not (os.clock() < v2) then
                    break
                end

                task.wait(0.25)
            end

            local Camera = Config.Tutorial.Guide.Camera
            local CurrentCamera = workspace.CurrentCamera
            local Character = LocalPlayer.Character
            local HumanoidRootPart = if not Character then
                nil
            else
                Character:FindFirstChild("HumanoidRootPart")
            local Magnitude = if not HumanoidRootPart then
                (1 / 0)
            else
                (HumanoidRootPart.Position - a2).Magnitude

            if CurrentCamera
                and HumanoidRootPart
                and not (Camera.MaxStuds < Magnitude)
                and not (Magnitude < Camera.NearStuds)
                and u110 == a1 then
                local Humanoid = Character:FindFirstChildOfClass("Humanoid")

                if Humanoid and 0.1 < Humanoid.MoveDirection.Magnitude then
                    u112 = false
                    return
                end

                local v3 = Vector3.new(HumanoidRootPart.Position.X - a2.X, 0, HumanoidRootPart.Position.Z - a2.Z)
                local v4 = CFrame.lookAt(a2 + (if not (0.1 < v3.Magnitude) then Vector3.new(0, 0, 1) else v3.Unit) * Camera.DistanceStuds + Vector3.new(0, Camera.HeightStuds, 0), a2)
                local CFrame_2 = CurrentCamera.CFrame
                local CameraType = CurrentCamera.CameraType
                local u122 = false
                local u123 = nil
                local u135 = nil
                local u125 = nil

                local function handBack()
                    -- Line: 278
                    -- upvalues: u122 (ref), u123 (ref), u135 (ref), u125 (ref), CurrentCamera (val), CameraType (val)
                    -- upvalues: u112 (upval)
                    if u122 then
                        return
                    end

                    u122 = true

                    if u123 then
                        u123:Disconnect()
                    end

                    if u135 then
                        u135:Disconnect()
                    end

                    if u125 then
                        u125:Cancel()
                    end

                    CurrentCamera.CameraType = CameraType
                    u112 = false
                end

                if Humanoid then
                    u135 = RunService.Heartbeat:Connect(function()
                        -- Line: 300
                        -- upvalues: Humanoid (val), u122 (ref), u123 (ref), u135 (ref), u125 (ref), CurrentCamera (val)
                        -- upvalues: CameraType (val), u112 (upval)
                        if not (0.1 < Humanoid.MoveDirection.Magnitude) and not Humanoid.Jump then
                            return
                        end

                        if u122 then
                            return
                        end

                        u122 = true

                        if u123 then
                            u123:Disconnect()
                        end

                        if u135 then
                            u135:Disconnect()
                        end

                        if u125 then
                            u125:Cancel()
                        end

                        CurrentCamera.CameraType = CameraType
                        u112 = false
                    end)
                end

                u123 = UserInputService.InputBegan:Connect(function(a1)
                    -- Line: 306
                    -- upvalues: u122 (ref), u123 (ref), u135 (ref), u125 (ref), CurrentCamera (val), CameraType (val)
                    -- upvalues: u112 (upval)
                    local UserInputType = a1.UserInputType

                    if UserInputType ~= Enum.UserInputType.Keyboard
                        and UserInputType ~= Enum.UserInputType.MouseButton1
                        and UserInputType ~= Enum.UserInputType.MouseButton2
                        and UserInputType ~= Enum.UserInputType.Touch
                        and UserInputType ~= Enum.UserInputType.Gamepad1 then
                        return
                    end

                    if u122 then
                        return
                    end

                    u122 = true

                    if u123 then
                        u123:Disconnect()
                    end

                    if u135 then
                        u135:Disconnect()
                    end

                    if u125 then
                        u125:Cancel()
                    end

                    CurrentCamera.CameraType = CameraType
                    u112 = false
                end)
                CurrentCamera.CameraType = Enum.CameraType.Scriptable
                local v5 = TweenInfo.new(Camera.MoveSeconds, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut)
                u125 = TweenService:Create(
                    CurrentCamera,
                    v5,
                    {CFrame = v4}
                )

                u125:Play()
                task.wait(Camera.MoveSeconds + Camera.HoldSeconds)

                if u122 then
                    return
                end

                u125 = TweenService:Create(
                    CurrentCamera,
                    v5,
                    {CFrame = CFrame_2}
                )
                u125:Play()
                task.wait(Camera.MoveSeconds)

                u125 = nil

                if not u122 then
                    u122 = true

                    if u123 then
                        u123:Disconnect()
                    end

                    if u135 then
                        u135:Disconnect()
                    end

                    if u125 then
                        u125:Cancel()
                    end

                    CurrentCamera.CameraType = CameraType
                    u112 = false
                end

                return
            end

            u112 = false
        end)
    end
end

local u115 = nil

local function applyGuide(a1)
    -- Line: 339
    -- upvalues: showMarks (val), tickTimers (val), u99 (ref), u100 (val), u102 (val), u101 (ref), u115 (ref)
    -- upvalues: Config (val), HotbarController (val)
    local points_2 = if type(a1) ~= "table" then
        nil
    else
        if type(a1.points) ~= "table" then nil else a1.points

    if not points_2 or not (#points_2 > 0) then
        if u99 then
            u99:Destroy()

            u99 = nil
        end

        table.clear(u100)
        table.clear(u102)

        if u101 then
            u101:Disconnect()

            u101 = nil
        end
    else
        showMarks(points_2, if type(a1.times) ~= "table" then nil else a1.times)
        tickTimers()
    end

    local item_2 = if type(a1) ~= "table" then
        nil
    else
        if type(a1.item) ~= "string" then nil else a1.item
    local v1 = false

    if u115 ~= nil then
        v1 = Config.Tutorial.Guide.KeepInHand[u115] == true
    end

    u115 = item_2
    HotbarController.suggest(item_2, v1)
end

local v2 = {}
local u118 = nil
local u119 = nil
local u120 = nil
local u121 = nil
local u122 = nil
local u123 = nil
local u124 = false
local u125 = nil
local u126 = nil
local u127 = nil
local u128 = 0
local u129 = false
local u130 = false
local u131 = nil
local u134 = Remotes.get(Remotes.TutorialProgress)
local u136 = DeviceMode.touchOnly()
local u138 = if not u136 then 300 else 230

local function placeFor(a1) -- Line: 404; upvalues: u136 (val); types: a1: boolean
    local v1 = if not a1 then -20 else 0

    if u136 then
        return UDim2.fromOffset(v1 + 12, 8)
    end

    return UDim2.new(0, v1 + 70, 0.45, 0)
end

local function fadeWords(a1, a2)
    -- Line: 413
    -- upvalues: u119 (ref), TweenService (val)
    -- types: a1: boolean, a2: number
    local v1
    local v2, v3 = a2, a1

    for i, j in u119:GetDescendants() do
        if j:IsA("TextLabel") or j:IsA("TextButton") then
            v1 = TweenInfo.new(v2)
            TweenService:Create(
                j,
                v1,
                {TextTransparency = if not v3 then 1 else 0}
            ):Play()
        end
    end
end

local function setShown(a1)
    -- Line: 421
    -- upvalues: u124 (ref), u128 (ref), u129 (ref), u130 (ref), u127 (ref), u126 (ref), ObjectiveController (val)
    -- upvalues: u119 (ref), TweenService (val), u136 (val), fadeWords (val)
    -- types: a1: boolean
    if u124 == a1 then
        return
    end

    u124 = a1
    u128 = u128 + 1
    u129 = false
    u130 = false
    u127.Scale = 1
    u126.Transparency = 0.6
    u126.Thickness = 1

    ObjectiveController.setSuppressed(a1)

    u119.Visible = true
    local v1 = u119
    local v2 = TweenInfo.new(0.25, Enum.EasingStyle.Quad)
    local v3 = {BackgroundTransparency = if not a1 then 1 else 0.15}
    local v4 = if not a1 then -20 else 0
    v3.Position = if not u136 then
        UDim2.new(0, v4 + 70, 0.45, 0)
    else
        UDim2.fromOffset(v4 + 12, 8)

    TweenService:Create(v1, v2, v3):Play()
    fadeWords(a1, 0.25)

    if not a1 then
        task.delay(
            0.3,
            function() -- Line: 441; upvalues: u124 (upval), u119 (upval)
                if not u124 then
                    u119.Visible = false
                end
            end
        )
    end
end

local function popIn()
    -- Line: 450
    -- upvalues: u119 (ref), u136 (val), u127 (ref), TweenService (val), fadeWords (val), u126 (ref)
    local v1 = u119
    local v2 = if not u136 then UDim2.new(0, 50, 0.45, 0) else UDim2.fromOffset(-8, 8)
    v1.Position = v2
    u127.Scale = 0.92

    for i, j in u119:GetDescendants() do
        if j:IsA("TextLabel") or j:IsA("TextButton") then
            j.TextTransparency = 1
        end
    end

    local v3 = u119
    local v4 = TweenInfo.new(0.3, Enum.EasingStyle.Quad)
    local v5 = {}
    local v6 = if not u136 then UDim2.new(0, 70, 0.45, 0) else UDim2.fromOffset(12, 8)
    v5.Position = v6

    TweenService:Create(v3, v4, v5):Play()

    TweenService:Create(
        u127,
        TweenInfo.new(0.3, Enum.EasingStyle.Back),
        {Scale = 1}
    ):Play()

    fadeWords(true, 0.3)

    u126.Transparency = 0
    u126.Thickness = 2.5

    TweenService:Create(
        u126,
        TweenInfo.new(0.8, Enum.EasingStyle.Quad),
        {Transparency = 0.6, Thickness = 1}
    ):Play()
end

local function swap(a1)
    -- Line: 472
    -- upvalues: u128 (ref), u118 (ref), u129 (ref), u130 (ref), TweenService (val), u119 (ref), u136 (val)
    -- upvalues: fadeWords (val), u124 (ref), popIn (val)
    -- types: a1: function
    u128 = u128 + 1
    local u3 = u128

    if not u118.Enabled then
        u129 = false
        a1()

        u130 = true

        return
    end

    u129 = true
    local v1 = u119
    local v2 = TweenInfo.new(0.15, Enum.EasingStyle.Quad, Enum.EasingDirection.In)
    local v3 = {}
    local v4 = if not u136 then UDim2.new(0, 50, 0.45, 0) else UDim2.fromOffset(-8, 8)
    v3.Position = v4

    TweenService:Create(v1, v2, v3):Play()
    fadeWords(false, 0.15)

    task.delay(
        0.15,
        function() -- Line: 488; upvalues: u3 (val), u128 (upval), u124 (upval), u129 (upval), a1 (val), popIn (upval)
            if u3 == u128 and u124 then
                u129 = false
                a1()
                popIn()
            end
        end
    )
end

local u155 = nil

local function refreshCountdown()
    -- Line: 503
    -- upvalues: u155 (ref), u110 (ref), u129 (ref), Config (val), u121 (ref), DeviceMode (val), KeyBinds (val)
    local v1 = u155

    if u110 == "Harvest" and v1 and not u129 then
        local Guide = Config.Tutorial.Guide
        local v2 = math.ceil(v1 - (workspace:GetServerTimeNow()))
        local v3 = u121
        local RipeTouch = if not (v2 > 0) then
            if not DeviceMode.touchOnly() then
                KeyBinds.fill(Guide.Ripe)
            else
                Guide.RipeTouch
        else
            string.format(Guide.Growing, v2)
        v3.Text = RipeTouch
    end
end

local function render()
    -- Line: 516
    -- upvalues: u110 (ref), GuideBeam (val), u131 (ref), setShown (val), Config (val), u121 (ref), u123 (ref)
    -- upvalues: u125 (ref), TweenService (val), u120 (ref), DeviceMode (val), KeyBinds (val), refreshCountdown (val)
    -- upvalues: u124 (ref), swap (val)
    local fill
    local v1 = u110

    if not v1 then
        GuideBeam.set(nil)

        u131 = nil
        setShown(false)

        return
    end

    for i, j in Config.Tutorial.Steps do
        if j.id == v1 then
            function fill()
                -- Line: 526
                -- upvalues: u121 (upval), u123 (upval), u125 (upval), i (val), Config (upval), TweenService (upval)
                -- upvalues: u120 (upval), j (val), DeviceMode (upval), KeyBinds (upval), refreshCountdown (upval)
                u121.Visible = true
                u123.Parent.Parent.Visible = true
                u125.Text = ("%* / %*"):format(i, #Config.Tutorial.Steps)

                TweenService:Create(
                    u123,
                    TweenInfo.new(0.4, Enum.EasingStyle.Quad),
                    {Size = UDim2.fromScale(i / #Config.Tutorial.Steps, 1)}
                ):Play()

                u120.Text = j.text
                local v1 = u121
                local touchHint = if not DeviceMode.touchOnly() then
                    KeyBinds.fill(j.hint)
                else
                    j.touchHint
                v1.Text = touchHint

                refreshCountdown()
            end

            GuideBeam.set(j.guideTo)

            if not u124 or u131 == nil or u131 == v1 then
                fill()
            else
                swap(fill)
            end

            u131 = v1
            setShown(true)

            return
        end
    end

    GuideBeam.set(nil)

    u131 = nil
    setShown(false)
end

function v2.isActive() -- Line: 561; upvalues: u110 (ref)
    return u110 ~= nil
end

function v2.isShowing() -- Line: 567; upvalues: u124 (ref)
    return u124
end

function v2.start()
    -- Line: 571
    -- upvalues: refreshCountdown (val), tickTimers (val), u118 (ref), LocalPlayer (val), BuildController (val)
    -- upvalues: u130 (ref), u124 (ref), popIn (val), KeyBinds (val), u110 (ref), render (val), ControlGlyphs (val)
    -- upvalues: u119 (ref), u138 (val), u136 (val), u126 (ref), u127 (ref), u120 (ref), u46 (val), u121 (ref)
    -- upvalues: u123 (ref), u125 (ref), u122 (ref), NewPlayerView (val), u99 (ref), u100 (val), u102 (val), u101 (ref)
    -- upvalues: u115 (ref), Config (val), HotbarController (val), u134 (val), Remotes (val), applyGuide (val)
    -- upvalues: u155 (ref), u111 (val), u112 (ref), WelcomeController (val), RunService (val), UserInputService (val)
    -- upvalues: TweenService (val), GuideBeam (val), swap (val), u131 (ref), setShown (val)
    task.spawn(function() -- Line: 573; upvalues: refreshCountdown (upval), tickTimers (upval)
        while true do
            task.wait(0.25)
            refreshCountdown()
            tickTimers()
        end
    end)

    u118 = Instance.new("ScreenGui")
    u118.Name = "Tutorial"
    u118.ResetOnSpawn = false
    u118.IgnoreGuiInset = false
    u118.DisplayOrder = 4
    u118.Parent = LocalPlayer:WaitForChild("PlayerGui")

    BuildController.onUiOpenChanged(function(a1)
        -- Line: 591
        -- upvalues: u118 (upval), u130 (upval), u124 (upval), popIn (upval)
        u118.Enabled = not a1

        if not a1 and u130 and u124 then
            u130 = false
            popIn()
        end
    end)

    KeyBinds.onChanged(function() -- Line: 599; upvalues: u110 (upval), render (upval)
        if u110 then
            render()
        end
    end)

    ControlGlyphs.onChanged(function() -- Line: 605; upvalues: u110 (upval), render (upval)
        if u110 then
            render()
        end
    end)

    u119 = Instance.new("Frame")
    u119.Size = UDim2.fromOffset(u138, 0)
    u119.AutomaticSize = Enum.AutomaticSize.Y
    local v1 = u119
    local v2 = if not u136 then UDim2.new(0, 50, 0.45, 0) else UDim2.fromOffset(-8, 8)
    v1.Position = v2
    u119.BackgroundColor3 = Color3.fromRGB(18, 20, 30)
    u119.BackgroundTransparency = 1
    u119.BorderSizePixel = 0
    u119.Visible = false
    u119.Parent = u118
    local UICorner = Instance.new("UICorner")
    UICorner.CornerRadius = UDim.new(0, 8)
    UICorner.Parent = u119
    u126 = Instance.new("UIStroke")
    u126.Color = Color3.fromRGB(255, 226, 130)
    u126.Transparency = 0.6
    u126.Parent = u119
    u127 = Instance.new("UIScale")
    u127.Parent = u119
    local UIPadding = Instance.new("UIPadding")
    UIPadding.PaddingTop = UDim.new(0, if not u136 then 10 else 8)
    UIPadding.PaddingBottom = UDim.new(0, 4)
    UIPadding.PaddingLeft = UDim.new(0, if not u136 then 12 else 10)
    UIPadding.PaddingRight = UDim.new(0, if not u136 then 12 else 10)
    UIPadding.Parent = u119
    local UIListLayout = Instance.new("UIListLayout")
    UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
    UIListLayout.Padding = UDim.new(0, if not u136 then 4 else 3)
    UIListLayout.Parent = u119

    local function textRow(a1, a2, a3, a4)
        -- Line: 645
        -- upvalues: u119 (upval)
        -- types: a1: number, a2: number, a3: userdata, a4: userdata
        local TextLabel = Instance.new("TextLabel")
        TextLabel.LayoutOrder = a1
        TextLabel.Size = UDim2.fromScale(1, 0)
        TextLabel.AutomaticSize = Enum.AutomaticSize.Y
        TextLabel.TextWrapped = true
        TextLabel.TextXAlignment = Enum.TextXAlignment.Left
        TextLabel.TextYAlignment = Enum.TextYAlignment.Top
        TextLabel.BackgroundTransparency = 1
        TextLabel.Text = ""
        TextLabel.TextColor3 = a4
        TextLabel.TextSize = a2
        TextLabel.FontFace = a3
        TextLabel.TextTransparency = 1
        TextLabel.Parent = u119

        return TextLabel
    end

    u120 = textRow(1, if not u136 then 17 else 14, u46.Font.Bold, u46.Palette.Text)
    u121 = textRow(2, if not u136 then 15 else 13, u46.Font.Medium, Color3.fromRGB(222, 228, 240))
    local Frame = Instance.new("Frame")
    Frame.LayoutOrder = 3
    Frame.Size = UDim2.new(1, 0, 0, u46.tap(22))
    Frame.BackgroundTransparency = 1
    Frame.Parent = u119
    u123 = u46.bar(Frame, UDim2.new(1, -100, 0, 5), UDim2.new(0, 0, 0.5, -2), Color3.fromRGB(120, 220, 140))
    u125 = Instance.new("TextLabel")
    u125.Size = UDim2.new(0, 40, 1, 0)
    u125.Position = UDim2.new(1, -96, 0, 0)
    u125.BackgroundTransparency = 1
    u125.TextXAlignment = Enum.TextXAlignment.Right
    u125.Text = ""
    u125.TextColor3 = Color3.fromRGB(150, 158, 175)
    u125.TextSize = 12
    u125.FontFace = u46.Font.Medium
    u125.TextTransparency = 1
    u125.Parent = Frame
    u122 = Instance.new("TextButton")
    u122.Size = UDim2.new(0, 50, 1, 0)
    u122.Position = UDim2.new(1, -50, 0, 0)
    u122.BackgroundTransparency = 1
    u122.Text = "Skip"
    u122.TextColor3 = Color3.fromRGB(150, 158, 175)
    u122.TextSize = 13
    u122.FontFace = u46.Font.Medium
    u122.TextXAlignment = Enum.TextXAlignment.Right
    u122.TextTransparency = 1
    u122.AutoButtonColor = false
    u122.Parent = Frame

    u122.Activated:Connect(function()
        -- Line: 702
        -- upvalues: u110 (upval), NewPlayerView (upval), u99 (upval), u100 (upval), u102 (upval), u101 (upval)
        -- upvalues: u115 (upval), Config (upval), HotbarController (upval), render (upval), u134 (upval)
        u110 = nil
        NewPlayerView.set(u110 ~= nil)

        if u99 then
            u99:Destroy()

            u99 = nil
        end

        table.clear(u100)
        table.clear(u102)

        if u101 then
            u101:Disconnect()

            u101 = nil
        end

        local v1 = false

        if u115 ~= nil then
            v1 = Config.Tutorial.Guide.KeepInHand[u115] == true
        end

        u115 = nil
        HotbarController.suggest(nil, v1)
        render()
        u134:FireServer("Skip")
    end)

    ;(Remotes.get(Remotes.TutorialStep)).OnClientEvent:Connect(function(a1, a2)
        -- Line: 712
        -- upvalues: applyGuide (upval), u155 (upval), u111 (upval), u112 (upval), LocalPlayer (upval), Config (upval)
        -- upvalues: WelcomeController (upval), u110 (upval), RunService (upval), UserInputService (upval)
        -- upvalues: TweenService (upval), NewPlayerView (upval), GuideBeam (upval), u120 (upval), u121 (upval)
        -- upvalues: u123 (upval), u124 (upval), swap (upval), u131 (upval), setShown (upval), render (upval)
        local u6 = if type(a1) ~= "string" then nil else a1
        applyGuide(if not u6 then nil else a2)

        u155 = if not u6 or type(a2) ~= "table" then
            nil
        else
            if type(a2.readyAt) ~= "number" then nil else a2.readyAt

        if u6 and type(a2) == "table" and typeof(a2.focus) == "Vector3" then
            local focus = a2.focus

            if not u111[u6] and not u112 then
                u111[u6] = true
                u112 = true

                task.spawn(function()
                    -- Line: 231
                    -- upvalues: LocalPlayer (upval), Config (upval), WelcomeController (upval), focus (val)
                    -- upvalues: u110 (upval), u6 (val), u112 (upval), RunService (upval), UserInputService (upval)
                    -- upvalues: TweenService (upval)
                    local PlayerGui, v1
                    local v2 = os.clock() + 30

                    while true do
                        PlayerGui = LocalPlayer:FindFirstChildOfClass("PlayerGui")
                        v1 = false

                        if PlayerGui ~= nil then
                            v1 = PlayerGui:FindFirstChild("LoadingScreen") ~= nil
                        end

                        if not v1 or not (os.clock() < v2) then
                            break
                        end

                        task.wait(0.25)
                    end

                    task.wait(Config.Tutorial.Guide.Camera.WelcomeGraceSeconds)

                    v2 = os.clock() + 600

                    while WelcomeController.pending() do
                        if not (os.clock() < v2) then
                            break
                        end

                        task.wait(0.25)
                    end

                    local Camera = Config.Tutorial.Guide.Camera
                    local CurrentCamera = workspace.CurrentCamera
                    local Character = LocalPlayer.Character
                    local HumanoidRootPart = if not Character then
                        nil
                    else
                        Character:FindFirstChild("HumanoidRootPart")
                    local Magnitude = if not HumanoidRootPart then
                        (1 / 0)
                    else
                        (HumanoidRootPart.Position - focus).Magnitude

                    if CurrentCamera
                        and HumanoidRootPart
                        and not (Camera.MaxStuds < Magnitude)
                        and not (Magnitude < Camera.NearStuds)
                        and u110 == u6 then
                        local Humanoid = Character:FindFirstChildOfClass("Humanoid")

                        if Humanoid and 0.1 < Humanoid.MoveDirection.Magnitude then
                            u112 = false
                            return
                        end

                        local v3 = Vector3.new(HumanoidRootPart.Position.X - focus.X, 0, HumanoidRootPart.Position.Z - focus.Z)
                        local v4 = CFrame.lookAt(focus + (if not (0.1 < v3.Magnitude) then Vector3.new(0, 0, 1) else v3.Unit) * Camera.DistanceStuds + Vector3.new(0, Camera.HeightStuds, 0), focus)
                        local CFrame_2 = CurrentCamera.CFrame
                        local CameraType = CurrentCamera.CameraType
                        local u122 = false
                        local u123 = nil
                        local u135 = nil
                        local u125 = nil

                        local function handBack()
                            -- Line: 278
                            -- upvalues: u122 (ref), u123 (ref), u135 (ref), u125 (ref), CurrentCamera (val)
                            -- upvalues: CameraType (val), u112 (upval)
                            if u122 then
                                return
                            end

                            u122 = true

                            if u123 then
                                u123:Disconnect()
                            end

                            if u135 then
                                u135:Disconnect()
                            end

                            if u125 then
                                u125:Cancel()
                            end

                            CurrentCamera.CameraType = CameraType
                            u112 = false
                        end

                        if Humanoid then
                            u135 = RunService.Heartbeat:Connect(function()
                                -- Line: 300
                                -- upvalues: Humanoid (val), u122 (ref), u123 (ref), u135 (ref), u125 (ref)
                                -- upvalues: CurrentCamera (val), CameraType (val), u112 (upval)
                                if not (0.1 < Humanoid.MoveDirection.Magnitude)
                                    and not Humanoid.Jump then
                                    return
                                end

                                if u122 then
                                    return
                                end

                                u122 = true

                                if u123 then
                                    u123:Disconnect()
                                end

                                if u135 then
                                    u135:Disconnect()
                                end

                                if u125 then
                                    u125:Cancel()
                                end

                                CurrentCamera.CameraType = CameraType
                                u112 = false
                            end)
                        end

                        u123 = UserInputService.InputBegan:Connect(function(a1)
                            -- Line: 306
                            -- upvalues: u122 (ref), u123 (ref), u135 (ref), u125 (ref), CurrentCamera (val)
                            -- upvalues: CameraType (val), u112 (upval)
                            local UserInputType = a1.UserInputType

                            if UserInputType ~= Enum.UserInputType.Keyboard
                                and UserInputType ~= Enum.UserInputType.MouseButton1
                                and UserInputType ~= Enum.UserInputType.MouseButton2
                                and UserInputType ~= Enum.UserInputType.Touch
                                and UserInputType ~= Enum.UserInputType.Gamepad1 then
                                return
                            end

                            if u122 then
                                return
                            end

                            u122 = true

                            if u123 then
                                u123:Disconnect()
                            end

                            if u135 then
                                u135:Disconnect()
                            end

                            if u125 then
                                u125:Cancel()
                            end

                            CurrentCamera.CameraType = CameraType
                            u112 = false
                        end)
                        CurrentCamera.CameraType = Enum.CameraType.Scriptable
                        local v5 = TweenInfo.new(Camera.MoveSeconds, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut)
                        u125 = TweenService:Create(
                            CurrentCamera,
                            v5,
                            {CFrame = v4}
                        )

                        u125:Play()
                        task.wait(Camera.MoveSeconds + Camera.HoldSeconds)

                        if u122 then
                            return
                        end

                        u125 = TweenService:Create(
                            CurrentCamera,
                            v5,
                            {CFrame = CFrame_2}
                        )
                        u125:Play()
                        task.wait(Camera.MoveSeconds)

                        u125 = nil

                        if not u122 then
                            u122 = true

                            if u123 then
                                u123:Disconnect()
                            end

                            if u135 then
                                u135:Disconnect()
                            end

                            if u125 then
                                u125:Cancel()
                            end

                            CurrentCamera.CameraType = CameraType
                            u112 = false
                        end

                        return
                    end

                    u112 = false
                end)
            end
        end

        local v1 = false

        if u110 ~= nil then
            v1 = u6 == nil
        end

        u110 = u6
        NewPlayerView.set(u110 ~= nil)

        if not v1 then
            render()
            return
        end

        GuideBeam.set(nil)

        if not u124 then
            u120.Text = Config.Tutorial.Finished
            u121.Text = ""
            u121.Visible = false
            u123.Parent.Parent.Visible = false
        else
            swap(function() -- Line: 728; upvalues: u120 (upval), Config (upval), u121 (upval), u123 (upval)
                u120.Text = Config.Tutorial.Finished
                u121.Text = ""
                u121.Visible = false
                u123.Parent.Parent.Visible = false
            end)
        end

        u131 = ""
        setShown(true)

        task.delay(
            Config.Tutorial.FinishedSeconds,
            function() -- Line: 744; upvalues: u110 (upval), setShown (upval)
                if u110 == nil then
                    setShown(false)
                end
            end
        )
    end)
end

return v2