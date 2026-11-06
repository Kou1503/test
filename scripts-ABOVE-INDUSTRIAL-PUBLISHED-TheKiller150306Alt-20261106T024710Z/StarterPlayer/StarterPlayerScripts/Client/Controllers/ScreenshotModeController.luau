-- Script path: game:GetService("Players").TheKiller150306Alt.PlayerScripts.Client.Controllers.ScreenshotModeController
-- Decompile time: 1.81 ms

local Players = game:GetService("Players")
local StarterGui = game:GetService("StarterGui")
local UserInputService = game:GetService("UserInputService")
local u15 = {}
local LocalPlayer = Players.LocalPlayer
local u17 = false
local u18 = {}
local u19 = {}

local function setCoreGui(a1) -- Line: 26; upvalues: u19 (val), StarterGui (val); types: a1: boolean
    pcall(function() -- Line: 27; upvalues: a1 (val), u19 (upval), StarterGui (upval)
        if a1 then
            for k, n in u19 do
                StarterGui:SetCoreGuiEnabled(k, n)
            end

            return
        end

        table.clear(u19)

        for i, j in Enum.CoreGuiType:GetEnumItems() do
            if j ~= Enum.CoreGuiType.All then
                u19[j] = (StarterGui:GetCoreGuiEnabled(j))
            end
        end

        StarterGui:SetCoreGuiEnabled(Enum.CoreGuiType.All, false)
    end)
end

local function hide(a1) -- Line: 44; upvalues: u18 (val); types: a1: userdata
    if a1:IsA("ScreenGui") and a1.Enabled then
        a1.Enabled = false
        table.insert(u18, a1)
    end
end

function u15.isHidden() -- Line: 51; upvalues: u17 (ref)
    return u17
end

function u15.setHidden(a1)
    -- Line: 55
    -- upvalues: u17 (ref), LocalPlayer (val), u18 (val), u19 (val), StarterGui (val)
    -- types: a1: boolean
    if a1 == u17 then
        return
    end

    u17 = a1
    local PlayerGui = LocalPlayer:FindFirstChildOfClass("PlayerGui")

    if not a1 then
        for i, j in u18 do
            if j.Parent then
                j.Enabled = true
            end
        end

        table.clear(u18)

        local u49 = true
        pcall(function() -- Line: 27; upvalues: u49 (val), u19 (upval), StarterGui (upval)
            if u49 then
                for k, n in u19 do
                    StarterGui:SetCoreGuiEnabled(k, n)
                end

                return
            end

            table.clear(u19)

            for i, j in Enum.CoreGuiType:GetEnumItems() do
                if j ~= Enum.CoreGuiType.All then
                    u19[j] = (StarterGui:GetCoreGuiEnabled(j))
                end
            end

            StarterGui:SetCoreGuiEnabled(Enum.CoreGuiType.All, false)
        end)

        return
    end

    table.clear(u18)

    if PlayerGui then
        for k, n in PlayerGui:GetChildren() do
            if n:IsA("ScreenGui") and n.Enabled then
                n.Enabled = false
                table.insert(u18, n)
            end
        end
    end

    local u32 = false
    pcall(function() -- Line: 27; upvalues: u32 (val), u19 (upval), StarterGui (upval)
        if u32 then
            for k, n in u19 do
                StarterGui:SetCoreGuiEnabled(k, n)
            end

            return
        end

        table.clear(u19)

        for i, j in Enum.CoreGuiType:GetEnumItems() do
            if j ~= Enum.CoreGuiType.All then
                u19[j] = (StarterGui:GetCoreGuiEnabled(j))
            end
        end

        StarterGui:SetCoreGuiEnabled(Enum.CoreGuiType.All, false)
    end)
end

function u15.start()
    -- Line: 80
    -- upvalues: UserInputService (val), u15 (val), u17 (ref), LocalPlayer (val), hide (val)
    UserInputService.InputBegan:Connect(function(a1, a2) -- Line: 81; upvalues: u15 (upval), u17 (upval)
        if not a2 and a1.KeyCode == Enum.KeyCode.F1 then
            u15.setHidden(not u17)
        end
    end)

    ;(LocalPlayer:WaitForChild("PlayerGui")).ChildAdded:Connect(function(a1)
        -- Line: 89
        -- upvalues: u17 (upval), hide (upval)
        if u17 then
            task.defer(hide, a1)
        end
    end)
end

return u15