-- Script path: game:GetService("Players").TheKiller150306Alt.PlayerScripts.Client.Controllers.GuideBeam
-- Decompile time: 4.69 ms

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local Workspace = game:GetService("Workspace")
local Shared = (game:GetService("ReplicatedStorage")):WaitForChild("Shared")
local Config = require(Shared.Config)
local u33 = require(script.Parent.Parent.Ui)
local TutorialArrow = require(script.Parent.TutorialArrow)
local v1 = {}
local LocalPlayer = Players.LocalPlayer
local u41 = {}

function u41.HubPond() -- Line: 34; upvalues: Config (val)
    return Config.Hub.Origin + Config.Hub.PondOffset
end

local u43 = nil
local u44 = nil
local u45 = nil
local u46 = nil
local u47 = {}
local u48 = nil
local u49 = 0
local u50 = nil

local function clear() -- Line: 48; upvalues: u44 (ref), u45 (ref), u46 (ref), u48 (ref), u47 (val)
    if u44 then
        u44:Destroy()
    end

    if u45 then
        u45:Destroy()
    end

    if u46 then
        u46:Destroy()
    end

    u44 = nil
    u45 = nil
    u46 = nil
    u48 = nil

    table.clear(u47)
end

local function findNpc(a1) -- Line: 63; upvalues: Workspace (val); types: a1: string
    local Hub = Workspace:FindFirstChild("Hub")
    local NPC = Hub and Hub:FindFirstChild("NPC")
    local v1 = NPC and NPC:FindFirstChild(a1)
    local HumanoidRootPart = v1 and v1:FindFirstChild("HumanoidRootPart")

    if HumanoidRootPart and HumanoidRootPart:IsA("BasePart") then
        return HumanoidRootPart
    end

    return nil
end

local function draw(a1, a2, a3)
    -- Line: 72
    -- upvalues: u44 (ref), u45 (ref), u46 (ref), u48 (ref), u47 (val), Workspace (val), u33 (val), TutorialArrow (val)
    -- types: a1: userdata?, a2: vector?, a3: userdata
    local v1

    if u44 then
        u44:Destroy()
    end

    if u45 then
        u45:Destroy()
    end

    if u46 then
        u46:Destroy()
    end

    u44 = nil
    u45 = nil
    u46 = nil
    u48 = nil

    table.clear(u47)

    local Folder = Instance.new("Folder")
    Folder.Name = "TutorialGuide"
    Folder.Parent = Workspace
    local Attachment = Instance.new("Attachment")
    Attachment.Name = "TutorialGuideFrom"
    Attachment.Position = Vector3.new(0, -1.5, 0)
    Attachment.Parent = a3
    local Attachment_2 = Instance.new("Attachment")
    Attachment_2.Name = "TutorialGuideTo"

    if not a1 then
        if not a1 then
            Attachment_2.WorldPosition = a2
            Attachment_2.Parent = Workspace.Terrain
            v1 = a2 + Vector3.new(0, 5, 0)
        else
            Attachment_2.Position = Vector3.new(0, -a1.Size.Y / 2 + 1, 0)
            Attachment_2.Parent = a1
            v1 = a1.Position + Vector3.new(0, a1.Size.Y / 2 + 2, 0)
        end
    elseif a1.Name == "HumanoidRootPart" then
        Attachment_2.Position = Vector3.new(0, -1.5, 0)
        Attachment_2.Parent = a1
        v1 = a1.Position + Vector3.new(0, 4.5, 0)
    elseif not a1 then
        Attachment_2.WorldPosition = a2
        Attachment_2.Parent = Workspace.Terrain
        v1 = a2 + Vector3.new(0, 5, 0)
    else
        Attachment_2.Position = Vector3.new(0, -a1.Size.Y / 2 + 1, 0)
        Attachment_2.Parent = a1
        v1 = a1.Position + Vector3.new(0, a1.Size.Y / 2 + 2, 0)
    end

    local Beam = Instance.new("Beam")
    Beam.Attachment0 = Attachment
    Beam.Attachment1 = Attachment_2
    Beam.Color = ColorSequence.new(u33.Palette.Gold)
    Beam.Transparency = NumberSequence.new({
        NumberSequenceKeypoint.new(0, 0.6),
        NumberSequenceKeypoint.new(0.15, 0.15),
        (NumberSequenceKeypoint.new(1, 0.15)),
    })
    Beam.Width0 = 0.45
    Beam.Width1 = 0.45
    Beam.LightEmission = 1
    Beam.FaceCamera = true
    Beam.Segments = 1
    Beam.Parent = Folder
    local v2 = TutorialArrow.make(Folder, v1, 0)

    if v2 then
        table.insert(u47, v2)
    end

    u44 = Folder
    u45 = Attachment
    u46 = Attachment_2
    u48 = a1
end

local function portalBody(a1) -- Line: 126; types: a1: userdata?
    if a1 and a1:IsA("BasePart") then
        return a1
    end

    if a1 and a1:IsA("Model") then
        local HB = a1:FindFirstChild("HB")

        if HB and HB:IsA("BasePart") then
            return HB
        end

        return a1.PrimaryPart or a1:FindFirstChildWhichIsA("BasePart", true)
    end

    return nil
