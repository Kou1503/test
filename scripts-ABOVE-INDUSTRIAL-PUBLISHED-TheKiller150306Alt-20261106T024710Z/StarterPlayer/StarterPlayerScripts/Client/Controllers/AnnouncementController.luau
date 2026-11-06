-- Script path: game:GetService("Players").TheKiller150306Alt.PlayerScripts.Client.Controllers.AnnouncementController
-- Decompile time: 2.32 ms

local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local Shared = (game:GetService("ReplicatedStorage")):WaitForChild("Shared")
local Remotes = require(Shared.Remotes)
local u28 = require(script.Parent.Parent.Ui)
local v1 = {}
local LocalPlayer = Players.LocalPlayer
local u31 = nil
local u32 = nil
local u33 = nil
local u34 = nil
local u35 = nil
local u36 = 0

local function build()
    -- Line: 38
    -- upvalues: LocalPlayer (val), u31 (ref), u28 (val), u32 (ref), u35 (ref), u33 (ref), u34 (ref)
    local ScreenGui = Instance.new("ScreenGui")
    ScreenGui.Name = "AboveAnnouncement"
    ScreenGui.ResetOnSpawn = false
    ScreenGui.DisplayOrder = 85
    ScreenGui.Parent = LocalPlayer:WaitForChild("PlayerGui")
    u31 = Instance.new("CanvasGroup")
    u31.AnchorPoint = Vector2.new(0.5, 0)
    u31.Position = UDim2.new(0.5, 0, 0, 64)
    u31.Size = UDim2.new(1, -32, 0, 0)
    u31.AutomaticSize = Enum.AutomaticSize.Y
    u31.BackgroundColor3 = u28.Palette.Card
    u31.BackgroundTransparency = 0.05
    u31.GroupTransparency = 1
    u31.Visible = false
    u31.Parent = ScreenGui

    u28.corner(u31, 14)
    u28.stroke(u31, u28.Palette.Gold, 1.5)

    local UISizeConstraint = Instance.new("UISizeConstraint")
    UISizeConstraint.MaxSize = Vector2.new(560, (1 / 0))
    UISizeConstraint.Parent = u31
    local UIPadding = Instance.new("UIPadding")
    UIPadding.PaddingLeft = UDim.new(0, 14)
    UIPadding.PaddingRight = UDim.new(0, 18)
    UIPadding.PaddingTop = UDim.new(0, 12)
    UIPadding.PaddingBottom = UDim.new(0, 12)
    UIPadding.Parent = u31
    local UIListLayout = Instance.new("UIListLayout")
    UIListLayout.FillDirection = Enum.FillDirection.Horizontal
    UIListLayout.VerticalAlignment = Enum.VerticalAlignment.Center
    UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
    UIListLayout.Padding = UDim.new(0, 14)
    UIListLayout.Parent = u31
    u32 = Instance.new("ImageLabel")
    u32.LayoutOrder = 1
    u32.Size = UDim2.fromOffset(64, 64)
    u32.BackgroundColor3 = Color3.fromRGB(40, 44, 56)
    u32.ScaleType = Enum.ScaleType.Crop
    u32.Parent = u31

    u28.corner(u32, 64)
    u28.stroke(u32, u28.Palette.Gold, 2)

    u35 = Instance.new("Frame")
    u35.LayoutOrder = 2
    u35.BackgroundTransparency = 1
    u35.AutomaticSize = Enum.AutomaticSize.Y
    u35.Parent = u31
    local UIListLayout_2 = Instance.new("UIListLayout")
    UIListLayout_2.SortOrder = Enum.SortOrder.LayoutOrder
    UIListLayout_2.Padding = UDim.new(0, 2)
    UIListLayout_2.Parent = u35
    u33 = Instance.new("TextLabel")
    u33.LayoutOrder = 1
    u33.Size = UDim2.new(1, 0, 0, 18)
    u33.BackgroundTransparency = 1
    u33.FontFace = u28.Font.Bold
    u33.TextSize = 14
    u33.TextColor3 = u28.Palette.Gold
    u33.TextXAlignment = Enum.TextXAlignment.Left
    u33.Parent = u35

    u28.asWritten(u33)

    u34 = Instance.new("TextLabel")
    u34.LayoutOrder = 2
    u34.Size = UDim2.fromScale(1, 0)
    u34.AutomaticSize = Enum.AutomaticSize.Y
    u34.BackgroundTransparency = 1
    u34.FontFace = u28.Font.Bold
    u34.TextSize = 22
    u34.TextColor3 = Color3.fromRGB(255, 255, 255)
    u34.TextWrapped = true
    u34.TextXAlignment = Enum.TextXAlignment.Left
    u34.Parent = u35

    u28.asWritten(u34)
end

local function show(a1, a2, a3)
    -- Line: 121
    -- upvalues: u36 (ref), u32 (ref), u35 (ref), u33 (ref), u34 (ref), u31 (ref), TweenService (val)
    -- types: a1: string, a2: number?, a3: string?
    u36 = u36 + 1
    local u5 = u36
    local v1 = a2 ~= nil
    u32.Visible = v1
    u32.Image = if not a2 then "" else ("rbxthumb://type=AvatarHeadShot&id=%*&w=150&h=150"):format(a2)
    u35.Size = UDim2.new(1, -(if not v1 then 0 else 78), 0, 0)
    local v2 = u33
    local v3 = false

    if a3 ~= nil then
        v3 = a3 ~= ""
    end

    v2.Visible = v3
    u33.Text = a3 or ""
    u34.Text = a1
    u31.Visible = true
    u31.Position = UDim2.new(0.5, 0, 0, 48)
    local u61 = TweenInfo.new(0.35, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)

    TweenService:Create(
        u31,
        u61,
        {GroupTransparency = 0, Position = UDim2.new(0.5, 0, 0, 64)}
    ):Play()

    task.delay(
        math.max(0, #a1 - 60) * 0.04 + 7,
        function() -- Line: 140; upvalues: u36 (upval), u5 (val), TweenService (upval), u31 (upval), u61 (val)
            if u36 ~= u5 then
                return
            end

            local v1 = TweenService:Create(
                u31,
                u61,
                {GroupTransparency = 1, Position = UDim2.new(0.5, 0, 0, 48)}
            )
            v1.Completed:Connect(function() -- Line: 146; upvalues: u36 (upval), u5 (upval), u31 (upval)
                if u36 == u5 then
                    u31.Visible = false
                end
            end)

            v1:Play()
        end
    )
end

function v1.start() -- Line: 155; upvalues: build (val), Remotes (val), show (val)
    build()

    ;(Remotes.get(Remotes.Announcement)).OnClientEvent:Connect(function(a1) -- Line: 157; upvalues: show (upval)
        if type(a1) == "table" and type(a1.text) == "string" then
            local userId_2 = if type(a1.userId) ~= "number" then nil else a1.userId
            local name_2 = if type(a1.name) ~= "string" then nil else a1.name

            show(a1.text, userId_2, name_2)
        end
    end)
end

return v1