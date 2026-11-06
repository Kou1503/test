-- Script path: game:GetService("Players").TheKiller150306Alt.PlayerScripts.Client.Controllers.WaterZoneController
-- Decompile time: 22.44 ms

local Players = game:GetService("Players")
local Shared = (game:GetService("ReplicatedStorage")):WaitForChild("Shared")
local Config = require(Shared.Config)
local Grid = require(Shared.Grid)
local u25 = require(script.Parent.HotbarController)
local SettingsController = require(script.Parent.SettingsController)
local v1 = {}
local LocalPlayer = Players.LocalPlayer
local u33 = {GrassBlock = true, FarmSoil = true, DirtBlock = true}
local u38 = Color3.fromRGB(90, 170, 255)
local u43 = Color3.fromRGB(255, 232, 150)
local RequiredGround = Config.Crop.RequiredGround
local u46 = {"CropCell", "BushCell", "FlowerCell", "NodeCell"}
local u51 = nil
local u52 = nil
local u53 = nil
local u54 = {}
local u55 = false
local u56 = nil
local u57 = 0

local function modeForHand() -- Line: 98; upvalues: u25 (val), Config (val), SettingsController (val)
    local v1 = u25.selected()
    local assignedItemId = v1.assignedItemId or v1.itemId

    if not assignedItemId then
        return nil
    end

    if Config.Build.Converters[assignedItemId] ~= nil then
        if SettingsController.get("PlowHints") == "Off" then
            return nil
        end

        return "Water"
    end

    if Config.Crop.isSeed(assignedItemId) then
        return "Soil"
    end

    return nil
end

local function rootPart() -- Line: 115; upvalues: LocalPlayer (val)
    local Character = LocalPlayer.Character

    if Character then
        return (Character:FindFirstChild("HumanoidRootPart"))
    end

    return nil
end

local function nearestIsland() -- Line: 121; upvalues: LocalPlayer (val)
    local Attribute, Magnitude, v1
    local Character = LocalPlayer.Character

    if not (if not Character then nil else Character:FindFirstChild("HumanoidRootPart")) then
        return nil
    end

    local v2 = nil
    local v3 = 1500

    for i, j in workspace:GetChildren() do
        if string.sub(j.Name, 1, 7) == "Island_" then
            Attribute = j:GetAttribute("IslandOrigin")

            if typeof(Attribute) == "Vector3" and j:FindFirstChild("Blocks") then
                Magnitude = (Attribute - v1.Position).Magnitude

                if Magnitude < v3 then
                    v2 = j
                    v3 = Magnitude
                end
            end
        end
    end

    return v2
end

local function parseKey(a1) -- Line: 143; types: a1: string
    local v1, v2, v3 = string.match(a1, "^(-?%d+),(-?%d+),(-?%d+)$")
    return (tonumber(v1)), (tonumber(v2)), (tonumber(v3))
end

local function addBlock(a1, a2) -- Line: 150; types: a1: table, a2: userdata
    if not a2:IsA("BasePart") then
        return
    end

    local Attribute = a2:GetAttribute("CellKey")

    if type(Attribute) ~= "string" then
        return
    end

    a1.byKey[Attribute] = a2
    a1.keyOf[a2] = Attribute

    if a2:GetAttribute("BlockId") == "WaterBlock" then
        a1.waters[Attribute] = a2
    end
end

local function removeBlock(a1, a2) -- Line: 165; types: a1: table, a2: userdata
    local v1 = a1.keyOf[a2]

    if not v1 then
        return
    end

    a1.keyOf[a2] = nil

    if a1.byKey[v1] == a2 then
        a1.byKey[v1] = nil
    end

    if a1.waters[v1] == a2 then
        a1.waters[v1] = nil
    end
end

local function takenCellOf(a1) -- Line: 181; upvalues: u46 (val); types: a1: userdata
    local Attribute
    local v1 = a1

    if a1:IsA("Model") then
        v1 = a1.PrimaryPart or a1:FindFirstChildWhichIsA("BasePart", true)
    end

    local v2 = nil
    local v3 = nil

    for i, j in u46, v2, v3 do
        Attribute = a1:GetAttribute(j) or v1 and v1:GetAttribute(j)

        if type(Attribute) == "string" then
            return Attribute
        end
    end

    return nil
end

local function claim(a1, a2, a3) -- Line: 195; types: a1: table, a2: userdata, a3: string
    a1.takenBy[a2] = a3
    a1.taken[a3] = (a1.taken[a3] or 0) + 1
end

