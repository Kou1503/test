-- Script path: game:GetService("Players").TheKiller150306Alt.PlayerScripts.Client.Controllers.GuiScaleController
-- Decompile time: 2.09 ms

local Players = game:GetService("Players")
local Shared = (game:GetService("ReplicatedStorage")):WaitForChild("Shared")
local Config = require(Shared.Config)
local u23 = require(script.Parent.Parent.Ui)
local SettingsController = require(script.Parent.SettingsController)
local v1 = {}

local function current() -- Line: 25; upvalues: u23 (val), Config (val), SettingsController (val)
    if u23.TouchOnly then
        return Config.Settings.phoneGuiScaleOf(SettingsController.get("PhoneGuiScale"))
    end

    if u23.TenFoot then
        return Config.Settings.guiScaleOf(SettingsController.get("ConsoleGuiScale"))
    end

    return Config.Settings.guiScaleOf(SettingsController.get("GuiScale"))
end

local function isBackdrop(a1) -- Line: 50; types: a1: userdata
    if a1:IsA("GuiObject")
        and not (a1.Size.X.Scale < 0.95)
        and not (a1.Size.Y.Scale < 0.95) then
        local v1 = true

        if not (a1.BackgroundTransparency < 1) then
            v1 = a1:IsA("ImageLabel") or a1:IsA("ImageButton")
        end

        return v1
    end

    return false
end

local function padForTv(a1, a2)
    -- Line: 57
    -- upvalues: u23 (val), Config (val), isBackdrop (val)
    -- types: a1: userdata, a2: number
    if u23.TenFoot
        and not Config.Settings.ConsoleSafeExempt[a1.Name]
        and not a1:GetAttribute("TvFullScreen") then
        local TvSafeArea = a1:FindFirstChild("TvSafeArea")

        if not TvSafeArea then
            for i, j in a1:GetChildren() do
                if isBackdrop(j) then
                    a1:SetAttribute("TvFullScreen", true)
                    return
                end
            end

            local UIPadding = Instance.new("UIPadding")
            UIPadding.Name = "TvSafeArea"
            UIPadding.Parent = a1
            TvSafeArea = UIPadding

            a1.ChildAdded:Connect(function(a1_2) -- Line: 75; upvalues: UIPadding (val), isBackdrop (upval), a1 (val)
                task.defer(function()
                    -- Line: 76
                    -- upvalues: UIPadding (upval), isBackdrop (upval), a1_2 (val), a1 (upval)
                    if UIPadding.Parent and isBackdrop(a1_2) then
                        a1:SetAttribute("TvFullScreen", true)
                        UIPadding:Destroy()
                    end
                end)
            end)
        end

        local ConsoleSafeMargin = Config.Settings.ConsoleSafeMargin
        local v1 = ConsoleSafeMargin / a2
        local v2 = 2 * ConsoleSafeMargin - v1
        local v3 = TvSafeArea
        v3.PaddingLeft = UDim.new(v1, 0)
        v3.PaddingTop = UDim.new(v1, 0)
        v3.PaddingRight = UDim.new(v2, 0)
        v3.PaddingBottom = UDim.new(v2, 0)
    end
end

local function apply(a1, a2)
    -- Line: 94
    -- upvalues: Config (val), padForTv (val), u23 (val)
    -- types: a1: userdata, a2: number
    if a1:IsA("ScreenGui") and not Config.Settings.GuiScaleExempt[a1.Name] then
        padForTv(a1, a2)

        local v1 = a1:FindFirstChild(u23.LAYER_SCALE)

        if a2 == 1 and not v1 then
            return
        end

        local v2 = v1

        if not v2 then
            v1 = Instance.new("UIScale")
            v1.Name = u23.LAYER_SCALE
            v1.Parent = a1
            v2 = v1
        end

        v2.Scale = a2
    end
end

function v1.start()
    -- Line: 113
    -- upvalues: Players (val), current (val), apply (val), u23 (val), SettingsController (val)
    local PlayerGui = Players.LocalPlayer:WaitForChild("PlayerGui")

    local function applyAll() -- Line: 115; upvalues: current (upval), PlayerGui (val), apply (upval), u23 (upval)
        local v1 = current()

        for i, j in PlayerGui:GetChildren() do
            apply(j, v1)
        end

        u23.layerScaleChanged()
    end

    applyAll()

    PlayerGui.ChildAdded:Connect(function(a1) -- Line: 125; upvalues: current (upval), apply (upval), u23 (upval)
        task.defer(function() -- Line: 126; upvalues: current (upval), apply (upval), a1 (val), u23 (upval)
            local v1 = current()
            apply(a1, v1)

            if v1 ~= 1 then
                u23.layerScaleChanged()
            end
        end)
    end)

    SettingsController.onChanged(function(a1) -- Line: 136; upvalues: applyAll (val); types: a1: string
        if a1 == "GuiScale" or a1 == "PhoneGuiScale" or a1 == "ConsoleGuiScale" then
            applyAll()
        end
    end)
end

return v1