-- Script path: game:GetService("Players").TheKiller150306Alt.PlayerScripts.Client.Controllers.BoundaryController
-- Decompile time: 3.67 ms

local Players = game:GetService("Players")
local Shared = (game:GetService("ReplicatedStorage")):WaitForChild("Shared")
local Config = require(Shared.Config)
local Grid = require(Shared.Grid)
local Remotes = require(Shared.Remotes)
local u28 = require(script.Parent.HudController)
local SettingsController = require(script.Parent.SettingsController)
local u34 = {}
local LocalPlayer = Players.LocalPlayer
local u41 = Color3.fromRGB(255, 214, 110)
local u46 = Color3.fromRGB(255, 226, 150)
local u47 = nil
local u48 = 0
local u49 = nil
local u50 = false
local u51 = 0

local function destroyGuide() -- Line: 41; upvalues: u49 (ref)
    if u49 then
        u49:Destroy()
    end

    u49 = nil
end

local function wall(a1, a2, a3)
    -- Line: 48
    -- upvalues: u46 (val), Config (val)
    -- types: a1: userdata, a2: vector, a3: vector
    local Part = Instance.new("Part")
    Part.Size = a2
    Part.CFrame = CFrame.new(a3)
    Part.Anchored = true
    Part.CanCollide = false
    Part.CanQuery = false
    Part.CanTouch = false
    Part.CastShadow = false
    Part.Color = u46
    Part.Material = Enum.Material.Neon
    Part.Transparency = Config.Build.BoundaryGuide.Transparency
    Part.Parent = a1
end

local function buildGuide()
    -- Line: 66
    -- upvalues: u49 (ref), u47 (ref), Config (val), u48 (ref), Grid (val), wall (val), u41 (val)
    if u49 then
        u49:Destroy()
    end

    u49 = nil
    local v1 = u47

    if not v1 then
        return
    end

    local BoundaryGuide = Config.Build.BoundaryGuide
    local v2 = Config.Build.boundsForTier(u48)
    local CellSize = Grid.CellSize
    local v3 = Grid.boundarySpanStuds(v2.horizontal)
    local v4 = Grid.boundaryEdgeStuds(v2.horizontal)
    local HeightStuds = BoundaryGuide.HeightStuds
    local ThicknessStuds = BoundaryGuide.ThicknessStuds
    local v5 = Instance.new("Model")
    v5.Name = "BoundaryGuide"
    local v6 = v1.Y + HeightStuds / 2 - CellSize / 2
    local v7 = v3 + ThicknessStuds

    for i, j in {-1, 1} do
        wall(v5, Vector3.new(v7, HeightStuds, ThicknessStuds), (Vector3.new(v1.X, v6, v1.Z + v4 * j)))
        wall(v5, Vector3.new(ThicknessStuds, HeightStuds, v7), (Vector3.new(v1.X + v4 * j, v6, v1.Z)))
    end

    local SelectionBox = Instance.new("SelectionBox")
    SelectionBox.Adornee = v5
    SelectionBox.Color3 = u41
    SelectionBox.LineThickness = 0.2
    SelectionBox.SurfaceTransparency = 1
    SelectionBox.Parent = v5
    v5.Parent = workspace
    u49 = v5
end

local function widthCells() -- Line: 121; upvalues: Config (val), u48 (ref)
    return Config.Build.boundsForTier(u48).horizontal * 2 + 1
end

function u34.setShown(a1) -- Line: 125; upvalues: u50 (ref), buildGuide (val), u49 (ref); types: a1: boolean
    if a1 then
        buildGuide()
        return
    end

    if u49 then
        u49:Destroy()
    end

    u49 = nil
end

function u34.toggle() -- Line: 134; upvalues: u34 (val), u50 (ref), Config (val), u48 (ref), u28 (val)
    u34.setShown(not u50)

    if u50 then
        local v1 = Config.Build.boundsForTier(u48).horizontal * 2 + 1
        u28.showAlert((("Boundary %*x%*"):format(v1, v1)))
    end
end

local function flash() -- Line: 147; upvalues: u51 (ref), u34 (val), Config (val), u48 (ref), u28 (val), u50 (ref)
    u51 = u51 + 1
    local u2 = u51

    u34.setShown(true)

    local v1 = Config.Build.boundsForTier(u48).horizontal * 2 + 1
    u28.showAlert((("Boundary %*x%*"):format(v1, v1)))

    task.delay(
        Config.Build.BoundaryGuide.FlashSeconds,
        function() -- Line: 153; upvalues: u2 (val), u51 (upval), u50 (upval), u34 (upval)
            if u2 == u51 and u50 then
                u34.setShown(false)
            end
        end
    )
end

function u34.start()
    -- Line: 161
    -- upvalues: SettingsController (val), u34 (val), Remotes (val), u47 (ref), u48 (ref), flash (val), u50 (ref)
    -- upvalues: buildGuide (val), LocalPlayer (val)
    SettingsController.onChanged(function(a1, a2) -- Line: 164; upvalues: u34 (upval)
        if a1 == "BoundaryGuide" then
            u34.setShown(a2 == "On")
        end
    end)

    u34.setShown(SettingsController.is("BoundaryGuide", "On"))

    ;(Remotes.get(Remotes.IslandReady)).OnClientEvent:Connect(function(a1, a2, a3, a4)
        -- Line: 176
        -- upvalues: u47 (upval), u48 (upval), flash (upval), u50 (upval), buildGuide (upval)
        -- types: a1: vector, a3: number?, a4: boolean?
        u47 = a1
        u48 = if type(a3) ~= "number" then 0 else a3

        if a4 == true then
            flash()
            return
        end

        if u50 then
            buildGuide()
        end
    end)

    LocalPlayer.CharacterAdded:Connect(function() -- Line: 192; upvalues: u50 (upval), buildGuide (upval)
        if u50 then
            buildGuide()
        end
    end)
end

return u34