local function addNode(a1, a2)
    -- Line: 200
    -- upvalues: takenCellOf (val), u52 (ref), u55 (ref)
    -- types: a1: table, a2: userdata
    if a1.takenBy[a2] then
        return
    end

    local v1 = takenCellOf(a2)

    if not v1 then
        task.delay(
            0.5,
            function() -- Line: 210; upvalues: u52 (upval), a1 (val), a2 (val), takenCellOf (upval), u55 (upval)
                if u52 == a1 and a2.Parent and not a1.takenBy[a2] then
                    local v1 = takenCellOf(a2)

                    if v1 then
                        a1.takenBy[a2] = v1
                        a1.taken[v1] = (a1.taken[v1] or 0) + 1
                        u55 = true
                    end
                end
            end
        )
        return
    end

    a1.takenBy[a2] = v1
    a1.taken[v1] = (a1.taken[v1] or 0) + 1
end

local function removeNode(a1, a2) -- Line: 221; types: a1: table, a2: userdata
    local v1 = a1.takenBy[a2]

    if not v1 then
        return
    end

    a1.takenBy[a2] = nil
    local v2 = (a1.taken[v1] or 1) - 1
    a1.taken[v1] = if not (v2 > 0) then nil else v2
end

local function dropIndex() -- Line: 231; upvalues: u52 (ref)
    local v1 = u52
    u52 = nil

    if v1 then
        for i, j in v1.connections do
            j:Disconnect()
        end
    end
end

local function indexIsland(a1)
    -- Line: 242
    -- upvalues: addBlock (val), u55 (ref), addNode (val), u52 (ref)
    -- types: a1: userdata
    local Blocks = a1:FindFirstChild("Blocks")
    local Attribute = a1:GetAttribute("IslandOrigin")

    if Blocks and typeof(Attribute) == "Vector3" then
        local Nodes = a1:FindFirstChild("Nodes")
        local u16 = {ready = false, blocks = Blocks, nodes = Nodes, origin = Attribute}
        u16.byKey = {}
        u16.keyOf = {}
        u16.waters = {}
        u16.taken = {}
        u16.takenBy = {}
        u16.connections = {}

        table.insert(
            u16.connections,
            (Blocks.ChildAdded:Connect(function(a1) -- Line: 263; upvalues: addBlock (upval), u16 (val), u55 (upval)
                addBlock(u16, a1)

                u55 = true
            end))
        )

        table.insert(
            u16.connections,
            (Blocks.ChildRemoved:Connect(function(a1) -- Line: 270; upvalues: u16 (val), u55 (upval)
                local v1 = u16
                local v2 = v1.keyOf[a1]

                if v2 then
                    v1.keyOf[a1] = nil

                    if v1.byKey[v2] == a1 then
                        v1.byKey[v2] = nil
                    end

                    if v1.waters[v2] == a1 then
                        v1.waters[v2] = nil
                    end
                end

                u55 = true
            end))
        )

        if Nodes then
            table.insert(
                u16.connections,
                (Nodes.ChildAdded:Connect(function(a1) -- Line: 278; upvalues: addNode (upval), u16 (val), u55 (upval)
                    addNode(u16, a1)

                    u55 = true
                end))
            )

            table.insert(
                u16.connections,
                (Nodes.ChildRemoved:Connect(function(a1) -- Line: 285; upvalues: u16 (val), u55 (upval)
                    local v1 = u16.takenBy[a1]

                    if v1 then
                        u16.takenBy[a1] = nil
                        local v2 = (u16.taken[v1] or 1) - 1
                        u16.taken[v1] = if not (v2 > 0) then nil else v2
                    end

                    u55 = true
                end))
            )
        end

        task.defer(function()
            -- Line: 293
            -- upvalues: Blocks (val), u52 (upval), u16 (val), addBlock (upval), Nodes (val), addNode (upval)
            -- upvalues: u55 (upval)
            local v1 = 0

            for i, j in Blocks:GetChildren() do
                if u52 ~= u16 then
                    return
                end

                addBlock(u16, j)

                v1 = v1 + 1

                if v1 % 3000 == 0 then
                    task.wait()
                end
            end

            if Nodes then
                for k, n in Nodes:GetChildren() do
                    if u52 ~= u16 then
                        return
                    end

                    addNode(u16, n)

                    v1 = v1 + 1

                    if v1 % 3000 == 0 then
                        task.wait()
                    end
                end
            end

            u16.ready = true
            u55 = true
        end)

        return u16
    end

    return nil
end

