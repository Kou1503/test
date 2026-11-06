-- Script path: game:GetService("StarterPlayer").PlayerModule.ControlModule.ActionController
-- Decompile time: 0.76 ms

local u1 = {}
u1.__index = u1

function u1.new() -- Line: 19; upvalues: u1 (val)
    local v1 = setmetatable(
        {},
        u1
    )
    v1.enabled = true

    return v1
end

function u1.initializeActions(a1) -- Line: 27
    a1.connectionUtil:trackConnection(
        "SERVER_AUTHORITY_CHANGED",
        ((a1.eventBus:subscribe("SERVER_AUTHORITY_CHANGED")):Connect(function() -- Line: 29; upvalues: a1 (val)
            a1.controlModule.actions = {}
        end))
    )

    if a1.controlModule.actions.MoveAction and a1.controlModule.actions.JumpAction then
        return
    end

    if not a1.player then
        return
    end

    pcall(function() -- Line: 38; upvalues: a1 (val)
        local InputContexts = script.Parent.Parent.InputContexts

        if a1.isServerAuthority then
            InputContexts = a1.player.InputContexts
        end

        local CharacterContext = InputContexts.CharacterContext
        a1.controlModule.actions = {
            MoveAction = CharacterContext.MoveAction,
            JumpAction = CharacterContext.JumpAction,
        }

        a1.eventBus:publish("ACTIONS_RELOADED")
    end)
end

function u1.update(a1) -- Line: 54
    if a1.controlModule.actions.MoveAction and a1.controlModule.actions.JumpAction then
        local ControlModule = a1.playerModule.ControlModule
        a1.controlModule.actions.MoveAction.Enabled = ControlModule.Enabled
        a1.controlModule.actions.JumpAction.Enabled = ControlModule.Enabled
        a1.controlModule.moveVector = a1.controlModule.actions.MoveAction:GetState()
        a1.controlModule.isJumping = a1.controlModule.actions.JumpAction:GetState()
    end
end

function u1.Enable(a1, a2) -- Line: 68; types: a1: table, a2: boolean
end

return u1