-- Script path: game:GetService("Players").TheKiller150306Alt.PlayerScripts.Client.Controllers.LooseCountController
-- Decompile time: 2.30 ms

local CollectionService = game:GetService("CollectionService")
local Players = game:GetService("Players")
local Shared = (game:GetService("ReplicatedStorage")):WaitForChild("Shared")
local Config = require(Shared.Config)
local u28 = require(script.Parent.Parent.Ui)
local v1 = {}
local LocalPlayer = Players.LocalPlayer
local u31 = {}
local u32 = {}

local function noteCount(a1) -- Line: 33; upvalues: u31 (val); types: a1: userdata
    local Attribute = a1:GetAttribute("Count")
    u31[a1] = if type(Attribute) ~= "number" then nil else if not (Attribute > 1) then nil else true
end

local function onAdded(a1) -- Line: 38; upvalues: u32 (val), u31 (val); types: a1: userdata
    if a1:IsA("BasePart") and not u32[a1] then
        u32[a1] = ((a1:GetAttributeChangedSignal("Count")):Connect(function()
            -- Line: 43
            -- upvalues: a1 (val), u31 (upval)
            local v1 = a1
            local Attribute = v1:GetAttribute("Count")
            u31[v1] = if type(Attribute) ~= "number" then
                nil
            else
                if not (Attribute > 1) then nil else true
        end))
        local Attribute = a1:GetAttribute("Count")
        u31[a1] = if type(Attribute) ~= "number" then nil else if not (Attribute > 1) then nil else true
    end
end

local function onRemoved(a1) -- Line: 49; upvalues: u32 (val), u31 (val); types: a1: userdata
    local v1 = u32[a1]

    if v1 then
        v1:Disconnect()

        u32[a1] = nil
    end

    u31[a1] = nil
end

local function makeLabel(a1) -- Line: 58; upvalues: Config (val), u28 (val); types: a1: userdata
    local BillboardGui = Instance.new("BillboardGui")
    BillboardGui.Name = "LooseCount"
    BillboardGui.Size = UDim2.fromOffset(40, 16)
    BillboardGui.StudsOffsetWorldSpace = Vector3.new(0, 1.2000000476837158, 0)
    BillboardGui.LightInfluence = 0
    BillboardGui.ResetOnSpawn = false
    BillboardGui.Enabled = false
    BillboardGui.MaxDistance = Config.Build.Pickup.CountLabelStuds + 4
    BillboardGui.Parent = a1
    local TextLabel = Instance.new("TextLabel")
    TextLabel.Size = UDim2.fromScale(1, 1)
    TextLabel.BackgroundTransparency = 1
    TextLabel.FontFace = u28.Font.Bold
    TextLabel.TextSize = 12
    TextLabel.TextColor3 = Color3.new(1, 1, 1)
    TextLabel.TextStrokeTransparency = 0.4
    TextLabel.Parent = BillboardGui

    return BillboardGui, TextLabel
end

function v1.start()
    -- Line: 81
    -- upvalues: LocalPlayer (val), Config (val), makeLabel (val), CollectionService (val), onAdded (val)
    -- upvalues: onRemoved (val), u31 (val)
    local v1, v2
    local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")
    local CountLabelStuds = Config.Build.Pickup.CountLabelStuds
    local u9 = {}
    local CountLabelMax = Config.Build.Pickup.CountLabelMax

    for i = 1, CountLabelMax do
        v1, v2 = makeLabel(PlayerGui)
        table.insert(
            u9,
            {gui = v1, text = v2}
        )
    end

    ;(CollectionService:GetInstanceAddedSignal("LooseItem")):Connect(onAdded)
    ;(CollectionService:GetInstanceRemovedSignal("LooseItem")):Connect(onRemoved)

    for j, k in CollectionService:GetTagged("LooseItem") do
        onAdded(k)
    end

    task.spawn(function() -- Line: 96; upvalues: LocalPlayer (upval), u31 (upval), CountLabelStuds (val), u9 (val)
        local Character, HumanoidRootPart, Magnitude, v1, v2, v3

        while true do
            task.wait(0.2)

            Character = LocalPlayer.Character
            HumanoidRootPart = if not Character then nil else Character:FindFirstChild("HumanoidRootPart")
            v1 = {}

            if HumanoidRootPart then
                for i in u31 do
                    if i.Parent then
                        Magnitude = (i.Position - HumanoidRootPart.Position).Magnitude

                        if Magnitude <= CountLabelStuds then
                            table.insert(
                                v1,
                                {part = i, distance = Magnitude}
                            )
                        end
                    end
                end
            end

            v3 = #v1

            if #u9 < v3 then
                table.sort(
                    v1,
                    function(a1, a2) -- Line: 115
                        return a1.distance < a2.distance
                    end
                )
            end

            for j, k in u9 do
                v2 = v1[j]

                if v2 then
                    k.gui.Adornee = v2.part
                    k.text.Text = ("x%*"):format((v2.part:GetAttribute("Count")))
                    k.gui.Enabled = true
                elseif k.gui.Enabled then
                    k.gui.Enabled = false
                    k.gui.Adornee = nil
                end
            end
        end
    end)
end

return v1