-- Script path: game:GetService("StarterPlayer").PlayerModule.ControlModule.ClassicThumbstick
-- Decompile time: 8.31 ms

local GuiService = game:GetService("GuiService")
local Players = game:GetService("Players")
local FlagUtil = require(script.Parent.Parent:WaitForChild("CommonUtils")).get("FlagUtil")
local u25 = FlagUtil.getUserFlag("UserPlayerScriptsCCLIntegrationD")
local UserPlayerScriptsClassicThumbstickRenameUI = FlagUtil.getUserFlag("UserPlayerScriptsClassicThumbstickRenameUI")
local UserAbilitiesUserInterfaceC = FlagUtil.getUserFlag("UserAbilitiesUserInterfaceC")
local UserPlayerScriptsResetDTTouchOnCreate = FlagUtil.getUserFlag("UserPlayerScriptsResetDTTouchOnCreate")
local u51 = script.Parent.Parent:WaitForChild("InputContexts"):WaitForChild("TransformerContext"):WaitForChild("ThumbstickAction")
local u55 = Vector2.new(-1, -1)
local AvatarAbilitiesInterface = require(script.Parent:WaitForChild("AvatarAbilitiesInterface"))
local u67 = if not u25 then nil else AvatarAbilitiesInterface.get(Players.LocalPlayer)
local u76 = require(script.Parent:WaitForChild("ActionController"))
local u80 = setmetatable(
    {},
    u76
)
u80.__index = u80

function u80.new(a1) -- Line: 30; upvalues: u76 (val), u80 (val)
    local v1 = u76.new()
    local v2 = setmetatable(v1, u80)
    v2.data = a1
    v2.enabled = false
    v2.isTouchActive = false
    v2.isFollowStick = false
    v2.thumbstickFrame = nil
    v2.screenPos = nil
    v2.stickImage = nil
    v2.thumbstickSize = nil

    return v2
end

local function setupThumbstickInput(a1) -- Line: 47; upvalues: u51 (val)
    for i, j in u51:GetChildren() do
        if j.Name == "DynamicTouchBinding" or j.Name == "ClassicTouchBinding" then
            j:Destroy()
        end
    end

    local InputBinding = Instance.new("InputBinding")
    InputBinding.Name = "ClassicTouchBinding"
    InputBinding.KeyCode = Enum.KeyCode.TouchPosition
    InputBinding.UIModifier = a1.thumbstickButton
    InputBinding.Parent = u51
end

local function enableThumbstickInput(a1, a2)
    -- Line: 60
    -- upvalues: setupThumbstickInput (val), u51 (val)
    -- types: a2: boolean
    if a2 then
        setupThumbstickInput(a1)

        a1.thumbstickStateChangedConn = u51.StateChanged:Connect(a1.onStateChanged)
        u51.Enabled = true

        return
    end

    u51.Enabled = false

    if a1.thumbstickStateChangedConn then
        a1.thumbstickStateChangedConn:Disconnect()

        a1.thumbstickStateChangedConn = nil
    end
end

function u80.Enable(a1, a2, a3)
    -- Line: 74
    -- upvalues: u76 (val), UserPlayerScriptsResetDTTouchOnCreate (val), setupThumbstickInput (val), u51 (val)
    -- types: a1: table, a2: boolean?
    if a2 == nil then
        return false
    end

    local v1 = not not a2

    if a1.enabled == v1 then
        return true
    end

    u76.Enable(a1, v1)

    a1.isJumping = false

    if not v1 then
        if not UserPlayerScriptsResetDTTouchOnCreate then end

        u51.Enabled = false

        if a1.thumbstickStateChangedConn then
            a1.thumbstickStateChangedConn:Disconnect()

            a1.thumbstickStateChangedConn = nil
        end

        a1.thumbstickFrame.Visible = false
        a1:OnInputEnded()
    else
        if not a1.thumbstickFrame then
            a1:Create(a3)
        end

        if UserPlayerScriptsResetDTTouchOnCreate then
            setupThumbstickInput(a1)
        end

        a1.thumbstickStateChangedConn = u51.StateChanged:Connect(a1.onStateChanged)
        u51.Enabled = true
        a1.thumbstickFrame.Visible = true
    end

    a1.enabled = v1
end

function u80:OnInputEnded() -- Line: 112
    self.isTouchActive = false
    self.thumbstickFrame.Position = self.screenPos
    self.stickImage.Position = UDim2.new(0, self.thumbstickFrame.Size.X.Offset / 2 - self.thumbstickSize / 4, 0, self.thumbstickFrame.Size.Y.Offset / 2 - self.thumbstickSize / 4)
    local ClassicThumbstickScriptableBinding = self.data.controlModule.actions.MoveAction:FindFirstChild("ClassicThumbstickScriptableBinding")

    if ClassicThumbstickScriptableBinding then
        ClassicThumbstickScriptableBinding:Fire(Vector2.zero)
    end

    self.isJumping = false
    self.thumbstickFrame.Position = self.screenPos
end

