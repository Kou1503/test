-- Script path: game:GetService("StarterPlayer").PlayerModule.ControlModule.DynamicThumbstick
-- Decompile time: 15.47 ms

local u0 = {0.10999999999999999, 0.30000000000000004, 0.4, 0.5, 0.6, 0.7, 0.75}
local u8 = {0.55, 0.65, 0.7, 0.75, 0.8, 0.85, 0.875}
local u16 = #u0
local u20 = Vector2.new(-1, -1)
local u25 = TweenInfo.new(0.15, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut)
local FlagUtil = require(script.Parent.Parent:WaitForChild("CommonUtils")).get("FlagUtil")
local u41 = FlagUtil.getUserFlag("UserPlayerScriptsCCLIntegrationD")
local UserAllowAbilityControlsBonus = FlagUtil.getUserFlag("UserAllowAbilityControlsBonus")
local UserDoubleJumpButtonFix = FlagUtil.getUserFlag("UserDoubleJumpButtonFix")
local UserPlayerScriptsResetDTTouchOnCreate = FlagUtil.getUserFlag("UserPlayerScriptsResetDTTouchOnCreate")
local v1 = game:GetService("Players")
local GuiService = game:GetService("GuiService")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local u87 = script.Parent.Parent:WaitForChild("InputContexts"):WaitForChild("TransformerContext"):WaitForChild("ThumbstickAction")
local AvatarAbilitiesInterface = require(script.Parent:WaitForChild("AvatarAbilitiesInterface"))
local u99 = if not u41 then nil else AvatarAbilitiesInterface.get(v1.LocalPlayer)
local LocalPlayer = v1.LocalPlayer

if not LocalPlayer then
    v1:GetPropertyChangedSignal("LocalPlayer"):Wait()

    LocalPlayer = v1.LocalPlayer
end

local u118 = require(script.Parent:WaitForChild("ActionController"))
local u122 = setmetatable(
    {},
    u118
)
u122.__index = u122

function u122.new(a1) -- Line: 67; upvalues: u118 (val), u122 (val)
    local v1 = u118.new()
    local v2 = setmetatable(v1, u122)
    v2.data = a1
    v2.enabled = false
    v2.isTouchActive = false
    v2.moveTouchFirstChanged = false
    v2.moveTouchStartPosition = nil
    v2.startImage = nil
    v2.endImage = nil
    v2.endImageStroke = nil
    v2.endImageCenter = nil
    v2.middleImages = {}
    v2.startImageFadeTween = nil
    v2.endImageFadeTween = nil
    v2.endImageCenterFadeTween = nil
    v2.middleImageFadeTweens = {}
    v2.isFirstTouch = true
    v2.thumbstickFrame = nil
    v2.onRenderSteppedConn = nil
    v2.fadeInAndOutBalance = 0.5
    v2.fadeInAndOutHalfDuration = 0.3
    v2.hasFadedBackgroundInPortrait = false
    v2.hasFadedBackgroundInLandscape = false
    v2.tweenInAlphaStart = nil
    v2.tweenOutAlphaStart = nil
    v2.newStyle = false

    return v2
end

function u122.GetIsJumping(a1) -- Line: 109
    local isJumping = a1.isJumping
    a1.isJumping = false

    return isJumping
end

local function setupThumbstickInput(a1) -- Line: 115; upvalues: u87 (val)
    for i, j in u87:GetChildren() do
        if j.Name == "DynamicTouchBinding" or j.Name == "ClassicTouchBinding" then
            j:Destroy()
        end
    end

    local InputBinding = Instance.new("InputBinding")
    InputBinding.Name = "DynamicTouchBinding"
    InputBinding.KeyCode = Enum.KeyCode.TouchPosition
    InputBinding.UIModifier = a1.thumbstickButton
    InputBinding.Parent = u87
end

local function enableThumbstickInput(a1, a2)
    -- Line: 128
    -- upvalues: setupThumbstickInput (val), u87 (val)
    -- types: a2: boolean
    if a2 then
        setupThumbstickInput(a1)

        a1.thumbstickStateChangedConn = u87.StateChanged:Connect(a1.onStateChanged)
        u87.Enabled = true

        return
    end

    u87.Enabled = false

    if a1.thumbstickStateChangedConn then
        a1.thumbstickStateChangedConn:Disconnect()

        a1.thumbstickStateChangedConn = nil
    end
end

