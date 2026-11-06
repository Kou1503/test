-- Script path: game:GetService("Players").TheKiller150306Alt.PlayerScripts.Client.Controllers.TapDebugController
-- Decompile time: 4.96 ms

local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local Debris = game:GetService("Debris")
local GuiService = game:GetService("GuiService")
local Shared = (game:GetService("ReplicatedStorage")):WaitForChild("Shared")
local Grid = require(Shared.Grid)
local u37 = require(script.Parent.Aim)
local BuildController = require(script.Parent.BuildController)
local v1 = {}
local LocalPlayer = Players.LocalPlayer
local u45 = nil
local u46 = nil
local u47 = nil
local u48 = nil

local function active() -- Line: 46; upvalues: LocalPlayer (val)
    return LocalPlayer:GetAttribute("TapDebug") == true
end

local function clear() -- Line: 50; upvalues: u45 (ref), u46 (ref), u47 (ref)
    if u45 then
        u45:ClearAllChildren()
    end

    if u46 then
        u46:ClearAllChildren()
    end

    if u47 then
        u47:ClearAllChildren()
    end
end

local function shortName(a1) -- Line: 62; types: a1: userdata
    local v1 = {}
    local Parent = a1

    while Parent do
        if Parent == workspace or not (#v1 < 3) then
            break
        end

        table.insert(v1, 1, Parent.Name)

        Parent = Parent.Parent
    end

    return table.concat(v1, ".")
end

local function box(a1, a2) -- Line: 72; upvalues: u47 (ref); types: a1: userdata, a2: userdata
    local SelectionBox = Instance.new("SelectionBox")
    SelectionBox.Adornee = a1
    SelectionBox.Color3 = a2
    SelectionBox.LineThickness = 0.04
    SelectionBox.SurfaceTransparency = 1
    SelectionBox.Parent = u47
end

local function marker(a1, a2, a3, a4, a5)
    -- Line: 81
    -- upvalues: u47 (ref)
    -- types: a1: vector, a2: vector, a3: userdata, a4: number
    local Part = Instance.new("Part")
    Part.Anchored = true
    Part.CanCollide = false
    Part.CanQuery = false
    Part.CanTouch = false
    Part.CastShadow = false
    Part.Shape = a5
    Part.Size = a2
    Part.Position = a1
    Part.Color = a3
    Part.Material = Enum.Material.Neon
    Part.Transparency = a4
    Part.Parent = u47

    return Part
end

local function show(a1, a2)
    -- Line: 98
    -- upvalues: u45 (ref), u46 (ref), u47 (ref), BuildController (val), u48 (ref), GuiService (val), shortName (val)
    -- upvalues: Grid (val), Debris (val)
    -- types: a1: userdata, a2: string
    local v1, v2, v3

    if u45 then
        u45:ClearAllChildren()
    end

    if u46 then
        u46:ClearAllChildren()
    end

    if u47 then
        u47:ClearAllChildren()
    end

    local v4 = u45
    local Frame = Instance.new("Frame")
    Frame.AnchorPoint = Vector2.new(0.5, 0.5)
    Frame.Size = UDim2.fromOffset(10, 10)
    Frame.Position = UDim2.fromOffset(a1.X, a1.Y)
    Frame.BackgroundColor3 = Color3.fromRGB(255, 60, 60)
    Frame.BorderSizePixel = 0
    Frame.Parent = v4
    local UICorner = Instance.new("UICorner")
    UICorner.CornerRadius = UDim.new(1, 0)
    UICorner.Parent = Frame
    local v5 = BuildController.aimReport()
    local v6 = {(("%* at %*,%*"):format(a2, math.floor(a1.X), (math.floor(a1.Y))))}
    local v7 = {}
    local v8 = u48

    if a2 == "tap" and v8 then
        local Frame_2 = Instance.new("Frame")
        Frame_2.AnchorPoint = Vector2.new(0.5, 0.5)
        Frame_2.Size = UDim2.fromOffset(22, 22)
        Frame_2.Position = UDim2.fromOffset(v8.X, v8.Y)
        Frame_2.BackgroundTransparency = 1
        Frame_2.Parent = u46
        local UIStroke = Instance.new("UIStroke")
        UIStroke.Color = Color3.fromRGB(80, 255, 120)
        UIStroke.Thickness = 2
        UIStroke.Parent = Frame_2
        local UICorner_2 = Instance.new("UICorner")
        UICorner_2.CornerRadius = UDim.new(1, 0)
        UICorner_2.Parent = Frame_2

        table.insert(v7, Frame_2)

        local GuiInset = GuiService:GetGuiInset()
        v2 = v8 + GuiInset
        v1 = a1 - v2

        table.insert(v6, (("finger %*,%*  aim is %*,%* off (top bar %*)"):format(math.floor(v2.X), math.floor(v2.Y), math.floor(v1.X), math.floor(v1.Y), (math.floor(GuiInset.Y)))))
    end

    local hit = v5.hit

    if not hit or not v5.position then
        table.insert(v6, "hit nothing (open air)")
    else
        local position = v5.position
        v3 = Color3.fromRGB(255, 220, 60)
        local Ball = Enum.PartType.Ball
        local Part = Instance.new("Part")
        Part.Anchored = true
        Part.CanCollide = false
        Part.CanQuery = false
        Part.CanTouch = false
        Part.CastShadow = false
        Part.Shape = Ball
        Part.Size = Vector3.new(0.3499999940395355, 0.3499999940395355, 0.3499999940395355)
        Part.Position = position
        Part.Color = v3
        Part.Material = Enum.Material.Neon
        Part.Transparency = 0
        Part.Parent = u47
        v2 = Color3.fromRGB(255, 220, 60)
        local SelectionBox = Instance.new("SelectionBox")
        SelectionBox.Adornee = hit
        SelectionBox.Color3 = v2
        SelectionBox.LineThickness = 0.04
        SelectionBox.SurfaceTransparency = 1
        SelectionBox.Parent = u47
        v2 = 0.99 <= hit.Transparency
        local Attribute = hit:GetAttribute("CellKey")

        table.insert(v6, (("hit %*%*  query=%*  cell=%*"):format(shortName(hit), if not v2 then "" else "  INVISIBLE", hit.CanQuery, Attribute or "-")))
    end

    local breakPart = v5.breakPart

    if breakPart then
        v2 = Color3.fromRGB(255, 70, 70)
        local SelectionBox_2 = Instance.new("SelectionBox")
        SelectionBox_2.Adornee = breakPart
        SelectionBox_2.Color3 = v2
        SelectionBox_2.LineThickness = 0.04
        SelectionBox_2.SurfaceTransparency = 1
        SelectionBox_2.Parent = u47

        table.insert(v6, (("break %*"):format((shortName(breakPart)))))
    end

    local cell = v5.cell

    if cell and v5.origin then
        v2 = Grid.cellToWorld(v5.origin, cell)
        v3 = Vector3.new(1, 1, 1) * (Grid.CellSize - 0.1)
        v1 = Color3.fromRGB(70, 150, 255)
        local Block = Enum.PartType.Block
        local Part_2 = Instance.new("Part")
        Part_2.Anchored = true
        Part_2.CanCollide = false
        Part_2.CanQuery = false
        Part_2.CanTouch = false
        Part_2.CastShadow = false
        Part_2.Shape = Block
        Part_2.Size = v3
        Part_2.Position = v2
        Part_2.Color = v1
        Part_2.Material = Enum.Material.Neon
        Part_2.Transparency = 0.7
        Part_2.Parent = u47
        local faceCell = v5.faceCell
        v3 = false

        if faceCell ~= nil then
            v3 = true

            if faceCell.x == cell.x then
                v3 = true

                if faceCell.y == cell.y then
                    v3 = faceCell.z ~= cell.z
                end
            end
        end

        table.insert(v6, (("place %*,%*,%*%*%*"):format(cell.x, cell.y, cell.z, if not v3 then "" else "  MOVED SIDEWAYS BY THE EDGE RULE", if not v5.struck then "  (open air: your own level)" else "")))
    end

    local TextLabel = Instance.new("TextLabel")
    TextLabel.AnchorPoint = Vector2.new(0, 1)
    TextLabel.Position = UDim2.fromOffset(a1.X + 12, a1.Y - 12)
    TextLabel.Size = UDim2.fromOffset(420, #v6 * 18)
    TextLabel.BackgroundTransparency = 0.35
    TextLabel.BackgroundColor3 = Color3.fromRGB(10, 12, 16)
    TextLabel.TextColor3 = Color3.fromRGB(240, 240, 240)
    TextLabel.TextXAlignment = Enum.TextXAlignment.Left
    TextLabel.TextYAlignment = Enum.TextYAlignment.Top
    TextLabel.Font = Enum.Font.Code
    TextLabel.TextSize = 13
    TextLabel.Text = table.concat(v6, "\n")
    TextLabel.Parent = v4

    print((("[ABOVE] /tap  %*"):format((table.concat(v6, "  |  ")))))

    v6 = {Frame, TextLabel}

    for i, j in v7 do
        table.insert(v6, j)
    end

    for k, n in u47:GetChildren() do
        table.insert(v6, n)
    end

    for m, i5 in v6 do
        Debris:AddItem(i5, 6)
    end
end

function v1.start()
    -- Line: 206
    -- upvalues: LocalPlayer (val), u45 (ref), u46 (ref), UserInputService (val), u48 (ref), u47 (ref), show (val)
    -- upvalues: u37 (val)
    local ScreenGui = Instance.new("ScreenGui")
    ScreenGui.Name = "TapDebug"
    ScreenGui.IgnoreGuiInset = true
    ScreenGui.DisplayOrder = 200
    ScreenGui.ResetOnSpawn = false
    ScreenGui.Parent = LocalPlayer:WaitForChild("PlayerGui")
    u45 = ScreenGui
    local ScreenGui_2 = Instance.new("ScreenGui")
    ScreenGui_2.Name = "TapDebugInset"
    ScreenGui_2.IgnoreGuiInset = false
    ScreenGui_2.DisplayOrder = 200
    ScreenGui_2.ResetOnSpawn = false
    ScreenGui_2.Parent = LocalPlayer:WaitForChild("PlayerGui")
    u46 = ScreenGui_2

    UserInputService.TouchEnded:Connect(function(a1) -- Line: 225; upvalues: u48 (upval)
        u48 = Vector2.new(a1.Position.X, a1.Position.Y)
    end)

    local Folder = Instance.new("Folder")
    Folder.Name = "TapDebugMarkers"
    Folder.Parent = workspace
    u47 = Folder

    ;(LocalPlayer:GetAttributeChangedSignal("TapDebug")):Connect(function()
        -- Line: 234
        -- upvalues: LocalPlayer (upval), u45 (upval), u46 (upval), u47 (upval)
        if not (LocalPlayer:GetAttribute("TapDebug") == true) then
            if u45 then
                u45:ClearAllChildren()
            end

            if u46 then
                u46:ClearAllChildren()
            end

            if u47 then
                u47:ClearAllChildren()
            end
        end
    end)

    UserInputService.TouchTapInWorld:Connect(function(a1)
        -- Line: 241
        -- upvalues: LocalPlayer (upval), show (upval), u37 (upval)
        if LocalPlayer:GetAttribute("TapDebug") == true then
            task.delay(
                0.05,
                function() -- Line: 243; upvalues: show (upval), u37 (upval), a1 (val)
                    show(u37.touchPoint() or a1, "tap")
                end
            )
        end
    end)

    UserInputService.InputBegan:Connect(function(a1, a2)
        -- Line: 248
        -- upvalues: LocalPlayer (upval), UserInputService (upval), show (upval)
        if LocalPlayer:GetAttribute("TapDebug") == true
            and not a2
            and a1.UserInputType == Enum.UserInputType.MouseButton1 then
            local MouseLocation = UserInputService:GetMouseLocation()
            show(MouseLocation, "click")
        end
    end)
end

return v1