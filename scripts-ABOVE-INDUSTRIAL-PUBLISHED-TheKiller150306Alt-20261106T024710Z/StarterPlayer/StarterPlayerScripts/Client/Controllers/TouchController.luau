-- Script path: game:GetService("Players").TheKiller150306Alt.PlayerScripts.Client.Controllers.TouchController
-- Decompile time: 20.49 ms

local GuiService = game:GetService("GuiService")
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local DeviceMode = require(script.Parent.DeviceMode)
local Shared = (game:GetService("ReplicatedStorage")):WaitForChild("Shared")
local Config = require(Shared.Config)

require(Shared.Config.TouchConfig)

local Ui = require(script.Parent.Parent.Ui)
local u57 = require(script.Parent.Aim)
local BackpackController = require(script.Parent.BackpackController)
local BuildController = require(script.Parent.BuildController)
local HotbarController = require(script.Parent.HotbarController)
local TargetController = require(script.Parent.TargetController)
local InputController = require(script.Parent.InputController)
local PromptController = require(script.Parent.PromptController)
local NewPlayerView = require(script.Parent.NewPlayerView)
local QuickTeleportController = require(script.Parent.QuickTeleportController)
local SettingsController = require(script.Parent.SettingsController)
local ShiftLockController = require(script.Parent.ShiftLockController)
local v1 = {}
local LocalPlayer = Players.LocalPlayer
local u110 = nil
local u111 = false
local u112 = false

local function isTouchOnly() -- Line: 57; upvalues: DeviceMode (val)
    return DeviceMode.touchOnly()
end

local function pressed(a1, a2) -- Line: 61; upvalues: TweenService (val); types: a1: userdata, a2: boolean
    TweenService:Create(
        a1,
        TweenInfo.new(0.08),
        {BackgroundTransparency = if not a2 then 0.35 else 0.05}
    ):Play()
end

local function recenterAim() -- Line: 71; upvalues: u57 (val)
    local CurrentCamera = workspace.CurrentCamera

    if not CurrentCamera then
        return
    end

    local ViewportSize = CurrentCamera.ViewportSize
    u57.setTouchPoint(Vector2.new(ViewportSize.X * 0.5, ViewportSize.Y * 0.42), true)
end

local function setIcon(a1, a2, a3) -- Line: 84; types: a1: userdata, a2: string, a3: string?
    local Icon = a1:FindFirstChild("Icon")

    if not a3 then
        if Icon then
            Icon:Destroy()
        end

        a1.Text = a2

        return
    end

    if not Icon then
        local ImageLabel = Instance.new("ImageLabel")
        ImageLabel.Name = "Icon"
        ImageLabel.AnchorPoint = Vector2.new(0.5, 0.5)
        ImageLabel.Position = UDim2.fromScale(0.5, 0.5)
        ImageLabel.Size = UDim2.fromScale(0.62, 0.62)
        ImageLabel.BackgroundTransparency = 1
        ImageLabel.ScaleType = Enum.ScaleType.Fit
        ImageLabel.Parent = a1
        Icon = ImageLabel
    end

    Icon.Image = a3
    a1.Text = ""
end

local function actionIcon(a1) -- Line: 110; upvalues: Config (val)
    local ActionIcons = Config.Touch.ActionIcons

    if a1.kind == "Tool" then
        return ActionIcons[a1.toolSlot or ""] or ActionIcons.Use
    end

    local itemId = a1.itemId

    if a1.kind == "Item" and itemId then
        if Config.Food.isFood(itemId) then
            return ActionIcons.Eat
        end

        if Config.Build.Converters[itemId] then
            return ActionIcons.Plow
        end

        if a1.placeable then
            return ActionIcons.Place
        end
    end

    return ActionIcons.Use
end

