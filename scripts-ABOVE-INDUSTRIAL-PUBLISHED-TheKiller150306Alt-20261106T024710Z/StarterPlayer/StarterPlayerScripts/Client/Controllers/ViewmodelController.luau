-- Script path: game:GetService("Players").TheKiller150306Alt.PlayerScripts.Client.Controllers.ViewmodelController
-- Decompile time: 1.97 ms

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local Workspace = game:GetService("Workspace")
local Shared = (game:GetService("ReplicatedStorage")):WaitForChild("Shared")
local Config = require(Shared.Config)
local v1 = {}
local LocalPlayer = Players.LocalPlayer
local u29 = nil
local u30 = nil

local function destroyCopy() -- Line: 35; upvalues: u30 (ref)
    if u30 then
        u30:Destroy()

        u30 = nil
    end
end

local function makeCopy(a1) -- Line: 44; types: a1: userdata
    local v1 = a1:Clone()
    local Descendants = v1:GetDescendants()

    table.insert(Descendants, v1)

    local v2 = nil
    local v3 = nil

    for i, j in Descendants, v2, v3 do
        if j:IsA("JointInstance") or j:IsA("WeldConstraint") or j:IsA("Constraint") then
            j:Destroy()
        elseif j:IsA("BasePart") then
            j.Anchored = true
            j.CanCollide = false
            j.CanQuery = false
            j.CanTouch = false
            j.CastShadow = false
            j.Massless = true
            j.LocalTransparencyModifier = 0
        end
    end

    v1.Name = "Viewmodel"

    return v1
end

local function pivotOf(a1) -- Line: 74; types: a1: userdata
    if a1:IsA("Model") then
        return a1:GetPivot()
    end

    if a1:IsA("BasePart") then
        return a1.CFrame
    end

    return nil
end

local function place(a1, a2) -- Line: 83; types: a1: userdata, a2: userdata
    if a1:IsA("Model") then
        a1:PivotTo(a2)
        return
    end

    if a1:IsA("BasePart") then
        a1.CFrame = a2
    end
end

local function isFirstPerson(a1) -- Line: 91; upvalues: Config (val); types: a1: userdata
    return (a1.Focus.Position - a1.CFrame.Position).Magnitude
        < Config.Appearance.Viewmodel.firstPersonStuds
end

local function step()
    -- Line: 95
    -- upvalues: Workspace (val), LocalPlayer (val), Config (val), u30 (ref), u29 (ref), makeCopy (val)
    local CurrentCamera = Workspace.CurrentCamera
    local Character = LocalPlayer.Character
    local Head = Character and Character:FindFirstChild("Head")
    local HeldTool = Character and Character:FindFirstChild("HeldTool")

    if CurrentCamera and Head and Head:IsA("BasePart") and HeldTool then
        local v1 = (CurrentCamera.Focus.Position - CurrentCamera.CFrame.Position).Magnitude
            < Config.Appearance.Viewmodel.firstPersonStuds

        if v1 then
            if HeldTool ~= u29 or not u30 then
                if u30 then
                    u30:Destroy()

                    u30 = nil
                end

                u29 = HeldTool
                u30 = makeCopy(HeldTool)
                u30.Parent = CurrentCamera
            end

            local CFrame_2 = if not HeldTool:IsA("Model") then
                if not HeldTool:IsA("BasePart") then nil else HeldTool.CFrame
            else
                HeldTool:GetPivot()

            if CFrame_2 and u30 then
                local offset = Config.Appearance.Viewmodel.offset
                v1 = Head.CFrame:ToObjectSpace(CFrame_2)
                local v2 = u30
                local v3 = CurrentCamera.CFrame
                    * CFrame.new(offset.x, offset.y, offset.z)
                    * v1

                if v2:IsA("Model") then
                    v2:PivotTo(v3)
                    return
                end

                if v2:IsA("BasePart") then
                    v2.CFrame = v3
                end

                return
            end

            return
        end
    end

    if u30 then
        u30:Destroy()

        u30 = nil
    end

    u29 = nil
end

function v1.start() -- Line: 125; upvalues: RunService (val), step (val)
    RunService:BindToRenderStep("Viewmodel", Enum.RenderPriority.Camera.Value + 1, step)
end

return v1