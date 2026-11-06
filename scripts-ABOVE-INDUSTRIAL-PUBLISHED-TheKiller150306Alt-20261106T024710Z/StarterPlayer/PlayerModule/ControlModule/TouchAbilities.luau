-- Script path: game:GetService("StarterPlayer").PlayerModule.ControlModule.TouchAbilities
-- Decompile time: 7.35 ms

local Players = game:GetService("Players")
local CommonUtils = require(script.Parent.Parent:WaitForChild("CommonUtils"))
local u24 = require(script.Parent:WaitForChild("AvatarAbilitiesInterface")).get(Players.LocalPlayer)
local u33 = require(script.Parent:WaitForChild("InputSlots"))
local FlagUtil = CommonUtils.get("FlagUtil")
local u40 = FlagUtil.getUserFlag("UserAbilitiesUserInterfaceA")
local UserAbilitiesUserInterfaceC = FlagUtil.getUserFlag("UserAbilitiesUserInterfaceC")
local u44 = {
    {small = {72, 60, 60}, large = {92, 112, 112}},
    {small = {44, 132, 132}, large = {56, 200, 200}},
    {small = {44, 132, 16}, large = {56, 200, 60}},
    {small = {44, 16, 132}, large = {56, 60, 200}},
    {small = {44, 156, 74}, large = {56, 228, 130}},
    {small = {44, 74, 156}, large = {56, 130, 228}},
    {small = {44, 16, 16}, large = {56, 60, 60}},
}
local u108 = {28, 44}
local u111 = {36, 56}
local u114 = {16, 12}
local u117 = {16, 12}

local function IsPortrait() -- Line: 52; upvalues: Players (val)
    local PlayerGui = Players.LocalPlayer:FindFirstChildOfClass("PlayerGui")

    if not PlayerGui then
        return false
    end

    return PlayerGui.CurrentScreenOrientation == Enum.ScreenOrientation.Portrait
end

local u121 = {}
u121.__index = u121

function u121.new(a1) -- Line: 70; upvalues: u121 (val)
    local v1 = setmetatable(
        {},
        u121
    )
    v1.parentUIFrame = a1
    v1.managedButtons = {}
    v1.created = false
    v1.enabled = false
    v1.enabledChangedEvent = Instance.new("BindableEvent")

    return v1
end

function u121.Enable(a1, a2) -- Line: 83
    if a1.enabled == a2 then
        return
    end

    a1.enabled = a2

    if a2 and not a1.created then
        a1:Create()

        a1.created = true
    end

    a1.enabledChangedEvent:Fire()
end