local function makeButton(a1, a2, a3, a4)
    -- Line: 130
    -- upvalues: Ui (val), u110 (ref)
    -- types: a1: string, a2: string, a3: number, a4: userdata
    local TextButton = Instance.new("TextButton")
    TextButton.Name = a1
    TextButton.Size = UDim2.fromOffset(a3, a3)
    TextButton.Position = a4
    TextButton.AnchorPoint = Vector2.new(1, 1)
    TextButton.BackgroundColor3 = Color3.fromRGB(24, 26, 36)
    TextButton.BackgroundTransparency = 0.35
    TextButton.BorderSizePixel = 0
    TextButton.Text = a2
    TextButton.TextColor3 = Color3.fromRGB(236, 240, 250)
    TextButton.TextSize = if not (a3 > 70) then 22 else 20
    TextButton.FontFace = Ui.Font.Bold
    TextButton.AutoButtonColor = false
    TextButton.Parent = u110
    local UICorner = Instance.new("UICorner")
    UICorner.CornerRadius = UDim.new(1, 0)
    UICorner.Parent = TextButton
    local UIStroke = Instance.new("UIStroke")
    UIStroke.Color = Color3.fromRGB(255, 255, 255)
    UIStroke.Transparency = 0.75
    UIStroke.Parent = TextButton

    return TextButton
end

local function bind(a1, a2)
    -- Line: 162
    -- upvalues: TweenService (val), BuildController (val), u112 (ref), InputController (val)
    -- types: a1: userdata
    local function up()
        -- Line: 184
        -- upvalues: a1 (val), TweenService (upval), a2 (val), u112 (upval), InputController (upval)
        TweenService:Create(
            a1,
            TweenInfo.new(0.08),
            {BackgroundTransparency = 0.35}
        ):Play()

        if a2.id == "Pickup" then
            u112 = false
            InputController.setPickupHeld(false, "button")

            return
        end

        if a2.id == "Drop" then
            InputController.setDropHeld(false)
        end
    end

    a1.MouseButton1Down:Connect(function()
        -- Line: 163
        -- upvalues: a1 (val), TweenService (upval), a2 (val), BuildController (upval), u112 (upval)
        -- upvalues: InputController (upval)
        TweenService:Create(
            a1,
            TweenInfo.new(0.08),
            {BackgroundTransparency = 0.05}
        ):Play()

        if a2.id == "Rotate" then
            BuildController.rotate()
            return
        end

        if a2.id == "Flip" then
            BuildController.flip()
            return
        end

        if a2.id == "Pickup" then
            u112 = true
            InputController.setPickupHeld(true, "button")

            return
        end

        if a2.id == "Drop" then
            InputController.setDropHeld(true)
            return
        end

        if a2.id ~= "Sprint" then
            warn((("[ABOVE] touch button %* has no action"):format(a2.id)))
            return
        end

        local v1 = if not InputController.toggleSprintButton() then
            Color3.fromRGB(24, 26, 36)
        else
            Color3.fromRGB(70, 120, 90)
        a1.BackgroundColor3 = v1
    end)

    a1.MouseButton1Up:Connect(up)
    a1.MouseLeave:Connect(up)
end

local u120 = false