function u122.Enable(a1, a2, a3)
    -- Line: 142
    -- upvalues: u118 (val), u41 (val), u99 (val), UserPlayerScriptsResetDTTouchOnCreate (val)
    -- upvalues: setupThumbstickInput (val), u87 (val)
    -- types: a1: table, a2: boolean?
    if a2 == nil then
        return false
    end

    local v1 = not not a2

    if a1.enabled == v1 then
        return true
    end

    u118.Enable(a1, v1)

    if not v1 then
        if not UserPlayerScriptsResetDTTouchOnCreate then end

        u87.Enabled = false

        if a1.thumbstickStateChangedConn then
            a1.thumbstickStateChangedConn:Disconnect()

            a1.thumbstickStateChangedConn = nil
        end

        a1:OnInputEnded()
    else
        if not a1.thumbstickFrame then
            a1:Create(a3)

            if u41 and not a1.avatarAbilitiesEnabledChangedConn then
                a1.avatarAbilitiesEnabledChangedConn = (u99:GetEnabledChangedSignal()):Connect(function()
                    -- Line: 153
                    -- upvalues: a1 (val), a3 (val), UserPlayerScriptsResetDTTouchOnCreate (upval)
                    -- upvalues: setupThumbstickInput (upval), u87 (upval)
                    if a1.enabled then
                        a1:Create(a3)

                        if UserPlayerScriptsResetDTTouchOnCreate then
                            setupThumbstickInput(a1)
                        end

                        a1.thumbstickStateChangedConn = u87.StateChanged:Connect(a1.onStateChanged)
                        u87.Enabled = true
                        a1.thumbstickFrame.Visible = true
                    end
                end)
            end
        end

        if UserPlayerScriptsResetDTTouchOnCreate then
            setupThumbstickInput(a1)
        end

        a1.thumbstickStateChangedConn = u87.StateChanged:Connect(a1.onStateChanged)
        u87.Enabled = true
    end

    a1.enabled = v1
    a1.thumbstickFrame.Visible = v1

    return nil
end

function u122:OnInputEnded() -- Line: 194
    self.isTouchActive = false
    local DynamicThumbstickScriptableBinding = self.data.controlModule.actions.MoveAction:FindFirstChild("DynamicThumbstickScriptableBinding")

    if DynamicThumbstickScriptableBinding then
        DynamicThumbstickScriptableBinding:Fire(Vector2.zero)
    end

    self:FadeThumbstick(false)
end

function u122:FadeThumbstick(a2)
    -- Line: 203
    -- upvalues: u41 (val), TweenService (val), u25 (val), u8 (val), u0 (val)
    -- types: self: table, a2: boolean?
    local middleImageFadeTweens, middleImageFadeTweens_2, v1, v2, v3

    if not a2 and self.isTouchActive then
        return
    end

    if self.isFirstTouch then
        return
    end

    if self.startImageFadeTween then
        self.startImageFadeTween:Cancel()
    end

    if self.endImageFadeTween then
        self.endImageFadeTween:Cancel()
    end

    if u41 and self.endImageCenterFadeTween then
        self.endImageCenterFadeTween:Cancel()
    end

    local v4 = #self.middleImages
    local v5 = self

    for i = 1, v4 do
        if v5.middleImageFadeTweens[i] then
            v5.middleImageFadeTweens[i]:Cancel()
        end
    end

    if not v1 then
        local middleImageFadeTweens_3, middleImageFadeTweens_4

        if not u41 or not v5.newStyle then
            v5.startImageFadeTween = TweenService:Create(
                v5.startImage,
                u25,
                {ImageTransparency = 1}
            )
            v5.startImageFadeTween:Play()

            v5.endImageFadeTween = TweenService:Create(
                v5.endImage,
                u25,
                {ImageTransparency = 1}
            )
            v5.endImageFadeTween:Play()
        else
            v5.startImageFadeTween = TweenService:Create(
                v5.startImage,
                u25,
                {BackgroundTransparency = 1}
            )
            v5.startImageFadeTween:Play()

            v5.endImageFadeTween = TweenService:Create(
                v5.endImageStroke,
                u25,
                {Transparency = 1}
            )
            v5.endImageFadeTween:Play()

            v5.endImageCenterFadeTween = TweenService:Create(
                v5.endImageCenter,
                u25,
                {BackgroundTransparency = 1}
            )
            v5.endImageCenterFadeTween:Play()
        end

        v4 = #v5.middleImages

        for j = 1, v4 do
            if not u41 or not v5.newStyle then
                middleImageFadeTweens_4 = v5.middleImageFadeTweens
                v3 = v5.middleImages[j]
                middleImageFadeTweens_4[j] = (TweenService:Create(
                    v3,
                    u25,
                    {ImageTransparency = 1}
                ))
            else
                middleImageFadeTweens_3 = v5.middleImageFadeTweens
                v3 = v5.middleImages[j]
                middleImageFadeTweens_3[j] = (TweenService:Create(
                    v3,
                    u25,
                    {BackgroundTransparency = 1}
                ))
            end

            v5.middleImageFadeTweens[j]:Play()
        end

        return
    end

    if not u41 or not v5.newStyle then
        v5.startImageFadeTween = TweenService:Create(
            v5.startImage,
            u25,
            {ImageTransparency = 0}
        )
        v5.startImageFadeTween:Play()

        v5.endImageFadeTween = TweenService:Create(
            v5.endImage,
            u25,
            {ImageTransparency = 0.2}
        )
        v5.endImageFadeTween:Play()
    else
        v5.startImageFadeTween = TweenService:Create(
            v5.startImage,
            u25,
            {BackgroundTransparency = 0.4}
        )
        v5.startImageFadeTween:Play()

        v5.endImageFadeTween = TweenService:Create(
            v5.endImageStroke,
            u25,
            {Transparency = 0}
        )
        v5.endImageFadeTween:Play()

        v5.endImageCenterFadeTween = TweenService:Create(
            v5.endImageCenter,
            u25,
            {BackgroundTransparency = 0}
        )
        v5.endImageCenterFadeTween:Play()
    end

    v4 = #v5.middleImages

    for k = 1, v4 do
        if not u41 or not v5.newStyle then
            middleImageFadeTweens_2 = v5.middleImageFadeTweens
            v3 = v5.middleImages[k]
            v2 = {ImageTransparency = u0[k]}
            middleImageFadeTweens_2[k] = (TweenService:Create(v3, u25, v2))
        else
            middleImageFadeTweens = v5.middleImageFadeTweens
            v3 = v5.middleImages[k]
            v2 = {BackgroundTransparency = u8[k]}
            middleImageFadeTweens[k] = (TweenService:Create(v3, u25, v2))
        end

        v5.middleImageFadeTweens[k]:Play()
    end
