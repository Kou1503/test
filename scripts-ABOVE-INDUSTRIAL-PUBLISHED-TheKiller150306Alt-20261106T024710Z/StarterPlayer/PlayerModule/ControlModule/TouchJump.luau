-- Script path: game:GetService("StarterPlayer").PlayerModule.ControlModule.TouchJump
-- Decompile time: 3.87 ms

local CommonUtils = require(script.Parent.Parent:WaitForChild("CommonUtils"))
local ConnectionUtil = CommonUtils.get("ConnectionUtil")
local CharacterUtil = CommonUtils.get("CharacterUtil")
local FlagUtil = CommonUtils.get("FlagUtil")
local u21 = FlagUtil.getUserFlag("UserPlayerScriptsCCLIntegrationD")
local UserPlayerScriptsRefactor1 = FlagUtil.getUserFlag("UserPlayerScriptsRefactor1")
local UserPlayerScriptsFixTouchJumpVisibility = FlagUtil.getUserFlag("UserPlayerScriptsFixTouchJumpVisibility")

game:GetService("Players")

local u42 = require(script.Parent:WaitForChild("AvatarAbilitiesInterface"))
local u43 = {
    "rbxasset://textures/ui/Input/JumpButtonRegular.png",
    "rbxasset://textures/ui/Input/JumpButtonPressed.png",
}
local ActionController = require(script.Parent:WaitForChild("ActionController"))
local u58 = setmetatable(
    {},
    ActionController
)
u58.__index = u58

function u58.new(a1)
    -- Line: 61
    -- upvalues: ActionController (val), u58 (val), UserPlayerScriptsFixTouchJumpVisibility (val), ConnectionUtil (val)
    local v1 = ActionController.new()
    local u6 = setmetatable(v1, u58)
    u6.data = a1

    ;(a1.eventBus:subscribe("ACTIONS_RELOADED")):Connect(function()
        -- Line: 65
        -- upvalues: u6 (val), UserPlayerScriptsFixTouchJumpVisibility (upval)
        u6:Create()

        if UserPlayerScriptsFixTouchJumpVisibility and u6._active then
            u6._active = false
            u6:EnableButton(true)
        end
    end)

    u6.parentUIFrame = nil
    u6.jumpButton = nil
    u6.externallyEnabled = false
    u6._active = false
    u6._connectionUtil = ConnectionUtil.new()

    return u6
end

function u58:_reset() -- Line: 83; upvalues: u21 (val), u42 (val), u43 (val)
    if self.jumpButton then
        if not u21 and u42.isEnabled() then
            self.jumpButton.Image = u43[1]
            return
        end

        self.jumpButton.ImageRectOffset = Vector2.new(1, 146)
    end
end

function u58:EnableButton(a2) -- Line: 96
    if a2 == self._active then
        return
    end

    if a2 then
        if not self.jumpButton then
            self:Create()
        end

        self.jumpButton.Visible = true
    elseif self.jumpButton then
        self.jumpButton.Visible = false
    end

    self:_reset()

    self._active = a2
end

function u58:UpdateEnabled() -- Line: 115; upvalues: CharacterUtil (val)
    local v1 = CharacterUtil.getChild("Humanoid", "Humanoid")

    if v1 and self.externallyEnabled then
        if v1.UseJumpPower and 0 < v1.JumpPower then
            if v1:GetStateEnabled(Enum.HumanoidStateType.Jumping) then
                self:EnableButton(true)
                return
            end

            self:EnableButton(false)

            return
        end

        if not v1.UseJumpPower
            and 0 < v1.JumpHeight
            and v1:GetStateEnabled(Enum.HumanoidStateType.Jumping) then
            self:EnableButton(true)
            return
        end
    end

    self:EnableButton(false)
end

function u58:_setupConfigurations() -- Line: 124; upvalues: CharacterUtil (val)
    local function update() -- Line: 125; upvalues: self (val)
        self:UpdateEnabled()
    end

    self._connectionUtil:trackConnection(
        "HUMANOID",
        (CharacterUtil.onChild(
            "Humanoid",
            "Humanoid",
            function(a1) -- Line: 130; upvalues: self (val), update (val)
                self:UpdateEnabled()
                self:_reset()
                self._connectionUtil:trackConnection("HUMANOID_JUMP_POWER", ((a1:GetPropertyChangedSignal("JumpPower")):Connect(update)))
                self._connectionUtil:trackConnection("HUMANOID_JUMP_HEIGHT", ((a1:GetPropertyChangedSignal("JumpHeight")):Connect(update)))

                self._connectionUtil:trackConnection(
                    "HUMANOID_STATE_ENABLED_CHANGED",
                    (a1.StateEnabledChanged:Connect(function(a1, a2) -- Line: 143; upvalues: self (upval)
                        if a1 == Enum.HumanoidStateType.Jumping and a2 ~= self._active then
                            self:UpdateEnabled()
                        end
                    end))
                )
            end
        ))
    )
