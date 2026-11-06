-- Script path: game:GetService("Players").TheKiller150306Alt.PlayerScripts.Client.Controllers.ControlGlyphs
-- Decompile time: 5.06 ms

local GamepadEnabled, v1
local GuiService = game:GetService("GuiService")
local UserInputService = game:GetService("UserInputService")
local u10 = {}
local u11 = {
    [Enum.UserInputType.Gamepad1] = true,
    [Enum.UserInputType.Gamepad2] = true,
    [Enum.UserInputType.Gamepad3] = true,
    [Enum.UserInputType.Gamepad4] = true,
    [Enum.UserInputType.Gamepad5] = true,
    [Enum.UserInputType.Gamepad6] = true,
    [Enum.UserInputType.Gamepad7] = true,
    [Enum.UserInputType.Gamepad8] = true,
}
local u28 = {
    [Enum.UserInputType.Keyboard] = true,
    [Enum.UserInputType.MouseButton1] = true,
    [Enum.UserInputType.MouseButton2] = true,
    [Enum.UserInputType.MouseButton3] = true,
    [Enum.UserInputType.MouseMovement] = true,
    [Enum.UserInputType.MouseWheel] = true,
    [Enum.UserInputType.Touch] = true,
}

local function firstGuess() -- Line: 47; upvalues: UserInputService (val), u11 (val), u28 (val), GuiService (val)
    local LastInputType = UserInputService:GetLastInputType()

    if u11[LastInputType] then
        return true
    end

    if u28[LastInputType] then
        return false
    end

    return GuiService:IsTenFootInterface()
        or UserInputService.GamepadEnabled
            and not UserInputService.KeyboardEnabled and not UserInputService.TouchEnabled
end

local LastInputType = UserInputService:GetLastInputType()

if u11[LastInputType] then
    GamepadEnabled = true
elseif not u28[LastInputType] then
    GamepadEnabled = GuiService:IsTenFootInterface()

    if not GamepadEnabled then
        GamepadEnabled = UserInputService.GamepadEnabled

        if GamepadEnabled then
            GamepadEnabled = not UserInputService.KeyboardEnabled

            if GamepadEnabled then
                GamepadEnabled = not UserInputService.TouchEnabled
            end
        end
    end
else
    GamepadEnabled = false
end

local u60 = {}
UserInputService.LastInputTypeChanged:Connect(function(a1)
    -- Line: 66
    -- upvalues: u11 (val), u28 (val), GamepadEnabled (ref), u60 (val)
    local v1

    if not u11[a1] and not u28[a1] then
        return
    end

    if u11[a1] == true == GamepadEnabled then
        return
    end

    GamepadEnabled = v1

    for i, j in u60 do
        task.spawn(j, v1)
    end
end)

function u10.usingGamepad() -- Line: 81; upvalues: GamepadEnabled (ref)
    return GamepadEnabled
end

function u10.onChanged(a1) -- Line: 86; upvalues: u60 (val); types: a1: function
    table.insert(u60, a1)
end

function u10.image(a1) -- Line: 91; upvalues: UserInputService (val)
    local success, err = pcall(function() -- Line: 92; upvalues: UserInputService (upval), a1 (val)
        return UserInputService:GetImageForKeyCode(a1)
    end)

    if success and type(err) == "string" then
        return err
    end

    return ""
end

function u10.bulkHeld() -- Line: 101; upvalues: UserInputService (val)
    return UserInputService:IsKeyDown(Enum.KeyCode.LeftShift)
        or UserInputService:IsKeyDown(Enum.KeyCode.RightShift)
            or UserInputService:IsGamepadButtonDown(Enum.UserInputType.Gamepad1, Enum.KeyCode.ButtonY)
end

function u10.name(a1) -- Line: 109; upvalues: UserInputService (val)
    local success, err = pcall(function() -- Line: 110; upvalues: UserInputService (upval), a1 (val)
        return UserInputService:GetStringForKeyCode(a1)
    end)
    return (string.gsub(if not success then a1.Name else if type(err) ~= "string" then a1.Name else if err == "" then a1.Name else err, "^Button", ""))
end

function u10.say(a1) -- Line: 118; upvalues: u10 (val); types: a1: string
    return (string.gsub(
        a1,
        "{(%w+)}",
        function(a1) -- Line: 120; upvalues: u10 (upval); types: a1: string
            local success, err = pcall(function() -- Line: 121; upvalues: a1 (val)
                return Enum.KeyCode[("Button%*"):format(a1)]
            end)

            if success and err then
                return (u10.name(err))
            end

            return nil
        end
    ))
end

function u10.icon(a1, a2) -- Line: 130; upvalues: u10 (val); types: a2: number
    local ImageLabel = Instance.new("ImageLabel")
    ImageLabel.Name = "Glyph"
    ImageLabel.BackgroundTransparency = 1
    ImageLabel.Size = UDim2.fromOffset(a2, a2)
    ImageLabel.Image = u10.image(a1)
    ImageLabel.ScaleType = Enum.ScaleType.Fit

    return ImageLabel
end

function u10.row(a1, a2, a3) -- Line: 145; upvalues: u10 (val); types: a1: userdata, a2: table, a3: userdata
    local TextLabel, text, v1
    local GlyphRow = a1:FindFirstChild("GlyphRow")

    if GlyphRow then
        GlyphRow:Destroy()
    end

    local Frame = Instance.new("Frame")
    Frame.Name = "GlyphRow"
    Frame.BackgroundTransparency = 1
    Frame.Size = UDim2.fromScale(0, 1)
    Frame.AutomaticSize = Enum.AutomaticSize.X
    local UIListLayout = Instance.new("UIListLayout")
    UIListLayout.FillDirection = Enum.FillDirection.Horizontal
    UIListLayout.VerticalAlignment = Enum.VerticalAlignment.Center
    UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
    UIListLayout.Padding = UDim.new(0, 6)
    UIListLayout.Parent = Frame
    local v2 = a3.TextSize + 8
    local v3 = nil
    local v4 = nil
    local v5, v6 = a1, a2

    for i, j in a2, v3, v4 do
        v1 = u10.icon(j.key, v2)
        v1.LayoutOrder = i * 2 - 1
        v1.Parent = Frame
        TextLabel = Instance.new("TextLabel")
        TextLabel.BackgroundTransparency = 1
        TextLabel.Size = UDim2.fromScale(0, 1)
        TextLabel.AutomaticSize = Enum.AutomaticSize.X
        text = if not (i < #v6) then j.text else j.text .. "   "
        TextLabel.Text = text
        TextLabel.TextColor3 = v7.TextColor3
        TextLabel.TextSize = v7.TextSize
        TextLabel.FontFace = v7.FontFace
        TextLabel.TextStrokeTransparency = v7.TextStrokeTransparency
        TextLabel.TextStrokeColor3 = v7.TextStrokeColor3
        TextLabel.LayoutOrder = i * 2
        TextLabel.Parent = Frame
    end

    Frame.Parent = v5

    return Frame
end

function u10.clear(a1) -- Line: 184; types: a1: userdata
    local GlyphRow = a1:FindFirstChild("GlyphRow")

    if GlyphRow then
        GlyphRow:Destroy()
    end
end

return u10