end

function u122.FadeThumbstickFrame(a1, a2, a3) -- Line: 279; types: a1: table, a2: number, a3: number
    a1.fadeInAndOutHalfDuration = a2 * 0.5
    a1.fadeInAndOutBalance = a3
    a1.tweenInAlphaStart = tick()
end

function u122:DoFadeInBackground() -- Line: 285; upvalues: LocalPlayer (ref)
    local PlayerGui = LocalPlayer:FindFirstChildOfClass("PlayerGui")
    local hasFadedBackgroundInPortrait = false

    if PlayerGui then
        if PlayerGui.CurrentScreenOrientation == Enum.ScreenOrientation.LandscapeLeft
            or PlayerGui.CurrentScreenOrientation == Enum.ScreenOrientation.LandscapeRight then
            hasFadedBackgroundInPortrait = self.hasFadedBackgroundInLandscape
            self.hasFadedBackgroundInLandscape = true
        elseif PlayerGui.CurrentScreenOrientation == Enum.ScreenOrientation.Portrait then
            hasFadedBackgroundInPortrait = self.hasFadedBackgroundInPortrait
            self.hasFadedBackgroundInPortrait = true
        end
    end

    if not hasFadedBackgroundInPortrait then
        self.fadeInAndOutHalfDuration = 0.3
        self.fadeInAndOutBalance = 0.5
        self.tweenInAlphaStart = tick()
    end
end

function u122:DoMove(a2) -- Line: 308; types: self: table, a2: userdata
    local v1 = a2
    v1 = if not (v1.Magnitude < self.radiusOfDeadZone) then
        v1.Unit
            * (1
                - math.max(0, (self.radiusOfMaxSpeed - v1.Magnitude) / self.radiusOfMaxSpeed))
    else
        Vector2.new()
    v1 = Vector2.new(v1.X, -v1.Y)
    local DynamicThumbstickScriptableBinding = self.data.controlModule.actions.MoveAction:FindFirstChild("DynamicThumbstickScriptableBinding")

    if DynamicThumbstickScriptableBinding then
        DynamicThumbstickScriptableBinding:Fire(v1)
    end
end