local function build()
    -- Line: 203
    -- upvalues: u120 (ref), u110 (ref), LocalPlayer (val), Config (val), makeButton (val), TweenService (val)
    -- upvalues: InputController (val), setIcon (val), bind (val), ShiftLockController (val), TargetController (val)
    -- upvalues: u112 (ref), HotbarController (val), actionIcon (val), NewPlayerView (val)
    -- upvalues: QuickTeleportController (val), BuildController (val), u57 (val), GuiService (val), u111 (ref)
    -- upvalues: UserInputService (val), BackpackController (val), RunService (val), PromptController (val)
    local v1

    if u120 then
        return
    end

    u120 = true
    u110 = Instance.new("ScreenGui")
    u110.Name = "TouchControls"
    u110.ResetOnSpawn = false
    u110.IgnoreGuiInset = true
    u110.DisplayOrder = 3
    u110.Parent = LocalPlayer:WaitForChild("PlayerGui")
    local Layout = Config.Touch.Layout

    local function jumpButton() -- Line: 228; upvalues: u110 (upval)
        local Parent = u110.Parent
        local TouchGui = Parent and Parent:FindFirstChild("TouchGui")
        local v1 = TouchGui and TouchGui:FindFirstChild("TouchControlFrame")
        local JumpButton = v1 and v1:FindFirstChild("JumpButton")

        if JumpButton and JumpButton:IsA("GuiObject") and 0 < JumpButton.AbsoluteSize.Y then
            return JumpButton
        end

        return nil
    end

    local function margins() -- Line: 238; upvalues: jumpButton (val), Layout (val), u110 (upval)
        local v1 = jumpButton()

        if not v1 then
            return Layout.MarginRight, Layout.MarginBottom
        end

        local v2 = u110.AbsolutePosition.X + u110.AbsoluteSize.X
            - (v1.AbsolutePosition.X + v1.AbsoluteSize.X)
        local v3 = u110.AbsolutePosition.Y + u110.AbsoluteSize.Y
            - v1.AbsolutePosition.Y
            + Layout.Gap

        return (math.max(Layout.MarginRight, v2)), (math.max(Layout.MarginBottom, v3))
    end

    local u38 = makeButton(Config.Touch.Action.id, Config.Touch.Action.label, Layout.ActionSize, UDim2.fromScale(1, 1))

    u38.MouseButton1Down:Connect(function()
        -- Line: 251
        -- upvalues: u38 (val), TweenService (upval), InputController (upval)
        TweenService:Create(
            u38,
            TweenInfo.new(0.08),
            {BackgroundTransparency = 0.05}
        ):Play()

        InputController.setActionHeld(true, "button")
    end)

    local function releaseAction() -- Line: 255; upvalues: u38 (val), TweenService (upval), InputController (upval)
        TweenService:Create(
            u38,
            TweenInfo.new(0.08),
            {BackgroundTransparency = 0.35}
        ):Play()

        InputController.setActionHeld(false, "button")
    end

    u38.MouseButton1Up:Connect(releaseAction)
    u38.MouseLeave:Connect(releaseAction)

    local u55 = {}

    for i, j in Config.Touch.Buttons do
        v1 = makeButton(j.id, j.label, Layout.ButtonSize, UDim2.new())
        setIcon(v1, j.label, j.icon)
        bind(v1, j)
        table.insert(u55, v1)
    end

    local ShiftLock = Config.Touch.ShiftLock
    local u78 = makeButton(ShiftLock.id, ShiftLock.label, Layout.ButtonSize, UDim2.new())

    setIcon(u78, ShiftLock.label, ShiftLock.icon)

    u78.AnchorPoint = Vector2.new(0.5, 0.5)
    u78.Position = UDim2.new(1, -Layout.ShiftLockCenterFromRight, Layout.SprintCenterFromTop, 0)

    u78.MouseButton1Down:Connect(function()
        -- Line: 278
        -- upvalues: u78 (val), TweenService (upval), ShiftLockController (upval)
        TweenService:Create(
            u78,
            TweenInfo.new(0.08),
            {BackgroundTransparency = 0.05}
        ):Play()

        local v1 = if not ShiftLockController.toggle() then
            Color3.fromRGB(24, 26, 36)
        else
            Color3.fromRGB(70, 120, 90)
        u78.BackgroundColor3 = v1
    end)

    u78.MouseButton1Up:Connect(function() -- Line: 283; upvalues: u78 (val), TweenService (upval)
        TweenService:Create(
            u78,
            TweenInfo.new(0.08),
            {BackgroundTransparency = 0.35}
        ):Play()
    end)

    u78.MouseLeave:Connect(function() -- Line: 286; upvalues: u78 (val), TweenService (upval)
        TweenService:Create(
            u78,
            TweenInfo.new(0.08),
            {BackgroundTransparency = 0.35}
        ):Play()
    end)

    local u110_2 = (-1 / 0)

    local function pickupWanted()
        -- Line: 297
        -- upvalues: TargetController (upval), u110_2 (ref), u112 (upval), Layout (val)
        if TargetController.hasPickupTarget() then
            u110_2 = os.clock()
            return true
        end

        return u112 or os.clock() - u110_2 < Layout.PickupGraceSeconds
    end

    local function layoutButtons()
        -- Line: 305
        -- upvalues: HotbarController (upval), setIcon (upval), u38 (val), Config (upval), actionIcon (upval)
        -- upvalues: InputController (upval), TweenService (upval), u78 (val), NewPlayerView (upval), margins (val)
        -- upvalues: Layout (val), QuickTeleportController (upval), u55 (val), TargetController (upval), u110_2 (ref)
        -- upvalues: u112 (upval), BuildController (upval)
        local new, new_2, v1, v2, v3
        local v4 = HotbarController.selected()

        setIcon(u38, Config.Touch.Action.label, (actionIcon(v4)))

        local v5 = not InputController.handEmpty(v4)

        if u38.Visible and not v5 then
            TweenService:Create(
                u38,
                TweenInfo.new(0.08),
                {BackgroundTransparency = 0.35}
            ):Play()

            InputController.setActionHeld(false, "button")
        end

        u38.Visible = v5
        local ShiftLockEnabled = Config.Touch.ShiftLockEnabled and not NewPlayerView.active()
        u78.Visible = ShiftLockEnabled
        v5 = false

        if v4.itemId ~= nil then
            v5 = v4.kind == "Item"
        end

        local v6 = v5

        if not v6 then
            v6 = false

            if v4.itemId ~= nil then
                v6 = false

                if v4.kind == "Tool" then
                    v6 = 0 < v4.count
                end
            end
        end

        local v7, v8 = margins()
        u38.Position = UDim2.new(1, -v7, 1, -v8)
        local v9 = v8 + Layout.ActionSize / 2
        local v10 = v7 + Layout.ActionSize + Layout.Gap
        local v11 = QuickTeleportController.isOpen()
        local v12 = nil
        local v13 = nil

        for i, j in u55, v12, v13 do
            if j.Name == "Sprint" then
                j.AnchorPoint = Vector2.new(0.5, 0.5)
                j.Position = UDim2.new(0, Layout.SprintCenterX, Layout.SprintCenterFromTop, 0)
                v1 = not NewPlayerView.active() and not v11
                j.Visible = v1
            elseif j.Name == "Drop" then
                j.AnchorPoint = Vector2.new(0.5, 0.5)
                new = UDim2.new
                v2 = Layout.SprintCenterX + Layout.DropOffsetX
                j.Position = new(0, v2, Layout.SprintCenterFromTop, 0)
                v1 = v6 and not NewPlayerView.active() and not v11
                j.Visible = v1
            elseif j.Name ~= "Pickup" then
                v1 = true

                if j.Name == "Rotate" then
                    v1 = v5 and v4.placeable and BuildController.canRotate(v4.itemId)
                elseif j.Name == "Flip" then
                    v1 = v5 and v4.placeable and BuildController.canFlip(v4.itemId)
                end

                j.Visible = v1

                if v1 then
                    j.Position = UDim2.new(1, -v10, 1, -(v9 - Layout.ButtonSize / 2))
                    v10 = v10 + (Layout.ButtonSize + Layout.Gap)
                end
            else
                if not TargetController.hasPickupTarget() then
                    v1 = u112 or os.clock() - u110_2 < Layout.PickupGraceSeconds
                else
                    u110_2 = os.clock()
                    v1 = true
                end

                j.Visible = v1
                new_2 = UDim2.new
                v2 = -(v7 + (Layout.ActionSize - Layout.ButtonSize) / 2)
                v3 = v8 + Layout.ActionSize
                j.Position = new_2(1, v2, 1, -(v3 + Layout.Gap))
            end
        end
    end

    HotbarController.onChanged(layoutButtons)
    NewPlayerView.onChanged(layoutButtons)
    QuickTeleportController.onToggled(layoutButtons)
    layoutButtons()

    local u130 = false
    local u132, u133 = margins()

    task.spawn(function()
        -- Line: 385
        -- upvalues: TargetController (upval), u110_2 (ref), u112 (upval), Layout (val), margins (val), u130 (ref)
        -- upvalues: u132 (ref), u133 (ref), layoutButtons (val)
        local v1, v2, v3

        while true do
            task.wait(0.1)

            if not TargetController.hasPickupTarget() then
                v1 = u112 or os.clock() - u110_2 < Layout.PickupGraceSeconds
            else
                u110_2 = os.clock()
                v1 = true
            end

            v2, v3 = margins()

            if v1 ~= u130 or v2 ~= u132 or v3 ~= u133 then
                u130 = v1
                u132 = v2
                u133 = v3

                layoutButtons()
            end
        end
    end)

    local CurrentCamera = workspace.CurrentCamera

    if CurrentCamera then
        local ViewportSize = CurrentCamera.ViewportSize
        u57.setTouchPoint(Vector2.new(ViewportSize.X * 0.5, ViewportSize.Y * 0.42), true)
    end

    local CurrentCamera_2 = workspace.CurrentCamera

    if CurrentCamera_2 then
        (CurrentCamera_2:GetPropertyChangedSignal("ViewportSize")):Connect(function()
            -- Line: 405
            -- upvalues: u57 (upval)
            local CurrentCamera = workspace.CurrentCamera

            if not CurrentCamera then
                return
            end

            local ViewportSize = CurrentCamera.ViewportSize
            u57.setTouchPoint(Vector2.new(ViewportSize.X * 0.5, ViewportSize.Y * 0.42), true)
        end)
    end

    local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")

    local function setWorldUiShown(a1)
        -- Line: 424
        -- upvalues: u110 (upval), GuiService (upval), PlayerGui (val)
        -- types: a1: boolean
        local v1, v2
        u110.Enabled = a1
        GuiService.TouchControlsEnabled = a1

        for i, j in {"MenuBar", "AboveHotbar"} do
            v2 = PlayerGui:FindFirstChild(j)

            if v2 and v2:IsA("ScreenGui") then
                v2.Enabled = a1
            end
        end

        local v3 = {"AboveHud", "AboveTopStrip"}
        local v4 = nil
        local v5 = nil

        for k, n in v3, v4, v5 do
            v2 = PlayerGui:FindFirstChild(n)

            if v2 then
                for m, i5 in {"Health", "Stats"} do
                    v1 = v2:FindFirstChild(i5)

                    if v1 and v1:IsA("GuiObject") then
                        v1.Visible = a1
                    end
                end
            end
        end
    end

    local u166 = nil
    local u167 = nil

    local function releaseEverything()
        -- Line: 453
        -- upvalues: u38 (val), TweenService (upval), InputController (upval), u112 (upval), u55 (val), u166 (ref)
        -- upvalues: u167 (ref), u57 (upval)
        TweenService:Create(
            u38,
            TweenInfo.new(0.08),
            {BackgroundTransparency = 0.35}
        ):Play()

        InputController.setActionHeld(false, "button")

        if u112 then
            local v1, v2
            u112 = false

            InputController.setPickupHeld(false, "button")

            for i, j in u55 do
                if j.Name == "Pickup" then
                    v1 = TweenService
                    v2 = TweenInfo.new(0.08)

                    v1:Create(
                        j,
                        v2,
                        {BackgroundTransparency = 0.35}
                    ):Play()
                end
            end
        end

        u166()

        u167 = nil
        u57.setFingerDown(false)
    end

    BuildController.onUiOpenChanged(function(a1)
        -- Line: 475
        -- upvalues: u111 (upval), releaseEverything (val), setWorldUiShown (val)
        u111 = a1

        if a1 then
            releaseEverything()
        end

        setWorldUiShown(not a1)
    end)

    UserInputService.WindowFocusReleased:Connect(releaseEverything)
    GuiService.MenuOpened:Connect(releaseEverything)

    local Gesture = Config.Touch.Gesture

    local function worldFree() -- Line: 504; upvalues: u111 (upval), BackpackController (upval)
        return not u111 and not BackpackController.isOpen()
    end

    local function running() -- Line: 510; upvalues: LocalPlayer (upval), Gesture (val)
        local Character = LocalPlayer.Character
        local Humanoid = Character and Character:FindFirstChildOfClass("Humanoid")
        local v1 = false

        if Humanoid ~= nil then
            v1 = Gesture.RunningMoveDirection <= Humanoid.MoveDirection.Magnitude
        end

        return v1
    end

    local function gestureIntent(a1)
        -- Line: 524
        -- upvalues: HotbarController (upval), LocalPlayer (upval), Gesture (val), TargetController (upval)
        -- upvalues: Config (upval), InputController (upval)
        -- types: a1: boolean?
        local v1
        local v2 = HotbarController.selected()
        local v3 = not a1

        if v3 then
            local Character = LocalPlayer.Character
            local Humanoid = Character and Character:FindFirstChildOfClass("Humanoid")
            v1 = false

            if Humanoid ~= nil then
                v1 = Gesture.RunningMoveDirection <= Humanoid.MoveDirection.Magnitude
            end

            v3 = not v1
        end

        if v3 and TargetController.hasPickupTarget() then
            v1 = false

            if v2.assignedItemId == Config.Flower.PollinatorItem then
                v1 = TargetController.flowerTarget() ~= nil
            end

            if not v1 and TargetController.pickupUnderAim() then
                return "Pickup"
            end
        end

        if InputController.handEmpty(v2) then
            return nil
        end

        return "Act"
    end

    local u195 = nil
    local zero = Vector2.zero
    local u197 = 0
    local u198 = nil
    local u199 = nil
    local u200 = nil
    local u201 = nil
    local u202 = false
    local u203 = 0

    local function touchPoint(a1) -- Line: 585; types: a1: userdata
        return Vector2.new(a1.Position.X, a1.Position.Y)
    end

    function u166()
        -- Line: 591
        -- upvalues: u198 (ref), u38 (val), TweenService (upval), InputController (upval), u200 (ref), u199 (ref)
        -- upvalues: u203 (ref), u195 (ref)
        if u198 == "Act" then
            TweenService:Create(
                u38,
                TweenInfo.new(0.08),
                {BackgroundTransparency = 0.35}
            ):Play()

            InputController.setActionHeld(false, "gesture")
        elseif u198 == "Pickup" then
            InputController.setPickupHeld(false, "gesture")
        elseif u198 == "Aim" then
            if u200 then
                u200:Disconnect()

                u200 = nil
            end

            local CurrentCamera = workspace.CurrentCamera

            if CurrentCamera and u199 then
                CurrentCamera.CameraType = u199
            end

            u199 = nil
        end

        if u198 then
            u203 = os.clock() + 0.2
        end

        u198 = nil
        u195 = nil
    end

    local function aimAt(a1) -- Line: 615; upvalues: u57 (upval); types: a1: userdata
        u57.setTouchPoint(a1)
    end

    local function aimAtFinger(a1) -- Line: 624; upvalues: u57 (upval), GuiService (upval); types: a1: userdata
        u57.setTouchPoint(a1 + GuiService:GetGuiInset())
    end

    local function beginHold()
        -- Line: 628
        -- upvalues: gestureIntent (val), HotbarController (upval), u198 (ref), InputController (upval), u199 (ref)
        -- upvalues: LocalPlayer (upval), u200 (ref), RunService (upval), u38 (val), TweenService (upval)
        local v1 = gestureIntent()
        local v2 = HotbarController.selected()

        if v1 == "Pickup" then
            u198 = "Pickup"
            InputController.setPickupHeld(true, "gesture")

            return
        end

        if v1 == "Act" and v2.kind == "Item" and v2.placeable then
            u198 = "Aim"
            local CurrentCamera = workspace.CurrentCamera

            if CurrentCamera and u199 == nil then
                u199 = CurrentCamera.CameraType
                CurrentCamera.CameraType = Enum.CameraType.Scriptable
                local Character = LocalPlayer.Character
                local HumanoidRootPart = Character

                if HumanoidRootPart then
                    HumanoidRootPart = Character:FindFirstChild("HumanoidRootPart")
                end

                if HumanoidRootPart and HumanoidRootPart:IsA("BasePart") then
                    local u35 = CurrentCamera.CFrame.Position - HumanoidRootPart.Position
                    local Rotation = CurrentCamera.CFrame.Rotation
                    u200 = RunService.RenderStepped:Connect(function()
                        -- Line: 648
                        -- upvalues: HumanoidRootPart (val), CurrentCamera (val), u35 (val), Rotation (val)
                        if HumanoidRootPart.Parent then
                            CurrentCamera.CFrame = (CFrame.new(HumanoidRootPart.Position + u35))
                                * Rotation
                        end
                    end)

                    return
                end
            end

            return
        end

        if v1 ~= "Act" then
            u198 = "Idle"
            return
        end

        u198 = "Act"
        TweenService:Create(
            u38,
            TweenInfo.new(0.08),
            {BackgroundTransparency = 0.05}
        ):Play()

        InputController.setActionHeld(true, "gesture")
    end

    UserInputService.TouchStarted:Connect(function(a1, a2)
        -- Line: 665
        -- upvalues: u167 (ref), u57 (upval), u195 (ref), u166 (ref), u111 (upval), BackpackController (upval)
        -- upvalues: zero (ref), u197 (ref), u201 (ref), u202 (ref), GuiService (upval)
        if u167 ~= nil and not a2 then
            u167 = nil
            u57.setFingerDown(false)

            if u195 ~= nil then
                u166()
            end

            return
        end

        if u195 ~= nil then
            u166()
            return
        end

        if not a2 then
            local v1 = not u111 and not BackpackController.isOpen()

            if v1 then
                u195 = a1
                u167 = a1

                u57.setFingerDown(true)

                zero = Vector2.new(a1.Position.X, a1.Position.Y)
                u197 = os.clock()
                u201 = u57.touchPoint()
                u202 = false
                v1 = zero

                u57.setTouchPoint(v1 + GuiService:GetGuiInset())
            end
        end
    end)

    UserInputService.TouchMoved:Connect(function(a1)
        -- Line: 698
        -- upvalues: u167 (ref), u202 (ref), u198 (ref), zero (ref), Gesture (val), u57 (upval), u201 (ref)
        -- upvalues: GuiService (upval), u195 (ref), u166 (ref)
        if a1 == u167 and not u202 then
            local v1

            if u198 == "Aim"
                or not (Gesture.HoldSlopPixels
                    < ((Vector2.new(a1.Position.X, a1.Position.Y)) - zero).Magnitude) then
                v1 = Vector2.new(a1.Position.X, a1.Position.Y)
                u57.setTouchPoint(v1 + GuiService:GetGuiInset())
            else
                u202 = true
                u57.setFingerDown(false)

                if u198 ~= "Act" and u198 ~= "Pickup" and u201 then
                    v1 = u201
                    u57.setTouchPoint(v1)
                end
            end
        end

        if a1 ~= u195 or u198 == "Aim" then
            return
        end

        if Gesture.HoldSlopPixels
            < ((Vector2.new(a1.Position.X, a1.Position.Y)) - zero).Magnitude then
            u166()
        end
    end)

    UserInputService.TouchEnded:Connect(function(a1)
        -- Line: 725
        -- upvalues: u167 (ref), u57 (upval), u195 (ref), u166 (ref)
        if a1 == u167 then
            u167 = nil
            u57.setFingerDown(false)
        end

        if a1 == u195 then
            u166()
        end
    end)

    RunService.Heartbeat:Connect(function()
        -- Line: 735
        -- upvalues: u167 (ref), u57 (upval), u195 (ref), u166 (ref), u198 (ref), u111 (upval)
        -- upvalues: BackpackController (upval), u197 (ref), Gesture (val), beginHold (val)
        local v1 = u167

        if v1
            and v1.UserInputState ~= Enum.UserInputState.Begin
            and v1.UserInputState ~= Enum.UserInputState.Change then
            u167 = nil
            u57.setFingerDown(false)
        end

        v1 = u195

        if not v1 then
            return
        end

        local UserInputState = v1.UserInputState

        if UserInputState ~= Enum.UserInputState.Begin
            and UserInputState ~= Enum.UserInputState.Change then
            u166()
            return
        end

        if u198 then
            return
        end

        if u111 or BackpackController.isOpen() then
            u166()
            return
        end

        if Gesture.HoldSeconds <= os.clock() - u197 then
            beginHold()
        end
    end)

    local function tapAt(a1, a2)
        -- Line: 774
        -- upvalues: u57 (upval), ShiftLockController (upval), HotbarController (upval), gestureIntent (val)
        -- upvalues: InputController (upval), Gesture (val), u111 (upval), BackpackController (upval)
        -- types: a1: userdata, a2: boolean?
        u57.setTouchPoint(a1)
        ShiftLockController.turnToward(a1)

        local v1 = HotbarController.selected()

        if v1.kind == "Item" and v1.placeable and gestureIntent(a2) == "Act" then
            InputController.actOnce()
            return
        end

        task.delay(
            Gesture.TapDecideSeconds,
            function()
                -- Line: 789
                -- upvalues: u111 (upval), BackpackController (upval), gestureIntent (upval), a2 (val)
                -- upvalues: InputController (upval)
                if not (not u111 and not BackpackController.isOpen()) then
                    return
                end

                local v1 = gestureIntent(a2)

                if v1 == "Pickup" then
                    InputController.pickupOnce()
                    return
                end

                if v1 == "Act" then
                    InputController.actOnce()
                end
            end
        )
    end

    UserInputService.TouchTapInWorld:Connect(function(a1, a2)
        -- Line: 801
        -- upvalues: u111 (upval), BackpackController (upval), u203 (ref), tapAt (val)
        if not a2
            and not u111
            and not BackpackController.isOpen()
            and not (os.clock() < u203) then
            tapAt(a1)
        end
    end)

    local function onlyStickUnder(a1)
        -- Line: 814
        -- upvalues: GuiService (upval), PlayerGui (val)
        -- types: a1: userdata
        local v1
        local v2 = {a1, a1 + (GuiService:GetGuiInset())}
        local v3 = nil
        local v4 = nil

        for i, j in v2, v3, v4 do
            for k, n in PlayerGui:GetGuiObjectsAtPosition(j.X, j.Y) do
                if not n:IsA("GuiButton") and not n:IsA("TextBox") then
                    v1 = n:FindFirstAncestorWhichIsA("ScreenGui")

                    if v1
                        and v1.Name ~= "TouchGui"
                        and n.Visible
                        and n.BackgroundTransparency < 1 then
                        return false
                    end

                    continue
                end

                return false
            end
        end

        return true
    end

    local u241 = {}
    local u242 = {}

    local function stickOnTop(a1) -- Line: 838; upvalues: GuiService (upval), PlayerGui (val); types: a1: userdata
        local v1, v2
        local v3 = {a1, a1 - (GuiService:GetGuiInset())}
        local v4 = nil
        local v5 = nil

        for i, j in v3, v4, v5 do
            v1 = PlayerGui:GetGuiObjectsAtPosition(j.X, j.Y)[1]
            v2 = if not v1 then nil else v1:FindFirstAncestorWhichIsA("ScreenGui")

            if v2 and v2.Name == "TouchGui" then
                return true
            end
        end

        return false
    end

    UserInputService.TouchStarted:Connect(function(a1, a2)
        -- Line: 849
        -- upvalues: u111 (upval), BackpackController (upval), stickOnTop (val), touchPoint (val)
        -- upvalues: PromptController (upval), u242 (val), u241 (val)
        if a2 then
            local v1 = not u111 and not BackpackController.isOpen()

            if v1 then
                v1 = if not stickOnTop(touchPoint(a1)) then
                    nil
                else
                    PromptController.promptAtTouch(touchPoint(a1))

                if v1 and v1.Enabled then
                    u242[a1] = v1
                    v1:InputHoldBegin()

                    return
                end

                u241[a1] = {
                    at = Vector2.new(a1.Position.X, a1.Position.Y),
                    startedAt = os.clock(),
                }
            end
        end
    end)

    UserInputService.TouchEnded:Connect(function(a1)
        -- Line: 862
        -- upvalues: u242 (val), u241 (val), Gesture (val), u111 (upval), BackpackController (upval)
        -- upvalues: onlyStickUnder (val), tapAt (val), GuiService (upval)
        local v1 = u242[a1]

        if v1 then
            u242[a1] = nil

            if v1.Parent then
                v1:InputHoldEnd()
            end

            return
        end

        v1 = u241[a1]

        if not v1 then
            return
        end

        u241[a1] = nil
        local v2 = ((Vector2.new(a1.Position.X, a1.Position.Y)) - v1.at).Magnitude
            <= Gesture.HoldSlopPixels
        local v3 = os.clock() - v1.startedAt <= Gesture.StickTapSeconds

        if v2
            and v3
            and not u111
            and not BackpackController.isOpen()
            and onlyStickUnder(v1.at) then
            tapAt(v1.at + GuiService:GetGuiInset(), true)
        end
    end)
end

function v1.start()
    -- Line: 885
    -- upvalues: DeviceMode (val), build (val), UserInputService (val), u120 (ref), SettingsController (val), u110 (ref)
    if DeviceMode.touchOnly() then
        build()
        return
    end

    if not DeviceMode.Hybrid then
        return
    end

    local function wanted() -- Line: 897; upvalues: DeviceMode (upval)
        return DeviceMode.mode() ~= "Keyboard & Mouse"
    end

    UserInputService.TouchStarted:Connect(function()
        -- Line: 900
        -- upvalues: u120 (upval), DeviceMode (upval), build (upval)
        if not u120 and DeviceMode.mode() ~= "Keyboard & Mouse" then
            build()
        end
    end)

    SettingsController.onChanged(function(a1)
        -- Line: 905
        -- upvalues: u120 (upval), u110 (upval), DeviceMode (upval), build (upval)
        -- types: a1: string
        if a1 ~= "ControlMode" then
            return
        end

        if u120 then
            u110.Enabled = DeviceMode.mode() ~= "Keyboard & Mouse"
            return
        end

        if DeviceMode.mode() == "Touch" then
            build()
        end
    end)
end

return v1