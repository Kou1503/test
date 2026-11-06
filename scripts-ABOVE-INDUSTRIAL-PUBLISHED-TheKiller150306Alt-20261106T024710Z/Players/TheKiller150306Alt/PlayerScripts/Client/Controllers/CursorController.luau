-- Script path: game:GetService("Players").TheKiller150306Alt.PlayerScripts.Client.Controllers.CursorController
-- Decompile time: 1.37 ms

local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local BuildController = require(script.Parent.BuildController)
local v1 = {}
local u16 = false
local u17 = false

local function free() -- Line: 42; upvalues: u17 (ref), UserInputService (val)
    if u17 then
        return
    end

    if UserInputService.MouseBehavior ~= Enum.MouseBehavior.Default then
        UserInputService.MouseBehavior = Enum.MouseBehavior.Default
    end

    if not UserInputService.MouseIconEnabled then
        UserInputService.MouseIconEnabled = true
    end
end

function v1.start()
    -- Line: 54
    -- upvalues: UserInputService (val), u16 (ref), u17 (ref), BuildController (val), RunService (val), free (val)
    UserInputService.InputBegan:Connect(function(a1, a2) -- Line: 55; upvalues: u16 (upval), u17 (upval)
        if a1.UserInputType == Enum.UserInputType.MouseButton2 and u16 and not a2 then
            u17 = true
        end
    end)

    UserInputService.InputEnded:Connect(function(a1)
        -- Line: 60
        -- upvalues: u17 (upval), u16 (upval), UserInputService (upval)
        if a1.UserInputType == Enum.UserInputType.MouseButton2 and u17 then
            u17 = false

            if u16 then
                if u17 then
                    return
                end

                if UserInputService.MouseBehavior ~= Enum.MouseBehavior.Default then
                    UserInputService.MouseBehavior = Enum.MouseBehavior.Default
                end

                if not UserInputService.MouseIconEnabled then
                    UserInputService.MouseIconEnabled = true
                end
            end
        end
    end)

    BuildController.onUiOpenChanged(function(a1)
        -- Line: 69
        -- upvalues: u16 (upval), RunService (upval), free (upval), u17 (upval), UserInputService (upval)
        if a1 and not u16 then
            u16 = true
            RunService:BindToRenderStep("AboveFreeCursor", Enum.RenderPriority.Camera.Value + 1, free)

            if u17 then
                return
            end

            if UserInputService.MouseBehavior ~= Enum.MouseBehavior.Default then
                UserInputService.MouseBehavior = Enum.MouseBehavior.Default
            end

            if UserInputService.MouseIconEnabled then
                return
            end

            UserInputService.MouseIconEnabled = true

            return
        end

        if not a1 and u16 then
            u16 = false
            RunService:UnbindFromRenderStep("AboveFreeCursor")
        end
    end)
end

return v1