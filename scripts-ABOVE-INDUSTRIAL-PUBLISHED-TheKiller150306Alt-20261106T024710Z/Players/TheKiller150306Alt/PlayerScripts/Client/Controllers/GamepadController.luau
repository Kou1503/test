-- Script path: game:GetService("Players").TheKiller150306Alt.PlayerScripts.Client.Controllers.GamepadController
-- Decompile time: 10.86 ms

local GamepadService = game:GetService("GamepadService")
local GuiService = game:GetService("GuiService")
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local Shared = (game:GetService("ReplicatedStorage")):WaitForChild("Shared")
local Config = require(Shared.Config)
local u43 = require(script.Parent.Parent.Ui)
local Aim = require(script.Parent.Aim)
local BuildController = require(script.Parent.BuildController)
local ControlGlyphs = require(script.Parent.ControlGlyphs)
local MenuBarController = require(script.Parent.MenuBarController)
local SettingsController = require(script.Parent.SettingsController)
local v1 = {}
local LocalPlayer = Players.LocalPlayer
local u71 = nil
local u72 = nil

local function touchDot() -- Line: 54; upvalues: Aim (val), ControlGlyphs (val), SettingsController (val)
    return Aim.isTouch()
        and not ControlGlyphs.usingGamepad()
            and SettingsController.get("TouchCrosshair") ~= "Off"
end

local function tapFade() -- Line: 62; upvalues: Config (val), Aim (val)
    local TapDot = Config.Touch.TapDot
    local v1 = Aim.sinceTap()

    if TapDot.Seconds <= v1 then
        return 1
    end

    return (math.clamp((v1 - (TapDot.Seconds - TapDot.FadeSeconds)) / TapDot.FadeSeconds, 0, 1))
end

local function touchDotShown()
    -- Line: 75
    -- upvalues: Aim (val), ControlGlyphs (val), SettingsController (val), Config (val)
    local v1 = Aim.isTouch()
        and not ControlGlyphs.usingGamepad()
            and SettingsController.get("TouchCrosshair") ~= "Off"

    if v1 then
        v1 = Aim.isCentred()

        if not v1 then
            local TapDot = Config.Touch.TapDot
            local v2 = Aim.sinceTap()
            v1 = (if not (TapDot.Seconds <= v2) then
                math.clamp((v2 - (TapDot.Seconds - TapDot.FadeSeconds)) / TapDot.FadeSeconds, 0, 1)
            else
                1)
                < 1
        end
    end

    return v1
end

local function virtualCursorOn() -- Line: 80; upvalues: GamepadService (val)
    local u0 = false
    pcall(function() -- Line: 82; upvalues: u0 (ref), GamepadService (upval)
        u0 = GamepadService.GamepadCursorEnabled
    end)

    return u0
end

local function refresh()
    -- Line: 88
    -- upvalues: BuildController (val), ControlGlyphs (val), Aim (val), GamepadService (val), u71 (ref)
    -- upvalues: SettingsController (val), Config (val)
    local v1 = BuildController.isUiOpen()
    local v2 = ControlGlyphs.usingGamepad()

    if v2 then
        v2 = not Aim.isVR()

        if v2 then
            local u10 = false
            pcall(function() -- Line: 82; upvalues: u10 (ref), GamepadService (upval)
                u10 = GamepadService.GamepadCursorEnabled
            end)

            v2 = not u10
        end
    end

    local v3 = u71
    local v4 = not v1

    if v4 then
        v4 = v2

        if not v4 then
            v4 = Aim.isTouch()
                and not ControlGlyphs.usingGamepad()
                    and SettingsController.get("TouchCrosshair") ~= "Off"

            if v4 then
                v4 = Aim.isCentred()

                if not v4 then
                    local TapDot = Config.Touch.TapDot
                    local v5 = Aim.sinceTap()
                    v4 = (if not (TapDot.Seconds <= v5) then
                        math.clamp((v5 - (TapDot.Seconds - TapDot.FadeSeconds)) / TapDot.FadeSeconds, 0, 1)
                    else
                        1)
                        < 1
                end
            end
        end
    end

    v3.Visible = v4
end

local u78 = false

local function robloxIcon(a1) -- Line: 100; upvalues: UserInputService (val), u78 (ref); types: a1: boolean
    if not a1 then
        if u78 then
            u78 = false
            UserInputService.MouseIconEnabled = true
        end

        return
    end

    if not UserInputService.MouseIconEnabled then
        return
    end

    UserInputService.MouseIconEnabled = false
    u78 = true
end