function u121:CreateAbilityButton(a2, a3, a4, a5, a6) -- Line: 95; upvalues: u24 (val)
    local ButtonAssetId = "rbxassetid://136780077406114"
    local ButtonPressedAssetId = "rbxassetid://76895455502876"
    local ButtonInvalidAssetId = nil
    local u9 = false

    if a3.ButtonAssetId then
        ButtonAssetId = a3.ButtonAssetId
    end

    if a3.ButtonPressedAssetId then
        ButtonPressedAssetId = a3.ButtonPressedAssetId
    end

    if a3.ButtonInvalidAssetId then
        ButtonInvalidAssetId = a3.ButtonInvalidAssetId
    end

    local ImageButton = Instance.new("ImageButton")
    ImageButton.Name = a2 .. "Button"
    ImageButton.Visible = false
    ImageButton.BackgroundTransparency = 1
    ImageButton.Image = ButtonAssetId
    ImageButton.Parent = self.parentUIFrame

    for i, j in a4:GetChildren() do
        if string.find(j.Name, "Touch") and j:IsA("InputBinding") then
            j.UIButton = ImageButton
            break
        end
    end

    local function ResizeButton() -- Line: 124; upvalues: self (val), a5 (val), ImageButton (val), a6 (val)
        local small = (math.min(self.parentUIFrame.AbsoluteSize.x, self.parentUIFrame.AbsoluteSize.y))
            <= 500
            and a5.small
            or a5.large
        local v1 = small[1]
        local v2 = small[2]
        local v3 = small[3]
        local v4 = -v2 - v1
        ImageButton.Size = UDim2.new(0, v1, 0, v1)

        if a6 then
            ImageButton.Position = UDim2.new(1, v4, 0, v3)
            return
        end

        ImageButton.Position = UDim2.new(1, v4, 1, -v3 - v1)
    end

    ResizeButton()

    local u76 = {}
    table.insert(u76, ((self.parentUIFrame:GetPropertyChangedSignal("AbsoluteSize")):Connect(ResizeButton)))

    local function UpdateButtonState()
        -- Line: 151
        -- upvalues: u24 (upval), a2 (val), ImageButton (val), self (val), a4 (val), u9 (ref)
        -- upvalues: ButtonPressedAssetId (ref), ButtonAssetId (ref), ButtonInvalidAssetId (ref)
        local AbilityValid = u24:GetAbilityValid(a2)
        local AbilityActive = u24:GetAbilityActive(a2)
        local enabled = self.enabled and a4.Enabled
        ImageButton.Visible = enabled

        if not ImageButton.Visible then
            return
        end

        if AbilityActive then
            ImageButton.Image = ButtonPressedAssetId
            ImageButton.ImageTransparency = 0

            return
        end

        if u9 and AbilityValid then
            ImageButton.Image = ButtonPressedAssetId
            ImageButton.ImageTransparency = 0

            return
        end

        if AbilityValid then
            ImageButton.Image = ButtonAssetId
            ImageButton.ImageTransparency = 0

            return
        end

        if ButtonInvalidAssetId then
            ImageButton.Image = ButtonInvalidAssetId
            ImageButton.ImageTransparency = 0

            return
        end

        ImageButton.Image = ButtonAssetId
        ImageButton.ImageTransparency = 0.6
    end

    UpdateButtonState()

    ImageButton.MouseButton1Down:Connect(function() -- Line: 176; upvalues: u9 (ref), UpdateButtonState (val)
        u9 = true
        UpdateButtonState()
    end)

    ImageButton.MouseButton1Up:Connect(function() -- Line: 181; upvalues: u9 (ref), UpdateButtonState (val)
        u9 = false
        UpdateButtonState()
    end)

    ImageButton.MouseLeave:Connect(function() -- Line: 186; upvalues: u9 (ref), UpdateButtonState (val)
        u9 = false
        UpdateButtonState()
    end)

    table.insert(u76, ((u24:GetAbilityActiveChangedSignal(a2)):Connect(UpdateButtonState)))
    table.insert(u76, ((u24:GetAbilityValidChangedSignal(a2)):Connect(UpdateButtonState)))
    table.insert(u76, (self.enabledChangedEvent.Event:Connect(UpdateButtonState)))
    table.insert(u76, ((a4:GetPropertyChangedSignal("Enabled")):Connect(UpdateButtonState)))

    ImageButton.Destroying:Connect(function() -- Line: 196; upvalues: u76 (val)
        for i, j in u76 do
            j:Disconnect()
        end

        table.clear(u76)
    end)

    return ImageButton
end

function u121:CreateOverflowScrollButton(a2)
    -- Line: 206
    -- upvalues: Players (val), u108 (val), u111 (val), u114 (val), u117 (val), u33 (val)
    local ImageButton = Instance.new("ImageButton")
    ImageButton.Name = "ScrollButton"
    ImageButton.BackgroundTransparency = 1
    ImageButton.Image = "rbxassetid://120193229129639"
    ImageButton.PressedImage = "rbxassetid://122643389561468"
    ImageButton.Parent = self.parentUIFrame

    local function ResizeButton()
        -- Line: 217
        -- upvalues: self (val), Players (upval), u108 (upval), u111 (upval), u114 (upval), u117 (upval)
        -- upvalues: ImageButton (val), a2 (val)
        local v1
        local v2 = math.min(self.parentUIFrame.AbsoluteSize.x, self.parentUIFrame.AbsoluteSize.y)
        local PlayerGui = Players.LocalPlayer:FindFirstChildOfClass("PlayerGui")
        local v3 = if PlayerGui then
            PlayerGui.CurrentScreenOrientation == Enum.ScreenOrientation.Portrait
        else
            false
        v2 = v2 <= 500 and u108 or u111
        local v4 = v1 and u114 or u117
        local v5 = if not v1 then 10 else 8
        local v6 = if not v1 then 56 else 44
        ImageButton.Size = UDim2.new(0, v2[1], 0, v2[2])

        if a2 then
            if v3 then
                ImageButton.Position = UDim2.new(1, -v4[1] - v2[2] + 0.5 * (v2[2] - v2[1]), 0, v4[2] + v2[1] + 4 * v5 + 3 * v6 - 0.5 * (v2[2] - v2[1]))
                ImageButton.Rotation = 270

                return
            end

            ImageButton.Position = UDim2.new(1, -v4[1] - 2 * v2[1] - 4 * v5 - 3 * v6, 0, v4[2])
            ImageButton.Rotation = 0

            return
        end

        ImageButton.Position = UDim2.new(1, -v4[1] - v2[1], 0, v4[2])

        if v3 then
            ImageButton.Position = UDim2.new(1, -v4[1] - v2[2] + 0.5 * (v2[2] - v2[1]), 0, v4[2] - 0.5 * (v2[2] - v2[1]))
            ImageButton.Rotation = 90

            return
        end

        ImageButton.Position = UDim2.new(1, -v4[1] - v2[1], 0, v4[2])
        ImageButton.Rotation = 180
    end

    ResizeButton()

    local u13 = {}
    table.insert(u13, ((self.parentUIFrame:GetPropertyChangedSignal("AbsoluteSize")):Connect(ResizeButton)))

    ImageButton.Activated:Connect(function() -- Line: 253; upvalues: a2 (val), u33 (upval)
        if a2 then
            u33.setOverflowScrollIndex(u33.getOverflowScrollIndex() + 1)
            return
        end

        u33.setOverflowScrollIndex(u33.getOverflowScrollIndex() - 1)
    end)

    ImageButton.Destroying:Connect(function() -- Line: 261; upvalues: u13 (val)
        for i, j in u13 do
            j:Disconnect()
        end

        table.clear(u13)
    end)

    return ImageButton
