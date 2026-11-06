-- Script path: game:GetService("StarterPlayer").StarterPlayerScripts.Client.Controllers.HitFeedbackController
-- Decompile time: 4.42 ms

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local Shared = (game:GetService("ReplicatedStorage")):WaitForChild("Shared")
local Remotes = require(Shared.Remotes)
local u27 = require(script.Parent.RumbleController)
local SettingsController = require(script.Parent.SettingsController)
local v1 = {}
local u36 = Remotes.get(Remotes.HitConfirmed)
local u37 = {}

local function shake(a1)
    -- Line: 32
    -- upvalues: SettingsController (val), u37 (val), RunService (val)
    -- types: a1: userdata
    if SettingsController.get("CameraShake") == "Off" or u37[a1] then
        return
    end

    local u12 = if not a1:IsA("Model") then nil else a1
    local u19 = if not a1:IsA("BasePart") then nil else a1

    if not u12 and not u19 then
        return
    end

    local Pivot = if not u12 then u19.CFrame else u12:GetPivot()
    local u29 = {}

    if u19 then
        for i, j in u19:GetDescendants() do
            if j:IsA("BasePart") then
                table.insert(
                    u29,
                    {piece = j, rest = j.CFrame}
                )
            end
        end
    end

    u37[a1] = true
    local u61 = os.clock()
    local u62 = nil
    u62 = (RunService.RenderStepped:Connect(function()
        -- Line: 66
        -- upvalues: u61 (val), a1 (val), u62 (ref), u37 (upval), u12 (val), Pivot (val), u19 (val), u29 (val)
        -- upvalues: SettingsController (upval)
        local v1 = (os.clock() - u61) / 0.16

        if a1.Parent and not (v1 >= 1) then
            local v2 = if SettingsController.get("CameraShake") ~= "Reduced" then
                0.22
            else
                0.08800000000000001
            local v3 = (1 - v1) * v2
            v2 = Vector3.new((math.random() - 0.5) * v3, (math.random() - 0.5) * v3, ((math.random()) - 0.5) * v3)

            if u12 then
                u12:PivotTo(Pivot + v2)
                return
            end

            if u19 then
                u19.CFrame = Pivot + v2

                for i, j in u29 do
                    j.piece.CFrame = j.rest + v2
                end
            end

            return
        end

        if u62 then
            u62:Disconnect()
        end

        u37[a1] = nil

        if a1.Parent then
            if u12 then
                u12:PivotTo(Pivot)
                return
            end

            if u19 then
                u19.CFrame = Pivot

                for k, n in u29 do
                    n.piece.CFrame = n.rest
                end
            end
        end
    end))
end

local function burst(a1) -- Line: 108; types: a1: userdata
    local v1
    local HitEffect = a1:FindFirstChild("HitEffect", true)

    if not HitEffect then
        return
    end

    for i, j in HitEffect:GetDescendants() do
        if j:IsA("ParticleEmitter") then
            v1 = 0 < j.Rate and math.ceil(j.Rate) or 12
            j:Emit(v1)
        end
    end

    if HitEffect:IsA("ParticleEmitter") then
        HitEffect:Emit(12)
    end
end

local u43 = Vector2.new(1.8, 0.16)
local u48 = Color3.fromRGB(22, 26, 30)
local u53 = Color3.fromRGB(90, 220, 110)
local u54 = {}

local function showHealth(a1)
    -- Line: 139
    -- upvalues: u54 (val), Players (val), u43 (val), u48 (val), u53 (val)
    -- types: a1: userdata
    local Attribute = a1:GetAttribute("MaxHP")

    if type(Attribute) == "number"
        and not (Attribute <= 0)
        and type((a1:GetAttribute("HP"))) == "number" then
        if u54[a1] then
            return
        end

        local PlayerGui = Players.LocalPlayer:FindFirstChildOfClass("PlayerGui")

        if not PlayerGui then
            return
        end

        local BillboardGui = Instance.new("BillboardGui")
        BillboardGui.Name = "BlockHealth"
        BillboardGui.Adornee = a1
        BillboardGui.Size = UDim2.fromScale(u43.X, u43.Y)
        BillboardGui.StudsOffsetWorldSpace = Vector3.new(0, a1.Size.Y / 2 + 0.6, 0)
        BillboardGui.AlwaysOnTop = false
        BillboardGui.LightInfluence = 0
        BillboardGui.ResetOnSpawn = false
        BillboardGui.Active = false
        local Frame_2 = Instance.new("Frame")
        Frame_2.Size = UDim2.fromScale(1, 1)
        Frame_2.BackgroundColor3 = u48
        Frame_2.BackgroundTransparency = 0.25
        Frame_2.BorderSizePixel = 0
        Frame_2.Parent = BillboardGui
        local Frame = Instance.new("Frame")
        Frame.BackgroundColor3 = u53
        Frame.BorderSizePixel = 0
        Frame.Parent = Frame_2
        local u60 = {}

        local function update()
            -- Line: 182
            -- upvalues: a1 (val), u60 (val), u54 (upval), BillboardGui (val), Frame (val)
            local Attribute = a1:GetAttribute("HP")
            local Attribute_2 = a1:GetAttribute("MaxHP")

            if type(Attribute) == "number"
                and type(Attribute_2) == "number"
                and not (Attribute_2 <= 0)
                and not (Attribute_2 <= Attribute)
                and a1.Parent then
                Frame.Size = UDim2.fromScale(math.clamp(Attribute / Attribute_2, 0, 1), 1)
                return
            end

            for i, j in u60 do
                j:Disconnect()
            end

            u54[a1] = nil
            BillboardGui:Destroy()
        end

        table.insert(u60, ((a1:GetAttributeChangedSignal("HP")):Connect(update)))

        table.insert(
            u60,
            (a1.Destroying:Connect(function()
                -- Line: 175
                -- upvalues: u60 (val), u54 (upval), a1 (val), BillboardGui (val)
                for i, j in u60 do
                    j:Disconnect()
                end

                u54[a1] = nil
                BillboardGui:Destroy()
            end))
        )

        table.insert(
            u60,
            (a1.AncestryChanged:Connect(function()
                -- Line: 195
                -- upvalues: a1 (val), u60 (val), u54 (upval), BillboardGui (val)
                if not a1:IsDescendantOf(workspace) then
                    for i, j in u60 do
                        j:Disconnect()
                    end

                    u54[a1] = nil
                    BillboardGui:Destroy()
                end
            end))
        )

        u54[a1] = BillboardGui
        BillboardGui.Parent = PlayerGui

        if not (Attribute <= a1:GetAttribute("HP")) then
            update()
            return
        end

        Frame.Size = UDim2.fromScale(1, 1)
        task.delay(
            0.5,
            function() -- Line: 208; upvalues: u54 (upval), a1 (val), BillboardGui (val), update (val)
                if u54[a1] == BillboardGui then
                    update()
                end
            end
        )
    end
end

function v1.start() -- Line: 218; upvalues: u36 (val), burst (val), u27 (val), showHealth (val), shake (val)
    u36.OnClientEvent:Connect(function(a1, a2)
        -- Line: 219
        -- upvalues: burst (upval), u27 (upval), showHealth (upval), shake (upval)
        -- types: a1: userdata?, a2: string
        if not a1 then
            return
        end

        burst(a1)
        u27.pulse(if a2 ~= "Destroyed" then "Hit" else "Break")

        if a2 == "Hit" and a1:IsA("BasePart") and a1:GetAttribute("CellKey") then
            showHealth(a1)
        end

        if a2 == "Destroyed" then
            return
        end

        shake(a1)
    end)
end

return v1