end

function u58.Enable(a1, a2, a3) -- Line: 155; upvalues: ActionController (val)
    if a3 then
        a1.parentUIFrame = a3
    end

    if a1.externallyEnabled == a2 then
        return
    end

    a1.externallyEnabled = a2
    ActionController.Enable(a1, a2)
    a1:UpdateEnabled()

    if a2 then
        a1:_setupConfigurations()
        return
    end

    a1._connectionUtil:disconnectAll()
end

function u58:Create() -- Line: 173; upvalues: u21 (val), UserPlayerScriptsRefactor1 (val), u42 (val), u43 (val)
    if not self.parentUIFrame then
        return
    end

    if self.jumpButton then
        self.jumpButton:Destroy()

        self.jumpButton = nil
    end

    if self.absoluteSizeChangedConn then
        self.absoluteSizeChangedConn:Disconnect()

        self.absoluteSizeChangedConn = nil
    end

    if not u21 and self.avatarAbilitiesEnabledChangedConn then
        self.avatarAbilitiesEnabledChangedConn:Disconnect()

        self.avatarAbilitiesEnabledChangedConn = nil
    end

    self.jumpButton = Instance.new("ImageButton")
    self.jumpButton.Name = "JumpButton"
    self.jumpButton.Visible = false
    self.jumpButton.BackgroundTransparency = 1

    if UserPlayerScriptsRefactor1 then
        self.jumpButton.ZIndex = 10
    end

    if u21 or not u42.isEnabled() then
        self.jumpButton.Image = "rbxasset://textures/ui/Input/TouchControlsSheetV2.png"
        self.jumpButton.ImageRectOffset = Vector2.new(1, 146)
        self.jumpButton.ImageRectSize = Vector2.new(144, 144)
    else
        self.jumpButton.Image = u43[1]
    end

    local function ResizeJumpButton() -- Line: 211; upvalues: self (val), u21 (upval), u42 (upval), u43 (upval)
        local v1, v2
        local v3 = (math.min(self.parentUIFrame.AbsoluteSize.x, self.parentUIFrame.AbsoluteSize.y))
            <= 500

        if not u21 and u42.isEnabled() then
            local v4
            v1 = if not v3 then 100 else 64
            local v5 = if not v3 then 112 else 64
            v2 = -(if not v3 then 120 else 72) - v1
            v1 = -v4 - v5
            self.jumpButton.Image = u43[1]
            self.jumpButton.ImageRectOffset = Vector2.new(0, 0)
            self.jumpButton.ImageRectSize = Vector2.new(0, 0)
            self.jumpButton.Size = UDim2.new(0, v4, 0, v4)
            self.jumpButton.Position = UDim2.new(1, v2, 1, v1)

            return
        end

        v1 = if not v3 then 120 else 70
        self.jumpButton.Image = "rbxasset://textures/ui/Input/TouchControlsSheetV2.png"
        self.jumpButton.ImageRectOffset = Vector2.new(1, 146)
        self.jumpButton.ImageRectSize = Vector2.new(144, 144)
        self.jumpButton.Size = UDim2.new(0, v1, 0, v1)
        local jumpButton = self.jumpButton
        v2 = v3 and UDim2.new(1, -(v1 * 1.5 - 10), 1, -v1 - 20)
            or UDim2.new(1, -(v1 * 1.5 - 10), 1, -v1 * 1.75)
        jumpButton.Position = v2
    end

    ResizeJumpButton()

    self.absoluteSizeChangedConn = (self.parentUIFrame:GetPropertyChangedSignal("AbsoluteSize")):Connect(ResizeJumpButton)

    if not u21 then
        self.avatarAbilitiesEnabledChangedConn = u42.GetEnabledChangedSignal():Connect(ResizeJumpButton)
    end

    self.jumpButton.Parent = self.parentUIFrame

    if not self.data.controlModule.actions.JumpAction then
        return
    end

    local TouchBinding = self.data.controlModule.actions.JumpAction:WaitForChild("TouchBinding")
    TouchBinding.UIButton = self.jumpButton

    self.data.controlModule.actions.JumpAction.Pressed:Connect(function()
        -- Line: 253
        -- upvalues: self (val), u21 (upval), u42 (upval), u43 (upval)
        if not self.jumpButton then
            return
        end

        if not u21 and u42.isEnabled() then
            self.jumpButton.Image = u43[2]
            return
        end

        self.jumpButton.ImageRectOffset = Vector2.new(146, 146)
    end)

    self.data.controlModule.actions.JumpAction.Released:Connect(function()
        -- Line: 265
        -- upvalues: self (val), u21 (upval), u42 (upval), u43 (upval)
        if not self.jumpButton then
            return
        end

        if not u21 and u42.isEnabled() then
            self.jumpButton.Image = u43[1]
            return
        end

        self.jumpButton.ImageRectOffset = Vector2.new(1, 146)
    end)
end

return u58