function u122:LayoutMiddleImages(a2, a3)
    -- Line: 328
    -- upvalues: u16 (val)
    -- types: self: table, a2: vector, a3: vector
    local v1, v2, v3, v4
    local v5 = self.thumbstickSize / 2 + self.middleSize
    local v6 = a3 - a2
    local v7 = v6.Magnitude - self.thumbstickRingSize / 2 - self.middleSize
    local Unit = v6.Unit
    v6 = self.middleSpacing * u16
    local middleSpacing = self.middleSpacing

    if v6 < v7 then
        middleSpacing = v7 / u16
    end

    local v8, v9 = self, a3

    for i = 1, u16 do
        v6 = v8.middleImages[i]
        v1 = v5 + middleSpacing * (i - 2)
        v2 = v5 + middleSpacing * (i - 1)

        if not (v1 < v7) then
            v6.Visible = false
        else
            v3 = v9 - Unit * v2
            v4 = math.clamp(1 - (v2 - v7) / middleSpacing, 0, 1)
            v6.Visible = true
            v6.Position = UDim2.new(0, v3.X, 0, v3.Y)
            v6.Size = UDim2.new(0, v8.middleSize * v4, 0, v8.middleSize * v4)
        end
    end
end

function u122:MoveStick(a2) -- Line: 359
    local v1 = (Vector2.new(self.moveTouchStartPosition.X, self.moveTouchStartPosition.Y))
        - self.thumbstickFrame.AbsolutePosition
    local v2 = (Vector2.new(a2.X, a2.Y)) - self.thumbstickFrame.AbsolutePosition
    self.endImage.Position = UDim2.new(0, v2.X, 0, v2.Y)

    self:LayoutMiddleImages(v1, v2)
end

