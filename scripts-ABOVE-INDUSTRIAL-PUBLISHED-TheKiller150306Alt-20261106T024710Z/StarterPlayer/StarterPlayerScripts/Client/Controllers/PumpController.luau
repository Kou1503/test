-- Script path: game:GetService("Players").TheKiller150306Alt.PlayerScripts.Client.Controllers.PumpController
-- Decompile time: 1.93 ms

local CollectionService = game:GetService("CollectionService")
local RunService = game:GetService("RunService")
local Workspace = game:GetService("Workspace")
local Ui = require(script.Parent.Parent.Ui)
local v1 = {}
local u26 = Color3.fromRGB(90, 160, 235)
local u27 = {}

local function attach(a1) -- Line: 28; upvalues: u27 (val), Ui (val), u26 (val); types: a1: userdata
    if a1:IsA("BasePart") and not u27[a1] then
        local BillboardGui = Instance.new("BillboardGui")
        BillboardGui.Name = "PumpProgress"
        BillboardGui.Size = UDim2.fromOffset(180, 22)
        BillboardGui.StudsOffset = Vector3.new(0, a1.Size.Y / 2 + 1.3, 0)
        BillboardGui.AlwaysOnTop = false
        BillboardGui.MaxDistance = 60
        BillboardGui.LightInfluence = 0
        BillboardGui.Enabled = false
        BillboardGui.Adornee = a1
        BillboardGui.Parent = a1
        local v1 = Ui.bar(BillboardGui, UDim2.fromOffset(64, 9), UDim2.new(0.5, -32, 0.5, -4), u26)
        local TextLabel = Instance.new("TextLabel")
        TextLabel.Size = UDim2.fromScale(1, 1)
        TextLabel.BackgroundTransparency = 1
        TextLabel.FontFace = Ui.Font.Bold
        TextLabel.TextSize = 13
        TextLabel.TextColor3 = Ui.Palette.Text
        TextLabel.TextStrokeTransparency = 0.4
        TextLabel.Visible = false
        TextLabel.Parent = BillboardGui
        u27[a1] = {gui = BillboardGui, fill = v1, track = v1.Parent, hint = TextLabel}
    end
end

local function detach(a1) -- Line: 56; upvalues: u27 (val); types: a1: userdata
    local v1 = u27[a1]

    if v1 then
        v1.gui:Destroy()

        u27[a1] = nil
    end
end

function v1.start()
    -- Line: 64
    -- upvalues: CollectionService (val), attach (val), detach (val), RunService (val), Workspace (val), u27 (val)
    (CollectionService:GetInstanceAddedSignal("WaterPump")):Connect(attach)
    ;(CollectionService:GetInstanceRemovedSignal("WaterPump")):Connect(detach)

    for i, j in CollectionService:GetTagged("WaterPump") do
        attach(j)
    end

    RunService.Heartbeat:Connect(function() -- Line: 71; upvalues: Workspace (upval), u27 (upval)
        local Attribute, Attribute_2, v1, v2, v3, v4, v5
        local ServerTimeNow = Workspace:GetServerTimeNow()
        local v6 = nil
        local v7 = nil

        for i, j in u27, v6, v7 do
            if i.Parent then
                v2 = i:GetAttribute("PumpActive") == true
                Attribute = i:GetAttribute("PumpHint")
                v4 = false

                if type(Attribute) == "string" then
                    v4 = Attribute ~= ""
                end

                j.gui.Enabled = v2 or v4
                j.hint.Visible = v4
                v1 = if not v4 then "" else Attribute
                j.hint.Text = v1
                v1 = v2 and not v4
                j.track.Visible = v1

                if v2 then
                    Attribute_2 = i:GetAttribute("PumpStartedAt")
                    v3 = i:GetAttribute("PumpInterval")
                    v5 = if type(Attribute_2) ~= "number"
                        or type(v3) ~= "number" or not (v3 > 0) then
                        0
                    else
                        math.clamp((ServerTimeNow - Attribute_2) / v3, 0, 1)
                    j.fill.Size = UDim2.fromScale(v5, 1)
                end
            else
                v2 = u27[i]

                if v2 then
                    v2.gui:Destroy()

                    u27[i] = nil
                end
            end
        end
    end)
end

return v1