end

local function findHomePortal() -- Line: 141; upvalues: Workspace (val), portalBody (val), Config (val)
    local Hub = Workspace:FindFirstChild("Hub")
    return (portalBody(Hub and Hub:FindFirstChild(Config.Hub.AuthoredPortalName)))
end

local function findPortal() -- Line: 148; upvalues: LocalPlayer (val), Workspace (val), portalBody (val)
    local Character = LocalPlayer.Character
    local HumanoidRootPart = Character and Character:FindFirstChild("HumanoidRootPart")

    if HumanoidRootPart and HumanoidRootPart:IsA("BasePart") then
        local Magnitude, v1
        local v2 = nil
        local v3 = (1 / 0)

        for i, j in Workspace:GetChildren() do
            if string.match(j.Name, "^Island_") then
                v1 = portalBody(j:FindFirstChild("HUB"))

                if v1 then
                    Magnitude = (v1.Position - HumanoidRootPart.Position).Magnitude

                    if Magnitude < v3 then
                        v2 = v1
                        v3 = Magnitude
                    end
                end
            end
        end

        return v2
    end

    return nil
end

local function hubPondMarker() -- Line: 174; upvalues: Workspace (val)
    local Hub = Workspace:FindFirstChild("Hub")
    local Pond = Hub and Hub:FindFirstChild("Pond")

    if Pond and Pond:IsA("BasePart") then
        return Pond
    end

    return nil
end

local function locate(a1)
    -- Line: 181
    -- upvalues: Workspace (val), u41 (val), findPortal (val), portalBody (val), Config (val), findNpc (val)
    -- types: a1: string
    local v1

    if a1 == "HubPond" then
        local Hub = Workspace:FindFirstChild("Hub")
        local Pond = Hub and Hub:FindFirstChild("Pond")
        v1 = if not Pond then nil else if not Pond:IsA("BasePart") then nil else Pond

        if v1 then
            return v1.Position, v1
        end
    end

    v1 = u41[a1]

    if v1 then
        return v1(), nil
    end

    if a1 == "Portal" then
        v1 = findPortal()
    elseif a1 ~= "HomePortal" then
        v1 = findNpc(a1)
    else
        local Hub_2 = Workspace:FindFirstChild("Hub")
        v1 = portalBody(Hub_2 and Hub_2:FindFirstChild(Config.Hub.AuthoredPortalName))
    end

    return if not v1 then nil else v1.Position, v1
end

local function step()
    -- Line: 199
    -- upvalues: u43 (ref), LocalPlayer (val), u44 (ref), u45 (ref), u46 (ref), u48 (ref), u49 (ref)
    -- upvalues: TutorialArrow (val), u47 (val), locate (val), draw (val)
    local v1 = u43

    if not v1 then
        return
    end

    local Character = LocalPlayer.Character
    local HumanoidRootPart = Character and Character:FindFirstChild("HumanoidRootPart")
    local v2 = os.clock()
    local v3 = false

    if u44 ~= nil then
        v3 = false

        if u45 ~= nil then
            v3 = false

            if u45.Parent == HumanoidRootPart then
                v3 = false

                if u46 ~= nil then
                    v3 = false

                    if u46.Parent ~= nil then
                        v3 = true

                        if u48 ~= nil then
                            v3 = u48.Parent ~= nil
                        end
                    end
                end
            end
        end
    end

    if v3 and v2 < u49 then
        TutorialArrow.move(u47)
        return
    end

    if v2 < u49 then
        return
    end

    u49 = v2 + 0.5
    local v4, v5 = locate(v1)
    v2 = false

    if v4 ~= nil then
        v2 = false

        if HumanoidRootPart ~= nil then
            v2 = HumanoidRootPart:IsA("BasePart")
                and (HumanoidRootPart.Position - v4).Magnitude <= 400
        end
    end

    if v2 then
        if v3 and u48 == v5 then
            TutorialArrow.move(u47)
            return
        end

        draw(v5, if not v5 then v4 else nil, HumanoidRootPart)

        return
    end

    if u44 then
        u44:Destroy()
    end

    if u45 then
        u45:Destroy()
    end

    if u46 then
        u46:Destroy()
    end

    u44 = nil
    u45 = nil
    u46 = nil
    u48 = nil

    table.clear(u47)
end

function v1.set(a1)
    -- Line: 241
    -- upvalues: u43 (ref), u44 (ref), u45 (ref), u46 (ref), u48 (ref), u47 (val), u49 (ref), u50 (ref)
    -- upvalues: RunService (val), step (val)
    -- types: a1: string?
    if a1 == u43 then
        return
    end

    u43 = a1

    if u44 then
        u44:Destroy()
    end

    if u45 then
        u45:Destroy()
    end

    if u46 then
        u46:Destroy()
    end

    u44 = nil
    u45 = nil
    u46 = nil
    u48 = nil

    table.clear(u47)

    u49 = 0

    if a1 and not u50 then
        u50 = RunService.RenderStepped:Connect(step)
        return
    end

    if not a1 and u50 then
        u50:Disconnect()

        u50 = nil
    end
end

return v1