function u122:Create(a2)
    -- Line: 367
    -- upvalues: UserPlayerScriptsResetDTTouchOnCreate (val), u87 (val), u41 (val), u99 (val)
    -- upvalues: UserDoubleJumpButtonFix (val), u16 (val), u8 (val), u0 (val), AvatarAbilitiesInterface (val)
    -- upvalues: UserAllowAbilityControlsBonus (val), RunService (val), u20 (val), GuiService (val), TweenService (val)
    -- upvalues: LocalPlayer (ref)
    -- types: self: table, a2: userdata
    local v1

    if self.thumbstickFrame then
        if not UserPlayerScriptsResetDTTouchOnCreate then end

        u87.Enabled = false

        if self.thumbstickStateChangedConn then
            self.thumbstickStateChangedConn:Disconnect()

            self.thumbstickStateChangedConn = nil
        end

        self.thumbstickFrame:Destroy()

        self.thumbstickFrame = nil

        if self.onRenderSteppedConn then
            self.onRenderSteppedConn:Disconnect()

            self.onRenderSteppedConn = nil
        end

        if self.absoluteSizeChangedConn then
            self.absoluteSizeChangedConn:Disconnect()

            self.absoluteSizeChangedConn = nil
        end

        if not u41 and self.avatarAbilitiesEnabledChangedConn then
            self.avatarAbilitiesEnabledChangedConn:Disconnect()

            self.avatarAbilitiesEnabledChangedConn = nil
        end

        if u41 then
            if self.cameraChangedConn then
                self.cameraChangedConn:Disconnect()

                self.cameraChangedConn = nil
            end

            if self.currentCameraChangedConn then
                self.currentCameraChangedConn:Disconnect()

                self.currentCameraChangedConn = nil
            end

            if self.menuOpenedConnection then
                self.menuOpenedConnection:Disconnect()

                self.menuOpenedConnection = nil
            end

            if self.playerGuiChangedConn then
                self.playerGuiChangedConn:Disconnect()

                self.playerGuiChangedConn = nil
            end
        end
    end

    local function layoutThumbstickFrame(a1) -- Line: 415; upvalues: self (val); types: a1: boolean
        if a1 then
            self.thumbstickFrame.Size = UDim2.new(1, 100, 0.4, 100)
            self.thumbstickFrame.Position = UDim2.new(0, -100, 0.6, 0)

            return
        end

        self.thumbstickFrame.Size = UDim2.new(0.4, 100, 0.6666666666666666, 100)
        self.thumbstickFrame.Position = UDim2.new(0, -100, 0.3333333333333333, 0)
    end

    local v2 = u41 and u99:isEnabled()
    self.newStyle = v2
    self.thumbstickFrame = Instance.new("Frame")
    self.thumbstickFrame.BorderSizePixel = 0
    self.thumbstickFrame.Name = "DynamicThumbstickFrame"
    self.thumbstickFrame.Visible = false
    self.thumbstickFrame.BackgroundTransparency = 1
    self.thumbstickFrame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    self.thumbstickFrame.Active = false
    self.thumbstickFrame.Size = UDim2.new(0.4, 100, 0.6666666666666666, 100)
    self.thumbstickFrame.Position = UDim2.new(0, -100, 0.3333333333333333, 0)
    self.thumbstickButton = Instance.new("ImageButton")
    self.thumbstickButton.Name = "DynamicThumbstickUIModifier"
    self.thumbstickButton.BackgroundTransparency = 1
    self.thumbstickButton.ImageTransparency = 1
    self.thumbstickButton.AutoButtonColor = false
    self.thumbstickButton.Size = UDim2.new(1, 0, 1, 0)
    self.thumbstickButton.ZIndex = self.thumbstickFrame.ZIndex
    self.thumbstickButton.Visible = true
    self.thumbstickButton.Active = false
    self.thumbstickButton.Parent = self.thumbstickFrame

    if not UserPlayerScriptsResetDTTouchOnCreate then
        v2 = nil

        if UserDoubleJumpButtonFix then
            v2 = u87:FindFirstChild("DynamicTouchBinding")
        end

        if not v2 then
            v2 = Instance.new("InputBinding")
            v2.Name = "DynamicTouchBinding"
            v2.KeyCode = Enum.KeyCode.TouchPosition
            v2.Parent = u87
        end

        v2.UIModifier = self.thumbstickButton
    end

    if not u41 then
        self.startImage = Instance.new("ImageLabel")
        self.startImage.Name = "ThumbstickStart"
        self.startImage.Visible = true
        self.startImage.BackgroundTransparency = 1
        self.startImage.Image = "rbxasset://textures/ui/Input/TouchControlsSheetV2.png"
        self.startImage.ImageRectOffset = Vector2.new(1, 1)
        self.startImage.ImageRectSize = Vector2.new(144, 144)
        self.startImage.ImageColor3 = Color3.new(0, 0, 0)
        self.startImage.AnchorPoint = Vector2.new(0.5, 0.5)
        self.startImage.ZIndex = 10
        self.startImage.Parent = self.thumbstickFrame
        self.endImage = Instance.new("ImageLabel")
        self.endImage.Name = "ThumbstickEnd"
        self.endImage.Visible = true
        self.endImage.BackgroundTransparency = 1
        self.endImage.Image = "rbxasset://textures/ui/Input/TouchControlsSheetV2.png"
        self.endImage.ImageRectOffset = Vector2.new(1, 1)
        self.endImage.ImageRectSize = Vector2.new(144, 144)
        self.endImage.AnchorPoint = Vector2.new(0.5, 0.5)
        self.endImage.ZIndex = 10
        self.endImage.Parent = self.thumbstickFrame

        for i = 1, u16 do
            self.middleImages[i] = (Instance.new("ImageLabel"))
            v1 = self.middleImages[i]
            v1.Name = "ThumbstickMiddle"
            v1 = self.middleImages[i]
            v1.Visible = false
            v1 = self.middleImages[i]
            v1.BackgroundTransparency = 1
            v1 = self.middleImages[i]
            v1.Image = "rbxasset://textures/ui/Input/TouchControlsSheetV2.png"
            v1 = self.middleImages[i]
            v1.ImageRectOffset = Vector2.new(1, 1)
            v1 = self.middleImages[i]
            v1.ImageRectSize = Vector2.new(144, 144)
            v1 = self.middleImages[i]
            v1.ImageTransparency = u0[i]
            v1 = self.middleImages[i]
            v1.AnchorPoint = Vector2.new(0.5, 0.5)
            v1 = self.middleImages[i]
            v1.ZIndex = 9
            v1 = self.middleImages[i]
            v1.Parent = self.thumbstickFrame
        end
    elseif not self.newStyle then
        self.startImage = Instance.new("ImageLabel")
        self.startImage.Name = "ThumbstickStart"
        self.startImage.Visible = true
        self.startImage.BackgroundTransparency = 1
        self.startImage.Image = "rbxasset://textures/ui/Input/TouchControlsSheetV2.png"
        self.startImage.ImageRectOffset = Vector2.new(1, 1)
        self.startImage.ImageRectSize = Vector2.new(144, 144)
        self.startImage.ImageColor3 = Color3.new(0, 0, 0)
        self.startImage.AnchorPoint = Vector2.new(0.5, 0.5)
        self.startImage.ZIndex = 10
        self.startImage.Parent = self.thumbstickFrame
        self.endImage = Instance.new("ImageLabel")
        self.endImage.Name = "ThumbstickEnd"
        self.endImage.Visible = true
        self.endImage.BackgroundTransparency = 1
        self.endImage.Image = "rbxasset://textures/ui/Input/TouchControlsSheetV2.png"
        self.endImage.ImageRectOffset = Vector2.new(1, 1)
        self.endImage.ImageRectSize = Vector2.new(144, 144)
        self.endImage.AnchorPoint = Vector2.new(0.5, 0.5)
        self.endImage.ZIndex = 10
        self.endImage.Parent = self.thumbstickFrame

        for j = 1, u16 do
            self.middleImages[j] = (Instance.new("ImageLabel"))
            v1 = self.middleImages[j]
            v1.Name = "ThumbstickMiddle"
            v1 = self.middleImages[j]
            v1.Visible = false
            v1 = self.middleImages[j]
            v1.BackgroundTransparency = 1
            v1 = self.middleImages[j]
            v1.Image = "rbxasset://textures/ui/Input/TouchControlsSheetV2.png"
            v1 = self.middleImages[j]
            v1.ImageRectOffset = Vector2.new(1, 1)
            v1 = self.middleImages[j]
            v1.ImageRectSize = Vector2.new(144, 144)
            v1 = self.middleImages[j]
            v1.ImageTransparency = u0[j]
            v1 = self.middleImages[j]
            v1.AnchorPoint = Vector2.new(0.5, 0.5)
            v1 = self.middleImages[j]
            v1.ZIndex = 9
            v1 = self.middleImages[j]
            v1.Parent = self.thumbstickFrame
        end
    else
        local v3
        self.startImage = Instance.new("Frame")
        self.startImage.Name = "ThumbstickStart"
        self.startImage.BackgroundColor3 = Color3.fromRGB(18, 18, 21)
        self.startImage.BackgroundTransparency = 0.4
        self.startImage.AnchorPoint = Vector2.new(0.5, 0.5)
        self.startImage.ZIndex = 10
        self.startImage.Parent = self.thumbstickFrame
        local UICorner = Instance.new("UICorner")
        UICorner.CornerRadius = UDim.new(0.5, 0)
        UICorner.Parent = self.startImage
        self.endImage = Instance.new("Frame")
        self.endImage.Name = "ThumbstickEnd"
        self.endImage.BackgroundTransparency = 1
        self.endImage.AnchorPoint = Vector2.new(0.5, 0.5)
        self.endImage.ZIndex = 10
        self.endImage.Parent = self.thumbstickFrame
        local UICorner_2 = Instance.new("UICorner")
        UICorner_2.CornerRadius = UDim.new(0.5, 0)
        UICorner_2.Parent = self.endImage
        self.endImageStroke = Instance.new("UIStroke")
        local v4 = if not UserDoubleJumpButtonFix then 2 else 1.5
        self.endImageStroke.Thickness = v4
        self.endImageStroke.Color = Color3.fromRGB(213, 215, 221)
        self.endImageStroke.Parent = self.endImage
        self.endImageCenter = Instance.new("Frame")
        self.endImageCenter.Name = "ThumbstickEndCenter"
        self.endImageCenter.BackgroundTransparency = 0
        self.endImageCenter.BackgroundColor3 = Color3.fromRGB(213, 215, 221)
        self.endImageCenter.AnchorPoint = Vector2.new(0.5, 0.5)
        self.endImageCenter.Size = UDim2.new(0.74, 0, 0.74, 0)
        self.endImageCenter.Position = UDim2.new(0.5, 0, 0.5, 0)
        self.endImageCenter.ZIndex = 10
        self.endImageCenter.Parent = self.endImage
        local UICorner_3 = Instance.new("UICorner")
        UICorner_3.CornerRadius = UDim.new(0.5, 0)
        UICorner_3.Parent = self.endImageCenter

        for k = 1, u16 do
            self.middleImages[k] = (Instance.new("Frame"))
            v3 = self.middleImages[k]
            v3.Name = "ThumbstickMiddle"
            v3 = self.middleImages[k]
            v3.Visible = false
            v3 = self.middleImages[k]
            v3.BackgroundTransparency = u8[k]
            v3 = self.middleImages[k]
            v3.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            v3 = self.middleImages[k]
            v3.AnchorPoint = Vector2.new(0.5, 0.5)
            v3 = self.middleImages[k]
            v3.ZIndex = 9
            v3 = self.middleImages[k]
            v3.Parent = self.thumbstickFrame
            v2 = Instance.new("UICorner")
            v2.CornerRadius = UDim.new(0.5, 0)
            v2.Parent = self.middleImages[k]
        end
    end

    local function ResizeThumbstick()
        -- Line: 557
        -- upvalues: a2 (val), u41 (upval), self (val), AvatarAbilitiesInterface (upval)
        -- upvalues: UserAllowAbilityControlsBonus (upval)
        local v1
        local AbsoluteSize = a2.AbsoluteSize
        local v2 = if not (500 < (math.min(AbsoluteSize.X, AbsoluteSize.Y))) then 1 else 2
        local newStyle = if not u41 then AvatarAbilitiesInterface.isEnabled() else self.newStyle

        if UserAllowAbilityControlsBonus and newStyle and v1 then
            v2 = 1.6216216216216217
        end

        self.thumbstickSize = 45 * v2
        self.thumbstickRingSize = 20 * v2
        self.middleSize = 10 * v2
        self.middleSpacing = 14 * v2
        self.radiusOfDeadZone = 2 * v2
        self.radiusOfMaxSpeed = 20 * v2
        local v3 = 74 * v2

        if not u41 or self.isFirstTouch then
            if not newStyle then
                self.startImage.Position = UDim2.new(0, self.thumbstickRingSize * 3.3 + 100, 1, -self.thumbstickRingSize * 2.8 - 100)
            else
                v2 = if not v1 then 64 else 100
                local v4 = if not v1 then 64 else 112
                self.startImage.Position = UDim2.new(0, v3 * 0.5 + 100 + v2, 1, -v3 * 0.5 - 100 - v4)
            end

            self.startImage.Size = UDim2.new(0, v3, 0, v3)
        end

        self.endImage.Position = self.startImage.Position

        if u41 and self.newStyle then
            self.endImage.Size = UDim2.new(0, self.thumbstickSize * 0.6, 0, self.thumbstickSize * 0.6)
            return
        end

        self.endImage.Size = UDim2.new(0, self.thumbstickSize * 0.8, 0, self.thumbstickSize * 0.8)
    end

    ResizeThumbstick()

    self.absoluteSizeChangedConn = (a2:GetPropertyChangedSignal("AbsoluteSize")):Connect(ResizeThumbstick)

    if not u41 then
        self.avatarAbilitiesEnabledChangedConn = AvatarAbilitiesInterface.GetEnabledChangedSignal():Connect(ResizeThumbstick)
    end

    local function onCurrentCameraChanged() -- Line: 612; upvalues: self (val), layoutThumbstickFrame (val)
        if self.cameraChangedConn then
            self.cameraChangedConn:Disconnect()

            self.cameraChangedConn = nil
        end

        local CurrentCamera = workspace.CurrentCamera

        if CurrentCamera then
            self.cameraChangedConn = (CurrentCamera:GetPropertyChangedSignal("ViewportSize")):Connect(function()
                -- Line: 619
                -- upvalues: CurrentCamera (val), layoutThumbstickFrame (upval)
                local ViewportSize = CurrentCamera.ViewportSize
                local v1 = ViewportSize.X < ViewportSize.Y

                layoutThumbstickFrame(v1)
            end)
            local ViewportSize = CurrentCamera.ViewportSize
            local v1 = ViewportSize.X < ViewportSize.Y

            layoutThumbstickFrame(v1)
        end
    end

    self.currentCameraChangedConn = (workspace:GetPropertyChangedSignal("CurrentCamera")):Connect(onCurrentCameraChanged)

    if workspace.CurrentCamera or u41 then
        onCurrentCameraChanged()
    end

    self.startImageFadeTween = nil
    self.endImageFadeTween = nil
    self.endImageCenterFadeTween = nil
    self.middleImageFadeTweens = {}

    if UserPlayerScriptsResetDTTouchOnCreate and self.isTouchActive then
        self:OnInputEnded()
    end

    self.moveTouchStartPosition = nil
    self.onRenderSteppedConn = RunService.RenderStepped:Connect(function() -- Line: 643; upvalues: self (val)
        local v1, v2

        if self.tweenInAlphaStart == nil then
            if self.tweenOutAlphaStart ~= nil then
                v1 = tick() - self.tweenOutAlphaStart
                v2 = self.fadeInAndOutHalfDuration * 2
                    - self.fadeInAndOutHalfDuration * 2 * self.fadeInAndOutBalance
                self.thumbstickFrame.BackgroundTransparency = math.min(v1 / v2, 1) * 0.35 + 0.65

                if v2 < v1 then
                    self.tweenOutAlphaStart = nil
                end
            end

            return
        end

        v1 = tick() - self.tweenInAlphaStart
        v2 = self.fadeInAndOutHalfDuration * 2 * self.fadeInAndOutBalance
        self.thumbstickFrame.BackgroundTransparency = 1 - math.min(v1 / v2, 1) * 0.35

        if not (v2 < v1) then
            return
        end

        self.tweenOutAlphaStart = tick()
        self.tweenInAlphaStart = nil
    end)

    function self.onStateChanged(a1)
        -- Line: 662
        -- upvalues: u20 (upval), GuiService (upval), self (val), TweenService (upval), u41 (upval)
        -- types: a1: userdata
        local v1

        if a1 == u20 then
            if self.isTouchActive then
                self:OnInputEnded()
            end

            return
        end

        local Min = GuiService:GetInsetArea(Enum.ScreenInsets.None).Min
        local v2 = Vector3.new(a1.X + Min.X, a1.Y + Min.Y, 0)

        if not self.isTouchActive then
            self.isTouchActive = true

            if self.isFirstTouch then
                self.isFirstTouch = false
                local v3 = TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out, 0, false, 0)

                TweenService:Create(
                    self.startImage,
                    v3,
                    {Size = UDim2.new(0, 0, 0, 0)}
                ):Play()

                if not u41 or not self.newStyle then
                    TweenService:Create(
                        self.endImage,
                        v3,
                        {
                            Size = UDim2.new(0, self.thumbstickSize, 0, self.thumbstickSize),
                            ImageColor3 = Color3.new(0, 0, 0),
                        }
                    ):Play()
                end
            end

            self.moveTouchStartPosition = v2
            self.moveTouchFirstChanged = true

            self:DoFadeInBackground()

            return
        end

        if self.moveTouchFirstChanged then
            self.moveTouchFirstChanged = false
            v1 = Vector2.new(self.moveTouchStartPosition.X - self.thumbstickFrame.AbsolutePosition.X, self.moveTouchStartPosition.Y - self.thumbstickFrame.AbsolutePosition.Y)
            self.startImage.Visible = true
            self.startImage.Position = UDim2.new(0, v1.X, 0, v1.Y)
            self.endImage.Visible = true
            self.endImage.Position = self.startImage.Position

            self:FadeThumbstick(true)
            self:MoveStick(self.moveTouchStartPosition)
        end

        v1 = Vector2.new(v2.X - self.moveTouchStartPosition.X, v2.Y - self.moveTouchStartPosition.Y)

        if not (0 < v1.Magnitude) then
            return
        end

        self:DoMove(v1)
        self:MoveStick(v2)
    end

    self.menuOpenedConnection = GuiService.MenuOpened:Connect(function() -- Line: 723; upvalues: self (val)
        if self.isTouchActive then
            self:OnInputEnded()
        end
    end)
    local PlayerGui = LocalPlayer:FindFirstChildOfClass("PlayerGui")

    while not PlayerGui do
        LocalPlayer.ChildAdded:wait()

        PlayerGui = LocalPlayer:FindFirstChildOfClass("PlayerGui")
    end

    local u574 = true

    if PlayerGui.CurrentScreenOrientation ~= Enum.ScreenOrientation.LandscapeLeft then
        u574 = PlayerGui.CurrentScreenOrientation == Enum.ScreenOrientation.LandscapeRight
    end

    local function longShowBackground() -- Line: 738; upvalues: self (val)
        self.fadeInAndOutHalfDuration = 2.5
        self.fadeInAndOutBalance = 0.05
        self.tweenInAlphaStart = tick()
    end

    self.playerGuiChangedConn = (PlayerGui:GetPropertyChangedSignal("CurrentScreenOrientation")):Connect(function()
        -- Line: 744
        -- upvalues: u574 (val), PlayerGui (ref), self (val)
        if u574 and PlayerGui.CurrentScreenOrientation == Enum.ScreenOrientation.Portrait then
            self.playerGuiChangedConn:Disconnect()

            self.fadeInAndOutHalfDuration = 2.5
            self.fadeInAndOutBalance = 0.05
            self.tweenInAlphaStart = tick()

            if u574 then
                self.hasFadedBackgroundInPortrait = true
                return
            end

            self.hasFadedBackgroundInLandscape = true

            return
        end

        if not u574 and PlayerGui.CurrentScreenOrientation ~= Enum.ScreenOrientation.Portrait then
            self.playerGuiChangedConn:Disconnect()

            self.fadeInAndOutHalfDuration = 2.5
            self.fadeInAndOutBalance = 0.05
            self.tweenInAlphaStart = tick()

            if u574 then
                self.hasFadedBackgroundInPortrait = true
                return
            end

            self.hasFadedBackgroundInLandscape = true
        end
    end)
    self.thumbstickFrame.Parent = a2

    if not game:IsLoaded() then
        coroutine.wrap(function() -- Line: 764; upvalues: self (val)
            game.Loaded:Wait()

            self.fadeInAndOutHalfDuration = 2.5
            self.fadeInAndOutBalance = 0.05
            self.tweenInAlphaStart = tick()
        end)()
    else
        self.fadeInAndOutHalfDuration = 2.5
        self.fadeInAndOutBalance = 0.05
        self.tweenInAlphaStart = tick()
    end
end

return u122