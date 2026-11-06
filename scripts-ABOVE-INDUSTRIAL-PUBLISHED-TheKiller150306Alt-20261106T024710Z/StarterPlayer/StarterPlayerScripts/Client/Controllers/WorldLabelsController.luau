-- Script path: game:GetService("Players").TheKiller150306Alt.PlayerScripts.Client.Controllers.WorldLabelsController
-- Decompile time: 1.64 ms

local Workspace = game:GetService("Workspace")
local SettingsController = require(script.Parent.SettingsController)
local v1 = {}
local u11 = {
    MachineStatus = true,
    Shopfront = true,
    PumpProgress = true,
    LooseCount = true,
    NeedsWater = true,
    GuestBookHearts = true,
}
local u12 = false

local function apply(a1) -- Line: 39; upvalues: u11 (val), u12 (ref); types: a1: userdata
    if a1:IsA("BillboardGui") and u11[a1.Name] then
        if u12 then
            if a1:GetAttribute("LabelDrawDistance") == nil then
                a1:SetAttribute("LabelDrawDistance", a1.MaxDistance)
            end

            a1.MaxDistance = 0.001

            return
        end

        local Attribute = a1:GetAttribute("LabelDrawDistance")

        if type(Attribute) == "number" then
            a1.MaxDistance = Attribute
            a1:SetAttribute("LabelDrawDistance", nil)
        end
    end
end

local function applyAll() -- Line: 58; upvalues: u12 (ref), SettingsController (val), Workspace (val), apply (val)
    u12 = SettingsController.get("WorldLabels") == "Off"

    for i, j in Workspace:GetDescendants() do
        apply(j)
    end
end

function v1.start() -- Line: 65; upvalues: u12 (ref), SettingsController (val), Workspace (val), apply (val)
    u12 = SettingsController.get("WorldLabels") == "Off"

    for i, j in Workspace:GetDescendants() do
        apply(j)
    end

    local v1 = apply
    Workspace.DescendantAdded:Connect(v1)

    SettingsController.onChanged(function(a1)
        -- Line: 69
        -- upvalues: u12 (upval), SettingsController (upval), Workspace (upval), apply (upval)
        if a1 == "WorldLabels" then
            u12 = SettingsController.get("WorldLabels") == "Off"

            for i, j in Workspace:GetDescendants() do
                apply(j)
            end
        end
    end)
end

return v1