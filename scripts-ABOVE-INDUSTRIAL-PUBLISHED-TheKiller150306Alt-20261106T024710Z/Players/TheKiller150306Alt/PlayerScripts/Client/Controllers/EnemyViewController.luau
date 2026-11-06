-- Script path: game:GetService("Players").TheKiller150306Alt.PlayerScripts.Client.Controllers.EnemyViewController
-- Decompile time: 6.95 ms

local CollectionService = game:GetService("CollectionService")
local RunService = game:GetService("RunService")
local Workspace = game:GetService("Workspace")
local Shared = (game:GetService("ReplicatedStorage")):WaitForChild("Shared")
local Config = require(Shared.Config)
local u32 = require(script.Parent.SettingsController)
local v1 = {}
local u34 = {}
local u35 = nil

local function container() -- Line: 65; upvalues: u35 (ref), Workspace (val)
    if u35 and u35.Parent then
        return u35
    end

    local Folder = Instance.new("Folder")
    Folder.Name = "EnemyViews"
    Folder.Parent = Workspace
    u35 = Folder

    return Folder
end

local function animationsOff() -- Line: 76; upvalues: u32 (val)
    return u32.get("MachineAnimations") == "Off"
end

local function riders(a1) -- Line: 81; types: a1: userdata
    local v1 = {}

    for i, j in a1:GetDescendants() do
        if j:IsA("BasePart") then
            table.insert(v1, j)
        end
    end

    return v1
end

local function hideOriginals(a1, a2) -- Line: 91; types: a1: table, a2: boolean
    local v1
    local v2 = nil
    local v3 = nil

    for i, j in a1.pieces, v2, v3 do
        v1 = if not a2 then 0 else 1
        j.original.LocalTransparencyModifier = v1
    end
end

local function release(a1) -- Line: 98; types: a1: table
    for i, j in a1.connections do
        j:Disconnect()
    end

    table.clear(a1.connections)

    if a1.folder then
        for k, n in a1.pieces do
            n.original.LocalTransparencyModifier = 0
        end

        a1.folder:Destroy()

        a1.folder = nil
    end

    if a1.anchor then
        a1.anchor:Destroy()

        a1.anchor = nil
    end

    local Health = a1.hitbox:FindFirstChild("Health")

    if Health and Health:IsA("BillboardGui") then
        Health.Adornee = nil
    end

    table.clear(a1.pieces)

    a1.lastScale = 1
end

local function build(a1) -- Line: 121; upvalues: riders (val), u35 (ref), Workspace (val); types: a1: table
    local hitbox = a1.hitbox
    local v1 = riders(hitbox)

    if #v1 == 0 then
        return
    end

    local Model = Instance.new("Model")
    Model.Name = hitbox.Name
    local v2 = v1
    local v3 = nil
    local v4 = nil
    local v5 = a1

    for i, j in v2, v3, v4 do
        local u164 = j:Clone()

        if u164 then
            for k, n in u164:GetChildren() do
                if n:IsA("JointInstance") or n:IsA("WeldConstraint") or n:IsA("BasePart") then
                    n:Destroy()
                end
            end

            u164.Anchored = true
            u164.CanCollide = false
            u164.CanQuery = false
            u164.CanTouch = false
            u164.Parent = Model

            table.insert(
                v5.pieces,
                {
                    original = j,
                    copy = u164,
                    offset = hitbox.CFrame:ToObjectSpace(j.CFrame),
                    size = j.Size,
                }
            )

            for m, i5 in {"Color", "Transparency"} do
                table.insert(
                    v5.connections,
                    ((j:GetPropertyChangedSignal(i5)):Connect(function()
                        -- Line: 155
                        -- upvalues: u164 (val), i5 (val), j (val)
                        u164[i5] = j[i5]
                    end))
                )
            end
        end
    end

    v1 = Instance.new("Part")
    v1.Name = "ViewAnchor"
    v1.Size = Vector3.new(1, 1, 1)
    v1.Transparency = 1
    v1.Anchored = true
    v1.CanCollide = false
    v1.CanQuery = false
    v1.CanTouch = false
    v1.CFrame = hitbox.CFrame
    v1.Parent = Model
    v5.anchor = v1
    local Health = hitbox:FindFirstChild("Health")

    if Health and Health:IsA("BillboardGui") then
        Health.Adornee = v1
    end

    if not u35 or not u35.Parent then
        v2 = Instance.new("Folder")
        v2.Name = "EnemyViews"
        v2.Parent = Workspace
        u35 = v2
        v3 = v2
    else
        v3 = u35
    end

    Model.Parent = v3
    v5.folder = Model

    for i6, i7 in v5.pieces do
        i7.original.LocalTransparencyModifier = 1
    end