local function cursor(a1) -- Line: 112; upvalues: Aim (val), GamepadService (val); types: a1: boolean
    if a1 and Aim.isVR() then
        return
    end

    pcall(function() -- Line: 116; upvalues: a1 (val), GamepadService (upval)
        if a1 then
            GamepadService:EnableGamepadCursor(nil)
            return
        end

        if GamepadService.GamepadCursorEnabled then
            GamepadService:DisableGamepadCursor()
        end
    end)
end

function v1.start()
    -- Line: 125
    -- upvalues: LocalPlayer (val), u71 (ref), u43 (val), u72 (ref), BuildController (val), MenuBarController (val)
    -- upvalues: ControlGlyphs (val), Aim (val), GamepadService (val), SettingsController (val), Config (val)
    -- upvalues: refresh (val), UserInputService (val), RunService (val), GuiService (val), u78 (ref)
    local ScreenGui = Instance.new("ScreenGui")
    ScreenGui.Name = "AboveCrosshair"
    ScreenGui.ResetOnSpawn = false
    ScreenGui.IgnoreGuiInset = true
    ScreenGui.DisplayOrder = 5
    ScreenGui.Parent = LocalPlayer:WaitForChild("PlayerGui")
    u71 = Instance.new("Frame")
    u71.Name = "Dot"
    u71.AnchorPoint = Vector2.new(0.5, 0.5)
    u71.Position = UDim2.fromScale(0.5, 0.5)
    u71.Size = UDim2.fromOffset(6, 6)
    u71.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    u71.BackgroundTransparency = 0.15
    u71.BorderSizePixel = 0
    u71.Visible = false
    u71.Parent = ScreenGui

    u43.corner(u71, 6)

    u72 = u43.stroke(u71, Color3.fromRGB(20, 22, 28), 1)
    BuildController.onUiOpenChanged(function(a1)
        -- Line: 147
        -- upvalues: MenuBarController (upval), BuildController (upval), ControlGlyphs (upval), Aim (upval)
        -- upvalues: GamepadService (upval), u71 (upval), SettingsController (upval), Config (upval)
        if a1 then
            MenuBarController.unfocus()
        end

        local v1 = BuildController.isUiOpen()
        local v2 = ControlGlyphs.usingGamepad()

        if v2 then
            v2 = not Aim.isVR()

            if v2 then
                local u14 = false
                pcall(function() -- Line: 82; upvalues: u14 (ref), GamepadService (upval)
                    u14 = GamepadService.GamepadCursorEnabled
                end)

                v2 = not u14
            end
        end

        local v3 = u71
        local v4 = not v1

        if v4 then
            v4 = v2

            if not v4 then
                v4 = Aim.isTouch()
                    and not ControlGlyphs.usingGamepad()
                        and SettingsController.get("TouchCrosshair") ~= "Off"

                if v4 then
                    v4 = Aim.isCentred()

                    if not v4 then
                        local TapDot = Config.Touch.TapDot
                        local v5 = Aim.sinceTap()
                        v4 = (if not (TapDot.Seconds <= v5) then
                            math.clamp((v5 - (TapDot.Seconds - TapDot.FadeSeconds)) / TapDot.FadeSeconds, 0, 1)
                        else
                            1)
                            < 1
                    end
                end
            end
        end

        v3.Visible = v4

        if ControlGlyphs.usingGamepad() then
            if a1 and Aim.isVR() then
                return
            end

            pcall(function() -- Line: 116; upvalues: a1 (val), GamepadService (upval)
                if a1 then
                    GamepadService:EnableGamepadCursor(nil)
                    return
                end

                if GamepadService.GamepadCursorEnabled then
                    GamepadService:DisableGamepadCursor()
                end
            end)
        end
    end)

    ;((game:GetService("VRService")):GetPropertyChangedSignal("VREnabled")):Connect(refresh)

    ControlGlyphs.onChanged(function(a1)
        -- Line: 159
        -- upvalues: BuildController (upval), ControlGlyphs (upval), Aim (upval), GamepadService (upval), u71 (upval)
        -- upvalues: SettingsController (upval), Config (upval)
        local v1 = BuildController.isUiOpen()
        local v2 = ControlGlyphs.usingGamepad()

        if v2 then
            v2 = not Aim.isVR()

            if v2 then
                local u11 = false
                pcall(function() -- Line: 82; upvalues: u11 (ref), GamepadService (upval)
                    u11 = GamepadService.GamepadCursorEnabled
                end)

                v2 = not u11
            end
        end

        local v3 = u71
        local v4 = not v1

        if v4 then
            v4 = v2

            if not v4 then
                v4 = Aim.isTouch()
                    and not ControlGlyphs.usingGamepad()
                        and SettingsController.get("TouchCrosshair") ~= "Off"

                if v4 then
                    v4 = Aim.isCentred()

                    if not v4 then
                        local TapDot = Config.Touch.TapDot
                        local v5 = Aim.sinceTap()
                        v4 = (if not (TapDot.Seconds <= v5) then
                            math.clamp((v5 - (TapDot.Seconds - TapDot.FadeSeconds)) / TapDot.FadeSeconds, 0, 1)
                        else
                            1)
                            < 1
                    end
                end
            end
        end

        v3.Visible = v4
        local u73 = a1

        if u73 then
            u73 = BuildController.isUiOpen()
        end

        if u73 and Aim.isVR() then
            return
        end

        pcall(function() -- Line: 116; upvalues: u73 (val), GamepadService (upval)
            if u73 then
                GamepadService:EnableGamepadCursor(nil)
                return
            end

            if GamepadService.GamepadCursorEnabled then
                GamepadService:DisableGamepadCursor()
            end
        end)
    end)

    UserInputService.InputBegan:Connect(function(a1)
        -- Line: 167
        -- upvalues: BuildController (upval), MenuBarController (upval), GamepadService (upval), Aim (upval)
        if a1.KeyCode ~= Enum.KeyCode.ButtonSelect then
            return
        end

        if not BuildController.isUiOpen() then
            if MenuBarController.isFocused() then
                MenuBarController.unfocus()
                return
            end

            local u12 = false
            pcall(function() -- Line: 116; upvalues: u12 (val), GamepadService (upval)
                if u12 then
                    GamepadService:EnableGamepadCursor(nil)
                    return
                end

                if GamepadService.GamepadCursorEnabled then
                    GamepadService:DisableGamepadCursor()
                end
            end)

            MenuBarController.focus()

            return
        end

        local u19 = false
        pcall(function() -- Line: 181; upvalues: u19 (ref), GamepadService (upval)
            u19 = GamepadService.GamepadCursorEnabled
        end)

        local u23 = not u19

        if not u23 or not Aim.isVR() then
            pcall(function() -- Line: 116; upvalues: u23 (val), GamepadService (upval)
                if u23 then
                    GamepadService:EnableGamepadCursor(nil)
                    return
                end

                if GamepadService.GamepadCursorEnabled then
                    GamepadService:DisableGamepadCursor()
                end
            end)
        end
    end)

    SettingsController.onChanged(function(a1)
        -- Line: 186
        -- upvalues: BuildController (upval), ControlGlyphs (upval), Aim (upval), GamepadService (upval), u71 (upval)
        -- upvalues: SettingsController (upval), Config (upval)
        -- types: a1: string
        if a1 == "TouchCrosshair" then
            local v1 = BuildController.isUiOpen()
            local v2 = ControlGlyphs.usingGamepad()

            if v2 then
                v2 = not Aim.isVR()

                if v2 then
                    local u11 = false
                    pcall(function() -- Line: 82; upvalues: u11 (ref), GamepadService (upval)
                        u11 = GamepadService.GamepadCursorEnabled
                    end)

                    v2 = not u11
                end
            end

            local v3 = u71
            local v4 = not v1

            if v4 then
                v4 = v2

                if not v4 then
                    v4 = Aim.isTouch()
                        and not ControlGlyphs.usingGamepad()
                            and SettingsController.get("TouchCrosshair") ~= "Off"

                    if v4 then
                        v4 = Aim.isCentred()

                        if not v4 then
                            local TapDot = Config.Touch.TapDot
                            local v5 = Aim.sinceTap()
                            v4 = (if not (TapDot.Seconds <= v5) then
                                math.clamp((v5 - (TapDot.Seconds - TapDot.FadeSeconds)) / TapDot.FadeSeconds, 0, 1)
                            else
                                1)
                                < 1
                        end
                    end
                end
            end

            v3.Visible = v4
        end
    end)

    RunService.RenderStepped:Connect(function()
        -- Line: 193
        -- upvalues: Aim (upval), ControlGlyphs (upval), u71 (upval), GuiService (upval), u43 (upval)
        -- upvalues: GamepadService (upval), BuildController (upval), SettingsController (upval), Config (upval)
        -- upvalues: UserInputService (upval), u78 (upval), u72 (upval)
        local AbsolutePosition, GuiInset, v1, v2
        local v3 = Aim.touchPoint()
        local CurrentCamera = workspace.CurrentCamera

        if not v3 or not CurrentCamera or ControlGlyphs.usingGamepad() then
            if CurrentCamera then
                GuiInset = GuiService:GetGuiInset()
                v1 = u43.layerScale(u71)
                AbsolutePosition = u71.Parent.AbsolutePosition
                v2 = CurrentCamera.ViewportSize / 2 - GuiInset - AbsolutePosition
                u71.Position = UDim2.fromOffset(v2.X / v1, v2.Y / v1)
                v2 = if not Aim.isCentred() then 6 else 9
                u71.Size = UDim2.fromOffset(v2, v2)
            end
        elseif not Aim.isCentred() then
            local ViewportSize = CurrentCamera.ViewportSize

            if 0 < ViewportSize.X and 0 < ViewportSize.Y then
                u71.Position = UDim2.fromScale(v3.X / ViewportSize.X, v3.Y / ViewportSize.Y)
                u71.Size = UDim2.fromOffset(9, 9)
            end
        elseif CurrentCamera then
            GuiInset = GuiService:GetGuiInset()
            v1 = u43.layerScale(u71)
            AbsolutePosition = u71.Parent.AbsolutePosition
            v2 = CurrentCamera.ViewportSize / 2 - GuiInset - AbsolutePosition
            u71.Position = UDim2.fromOffset(v2.X / v1, v2.Y / v1)
            v2 = if not Aim.isCentred() then 6 else 9
            u71.Size = UDim2.fromOffset(v2, v2)
        end

        local v4 = ControlGlyphs.usingGamepad()

        if v4 then
            v4 = not Aim.isVR()

            if v4 then
                local u71_2 = false
                pcall(function() -- Line: 82; upvalues: u71_2 (ref), GamepadService (upval)
                    u71_2 = GamepadService.GamepadCursorEnabled
                end)

                v4 = not u71_2
            end
        end

        v3 = not BuildController.isUiOpen()

        if v3 then
            v3 = v4

            if not v3 then
                v3 = Aim.isTouch()
                    and not ControlGlyphs.usingGamepad()
                        and SettingsController.get("TouchCrosshair") ~= "Off"

                if v3 then
                    v3 = Aim.isCentred()

                    if not v3 then
                        local TapDot = Config.Touch.TapDot
                        local v5 = Aim.sinceTap()
                        v3 = (if not (TapDot.Seconds <= v5) then
                            math.clamp((v5 - (TapDot.Seconds - TapDot.FadeSeconds)) / TapDot.FadeSeconds, 0, 1)
                        else
                            1)
                            < 1
                    end
                end
            end
        end

        if u71.Visible ~= v3 then
            u71.Visible = v3
        end

        if not v3 or not v4 then
            if u78 then
                u78 = false
                UserInputService.MouseIconEnabled = true
            end
        elseif UserInputService.MouseIconEnabled then
            UserInputService.MouseIconEnabled = false
            u78 = true
        end

        if not v3 or ControlGlyphs.usingGamepad() or Aim.isCentred() then
            v4 = 0
        else
            local TapDot_2 = Config.Touch.TapDot
            v1 = Aim.sinceTap()
            v4 = if not (TapDot_2.Seconds <= v1) then
                math.clamp((v1 - (TapDot_2.Seconds - TapDot_2.FadeSeconds)) / TapDot_2.FadeSeconds, 0, 1)
            else
                1
        end

        u71.BackgroundTransparency = v4 * 0.85 + 0.15
        u72.Transparency = v4
    end)

    local v1 = BuildController.isUiOpen()
    local v2 = ControlGlyphs.usingGamepad()

    if v2 then
        v2 = not Aim.isVR()

        if v2 then
            local u107 = false
            pcall(function() -- Line: 82; upvalues: u107 (ref), GamepadService (upval)
                u107 = GamepadService.GamepadCursorEnabled
            end)

            v2 = not u107
        end
    end

    local v3 = u71
    local v4 = not v1

    if v4 then
        v4 = v2

        if not v4 then
            v4 = Aim.isTouch()
                and not ControlGlyphs.usingGamepad()
                    and SettingsController.get("TouchCrosshair") ~= "Off"

            if v4 then
                v4 = Aim.isCentred()

                if not v4 then
                    local TapDot = Config.Touch.TapDot
                    local v5 = Aim.sinceTap()
                    v4 = (if not (TapDot.Seconds <= v5) then
                        math.clamp((v5 - (TapDot.Seconds - TapDot.FadeSeconds)) / TapDot.FadeSeconds, 0, 1)
                    else
                        1)
                        < 1
                end
            end
        end
    end

    v3.Visible = v4
end

return v1