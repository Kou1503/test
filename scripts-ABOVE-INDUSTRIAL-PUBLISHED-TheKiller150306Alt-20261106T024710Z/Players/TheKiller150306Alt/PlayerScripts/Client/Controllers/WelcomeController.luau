-- Script path: game:GetService("Players").TheKiller150306Alt.PlayerScripts.Client.Controllers.WelcomeController
-- Decompile time: 1.67 ms

local Players = game:GetService("Players")
local Shared = (game:GetService("ReplicatedStorage")):WaitForChild("Shared")
local Config = require(Shared.Config)
local Remotes = require(Shared.Remotes)
local u26 = require(script.Parent.Parent.Ui)
local v1 = {}
local LocalPlayer = Players.LocalPlayer
local u29 = false
local u30 = 0
local u31 = 0

function v1.pending() -- Line: 31; upvalues: u29 (ref), u30 (ref)
    return u29 or u30 > 0
end

local function loadingScreenUp() -- Line: 35; upvalues: LocalPlayer (val)
    local PlayerGui = LocalPlayer:FindFirstChildOfClass("PlayerGui")
    local v1 = false

    if PlayerGui ~= nil then
        v1 = PlayerGui:FindFirstChild("LoadingScreen") ~= nil
    end

    return v1
end

function v1.start()
    -- Line: 40
    -- upvalues: Remotes (val), u29 (ref), LocalPlayer (val), u31 (ref), Config (val), u26 (val), u30 (ref)
    (Remotes.get(Remotes.Welcome)).OnClientEvent:Connect(function()
        -- Line: 41
        -- upvalues: u29 (upval), LocalPlayer (upval), u31 (upval), Config (upval), u26 (upval)
        u29 = true
        task.spawn(function()
            -- Line: 43
            -- upvalues: LocalPlayer (upval), u31 (upval), Config (upval), u26 (upval), u29 (upval)
            local PlayerGui, v1
            local v2 = os.clock() + 120

            while true do
                PlayerGui = LocalPlayer:FindFirstChildOfClass("PlayerGui")
                v1 = false

                if PlayerGui ~= nil then
                    v1 = PlayerGui:FindFirstChild("LoadingScreen") ~= nil
                end

                if not v1 and not (u31 > 0) then
                    break
                end

                if not (os.clock() < v2) then
                    break
                end

                task.wait(0.25)
            end

            local Welcome = Config.Tutorial.Welcome
            u26.confirm(
                {
                    title = Welcome.Title,
                    body = Welcome.Body,
                    confirm = Welcome.Button,
                    height = Welcome.Height,
                },
                function() -- Line: 54; upvalues: u29 (upval)
                    u29 = false
                end
            )
        end)
    end)

    ;(Remotes.get(Remotes.InfoDialog)).OnClientEvent:Connect(function(a1, a2, a3, a4)
        -- Line: 62
        -- upvalues: u30 (upval), LocalPlayer (upval), u29 (upval), u31 (upval), u26 (upval)
        if type(a1) == "string" and type(a2) == "string" then
            u30 = u30 + 1
            task.spawn(function()
                -- Line: 67
                -- upvalues: LocalPlayer (upval), u29 (upval), u31 (upval), u26 (upval), a1 (val), a2 (val), a3 (val)
                -- upvalues: a4 (val), u30 (upval)
                local PlayerGui, v1
                local v2 = os.clock() + 120

                task.wait(0.5)

                while true do
                    PlayerGui = LocalPlayer:FindFirstChildOfClass("PlayerGui")
                    v1 = false

                    if PlayerGui ~= nil then
                        v1 = PlayerGui:FindFirstChild("LoadingScreen") ~= nil
                    end

                    if not v1 and not u29 then
                        break
                    end

                    if not (os.clock() < v2) then
                        break
                    end

                    task.wait(0.25)
                end

                u31 = u31 + 1
                u26.confirm(
                    {
                        title = a1,
                        body = a2,
                        confirm = if type(a3) ~= "string" then "OK" else a3,
                        height = if type(a4) ~= "number" then nil else a4,
                    },
                    function() -- Line: 81; upvalues: u31 (upval), u30 (upval)
                        u31 = u31 - 1
                        u30 = u30 - 1
                    end
                )
            end)
        end
    end)
end

return v1