end

local function jellyScale(a1, a2) -- Line: 183; upvalues: Config (val); types: a1: table, a2: number
    local hopAt = a1.hopAt

    if a1.jelly and hopAt then
        local hopSecondsInAir = Config.Enemy.HubGuardians.hopSecondsInAir
        local v1 = a2 - hopAt

        if not (v1 < 0) and not (hopSecondsInAir <= 0) then
            if v1 < hopSecondsInAir then
                return math.sin((math.clamp(v1 / hopSecondsInAir, 0, 1)) * 3.141592653589793)
                    * 0.36
                    + 1
            end

            local v2 = v1 - hopSecondsInAir

            if v2 < 0.16 then
                return 1 - 0.52 * (1 - v2 / 0.16)
            end

            return 1
        end

        return 1
    end

    return 1
end

local function poseAt(a1, a2) -- Line: 204; types: a1: table, a2: number
    local v1, v2
    local snapshots = a1.snapshots
    local v3 = snapshots[1]

    if a2 <= v3.at then
        return v3.cframe
    end

    local v4 = #snapshots

    for i = 2, v4 do
        v3 = snapshots[i]

        if a2 <= v3.at then
            v1 = snapshots[i - 1]
            v2 = v3.at - v1.at

            return v1.cframe:Lerp(v3.cframe, if not (v2 > 0) then 1 else (a2 - v1.at) / v2)
        end
    end

    return snapshots[#snapshots].cframe
end

local function stretched(a1, a2, a3) -- Line: 223; types: a1: table, a2: number, a3: number
    local offset = a1.offset

    local function along(a1) -- Line: 225; upvalues: a3 (val), a2 (val); types: a1: vector
        return (math.sqrt((a1.X * a3) ^ 2 + (a1.Y * a2) ^ 2 + (a1.Z * a3) ^ 2))
    end

    local X = a1.size.X
    local RightVector = offset.RightVector
    local v1 = X
        * math.sqrt((RightVector.X * a3) ^ 2 + (RightVector.Y * a2) ^ 2 + (RightVector.Z * a3) ^ 2)
    local Y = a1.size.Y
    local UpVector = offset.UpVector
    local v2 = Y
        * math.sqrt((UpVector.X * a3) ^ 2 + (UpVector.Y * a2) ^ 2 + (UpVector.Z * a3) ^ 2)
    local Z_3 = a1.size.Z
    local v3 = -offset.LookVector

    return (Vector3.new(v1, v2, Z_3 * (math.sqrt((v3.X * a3) ^ 2 + (v3.Y * a2) ^ 2 + (v3.Z * a3) ^ 2))))
end

local u45 = {}
local u46 = {}

local function draw(a1, a2)
    -- Line: 238
    -- upvalues: poseAt (val), jellyScale (val), u45 (val), u46 (val), stretched (val)
    -- types: a1: table, a2: number
    local Position, copy_2, offset, size
    local v1 = a2 - 0.1
    local v2 = poseAt(a1, v1)
    local v3 = jellyScale(a1, v1)
    local at = a1.snapshots[#a1.snapshots].at

    if v3 == 1 and a1.lastScale == 1 then
        local posedAt = a1.posedAt

        if at + 0.1 < posedAt then
            return
        end
    end

    a1.posedAt = a2
    v1 = 1 / math.sqrt(v3)
    local v4 = v2 * CFrame.new(0, (v3 - 1) * a1.hitbox.Size.Y / 2, 0)
    local v5 = true

    if v3 == 1 then
        v5 = a1.lastScale ~= 1
    end

    local v6 = nil
    local v7 = nil
    local v8 = a1

    for i, j in a1.pieces, v6, v7 do
        offset = j.offset
        Position = offset.Position

        table.insert(u45, j.copy)
        table.insert(u46, v4 * CFrame.new(Position.X * v1, Position.Y * v3, Position.Z * v1) * offset.Rotation)

        if v5 then
            copy_2 = j.copy
            size = if v3 ~= 1 then stretched(j, v3, v1) else j.size
            copy_2.Size = size
        end
    end

    local anchor = v8.anchor

    if anchor then
        table.insert(u45, anchor)
        table.insert(u46, v2)
    end

    v8.lastScale = v3
end

local function track(a1) -- Line: 270; upvalues: u34 (val), Config (val); types: a1: userdata
    if a1:IsA("BasePart") and not u34[a1] then
        local v1 = Config.Enemy.Enemies[a1:GetAttribute("EnemyId")]
        local u15 = {lastScale = 1, posedAt = 0, hitbox = a1}
        local v2 = false

        if v1 ~= nil then
            v2 = v1.jelly == true
        end

        u15.jelly = v2
        u15.snapshots = {{at = os.clock(), cframe = a1.CFrame}}
        u15.pieces = {}
        u15.connections = {}
        u34[a1] = u15

        ;(a1:GetAttributeChangedSignal("Hop")):Connect(function() -- Line: 289; upvalues: u15 (val)
            u15.hopAt = os.clock()
        end)
    end
end

local function untrack(a1) -- Line: 294; upvalues: u34 (val), release (val); types: a1: userdata
    local v1 = u34[a1]

    if v1 then
        release(v1)

        u34[a1] = nil
    end
end

function v1.start()
    -- Line: 302
    -- upvalues: CollectionService (val), track (val), untrack (val), RunService (val), Workspace (val), u32 (val)
    -- upvalues: u34 (val), release (val), Config (val), build (val), draw (val), u45 (val), u46 (val)
    (CollectionService:GetInstanceAddedSignal("Enemy")):Connect(track)
    ;(CollectionService:GetInstanceRemovedSignal("Enemy")):Connect(untrack)

    for i, j in CollectionService:GetTagged("Enemy") do
        track(j)
    end

    RunService.RenderStepped:Connect(function()
        -- Line: 309
        -- upvalues: Workspace (upval), u32 (upval), u34 (upval), release (upval), Config (upval), build (upval)
        -- upvalues: draw (upval), u45 (upval), u46 (upval)
        local CFrame_2, snapshots, v1, v2
        local v3 = os.clock()
        local CurrentCamera = Workspace.CurrentCamera
        local Position = if not CurrentCamera then nil else CurrentCamera.CFrame.Position
        local v4 = u32.get("MachineAnimations") == "Off"
        local v5 = nil
        local v6 = nil

        for i, j in u34, v5, v6 do
            if i.Parent then
                CFrame_2 = i.CFrame
                snapshots = j.snapshots
                v1 = snapshots[#snapshots]

                if CFrame_2 ~= v1.cframe then
                    if 0.1 < v3 - v1.at then
                        table.insert(
                            snapshots,
                            {at = v3 - 0.016666666666666666, cframe = v1.cframe}
                        )
                    end

                    table.insert(
                        snapshots,
                        {at = v3, cframe = CFrame_2}
                    )

                    if #snapshots > 12 then
                        table.remove(snapshots, 1)
                    end
                end

                v1 = true

                if Position ~= nil then
                    v1 = (CFrame_2.Position - Position).Magnitude
                        <= Config.Appearance.MotionStuds
                end

                if v4 then
                    if j.folder then
                        release(j)
                    end
                elseif v1 then
                    if j.folder then
                        draw(j, v3)
                    elseif not (#snapshots < 2) then
                        build(j)

                        if j.folder then
                            draw(j, v3)
                        end
                    end
                elseif j.folder then
                    release(j)
                end
            else
                v2 = u34[i]

                if v2 then
                    release(v2)

                    u34[i] = nil
                end
            end
        end

        if #u45 > 0 then
            Workspace:BulkMoveTo(u45, u46, Enum.BulkMoveMode.FireCFrameChanged)
            table.clear(u45)
            table.clear(u46)
        end
    end)
end

return v1