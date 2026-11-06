-- Script path: game:GetService("Players").TheKiller150306Alt.PlayerScripts.Client.Controllers.GatherFxController
-- Decompile time: 6.65 ms

local v1, v2
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local Shared = (game:GetService("ReplicatedStorage")):WaitForChild("Shared")
local Config = require(Shared.Config)
local Palette = require(Shared.Palette)
local Remotes = require(Shared.Remotes)
local u33 = require(script.Parent.AudioController)
local v3 = {}
local LocalPlayer = Players.LocalPlayer
local CurrentCamera = workspace.CurrentCamera
local u40 = Remotes.get(Remotes.ItemGained)
local u43 = Remotes.get(Remotes.BlockBroken)
local u44 = nil
local u45 = nil
local u46 = {}

local function ease(a1) -- Line: 78; types: a1: number
    return a1 * a1 * a1 * (a1 * (a1 * 6 - 15) + 10)
end

local function bezier(a1, a2, a3, a4) -- Line: 87; types: a1: userdata, a2: userdata, a3: userdata, a4: number
    local v1 = 1 - a4
    return a1 * (v1 * v1) + a2 * (v1 * 2 * a4) + a3 * (a4 * a4)
end

local function targetPoint() -- Line: 98; upvalues: LocalPlayer (val), CurrentCamera (val)
    local Character = LocalPlayer.Character
    local HumanoidRootPart = Character and Character:FindFirstChild("HumanoidRootPart")

    if HumanoidRootPart and HumanoidRootPart:IsA("BasePart") then
        local v1 = CurrentCamera:WorldToViewportPoint(HumanoidRootPart.Position + Vector3.new(0, 1, 0))
        return Vector2.new(v1.X, v1.Y)
    end

    return nil
end

local function colorFor(a1) -- Line: 108; upvalues: Config (val), Palette (val); types: a1: string
    local v1 = Config.Appearance.GatherFx.Colors[a1]

    if v1 then
        return Color3.fromRGB(v1.r, v1.g, v1.b)
    end

    return Palette.colorFor(a1)
end

local function spawnDebris(a1, a2)
    -- Line: 129
    -- upvalues: Config (val), LocalPlayer (val), Palette (val), u44 (ref)
    -- types: a1: string, a2: vector
    local Part, v1, v2
    local BreakFx = Config.Appearance.BreakFx
    local Character = LocalPlayer.Character
        and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")

    if Character
        and Character:IsA("BasePart")
        and BreakFx.MaxDistanceStuds < (Character.Position - a2).Magnitude then
        return
    end

    local v3 = Config.Appearance.GatherFx.Colors[a1]
    local v4 = if not v3 then
        Palette.colorFor(a1)
    else
        Color3.fromRGB(v3.r, v3.g, v3.b)
    local Count = BreakFx.Count

    for i = 1, Count do
        Part = Instance.new("Part")
        Part.Size = Vector3.new(1, 1, 1) * BreakFx.SizeStuds
        Part.Color = v4
        Part.Material = Enum.Material.SmoothPlastic
        Part.CanCollide = false
        Part.CanQuery = false
        Part.CanTouch = false
        Part.Massless = true
        Part.CFrame = (CFrame.new(a2 + Vector3.new(math.random() - 0.5, math.random() - 0.5, (math.random()) - 0.5)))
            * CFrame.Angles(math.random() * 6, math.random() * 6, math.random() * 6)
        v1 = math.random() * 3.141592653589793 * 2
        v2 = math.random() * BreakFx.SpeedStuds
        Part.AssemblyLinearVelocity = Vector3.new(math.cos(v1) * v2, BreakFx.UpwardMinStuds + math.random() * (BreakFx.UpwardStuds - BreakFx.UpwardMinStuds), (math.sin(v1)) * v2)
        Part.AssemblyAngularVelocity = Vector3.new(math.random() * 14 - 7, math.random() * 14 - 7, (math.random()) * 14 - 7)
        Part.Parent = u44

        ;(game:GetService("Debris")):AddItem(Part, BreakFx.Seconds)
    end
end

