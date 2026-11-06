-- Script path: game:GetService("StarterPlayer").PlayerModule.PlayerModuleInternal
-- Decompile time: 1.24 ms

local RunService = game:GetService("RunService")
local CommonUtils = require(script.Parent:WaitForChild("CommonUtils"))

require(script.Parent.Types)

local CharacterUtil = CommonUtils.get("CharacterUtil")
local ConnectionUtil = CommonUtils.get("ConnectionUtil")
local EventBus = CommonUtils.get("EventBus")
local u31 = require(script.Parent)
local CameraModule = require(script.Parent:WaitForChild("CameraModule"))
local ControlModule = require(script.Parent:WaitForChild("ControlModule"))
local ServerAuthority = require(script.Parent:WaitForChild("ServerAuthority"))
local u57 = {}
u57.__index = u57

function u57.new() -- Line: 38; upvalues: u31 (val), ConnectionUtil (val), EventBus (val), u57 (val)
    return (setmetatable(
        {
            data = {
                isServerAuthority = false,
                playerModule = u31,
                controlModule = {
                    isJumping = false,
                    moveVector = Vector2.new(),
                    worldMoveVector = Vector3.new(),
                    actions = {},
                },
                connectionUtil = ConnectionUtil.new(),
                eventBus = EventBus.new(),
            },
        },
        u57
    ))
end

function u57.start(a1)
    -- Line: 59
    -- upvalues: CharacterUtil (val), ServerAuthority (val), ControlModule (val), RunService (val), CameraModule (val)
    a1.data.connectionUtil:trackConnection(
        "ONLOCALPLAYER",
        (CharacterUtil.onLocalPlayer(function(a1_2)
            -- Line: 63
            -- upvalues: a1 (val), ServerAuthority (upval), ControlModule (upval), RunService (upval)
            -- upvalues: CharacterUtil (upval), CameraModule (upval)
            a1.data.player = a1_2
            ServerAuthority.initialize(a1.data)
            ControlModule:initialize(a1.data)

            RunService:BindToRenderStep(
                "PLAYERMODULE_RENDERSTEPPED_INPUT",
                Enum.RenderPriority.Input.Value,
                function(a1_2) -- Line: 70; upvalues: a1 (upval), CharacterUtil (upval), ControlModule (upval)
                    a1.data.character = CharacterUtil.getCharacter()

                    if not a1.data.character then
                        return
                    end

                    ControlModule:Update(a1.data, a1_2)
                end
            )

            a1.data.connectionUtil:trackBoundFunction(
                "PLAYERMODULE_RENDERSTEPPED_INPUT",
                function() -- Line: 78; upvalues: RunService (upval)
                    RunService:UnbindFromRenderStep("PLAYERMODULE_RENDERSTEPPED_INPUT")
                end
            )

            RunService:BindToRenderStep(
                "PLAYERMODULE_RENDERSTEPPED_CAMERA",
                Enum.RenderPriority.Camera.Value,
                function(a1_2) -- Line: 83; upvalues: CameraModule (upval), a1 (upval)
                    CameraModule:Update(a1.data, a1_2)
                end
            )

            a1.data.connectionUtil:trackBoundFunction(
                "PLAYERMODULE_RENDERSTEPPED_CAMERA",
                function() -- Line: 86; upvalues: RunService (upval)
                    RunService:UnbindFromRenderStep("PLAYERMODULE_RENDERSTEPPED_CAMERA")
                end
            )
        end))
    )
end

function u57.stop(a1) -- Line: 93
    a1.data.connectionUtil:disconnectAll()
end

return u57