local function standingLevel(a1) -- Line: 328; upvalues: LocalPlayer (val), Grid (val); types: a1: vector
    local Character = LocalPlayer.Character
    local Character_2 = LocalPlayer.Character
    local v1 = if not Character_2 then nil else Character_2:FindFirstChild("HumanoidRootPart")
    local Humanoid = if not Character then nil else Character:FindFirstChildOfClass("Humanoid")

    if not v1 then
        return nil
    end

    return (math.round((v1.Position.Y - (if not Humanoid then 0 else Humanoid.HipHeight) - v1.Size.Y / 2 - a1.Y + Grid.CellSize / 2) / Grid.CellSize))
end

local function onWorkedFloor(a1, a2) -- Line: 340; upvalues: Config (val); types: a1: number, a2: number?
    local v1 = true

    if a2 ~= nil then
        v1 = (math.abs(a1 - a2)) <= Config.Build.Farm.HighlightFloorCells
    end

    return v1
end

local function makePlate(a1, a2, a3, a4) -- Line: 344; types: a1: userdata, a2: userdata, a3: number, a4: userdata
    local Part = Instance.new("Part")
    Part.Anchored = true
    Part.CanCollide = false
    Part.CanQuery = false
    Part.CanTouch = false
    Part.CastShadow = false
    Part.Material = Enum.Material.SmoothPlastic
    Part.Color = a2
    Part.Transparency = a3
    Part.Size = Vector3.new(a1.Size.X - 0.1, 0.06, a1.Size.Z - 0.1)
    Part.CFrame = CFrame.new(a1.Position + Vector3.new(0, a1.Size.Y / 2 + 0.04, 0))
    Part.Parent = a4

    return Part
end

local function clearPlates() -- Line: 360; upvalues: u53 (ref), u54 (val)
    if u53 then
        u53:Destroy()

        u53 = nil
    end

    table.clear(u54)
end

local function feetCell(a1)
    -- Line: 369
    -- upvalues: LocalPlayer (val), Grid (val), standingLevel (val)
    -- types: a1: table
    local v1
    local Character = LocalPlayer.Character

    if not (if not Character then nil else Character:FindFirstChild("HumanoidRootPart")) then
        return nil, nil, nil
    end

    local v2 = Grid.worldToCell(a1.origin, v1.Position)

    return v2.x, (standingLevel(a1.origin)), v2.z
end

local function wantedSoil(a1, a2)
    -- Line: 382
    -- upvalues: LocalPlayer (val), Config (val), Grid (val), standingLevel (val), RequiredGround (val)
    -- types: a1: table, a2: table
    local v1, x, z
    local Character = LocalPlayer.Character
    local Character_2 = LocalPlayer.Character
    local v2 = if not Character_2 then nil else Character_2:FindFirstChild("HumanoidRootPart")
    local Humanoid = if not Character then nil else Character:FindFirstChildOfClass("Humanoid")

    if not v2 then
        return
    end

    local Position = v2.Position
    local v3 = Position
        - Vector3.new(0, (if not Humanoid then 0 else Humanoid.HipHeight) + v2.Size.Y / 2, 0)
    local v4 = Config.Player.BuildReachCells * Grid.CellSize
    local Character_3 = LocalPlayer.Character
    v2 = if not Character_3 then nil else Character_3:FindFirstChild("HumanoidRootPart")

    if v2 then
        local v5 = Grid.worldToCell(a1.origin, v2.Position)
        x = v5.x
        v1 = standingLevel(a1.origin)
        z = v5.z
    else
        x = nil
        v1 = nil
        z = nil
    end

    if x and v1 and z then
        local v6, v7, v8, v9, v10, v11, v12, v13
        local BuildReachCells = Config.Player.BuildReachCells
        local HighlightFloorCells = Config.Build.Farm.HighlightFloorCells
        local v14 = 0
        local v15 = x - BuildReachCells
        local v16 = x + BuildReachCells
        local v17, v18 = a1, a2

        for i = v15, v16 do
            v7 = z - BuildReachCells
            v6 = z + BuildReachCells

            for j = v7, v6 do
                v9 = v1 - HighlightFloorCells
                v8 = v1 + HighlightFloorCells

                for k = v9, v8 do
                    v10 = k - 1
                    v11 = ("%*,%*,%*"):format(i, v10, j)
                    v10 = v17.byKey[v11]

                    if v10 and (v10:GetAttribute("BlockId")) == RequiredGround and v14 < 900 then
                        v12 = ("%*,%*,%*"):format(i, k, j)

                        if not v17.byKey[v12] and not v17.taken[v12] then
                            v13 = true

                            if v1 ~= nil then
                                v13 = (math.abs(k - v1))
                                    <= Config.Build.Farm.HighlightFloorCells
                            end

                            if v13
                                and not (v4
                                    < (Grid.cellToWorld(v17.origin, Grid.cell(i, k, j)) - v3).Magnitude) then
                                v14 = v14 + 1
                                v18[v11] = v10
                            end
                        end
                    end
                end
            end
        end
    end