local function spawnBurst(a1, a2, a3, a4)
    -- Line: 168
    -- upvalues: Config (val), Palette (val), u46 (val), u45 (ref)
    -- types: a1: string, a2: vector, a3: number, a4: number?
    local Frame, v1, v2, v3
    local GatherFx = Config.Appearance.GatherFx
    local v4 = math.clamp(a3 * GatherFx.CountPerItem, 1, GatherFx.MaxCount)
    local v5 = Config.Appearance.GatherFx.Colors[a1]
    local v6 = if not v5 then
        Palette.colorFor(a1)
    else
        Color3.fromRGB(v5.r, v5.g, v5.b)
    v5 = os.clock()

    while true do
        if not (GatherFx.MaxOnScreen < #u46 + v4) or not (#u46 > 0) then
            break
        end

        v3 = table.remove(u46, 1)

        if v3 then
            v3.frame:Destroy()
        end
    end

    for i = 1, v4 do
        Frame = Instance.new("Frame")
        Frame.Size = UDim2.fromOffset(GatherFx.SizePixels, GatherFx.SizePixels)
        Frame.AnchorPoint = Vector2.new(0.5, 0.5)
        Frame.BackgroundColor3 = v6
        Frame.BorderSizePixel = 0
        Frame.Rotation = math.random(0, 45)
        Frame.ZIndex = 2
        Frame.Visible = false
        Frame.Parent = u45
        v1 = math.random() * 3.141592653589793 * 2
        v2 = Vector2.new(math.cos(v1), (math.sin(v1)))

        table.insert(
            u46,
            {
                frame = Frame,
                origin = v7,
                direction = v2,
                control = v2 * GatherFx.DriftPixels,
                born = v5,
                delay = (v8 or 0) + math.random() * GatherFx.StaggerSeconds,
                size = GatherFx.SizePixels,
            }
        )
    end
end

local function step() -- Line: 213; upvalues: u46 (val), Config (val), targetPoint (val), CurrentCamera (val)
    local v1, v2, v3, v4, v5, v6, v7

    if #u46 == 0 then
        return
    end

    local GatherFx = Config.Appearance.GatherFx
    local v8 = os.clock()
    local v9 = targetPoint()

    for i = #u46, 1, -1 do
        v4 = u46[i]
        v5 = v8 - v4.born - v4.delay
        v6 = v5 / GatherFx.Seconds

        if not v9 or v6 >= 1 then
            v4.frame:Destroy()
            table.remove(u46, i)
        elseif not (v5 < 0) then
            v5 = CurrentCamera:WorldToViewportPoint(v4.origin)
            v1 = (Vector2.new(v5.X, v5.Y))
                + v4.direction * (GatherFx.SpreadPixels * (1 - v6))
            v7 = v6 * v6 * v6 * (v6 * (v6 * 6 - 15) + 10)
            v2 = (v1 + v9) / 2 + v4.control
            v3 = 1 - v7
            v5 = v1 * (v3 * v3) + v2 * (v3 * 2 * v7) + v9 * (v7 * v7)
            v1 = 1 - (1 - GatherFx.ArriveScale) * v7
            v4.frame.Visible = true
            v4.frame.Position = UDim2.fromOffset(v5.X, v5.Y)
            v4.frame.Size = UDim2.fromOffset(v4.size * v1, v4.size * v1)
            v4.frame.BackgroundTransparency = math.max(0, (v6 - 0.75) / 0.25)
        end
    end
end

function v3.start()
    -- Line: 256
    -- upvalues: u45 (ref), LocalPlayer (val), u44 (ref), u40 (val), spawnBurst (val), u33 (val), u43 (val)
    -- upvalues: spawnDebris (val), RunService (val), step (val)
    u45 = Instance.new("ScreenGui")
    u45.Name = "GatherFx"
    u45.ResetOnSpawn = false
    u45.IgnoreGuiInset = true
    u45.DisplayOrder = -1
    u45.Parent = LocalPlayer:WaitForChild("PlayerGui")
    u44 = Instance.new("Folder")
    u44.Name = "BreakDebris"
    u44.Parent = workspace

    u40.OnClientEvent:Connect(function(a1, a2, a3, a4) -- Line: 270; upvalues: spawnBurst (upval), u33 (upval)
        if type(a1) == "string" and typeof(a2) == "Vector3" then
            local v1 = spawnBurst
            local v2 = if type(a4) ~= "number" then nil else math.clamp(a4, 0, 2)

            v1(a1, a2, if type(a3) ~= "number" then 1 else math.max(1, a3), v2)

            if not u33.pickupSuppressed() then
                u33.play("ItemPickup")
            end
        end
    end)

    u43.OnClientEvent:Connect(function(a1, a2) -- Line: 291; upvalues: spawnDebris (upval), u33 (upval)
        if type(a1) == "string" and typeof(a2) == "Vector3" then
            spawnDebris(a1, a2)
            u33.play("BlockBreak", a2)
        end
    end)

    RunService.RenderStepped:Connect(step)
end

return v3