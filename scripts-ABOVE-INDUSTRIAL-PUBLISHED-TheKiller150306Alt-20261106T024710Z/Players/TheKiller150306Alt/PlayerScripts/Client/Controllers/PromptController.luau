-- Script path: game:GetService("Players").TheKiller150306Alt.PlayerScripts.Client.Controllers.PromptController
-- Decompile time: 17.22 ms

local Players = game:GetService("Players")
local ProximityPromptService = game:GetService("ProximityPromptService")
local UserInputService = game:GetService("UserInputService")
local DeviceMode = require(script.Parent.DeviceMode)
local RunService = game:GetService("RunService")
local GuiService = game:GetService("GuiService")
local TweenService = game:GetService("TweenService")
local CollectionService = game:GetService("CollectionService")
local Config = require((game:GetService("ReplicatedStorage")):WaitForChild("Shared").Config)
local Prompts = require((game:GetService("ReplicatedStorage")):WaitForChild("Shared").Prompts)
local Ui = require(script.Parent.Parent.Ui)
local TargetController = require(script.Parent.TargetController)
local ControlGlyphs = require(script.Parent.ControlGlyphs)
local KeyBinds = require(script.Parent.KeyBinds)
local u85 = {}
local LocalPlayer = Players.LocalPlayer
local u87 = {}
local u88 = {}
local u90 = DeviceMode.touchOnly()
local u96 = Color3.fromRGB(24, 27, 34)
local u101 = Color3.fromRGB(238, 242, 250)
local u106 = Color3.fromRGB(150, 162, 180)
local u111 = Color3.fromRGB(255, 226, 130)

local function keyLabelFor(a1) -- Line: 54; upvalues: u90 (val), UserInputService (val); types: a1: userdata
    if u90 then
        return "TAP"
    end

    local GamepadEnabled = UserInputService.GamepadEnabled and not UserInputService.KeyboardEnabled

    if GamepadEnabled then
        return a1.GamepadKeyCode.Name
    end

    return a1.KeyboardKeyCode.Name
end