end

local function wantedWater(a1, a2)
    -- Line: 423
    -- upvalues: LocalPlayer (val), Grid (val), standingLevel (val), Config (val), u33 (val)
    -- types: a1: table, a2: table
    local v1, x, z
    local Character = LocalPlayer.Character
    local v2 = if not Character then nil else Character:FindFirstChild("HumanoidRootPart")

    if v2 then
        local v3 = Grid.worldToCell(a1.origin, v2.Position)
        x = v3.x
        v1 = standingLevel(a1.origin)
        z = v3.z
    else
        x = nil
        v1 = nil
        z = nil
    end

    if x and z then
        local Attribute, v4, v5, v6, v7, v8, v9, v10, v11, v12, v13, v14, v15
        local WaterTintRadiusCells = Config.Build.Farm.WaterTintRadiusCells
        local HydrationRadiusCells = Config.Build.Farm.HydrationRadiusCells
        local v16 = 0
        local waters = a1.waters
        local v17 = nil
        local v18 = nil
        local v19, v20 = a1, a2

        for i, j in waters, v17, v18 do
            v7, v8, v9 = string.match(i, "^(-?%d+),(-?%d+),(-?%d+)$")
            v4 = tonumber(v7)
            v5 = tonumber(v8)
            v6 = tonumber(v9)

            if v4 and v5 and v6 then
                v7 = math.abs(v4 - x)

                if not (WaterTintRadiusCells + HydrationRadiusCells < v7) then
                    v7 = math.abs(v6 - z)

                    if not (WaterTintRadiusCells + HydrationRadiusCells < v7) then
                        Attribute = j:GetAttribute("WaterUses")

                        if type(Attribute) ~= "number" then
                            for k = -HydrationRadiusCells, HydrationRadiusCells do
                                v7 = v4 + k

                                if not (WaterTintRadiusCells < math.abs(v7 - x)) then
                                    for n = -HydrationRadiusCells, HydrationRadiusCells do
                                        v10 = v6 + n

                                        if not (WaterTintRadiusCells < math.abs(v10 - z)) then
                                            for m = -HydrationRadiusCells, HydrationRadiusCells do
                                                v11 = v5 + m
                                                v12 = ("%*,%*,%*"):format(v7, v11, v10)
                                                v13 = v19.byKey[v12]

                                                if v13
                                                    and not v20[v12]
                                                    and v16 < 900
                                                    and u33[v13:GetAttribute("BlockId")] then
                                                    v15 = v11 + 1
                                                    v14 = true

                                                    if v1 ~= nil then
                                                        v14 = (math.abs(v15 - v1))
                                                            <= Config.Build.Farm.HighlightFloorCells
                                                    end

                                                    if v14
                                                        and not v19.byKey[("%*,%*,%*"):format(v7, v11 + 1, v10)] then
                                                        v16 = v16 + 1
                                                        v20[v12] = v13
                                                    end
                                                end
                                            end
                                        end
                                    end
                                end
                            end
                        elseif not (Attribute <= 0) then
                            for i5 = -HydrationRadiusCells, HydrationRadiusCells do
                                v7 = v4 + i5

                                if not (WaterTintRadiusCells < math.abs(v7 - x)) then
                                    for i6 = -HydrationRadiusCells, HydrationRadiusCells do
                                        v10 = v6 + i6

                                        if not (WaterTintRadiusCells < math.abs(v10 - z)) then
                                            for i7 = -HydrationRadiusCells, HydrationRadiusCells do
                                                v11 = v5 + i7
                                                v12 = ("%*,%*,%*"):format(v7, v11, v10)
                                                v13 = v19.byKey[v12]

                                                if v13
                                                    and not v20[v12]
                                                    and v16 < 900
                                                    and u33[v13:GetAttribute("BlockId")] then
                                                    v15 = v11 + 1
                                                    v14 = true

                                                    if v1 ~= nil then
                                                        v14 = (math.abs(v15 - v1))
                                                            <= Config.Build.Farm.HighlightFloorCells
                                                    end

                                                    if v14
                                                        and not v19.byKey[("%*,%*,%*"):format(v7, v11 + 1, v10)] then
                                                        v16 = v16 + 1
                                                        v20[v12] = v13
                                                    end
                                                end
                                            end
                                        end
                                    end
                                end
                            end
                        end
                    end
                end
            end
        end
    end