end

function u121:Create()
    -- Line: 271
    -- upvalues: u24 (val), u33 (val), u44 (val), u40 (val), UserAbilitiesUserInterfaceC (val), u108 (val), u111 (val)
    -- upvalues: Players (val), u114 (val), u117 (val)
    if not self.parentUIFrame then
        return
    end

    local function CreateButtons()
        -- Line: 276
        -- upvalues: self (val), u24 (upval), u33 (upval), u44 (upval), u40 (upval), UserAbilitiesUserInterfaceC (upval)
        -- upvalues: u108 (upval), u111 (upval), Players (upval), u114 (upval), u117 (upval)
        local v1 = nil

        for i, j in self.managedButtons, nil, v1 do
            j:Destroy()
        end

        self.managedButtons = {}

        if u24:isEnabled() then
            local AbilityConfig_2, managedButtons_5, v2, v3

            for k, v in pairs((u33.GetSlotMap())) do
                v3 = u33.GetActionInSlot(k)

                if v and v3 and k <= #u44 then
                    if u40 or k == 1 then
                        AbilityConfig_2 = u24:GetAbilityConfig(v)
                        managedButtons_5 = self.managedButtons
                        v2 = u44[k]

                        table.insert(managedButtons_5, (self:CreateAbilityButton(v, AbilityConfig_2, v3, v2, false)))
                    end
                end
            end

            if u40 and UserAbilitiesUserInterfaceC then
                local AbilityConfig, PlayerGui
                local v4 = u33.GetAbilitiesInOverflow()
                local v5 = 0
                v1 = 0
                local v6 = #v4

                if u33.GetNumOverflowSlots() < v6 then
                    if 0 < u33.getOverflowScrollIndex() then
                        table.insert(self.managedButtons, (self:CreateOverflowScrollButton(false)))
                    end

                    if u33.getOverflowScrollIndex() < #v4 - u33.GetNumOverflowSlots() then
                        table.insert(self.managedButtons, (self:CreateOverflowScrollButton(true)))
                    end

                    v5 = u108[1] + 8
                    v1 = u111[1] + 10
                end

                local v7 = #v4

                for k2 = 1, (math.min(v7, (u33.GetNumOverflowSlots()))) do
                    v3 = v4[k2 + u33.getOverflowScrollIndex()]
                    v7 = u33.GetOverflowAction(k2)

                    if v3 and v7 then
                        AbilityConfig = u24:GetAbilityConfig(v3)
                        PlayerGui = Players.LocalPlayer:FindFirstChildOfClass("PlayerGui")

                        table.insert(
                            self.managedButtons,
                            (self:CreateAbilityButton(
                                v3,
                                AbilityConfig,
                                v7,
                                if not (if PlayerGui then
                                    PlayerGui.CurrentScreenOrientation
                                        == Enum.ScreenOrientation.Portrait
                                else
                                    false) then
                                    {
                                        small = {44, u114[1] + v5 + (k2 - 1) * 52, u114[2]},
                                        large = {56, u117[1] + v1 + (k2 - 1) * 66, u117[2]},
                                    }
                                else
                                    {
                                        small = {44, u114[1], u114[2] + v5 + (k2 - 1) * 52},
                                        large = {56, u117[1], u117[2] + v1 + (k2 - 1) * 66},
                                    },
                                true
                            ))
                        )
                    end
                end
            end
        end
    end

    CreateButtons()
    u33.GetSlotMapChangedSignal():Connect(CreateButtons)
    u24:GetEnabledChangedSignal():Connect(CreateButtons)
    u33.getScrollIndexChangedEvent():Connect(CreateButtons)

    local PlayerGui = Players.LocalPlayer:WaitForChild("PlayerGui", 5)

    if PlayerGui then
        (PlayerGui:GetPropertyChangedSignal("CurrentScreenOrientation")):Connect(CreateButtons)
    end
end

return u121