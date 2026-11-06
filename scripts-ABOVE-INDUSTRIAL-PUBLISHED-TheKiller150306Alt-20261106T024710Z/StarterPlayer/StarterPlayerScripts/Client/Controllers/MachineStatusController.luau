-- Script path: game:GetService("Players").TheKiller150306Alt.PlayerScripts.Client.Controllers.MachineStatusController
-- Decompile time: 2.59 ms

local CollectionService = game:GetService("CollectionService")
local RunService = game:GetService("RunService")
local Workspace = game:GetService("Workspace")
local Shared = (game:GetService("ReplicatedStorage")):WaitForChild("Shared")
local v1 = {}
local StatusBar = require(Shared.Config).Factory.StatusBar
local u30 = {}
local u31 = {}

local function draw(a1, a2) -- Line: 45; types: a1: table, a2: number
    a1.shown = a2
    a1.fill.Size = UDim2.fromScale(a2, 1)
end

local function snap(a1, a2) -- Line: 50; upvalues: u31 (val); types: a1: table, a2: number
    u31[a1] = nil
    a1.from = a2
    a1.target = a2
    a1.shown = a2
    a1.fill.Size = UDim2.fromScale(a2, 1)
end

local function farAway(a1) -- Line: 56; upvalues: Workspace (val); types: a1: userdata
    local Parent = a1.Parent
    local CurrentCamera = Workspace.CurrentCamera

    if CurrentCamera and Parent and Parent:IsA("BasePart") then
        return a1.MaxDistance
            < (CurrentCamera.CFrame.Position - Parent.Position).Magnitude
    end

    return true
end

local function onProgress(a1) -- Line: 65; upvalues: StatusBar (val), u31 (val), Workspace (val); types: a1: table
    local Attribute = a1.billboard:GetAttribute(StatusBar.ProgressAttribute)
    local v1 = os.clock()
    local v2 = v1 - a1.lastAt
    a1.lastAt = v1

    if type(Attribute) ~= "number" then
        a1.active = false
        u31[a1] = nil
        a1.from = 0
        a1.target = 0
        a1.shown = 0
        a1.fill.Size = UDim2.fromScale(0, 1)

        return
    end

    if a1.active and not (Attribute < a1.shown) then
        local billboard_2 = a1.billboard
        local Parent = billboard_2.Parent
        local CurrentCamera = Workspace.CurrentCamera

        if not (if not CurrentCamera or not Parent then
            true
        else
            if Parent:IsA("BasePart") then
                billboard_2.MaxDistance
                    < (CurrentCamera.CFrame.Position - Parent.Position).Magnitude
            else
                true) then
            a1.from = a1.shown
            a1.target = Attribute
            a1.startedAt = v1
            a1.duration = math.clamp(v2, StatusBar.TweenMinSeconds, StatusBar.TweenMaxSeconds)
            u31[a1] = true

            return
        end
    end

    a1.active = true
    u31[a1] = nil
    a1.from = Attribute
    a1.target = Attribute
    a1.shown = Attribute
    a1.fill.Size = UDim2.fromScale(Attribute, 1)
end

local function attach(a1)
    -- Line: 91
    -- upvalues: u30 (val), StatusBar (val), u31 (val), onProgress (val)
    -- types: a1: userdata
    if a1:IsA("BillboardGui") and not u30[a1] then
        local v1 = a1:FindFirstChild(StatusBar.FillName, true)

        if v1 and v1:IsA("Frame") then
            local u17 = {
                shown = 0,
                from = 0,
                target = 0,
                startedAt = 0,
                duration = 0,
                active = false,
                billboard = a1,
                fill = v1,
            }
            u17.lastAt = os.clock()
            u30[a1] = u17
            v1 = a1:GetAttribute(StatusBar.ProgressAttribute)
            u17.active = type(v1) == "number"
            local v2 = if type(v1) ~= "number" then 0 else v1
            u31[u17] = nil
            u17.from = v2
            u17.target = v2
            u17.shown = v2
            u17.fill.Size = UDim2.fromScale(v2, 1)
            u17.connection = (a1:GetAttributeChangedSignal(StatusBar.ProgressAttribute)):Connect(function()
                -- Line: 117
                -- upvalues: onProgress (upval), u17 (val)
                onProgress(u17)
            end)
        end
    end
end

local function detach(a1) -- Line: 122; upvalues: u30 (val), u31 (val); types: a1: userdata
    local v1 = u30[a1]

    if v1 then
        v1.connection:Disconnect()

        u31[v1] = nil
        u30[a1] = nil
    end
end

function v1.start()
    -- Line: 131
    -- upvalues: CollectionService (val), StatusBar (val), attach (val), detach (val), RunService (val), u31 (val)
    (CollectionService:GetInstanceAddedSignal(StatusBar.Tag)):Connect(attach)
    ;(CollectionService:GetInstanceRemovedSignal(StatusBar.Tag)):Connect(detach)

    for i, j in CollectionService:GetTagged(StatusBar.Tag) do
        attach(j)
    end

    RunService.Heartbeat:Connect(function() -- Line: 138; upvalues: u31 (upval)
        local target, v1, v2

        if next(u31) == nil then
            return
        end

        local v3 = os.clock()
        local v4 = nil
        local v5 = nil

        for i in u31, v4, v5 do
            v1 = if not (0 < i.duration) then 1 else (v3 - i.startedAt) / i.duration

            if not (v1 >= 1) then
                v2 = i.from + (i.target - i.from) * v1
                i.shown = v2
                i.fill.Size = UDim2.fromScale(v2, 1)
            else
                target = i.target
                u31[i] = nil
                i.from = target
                i.target = target
                i.shown = target
                i.fill.Size = UDim2.fromScale(target, 1)
            end
        end
    end)
end

return v1