end

local function redraw()
    -- Line: 476
    -- upvalues: u57 (ref), u55 (ref), u52 (ref), u51 (ref), wantedSoil (val), wantedWater (val), u53 (ref), u54 (val)
    -- upvalues: u43 (val), u38 (val), makePlate (val)
    u57 = os.clock()
    u55 = false
    local v1 = u52

    if v1 and v1.ready and u51 then
        local v2 = {}

        if u51 ~= "Soil" then
            wantedWater(v1, v2)
        else
            wantedSoil(v1, v2)
        end

        if not u53 then
            v1 = Instance.new("Folder")
            v1.Name = if u51 ~= "Soil" then "WaterZone" else "OpenSoil"
            v1.Parent = workspace
            u53 = v1
        end

        local v3 = u53
        local v4 = nil
        local v5 = nil

        for i, j in u54, v4, v5 do
            if not v2[i] or not j.Parent then
                j:Destroy()

                u54[i] = nil
            end
        end

        local v6 = if u51 ~= "Soil" then u38 else u43
        v4 = if u51 ~= "Soil" then 0.82 else 0.55

        for k, n in v2 do
            if not u54[k] then
                u54[k] = (makePlate(n, v6, v4, v3))
            end
        end
    end
end

local function update()
    -- Line: 511
    -- upvalues: modeForHand (val), u51 (ref), u53 (ref), u54 (val), u56 (ref), u55 (ref), nearestIsland (val)
    -- upvalues: u52 (ref), indexIsland (val), LocalPlayer (val), Grid (val), standingLevel (val), u57 (ref)
    -- upvalues: redraw (val)
    local v1, v2, x, z
    local v3 = modeForHand()

    if v3 ~= u51 then
        u51 = v3

        if u53 then
            u53:Destroy()

            u53 = nil
        end

        table.clear(u54)

        u56 = nil
        u55 = true
    end

    if not u51 then
        return
    end

    v3 = nearestIsland()

    if not v3 then
        v1 = u52
        u52 = nil

        if v1 then
            for m, i5 in v1.connections do
                i5:Disconnect()
            end
        end

        if u53 then
            u53:Destroy()

            u53 = nil
        end

        table.clear(u54)

        return
    end

    if not u52 then
        v1 = u52
        u52 = nil

        if v1 then
            for i, j in v1.connections do
                j:Disconnect()
            end
        end

        if u53 then
            u53:Destroy()

            u53 = nil
        end

        table.clear(u54)

        u52 = indexIsland(v3)
        u56 = nil
    elseif u52.blocks.Parent ~= v3 then
        v1 = u52
        u52 = nil

        if v1 then
            for k, n in v1.connections do
                n:Disconnect()
            end
        end

        if u53 then
            u53:Destroy()

            u53 = nil
        end

        table.clear(u54)

        u52 = indexIsland(v3)
        u56 = nil
    end

    v3 = u52

    if not v3 then
        return
    end

    local Character = LocalPlayer.Character
    local v4 = if not Character then nil else Character:FindFirstChild("HumanoidRootPart")

    if v4 then
        local v5 = Grid.worldToCell(v3.origin, v4.Position)
        x = v5.x
        v2 = standingLevel(v3.origin)
        z = v5.z
    else
        x = nil
        v2 = nil
        z = nil
    end

    v3 = if not x then
        nil
    else
        if not v2 then nil else if not z then nil else ("%*,%*,%*"):format(x, v2, z)
    local v6 = os.clock()

    if v3 ~= u56 then
        if 0.25 <= v6 - u57 or 2 <= v6 - u57 then
            u56 = v3
            redraw()
        end
    elseif not u55 then
        if 2 <= v6 - u57 then
            u56 = v3
            redraw()
        end
    elseif 0.25 <= v6 - u57 or 2 <= v6 - u57 then
        u56 = v3
        redraw()
    end
end

function v1.start()
    -- Line: 549
    -- upvalues: u25 (val), update (val), SettingsController (val), u51 (ref), modeForHand (val)
    u25.onChanged(function() -- Line: 550; upvalues: update (upval)
        update()
    end)

    SettingsController.onChanged(function(a1) -- Line: 554; upvalues: update (upval); types: a1: string
        if a1 == "PlowHints" then
            update()
        end
    end)

    task.spawn(function() -- Line: 562; upvalues: u51 (upval), modeForHand (upval), update (upval)
        while true do
            task.wait(0.1)

            if u51 or modeForHand() then
                update()
            end
        end
    end)
end

return v1