-- Script path: game:GetService("Players").TheKiller150306Alt.PlayerScripts.Client.Controllers.PressStrokeController
-- Decompile time: 2.83 ms

local CollectionService = game:GetService("CollectionService")
local TweenService = game:GetService("TweenService")
local Workspace = game:GetService("Workspace")
local Shared = (game:GetService("ReplicatedStorage")):WaitForChild("Shared")
local Config = require(Shared.Config)
local u32 = require(script.Parent.AudioController)
local SettingsController = require(script.Parent.SettingsController)
local v1 = {}
local u39 = {}
local u40 = {}
local u41 = {}

local function restOf(a1) -- Line: 35; upvalues: u39 (val), u40 (val); types: a1: userdata
    local v1 = u39[a1]

    if not v1 then
        v1 = a1:GetPivot()
        u39[a1] = v1
        local u8 = nil
        u8 = (a1.AncestryChanged:Connect(function() -- Line: 42; upvalues: a1 (val), u39 (upval), u40 (upval), u8 (ref)
            if not a1:IsDescendantOf(game) then
                u39[a1] = nil
                u40[a1] = nil

                u8:Disconnect()
            end
        end))
    end

    return v1
end

local function strike(a1)
    -- Line: 53
    -- upvalues: Config (val), u32 (val), u41 (val), SettingsController (val), Workspace (val), u39 (val), u40 (val)
    -- upvalues: TweenService (val)
    -- types: a1: userdata
    local v1 = Config.Appearance.PressStrokes[a1:GetAttribute("MachineId")]

    if not v1 then
        return
    end

    local Sound = v1.Sound

    if Sound then
        task.delay(
            math.max(0, v1.DownSeconds - (v1.SoundLeadSeconds or 0)),
            function() -- Line: 62; upvalues: a1 (val), u32 (upval), Sound (val)
                if a1.Parent then
                    u32.play(Sound, a1)
                end
            end
        )
    end

    local u28 = if not v1.Reveal then nil else a1:FindFirstChild(v1.Reveal, true)
    local Attribute = if not u28 then
        nil
    else
        u28:GetAttribute(Config.Appearance.RevealTransparencyAttribute)

    if u28 and u28:IsA("BasePart") and type(Attribute) == "number" then
        local u49 = (u41[u28] or 0) + 1
        u41[u28] = u49
        u28.Transparency = Attribute

        task.delay(
            Config.Appearance.pressStrokeSeconds((a1:GetAttribute("MachineId"))),
            function() -- Line: 76; upvalues: u41 (upval), u28 (val), u49 (val)
                if u41[u28] == u49 then
                    u41[u28] = nil
                    u28.Transparency = 1
                end
            end
        )
    end

    if SettingsController.get("MachineAnimations") == "Off" then
        return
    end

    local CurrentCamera = Workspace.CurrentCamera

    if CurrentCamera
        and Config.Appearance.MotionStuds
            < (CurrentCamera.CFrame.Position - a1.Position).Magnitude then
        return
    end

    local u88 = a1:FindFirstChild(v1.Model, true)

    if u88 and u88:IsA("PVInstance") then
        local v2 = u39[u88]

        if not v2 then
            v2 = u88:GetPivot()
            u39[u88] = v2
            local u100 = nil
            u100 = (u88.AncestryChanged:Connect(function()
                -- Line: 42
                -- upvalues: u88 (val), u39 (upval), u40 (upval), u100 (ref)
                if not u88:IsDescendantOf(game) then
                    u39[u88] = nil
                    u40[u88] = nil

                    u100:Disconnect()
                end
            end))
        end

        local u111 = (u40[u88] or 0) + 1
        u40[u88] = u111
        local CFrameValue = Instance.new("CFrameValue")
        CFrameValue.Value = u88:GetPivot()

        CFrameValue.Changed:Connect(function(a1) -- Line: 101; upvalues: u40 (upval), u88 (val), u111 (val)
            if u40[u88] == u111 and u88.Parent then
                u88:PivotTo(a1)
            end
        end)

        local v3 = TweenService:Create(
            CFrameValue,
            TweenInfo.new(v1.DownSeconds, Enum.EasingStyle.Quad, Enum.EasingDirection.In),
            {Value = v2 - Vector3.new(0, v1.Studs, 0)}
        )
        v3:Play()
        v3.Completed:Wait()
        task.wait(v1.HoldSeconds)

        if u40[u88] ~= u111 then
            CFrameValue:Destroy()
            return
        end

        v3 = TweenService:Create(
            CFrameValue,
            TweenInfo.new(v1.UpSeconds, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut),
            {Value = v2}
        )
        v3:Play()
        v3.Completed:Wait()
        CFrameValue:Destroy()

        if u40[u88] == u111 then
            u40[u88] = nil
        end
    end
end

function v1.start() -- Line: 133; upvalues: Config (val), strike (val), CollectionService (val)
    local PressStrokeAttribute = Config.Appearance.PressStrokeAttribute
    local u3 = {}

    local function track(a1)
        -- Line: 138
        -- upvalues: u3 (val), PressStrokeAttribute (val), strike (upval)
        -- types: a1: userdata
        if a1:IsA("BasePart") and not u3[a1] then
            u3[a1] = ((a1:GetAttributeChangedSignal(PressStrokeAttribute)):Connect(function()
                -- Line: 142
                -- upvalues: strike (upval), a1 (val)
                task.spawn(strike, a1)
            end))
            a1.Destroying:Connect(function() -- Line: 145; upvalues: u3 (upval), a1 (val)
                local v1 = u3[a1]

                if v1 then
                    v1:Disconnect()
                end

                u3[a1] = nil
            end)
        end
    end

    ;(CollectionService:GetInstanceAddedSignal(Config.Appearance.PressStrokeTag)):Connect(track)

    for i, j in CollectionService:GetTagged(Config.Appearance.PressStrokeTag) do
        track(j)
    end
end

return v1