local function build(a1)
    -- Line: 65
    -- upvalues: Config (val), LocalPlayer (val), u90 (val), u96 (val), Ui (val), UserInputService (val), u111 (val)
    -- upvalues: ControlGlyphs (val), u101 (val), u106 (val)
    -- types: a1: userdata
    local Parent = a1.Parent

    if Parent and Parent:IsA("BasePart") then
        local Name
        local BillboardGui = Instance.new("BillboardGui")
        BillboardGui.Name = "PromptUi"
        BillboardGui.Adornee = Parent
        BillboardGui.AlwaysOnTop = true
        BillboardGui.Size = UDim2.fromOffset(220, 44)
        BillboardGui.StudsOffset = Vector3.new(0, Parent.Size.Y / 2 + 1.4, 0)
        local v1 = nil

        for i, j in Parent:GetDescendants() do
            if j.Name == "Display" and j:IsA("BasePart") and not j:FindFirstAncestor("ShopSample") then
                v1 = j
                break
            end
        end

        if v1 then
            local CFrame = v1.CFrame
            BillboardGui.StudsOffset = Vector3.new(0, v1.Position.Y - ((math.abs(CFrame.RightVector.Y)) * v1.Size.X + (math.abs(CFrame.UpVector.Y)) * v1.Size.Y + (math.abs(CFrame.LookVector.Y)) * v1.Size.Z) / 2 - Config.Player.PromptBelowDisplayStuds - Parent.Position.Y, 0)
        end

        BillboardGui.MaxDistance = a1.MaxActivationDistance + LocalPlayer.CameraMaxZoomDistance
        BillboardGui.Active = u90
        BillboardGui.ResetOnSpawn = false
        local Frame = Instance.new("Frame")
        Frame.Size = UDim2.fromScale(1, 1)
        Frame.BackgroundTransparency = 1
        Frame.Active = false
        Frame.Parent = BillboardGui
        local v2 = Instance.new(if not u90 then "Frame" else "TextButton")
        v2.Name = "Pill"
        v2.AnchorPoint = Vector2.new(0.5, 0.5)
        v2.Position = UDim2.fromScale(0.5, 0.5)
        v2.Size = UDim2.fromOffset(0, 0)
        v2.AutomaticSize = Enum.AutomaticSize.XY
        v2.BackgroundColor3 = u96
        v2.BackgroundTransparency = 0.12
        v2.BorderSizePixel = 0

        if not v2:IsA("TextButton") then
            v2.Active = false
        else
            v2.Text = ""
            v2.AutoButtonColor = false
        end

        v2.Parent = Frame
        Ui.corner(v2, 8)

        local UIStroke = Instance.new("UIStroke")
        UIStroke.Thickness = 1
        UIStroke.Transparency = 0.45
        UIStroke.Color = Color3.fromRGB(90, 102, 124)
        UIStroke.Parent = v2
        local UIListLayout = Instance.new("UIListLayout")
        UIListLayout.FillDirection = Enum.FillDirection.Vertical
        UIListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
        UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
        UIListLayout.Padding = UDim.new(0, 2)
        UIListLayout.Parent = v2
        local UIPadding = Instance.new("UIPadding")
        UIPadding.PaddingLeft = UDim.new(0, 10)
        UIPadding.PaddingRight = UDim.new(0, 12)
        UIPadding.PaddingTop = UDim.new(0, 4)
        UIPadding.PaddingBottom = UDim.new(0, 4)
        UIPadding.Parent = v2
        local Frame_2 = Instance.new("Frame")
        Frame_2.Name = "Row"
        Frame_2.LayoutOrder = 1
        Frame_2.Size = UDim2.fromOffset(0, 18)
        Frame_2.AutomaticSize = Enum.AutomaticSize.X
        Frame_2.BackgroundTransparency = 1
        Frame_2.Active = false
        Frame_2.Parent = v2
        local UIListLayout_2 = Instance.new("UIListLayout")
        UIListLayout_2.FillDirection = Enum.FillDirection.Horizontal
        UIListLayout_2.VerticalAlignment = Enum.VerticalAlignment.Center
        UIListLayout_2.SortOrder = Enum.SortOrder.LayoutOrder
        UIListLayout_2.Padding = UDim.new(0, 8)
        UIListLayout_2.Parent = Frame_2

        if not u90 then
            local GamepadEnabled = UserInputService.GamepadEnabled
                and not UserInputService.KeyboardEnabled
            Name = if not GamepadEnabled then
                a1.KeyboardKeyCode.Name
            else
                a1.GamepadKeyCode.Name
        else
            Name = "TAP"
        end

        local TextLabel = Instance.new("TextLabel")
        TextLabel.Name = "Key"
        TextLabel.LayoutOrder = 1
        local v3 = math.max(20, #Name * 8 + 10)
        TextLabel.Size = UDim2.fromOffset(v3, 18)
        TextLabel.BackgroundColor3 = Color3.fromRGB(44, 49, 60)
        TextLabel.BorderSizePixel = 0
        TextLabel.Text = Name
        TextLabel.TextColor3 = u111
        TextLabel.FontFace = Ui.Font.Bold
        TextLabel.TextSize = 12
        TextLabel.Active = false
        TextLabel.Parent = Frame_2

        Ui.corner(TextLabel, 4)

        if ControlGlyphs.usingGamepad() and not u90 then
            TextLabel.Text = ""
            TextLabel.BackgroundTransparency = 1
            TextLabel.Size = UDim2.fromOffset(20, 18)
            local v4 = ControlGlyphs.icon(a1.GamepadKeyCode, 18)
            v4.AnchorPoint = Vector2.new(0.5, 0.5)
            v4.Position = UDim2.fromScale(0.5, 0.5)
            v4.Parent = TextLabel
        end

        local v5 = Instance.new("TextLabel")
        v5.Name = "Action"
        v5.LayoutOrder = 2
        local v6 = #a1.ActionText * 8 + 6
        v5.Size = UDim2.fromOffset(v6, 18)
        v5.BackgroundTransparency = 1
        v5.Text = a1.ActionText
        v5.TextColor3 = u101
        v5.FontFace = Ui.Font.Bold
        v5.TextSize = 13
        v5.Active = false
        v5.Parent = Frame_2

        if a1.ObjectText ~= "" then
            v1 = Instance.new("TextLabel")
            v1.Name = "Object"
            v1.LayoutOrder = 2
            v1.Size = UDim2.fromOffset(#a1.ObjectText * 6 + 6, 14)
            v1.BackgroundTransparency = 1
            v1.Text = a1.ObjectText
            v1.TextColor3 = u106
            v1.FontFace = Ui.Font.Regular
            v1.TextSize = 11
            v1.Active = false
            v1.Parent = v2
        end

        if v2:IsA("TextButton") then
            v2.MouseButton1Down:Connect(function() -- Line: 254; upvalues: a1 (val)
                a1:InputHoldBegin()
            end)

            v2.MouseButton1Up:Connect(function() -- Line: 257; upvalues: a1 (val)
                a1:InputHoldEnd()
            end)
        end

        BillboardGui.Size = UDim2.fromOffset(math.max(v3 + v6 + 8 + 22 + 12, 34), if not (v5 > 0) then 44 else 60)
        BillboardGui.Parent = LocalPlayer:FindFirstChildOfClass("PlayerGui")

        return BillboardGui
    end

    return nil
end

local function watch(a1) -- Line: 282; upvalues: u87 (val), build (val), u88 (val); types: a1: userdata
    local function redraw() -- Line: 283; upvalues: u87 (upval), a1 (val), build (upval)
        local v1 = u87[a1]

        if not v1 then
            return
        end

        local v2 = build(a1)
        v1:Destroy()

        u87[a1] = v2
    end

    u88[a1] = {
        (a1:GetPropertyChangedSignal("ObjectText")):Connect(redraw),
        ((a1:GetPropertyChangedSignal("ActionText")):Connect(redraw)),
    }
end

local function unwatch(a1) -- Line: 298; upvalues: u88 (val); types: a1: userdata
    local v1 = u88[a1]

    if v1 then
        for i, j in v1 do
            j:Disconnect()
        end

        u88[a1] = nil
    end
end

local function promptUnder(a1)
    -- Line: 315
    -- upvalues: LocalPlayer (val), GuiService (val), u87 (val)
    -- types: a1: userdata
    local v1
    local PlayerGui = LocalPlayer:FindFirstChildOfClass("PlayerGui")

    if not PlayerGui then
        return nil
    end

    local GuiInset = GuiService:GetGuiInset()

    for i, j in PlayerGui:GetGuiObjectsAtPosition(a1.X - GuiInset.X, a1.Y - GuiInset.Y) do
        v1 = j:FindFirstAncestorWhichIsA("ScreenGui")

        if v1 and v1.Name == "TouchGui" then
            continue
        end

        v1 = j:FindFirstAncestorOfClass("BillboardGui")

        if v1 then
            for k, n in u87 do
                if n == v1 then
                    return k
                end
            end
        elseif j.Visible and j.BackgroundTransparency < 1 then
            return nil
        end
    end

    return nil
end

function u85.promptAtTouch(a1) -- Line: 346; upvalues: GuiService (val), promptUnder (val); types: a1: userdata
    return promptUnder(a1 + (GuiService:GetGuiInset())) or promptUnder(a1)
end

function u85.pointerOverPrompt() -- Line: 353; upvalues: u90 (val), UserInputService (val), promptUnder (val)
    if not u90 and UserInputService.MouseBehavior == Enum.MouseBehavior.Default then
        return promptUnder(UserInputService:GetMouseLocation()) ~= nil
    end

    return false
end

local u119 = false

local function updateHand() -- Line: 366; upvalues: u85 (val), u119 (ref), UserInputService (val)
    local v1 = u85.pointerOverPrompt()

    if v1 and not u119 and UserInputService.MouseIcon == "" then
        UserInputService.MouseIcon = "rbxasset://SystemCursors/PointingHand"
        u119 = true

        return
    end

    if not v1 and u119 then
        if UserInputService.MouseIcon == "rbxasset://SystemCursors/PointingHand" then
            UserInputService.MouseIcon = ""
        end

        u119 = false
    end
end

local function yieldToPickup()
    -- Line: 383
    -- upvalues: KeyBinds (val), TargetController (val), ProximityPromptService (val)
    local v1 = KeyBinds.shared()

    if v1 then
        if TargetController.pickupEntityId() ~= nil then
            v1 = TargetController.pickupUnderAim()
        else
            v1 = false

            if TargetController.harvestTarget() ~= nil then
                v1 = TargetController.pickupUnderAim()
            end
        end
    end

    if ProximityPromptService.Enabled == v1 then
        ProximityPromptService.Enabled = not v1
    end
end

local u122 = {}
local u123 = nil

local function holdToOwnReach(a1) -- Line: 419; upvalues: u123 (ref), Prompts (val); types: a1: userdata
    if a1:IsA("ProximityPrompt") and a1 ~= u123 then
        a1.MaxActivationDistance = Prompts.reachOf(a1)
    end
end

local function refusedHere(a1) -- Line: 427; upvalues: Prompts (val), LocalPlayer (val); types: a1: userdata
    local v1 = false

    if a1:GetAttribute(Prompts.RequiresAttribute) == "Build" then
        v1 = LocalPlayer:GetAttribute(Prompts.MayBuildAttribute) ~= true
    end

    return v1
end

local function applyRequires(a1) -- Line: 432; upvalues: Prompts (val), LocalPlayer (val); types: a1: userdata
    if a1:IsA("ProximityPrompt") and a1:GetAttribute(Prompts.RequiresAttribute) ~= nil then
        local v1 = false

        if a1:GetAttribute(Prompts.RequiresAttribute) == "Build" then
            v1 = LocalPlayer:GetAttribute(Prompts.MayBuildAttribute) ~= true
        end

        if v1 then
            a1.Enabled = false
            return
        end

        if a1:GetAttribute(Prompts.BenchedAttribute) ~= true then
            a1.Enabled = true
        end
    end
end

local function focusPointed()
    -- Line: 443
    -- upvalues: TargetController (val), u123 (ref), Prompts (val), u122 (val), LocalPlayer (val), u87 (val)
    local BenchedAttribute, BenchedAttribute_2, RequiresAttribute, v1
    local v2 = TargetController.pointedPrompt()

    if v2 ~= u123 then
        local v3 = u123

        if v3 and v3.Parent and v3:IsA("ProximityPrompt") and v3 ~= v2 then
            v3.MaxActivationDistance = Prompts.reachOf(v3)
        end

        if v2 then
            v2.MaxActivationDistance = Prompts.pointedReach(v2)
        end
    end

    local v4 = nil
    local v5 = nil

    for i in u122, v4, v5 do
        if i == v2 or not v2 or not i.Parent then
            u122[i] = nil
            BenchedAttribute_2 = Prompts.BenchedAttribute

            i:SetAttribute(BenchedAttribute_2, nil)

            v1 = false
            RequiresAttribute = Prompts.RequiresAttribute

            if i:GetAttribute(RequiresAttribute) == "Build" then
                v1 = LocalPlayer:GetAttribute(Prompts.MayBuildAttribute) ~= true
            end

            i.Enabled = not v1
        end
    end

    if not v2 then
        return
    end

    for j in u87 do
        if j ~= v2 and not u122[j] then
            u122[j] = true
            BenchedAttribute = Prompts.BenchedAttribute

            j:SetAttribute(BenchedAttribute, true)

            j.Enabled = false
        end
    end
end

function u85.start()
    -- Line: 475
    -- upvalues: UserInputService (val), u90 (val), promptUnder (val), RunService (val), updateHand (val)
    -- upvalues: yieldToPickup (val), focusPointed (val), CollectionService (val), Prompts (val), u122 (val)
    -- upvalues: LocalPlayer (val), u123 (ref), holdToOwnReach (val), applyRequires (val), ProximityPromptService (val)
    -- upvalues: u87 (val), KeyBinds (val), build (val), watch (val), TweenService (val), ControlGlyphs (val), u88 (val)
    local u0 = nil
    UserInputService.InputBegan:Connect(function(a1)
        -- Line: 481
        -- upvalues: u90 (upval), UserInputService (upval), promptUnder (upval), u0 (ref)
        if not u90 and a1.UserInputType == Enum.UserInputType.MouseButton1 then
            if UserInputService.MouseBehavior ~= Enum.MouseBehavior.Default then
                return
            end

            local v1 = promptUnder(UserInputService:GetMouseLocation())

            if v1 and v1.Enabled then
                u0 = v1
                v1:InputHoldBegin()
            end
        end
    end)

    if not u90 then
        RunService.Heartbeat:Connect(updateHand)
        RunService.Heartbeat:Connect(yieldToPickup)
    end

    RunService.Heartbeat:Connect(focusPointed)

    task.spawn(function()
        -- Line: 503
        -- upvalues: CollectionService (upval), Prompts (upval), u122 (upval), LocalPlayer (upval)
        local BenchedAttribute, BenchedAttribute_2, RequiresAttribute, v1

        while true do
            task.wait(2)

            for i, j in CollectionService:GetTagged(Prompts.Tag) do
                if j:IsA("ProximityPrompt") then
                    BenchedAttribute = Prompts.BenchedAttribute

                    if j:GetAttribute(BenchedAttribute) == true and not u122[j] then
                        BenchedAttribute_2 = Prompts.BenchedAttribute
                        j:SetAttribute(BenchedAttribute_2, nil)

                        v1 = false
                        RequiresAttribute = Prompts.RequiresAttribute

                        if j:GetAttribute(RequiresAttribute) == "Build" then
                            v1 = LocalPlayer:GetAttribute(Prompts.MayBuildAttribute) ~= true
                        end

                        j.Enabled = not v1
                    end
                end
            end
        end
    end)

    for i, j in CollectionService:GetTagged(Prompts.Tag) do
        if j:IsA("ProximityPrompt") and j ~= u123 then
            j.MaxActivationDistance = Prompts.reachOf(j)
        end
    end

    ;(CollectionService:GetInstanceAddedSignal(Prompts.Tag)):Connect(holdToOwnReach)

    for k, n in CollectionService:GetTagged(Prompts.Tag) do
        applyRequires(n)
    end

    ;(CollectionService:GetInstanceAddedSignal(Prompts.Tag)):Connect(applyRequires)

    ;(LocalPlayer:GetAttributeChangedSignal(Prompts.MayBuildAttribute)):Connect(function()
        -- Line: 529
        -- upvalues: CollectionService (upval), Prompts (upval), applyRequires (upval)
        for i, j in CollectionService:GetTagged(Prompts.Tag) do
            applyRequires(j)
        end
    end)

    UserInputService.InputEnded:Connect(function(a1) -- Line: 534; upvalues: u0 (ref)
        if a1.UserInputType ~= Enum.UserInputType.MouseButton1 then
            return
        end

        local v1 = u0
        u0 = nil

        if v1 and v1.Parent then
            v1:InputHoldEnd()
        end
    end)

    ProximityPromptService.PromptShown:Connect(function(a1)
        -- Line: 545
        -- upvalues: u87 (upval), KeyBinds (upval), build (upval), watch (upval), TweenService (upval)
        if u87[a1] then
            return
        end

        a1.KeyboardKeyCode = KeyBinds.use()
        local v1 = build(a1)

        if v1 then
            u87[a1] = v1
            watch(a1)

            local Size = v1.Size
            v1.Size = UDim2.fromOffset(Size.X.Offset, Size.Y.Offset - 10)

            TweenService:Create(
                v1,
                TweenInfo.new(0.12, Enum.EasingStyle.Quad),
                {Size = Size}
            ):Play()
        end
    end)

    KeyBinds.onChanged(function() -- Line: 568; upvalues: u87 (upval), KeyBinds (upval), build (upval)
        local v1

        for i, j in u87 do
            i.KeyboardKeyCode = KeyBinds.use()
            v1 = build(i)

            j:Destroy()

            u87[i] = v1
        end
    end)

    ControlGlyphs.onChanged(function() -- Line: 578; upvalues: u87 (upval), build (upval)
        local v1

        for i, j in u87 do
            v1 = build(i)
            j:Destroy()

            u87[i] = v1
        end
    end)

    ProximityPromptService.PromptHidden:Connect(function(a1) -- Line: 586; upvalues: u88 (upval), u87 (upval)
        local v1 = u88[a1]

        if v1 then
            for i, j in v1 do
                j:Disconnect()
            end

            u88[a1] = nil
        end

        v1 = u87[a1]

        if v1 then
            u87[a1] = nil
            v1:Destroy()
        end
    end)

    task.spawn(function() -- Line: 599; upvalues: u87 (upval), u88 (upval)
        local v1, v2, v3

        while true do
            task.wait(1)

            v1 = nil
            v2 = nil

            for i, j in u87, v1, v2 do
                if not i.Parent then
                    u87[i] = nil
                    v3 = u88[i]

                    if v3 then
                        for k, n in v3 do
                            n:Disconnect()
                        end

                        u88[i] = nil
                    end

                    j:Destroy()
                end
            end
        end
    end)
end

return u85