function u80:Create(a2)
    -- Line: 125
    -- upvalues: u51 (val), UserPlayerScriptsClassicThumbstickRenameUI (val), u25 (val), u67 (val)
    -- upvalues: AvatarAbilitiesInterface (val), UserPlayerScriptsResetDTTouchOnCreate (val)
    -- upvalues: UserAbilitiesUserInterfaceC (val), u55 (val), GuiService (val)
    if self.thumbstickFrame then
        u51.Enabled = false

        if self.thumbstickStateChangedConn then
            self.thumbstickStateChangedConn:Disconnect()

            self.thumbstickStateChangedConn = nil
        end

        self.thumbstickFrame:Destroy()

        self.thumbstickFrame = nil

        if self.absoluteSizeChangedConn then
            self.absoluteSizeChangedConn:Disconnect()

            self.absoluteSizeChangedConn = nil
        end

        if self.avatarAbilitiesEnabledChangedConn then
            self.avatarAbilitiesEnabledChangedConn:Disconnect()

            self.avatarAbilitiesEnabledChangedConn = nil
        end
    end

    self.thumbstickFrame = Instance.new("Frame")
    local v1 = if not UserPlayerScriptsClassicThumbstickRenameUI then
        "ThumbstickFrame"
    else
        "ClassicThumbstickFrame"
    self.thumbstickFrame.Name = v1
    self.thumbstickFrame.Active = true
    self.thumbstickFrame.Visible = false
    self.thumbstickFrame.BackgroundTransparency = 1
    local ImageLabel = Instance.new("ImageLabel")
    ImageLabel.Name = "OuterImage"
    ImageLabel.Image = "rbxasset://textures/ui/TouchControlsSheet.png"
    ImageLabel.ImageRectOffset = Vector2.new()
    ImageLabel.ImageRectSize = Vector2.new(220, 220)
    ImageLabel.BackgroundTransparency = 1
    ImageLabel.Position = UDim2.new(0, 0, 0, 0)
    self.stickImage = Instance.new("ImageLabel")
    self.stickImage.Name = "StickImage"
    self.stickImage.Image = "rbxasset://textures/ui/TouchControlsSheet.png"
    self.stickImage.ImageRectOffset = Vector2.new(220, 0)
    self.stickImage.ImageRectSize = Vector2.new(111, 111)
    self.stickImage.BackgroundTransparency = 1
    self.stickImage.ZIndex = 2

    local function ResizeThumbstick()
        -- Line: 168
        -- upvalues: a2 (val), u25 (upval), u67 (upval), AvatarAbilitiesInterface (upval), self (val), ImageLabel (val)
        local v1
        local v2 = (math.min(a2.AbsoluteSize.X, a2.AbsoluteSize.Y)) <= 500

        if not (if not u25 then AvatarAbilitiesInterface.isEnabled() else u67:isEnabled()) then
            self.thumbstickSize = if not v2 then 120 else 70
            v1 = v2
                and UDim2.new(0, self.thumbstickSize / 2 - 10, 1, -self.thumbstickSize - 20)
                or UDim2.new(0, self.thumbstickSize / 2, 1, -self.thumbstickSize * 1.75)
            self.screenPos = v1
        else
            v1 = if not v2 then 112 else 64
            self.thumbstickSize = if not v2 then 120 else 72
            self.screenPos = UDim2.new(0, if not v2 then 100 else 64, 1, -self.thumbstickSize - v1)
        end

        self.thumbstickFrame.Size = UDim2.new(0, self.thumbstickSize, 0, self.thumbstickSize)
        self.thumbstickFrame.Position = self.screenPos
        ImageLabel.Size = UDim2.new(0, self.thumbstickSize, 0, self.thumbstickSize)
        self.stickImage.Size = UDim2.new(0, self.thumbstickSize / 2, 0, self.thumbstickSize / 2)
        self.stickImage.Position = UDim2.new(0, self.thumbstickSize / 2 - self.thumbstickSize / 4, 0, self.thumbstickSize / 2 - self.thumbstickSize / 4)
    end

    ResizeThumbstick()

    self.absoluteSizeChangedConn = (a2:GetPropertyChangedSignal("AbsoluteSize")):Connect(ResizeThumbstick)

    if not u25 then
        self.avatarAbilitiesEnabledChangedConn = AvatarAbilitiesInterface.GetEnabledChangedSignal():Connect(ResizeThumbstick)
    else
        self.avatarAbilitiesEnabledChangedConn = u67:GetEnabledChangedSignal():Connect(ResizeThumbstick)
    end

    ImageLabel.Parent = self.thumbstickFrame
    self.stickImage.Parent = self.thumbstickFrame
    self.thumbstickButton = Instance.new("ImageButton")
    self.thumbstickButton.Name = "ClassicThumbstickUIModifier"
    self.thumbstickButton.BackgroundTransparency = 1
    self.thumbstickButton.ImageTransparency = 1
    self.thumbstickButton.AutoButtonColor = false
    self.thumbstickButton.Size = UDim2.new(1, 0, 1, 0)
    self.thumbstickButton.ZIndex = self.thumbstickFrame.ZIndex
    self.thumbstickButton.Visible = true
    self.thumbstickButton.Active = false
    self.thumbstickButton.Parent = self.thumbstickFrame

    if not UserPlayerScriptsResetDTTouchOnCreate then
        local InputBinding = Instance.new("InputBinding")
        InputBinding.Name = "ClassicTouchBinding"
        InputBinding.KeyCode = Enum.KeyCode.TouchPosition
        InputBinding.UIModifier = self.thumbstickButton
        InputBinding.Parent = u51
    end

    local u157 = nil

    local function DoMove(a1) -- Line: 226; upvalues: self (val); types: a1: userdata
        local v1 = a1 / (self.thumbstickSize / 2)
        local magnitude = v1.magnitude
        v1 = if not (magnitude < 0.05) then
            v1.unit * math.min(1, (magnitude - 0.05) / 0.95)
        else
            Vector2.new()
        v1 = Vector2.new(v1.X, -v1.Y)
        local ClassicThumbstickScriptableBinding = self.data.controlModule.actions.MoveAction:FindFirstChild("ClassicThumbstickScriptableBinding")

        if ClassicThumbstickScriptableBinding then
            ClassicThumbstickScriptableBinding:Fire(v1)
        end
    end

    local function MoveStick(a1)
        -- Line: 246
        -- upvalues: u157 (ref), self (val), UserAbilitiesUserInterfaceC (upval), a2 (val)
        -- types: a1: vector
        local v1 = Vector2.new(a1.X - u157.X, a1.Y - u157.Y)
        local magnitude = v1.magnitude
        local v2 = self.thumbstickFrame.AbsoluteSize.X / 2

        if not self.isFollowStick or not (v2 < magnitude) then
            v1 = v1.unit * (math.min(magnitude, v2))
        else
            local v3 = v1.unit * v2

            if not UserAbilitiesUserInterfaceC then
                self.thumbstickFrame.Position = UDim2.new(0, a1.X - self.thumbstickFrame.AbsoluteSize.X / 2 - v3.X, 0, a1.Y - self.thumbstickFrame.AbsoluteSize.Y / 2 - v3.Y)
            else
                local AbsolutePosition = a2.AbsolutePosition
                self.thumbstickFrame.Position = UDim2.new(0, a1.X - AbsolutePosition.X - self.thumbstickFrame.AbsoluteSize.X / 2 - v3.X, 0, a1.Y - AbsolutePosition.Y - self.thumbstickFrame.AbsoluteSize.Y / 2 - v3.Y)
            end
        end

        self.stickImage.Position = UDim2.new(0, v1.X + self.stickImage.AbsoluteSize.X / 2, 0, v1.Y + self.stickImage.AbsoluteSize.Y / 2)
    end

    function self.onStateChanged(a1)
        -- Line: 269
        -- upvalues: u55 (upval), GuiService (upval), self (val), UserAbilitiesUserInterfaceC (upval), a2 (val)
        -- upvalues: u157 (ref), DoMove (val), MoveStick (val)
        -- types: a1: userdata
        if a1 == u55 then
            if self.isTouchActive then
                self:OnInputEnded()
            end

            return
        end

        local Min = GuiService:GetInsetArea(Enum.ScreenInsets.None).Min
        local v1 = Vector3.new(a1.X + Min.X, a1.Y + Min.Y, 0)

        if self.isTouchActive then
            u157 = Vector2.new(self.thumbstickFrame.AbsolutePosition.X + self.thumbstickFrame.AbsoluteSize.X / 2, self.thumbstickFrame.AbsolutePosition.Y + self.thumbstickFrame.AbsoluteSize.Y / 2)
            DoMove((Vector2.new(v1.X - u157.X, v1.Y - u157.Y)))
            MoveStick(v1)

            return
        end

        self.isTouchActive = true

        if not UserAbilitiesUserInterfaceC then
            self.thumbstickFrame.Position = UDim2.new(0, v1.X - self.thumbstickFrame.Size.X.Offset / 2, 0, v1.Y - self.thumbstickFrame.Size.Y.Offset / 2)
        else
            local AbsolutePosition = a2.AbsolutePosition
            self.thumbstickFrame.Position = UDim2.new(0, v1.X - AbsolutePosition.X - self.thumbstickFrame.Size.X.Offset / 2, 0, v1.Y - AbsolutePosition.Y - self.thumbstickFrame.Size.Y.Offset / 2)
        end

        u157 = Vector2.new(self.thumbstickFrame.AbsolutePosition.X + self.thumbstickFrame.AbsoluteSize.X / 2, self.thumbstickFrame.AbsolutePosition.Y + self.thumbstickFrame.AbsoluteSize.Y / 2)
    end

    GuiService.MenuOpened:Connect(function() -- Line: 308; upvalues: self (val)
        if self.isTouchActive then
            self:OnInputEnded()
        end
    end)

    self.thumbstickFrame.Parent = a2
end

return u80