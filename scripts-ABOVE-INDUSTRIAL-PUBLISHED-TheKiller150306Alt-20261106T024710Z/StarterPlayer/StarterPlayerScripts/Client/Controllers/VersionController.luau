-- Script path: game:GetService("Players").TheKiller150306Alt.PlayerScripts.Client.Controllers.VersionController
-- Decompile time: 1.58 ms

local Players = game:GetService("Players")
local Stats = game:GetService("Stats")
local Workspace = game:GetService("Workspace")
local Shared = (game:GetService("ReplicatedStorage")):WaitForChild("Shared")
local Config = require(Shared.Config)
local u33 = require(script.Parent.Parent.Ui)
local SettingsController = require(script.Parent.SettingsController)
local v1 = {}
local LocalPlayer = Players.LocalPlayer

local function version() -- Line: 36; upvalues: Config (val)
    local v1 = "v" .. Config.Version

    if 0 < game.PlaceVersion then
        v1 = v1 .. " (" .. game.PlaceVersion .. ")"
    end

    return v1
end

local function pingMs() -- Line: 46; upvalues: Stats (val), LocalPlayer (val)
    local success, err = pcall(function() -- Line: 47; upvalues: Stats (upval)
        return Stats.Network.ServerStatsItem["Data Ping"]:GetValue()
    end)

    if success and type(err) == "number" and err > 0 then
        return (math.floor(err + 0.5))
    end

    local success_2, err_2 = pcall(function() -- Line: 53; upvalues: LocalPlayer (upval)
        return LocalPlayer:GetNetworkPing()
    end)

    if success_2 and type(err_2) == "number" and err_2 > 0 then
        return (math.floor(err_2 * 2000 + 0.5))
    end

    return nil
end

local function label() -- Line: 62; upvalues: Config (val), Workspace (val), SettingsController (val), pingMs (val)
    local v1 = {}
    local v2 = "v" .. Config.Version

    if 0 < game.PlaceVersion then
        v2 = v2 .. " (" .. game.PlaceVersion .. ")"
    end

    v1[1] = v2
    local Attribute = Workspace:GetAttribute("ServerRegion")

    if type(Attribute) == "string"
        and Attribute ~= ""
        and SettingsController.is("ShowServerRegion", "On") then
        table.insert(v1, Attribute)
    end

    v2 = pingMs()

    if v2 then
        table.insert(v1, (("%* ms"):format(v2)))
    end

    return table.concat(v1, " · ")
end

function v1.start()
    -- Line: 76
    -- upvalues: u33 (val), label (val), LocalPlayer (val), Workspace (val), SettingsController (val)
    local ScreenGui = Instance.new("ScreenGui")
    ScreenGui.Name = "Version"
    ScreenGui.ResetOnSpawn = false
    ScreenGui.DisplayOrder = -10
    ScreenGui.ScreenInsets = Enum.ScreenInsets.DeviceSafeInsets
    local TextLabel = Instance.new("TextLabel")
    TextLabel.Name = "Version"
    TextLabel.AnchorPoint = Vector2.new(1, 1)
    TextLabel.Position = UDim2.new(1, -4, 1, -2)
    TextLabel.Size = UDim2.fromOffset(0, 12)
    TextLabel.AutomaticSize = Enum.AutomaticSize.X
    TextLabel.BackgroundTransparency = 1
    TextLabel.FontFace = u33.Font.Regular
    TextLabel.TextSize = 10
    TextLabel.TextColor3 = Color3.new(1, 1, 1)
    TextLabel.TextTransparency = 0.75
    TextLabel.TextXAlignment = Enum.TextXAlignment.Right
    TextLabel.Active = false
    TextLabel.Interactable = false
    TextLabel.Text = label()
    TextLabel.AutoLocalize = false
    TextLabel.Parent = ScreenGui
    ScreenGui.Parent = LocalPlayer:WaitForChild("PlayerGui")

    ;(Workspace:GetAttributeChangedSignal("ServerRegion")):Connect(function()
        -- Line: 105
        -- upvalues: TextLabel (val), label (upval)
        TextLabel.Text = label()
    end)

    SettingsController.onChanged(function(a1) -- Line: 108; upvalues: TextLabel (val), label (upval)
        if a1 == "ShowServerRegion" then
            TextLabel.Text = label()
        end
    end)

    task.spawn(function() -- Line: 113; upvalues: ScreenGui (val), TextLabel (val), label (upval)
        while ScreenGui.Parent do
            task.wait(2)

            TextLabel.Text = label()
        end
    end)
end

return v1