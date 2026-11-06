-- Script path: game:GetService("Players").TheKiller150306Alt.PlayerScripts.Client.Controllers.NewsController
-- Decompile time: 2.38 ms

local Players = game:GetService("Players")
local Shared = (game:GetService("ReplicatedStorage")):WaitForChild("Shared")
local Config = require(Shared.Config)
local NewsView = require(Shared.NewsView)
local Remotes = require(Shared.Remotes)
local u29 = require(script.Parent.Parent.Ui)
local BuildController = require(script.Parent.BuildController)
local u35 = {}
local LocalPlayer = Players.LocalPlayer
local u37 = nil
local u38 = nil
local u39 = nil
local u40 = {}

function u35.isOpen() -- Line: 31; upvalues: u38 (ref)
    local Visible = false

    if u38 ~= nil then
        Visible = u38.Visible
    end

    return Visible
end

local u42 = {regular = u29.Font.Regular, bold = u29.Font.Bold}
u42.textSize = u29.tapText(14)
u42.text = Color3.fromRGB(226, 230, 240)
u42.dim = u29.Palette.Faint

local function render()
    -- Line: 44
    -- upvalues: u39 (ref), u40 (ref), Config (val), u29 (val), NewsView (val), u42 (val)
    local Frame

    for i, j in u39:GetChildren() do
        if not j:IsA("UIListLayout") and not j:IsA("UIPadding") then
            j:Destroy()
        end
    end

    if #u40 == 0 then
        local TextLabel = Instance.new("TextLabel")
        TextLabel.Size = UDim2.new(1, 0, 0, 40)
        TextLabel.BackgroundTransparency = 1
        TextLabel.TextWrapped = true
        TextLabel.Text = Config.News.UnavailableText
        TextLabel.TextColor3 = u29.Palette.Faint
        TextLabel.FontFace = u29.Font.Regular
        TextLabel.TextSize = 14
        TextLabel.Parent = u39

        return
    end

    local v1 = nil
    local v2 = nil

    for k, n in u40, v1, v2 do
        if k > 1 then
            Frame = Instance.new("Frame")
            Frame.LayoutOrder = k * 2 - 1
            Frame.Size = UDim2.new(1, 0, 0, 1)
            Frame.BackgroundColor3 = Color3.fromRGB(58, 62, 78)
            Frame.BorderSizePixel = 0
            Frame.Parent = u39
        end

        NewsView.render(u39, n, u42, k * 2)
    end
end

function u35.close() -- Line: 77; upvalues: u38 (ref), BuildController (val)
    local Visible = false

    if u38 ~= nil then
        Visible = u38.Visible
    end

    if not Visible then
        return
    end

    u38.Visible = false
    BuildController.setUiOpen("News", false)
end

function u35.open() -- Line: 85; upvalues: u38 (ref), u29 (val), BuildController (val), u39 (ref)
    u38.Visible = true
    u29.appear(u38)
    BuildController.setUiOpen("News", true)

    u39.CanvasPosition = Vector2.zero
end

function u35.toggle() -- Line: 92; upvalues: u38 (ref), u35 (val)
    local Visible = false

    if u38 ~= nil then
        Visible = u38.Visible
    end

    if Visible then
        u35.close()
        return
    end

    u35.open()
end

function u35.start()
    -- Line: 100
    -- upvalues: BuildController (val), u35 (val), u37 (ref), LocalPlayer (val), u38 (ref), u29 (val), u39 (ref)
    -- upvalues: render (val), Remotes (val), u40 (ref)
    BuildController.registerMenu("News", u35.close)

    u37 = Instance.new("ScreenGui")
    u37.Name = "News"
    u37.ResetOnSpawn = false
    u37.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    u37.Parent = LocalPlayer:WaitForChild("PlayerGui")
    u38 = Instance.new("CanvasGroup")
    u38.Size = UDim2.fromOffset(520, 480)
    u38.Position = UDim2.new(0.5, -260, 0.5, -240)

    u29.fitToScreen(u38)

    u38.BackgroundColor3 = Color3.fromRGB(22, 24, 30)
    u38.BackgroundTransparency = 0.05
    u38.BorderSizePixel = 0
    u38.Visible = false
    u38.Active = true
    u38.Parent = u37

    u29.closeButton(u38, 10, u35.close)

    local UICorner = Instance.new("UICorner")
    UICorner.CornerRadius = UDim.new(0, 10)
    UICorner.Parent = u38
    local UIStroke = Instance.new("UIStroke")
    UIStroke.Color = Color3.fromRGB(58, 62, 78)
    UIStroke.Thickness = 1
    UIStroke.Parent = u38
    local TextLabel = Instance.new("TextLabel")
    TextLabel.Size = UDim2.new(1, -24, 0, 30)
    TextLabel.Position = UDim2.fromOffset(14, 10)
    TextLabel.BackgroundTransparency = 1
    TextLabel.Text = "UPDATES"
    TextLabel.TextColor3 = Color3.fromRGB(238, 240, 248)
    TextLabel.TextSize = 17
    TextLabel.FontFace = u29.Font.Bold
    TextLabel.TextXAlignment = Enum.TextXAlignment.Left
    TextLabel.Parent = u38
    u39 = Instance.new("ScrollingFrame")
    u39.Size = UDim2.new(1, -20, 1, -54)
    u39.Position = UDim2.fromOffset(10, 46)
    u39.BackgroundTransparency = 1
    u39.BorderSizePixel = 0
    u39.ScrollBarThickness = 5
    u39.CanvasSize = UDim2.fromOffset(0, 0)
    u39.AutomaticCanvasSize = Enum.AutomaticSize.Y
    u39.ScrollingDirection = Enum.ScrollingDirection.Y
    u39.Parent = u38
    local UIPadding = Instance.new("UIPadding")
    UIPadding.PaddingLeft = UDim.new(0, 4)
    UIPadding.PaddingRight = UDim.new(0, 12)
    UIPadding.PaddingBottom = UDim.new(0, 12)
    UIPadding.Parent = u39
    local UIListLayout = Instance.new("UIListLayout")
    UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
    UIListLayout.Padding = UDim.new(0, 14)
    UIListLayout.Parent = u39

    render()

    ;(Remotes.get(Remotes.NewsFeed)).OnClientEvent:Connect(function(a1)
        -- Line: 167
        -- upvalues: u40 (upval), render (upval)
        if type(a1) ~= "table" then
            return
        end

        u40 = a1
        render()
    end)
end

return u35