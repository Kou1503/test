-- Script path: game:GetService("Players").TheKiller150306Alt.PlayerScripts.Client.Controllers.ObjectiveController
-- Decompile time: 5.68 ms

local GuiService = game:GetService("GuiService")
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local Shared = (game:GetService("ReplicatedStorage")):WaitForChild("Shared")
local Config = require(Shared.Config)
local Remotes = require(Shared.Remotes)
local u41 = require(script.Parent.Parent.Ui)
local TutorialArrow = require(script.Parent.TutorialArrow)
local v1 = {}
local LocalPlayer = Players.LocalPlayer
local CurrentCamera = workspace.CurrentCamera
local u51 = nil
local u52 = nil
local u53 = nil
local u54 = nil
local u55 = nil
local u56 = nil
local u57 = nil
local u58 = nil
local u59 = nil

local function clearArrow() -- Line: 56; upvalues: u58 (ref), u59 (ref)
    if u58 then
        u58:Destroy()
    end

    u58 = nil
    u59 = nil
end

local function placeArrow(a1) -- Line: 64; upvalues: u58 (ref), u59 (ref), TutorialArrow (val); types: a1: vector
    if u58 then
        u58:Destroy()
    end

    u58 = nil
    u59 = nil
    local Folder = Instance.new("Folder")
    Folder.Name = "ObjectiveArrow"
    u59 = TutorialArrow.make(Folder, a1, 0)
    Folder.Parent = workspace
    u58 = Folder
end

local u62 = false
local u63 = ""

function v1.setSuppressed(a1)
    -- Line: 84
    -- upvalues: u62 (ref), u58 (ref), u52 (ref), u53 (ref), u63 (ref), Config (val), TweenService (val)
    -- types: a1: boolean
    u62 = a1

    if u58 then
        u58.Parent = if not u62 then workspace else nil
    end

    if u62 then
        u52.TextTransparency = 1
        u53.Visible = false

        return
    end

    if u63 ~= "" and Config.Objective.ShowLine then
        TweenService:Create(
            u52,
            TweenInfo.new(0.3),
            {TextTransparency = 0}
        ):Play()
    end
end

local u65 = nil
local u66 = 0

local function portalPosition() -- Line: 110; upvalues: u65 (ref), u66 (ref), LocalPlayer (val)
    local v1 = u65

    if v1 and v1.Parent then
        return v1.Position
    end

    v1 = os.clock()

    if v1 < u66 then
        return nil
    end

    u66 = v1 + 2
    local Character = LocalPlayer.Character
    local HumanoidRootPart = Character and Character:FindFirstChild("HumanoidRootPart")

    if HumanoidRootPart and HumanoidRootPart:IsA("BasePart") then
        local Magnitude
        v1 = nil
        local v2 = (1 / 0)

        for i, j in workspace:GetDescendants() do
            if j:IsA("BasePart") and j.Name == "HUB" then
                Magnitude = (j.Position - HumanoidRootPart.Position).Magnitude

                if Magnitude < v2 then
                    v1 = j
                    v2 = Magnitude
                end
            end
        end

        u65 = v1

        if v1 then
            return v1.Position
        end

        return nil
    end

    return nil
end

local function updateMarker()
    -- Line: 144
    -- upvalues: u59 (ref), u62 (ref), TutorialArrow (val), u56 (ref), u53 (ref), portalPosition (val), u57 (ref)
    -- upvalues: CurrentCamera (val), u54 (ref), u55 (ref)
    if u59 and not u62 then
        TutorialArrow.move({u59})
    end

    if not u62 and u56 then
        local v1, v2

        if not (if not (u56 == "Portal") then u57 else portalPosition()) then
            u53.Visible = false
            return
        end

        local v3, v4 = CurrentCamera:WorldToViewportPoint(if not v1 then v2 else v2 + Vector3.new(0, 4, 0))

        if v4 and not v1 then
            u53.Visible = false
            return
        end

        if v4 then
            u53.Visible = true
            u53.Position = UDim2.fromOffset(v3.X, v3.Y)
            u54.Rotation = 45
            u55.CornerRadius = UDim.new(0, 3)

            return
        end

        local ViewportSize = CurrentCamera.ViewportSize
        u53.Visible = true
        u53.Position = UDim2.fromOffset(math.clamp(v3.X, 40, ViewportSize.X - 40), (math.clamp(if not (v3.Z < 0) then v3.Y else ViewportSize.Y - 80, 80, ViewportSize.Y - 80)))
        u54.Rotation = 0
        u55.CornerRadius = UDim.new(0.5, 0)

        return
    end

    u53.Visible = false
end

local u69 = {AboveTopStrip = "Stats", MenuBar = "Frame"}

local function clearTopChrome() -- Line: 194; upvalues: LocalPlayer (val), u52 (ref), GuiService (val), u69 (val)
    local PlayerGui = LocalPlayer:FindFirstChildOfClass("PlayerGui")

    if PlayerGui and u52 then
        local Y_2, v1, v2, v3
        local GuiInset = GuiService:GetGuiInset()
        local X = u52.AbsolutePosition.X
        local v4 = X + u52.AbsoluteSize.X
        local Y = u52.AbsoluteSize.Y
        local v5 = {}
        local v6 = nil
        local v7 = nil

        for i, j in u69, v6, v7 do
            v1 = PlayerGui:FindFirstChild(i)

            if v1 and v1:IsA("ScreenGui") and v1.Enabled then
                Y_2 = GuiInset.Y

                for k, n in v1:GetChildren() do
                    if n:IsA("GuiObject") and n.Visible then
                        if n.Name == j then
                            if n.AbsolutePosition.X < v4
                                and X < n.AbsolutePosition.X + n.AbsoluteSize.X then
                                v2 = n.AbsolutePosition.Y + Y_2
                                table.insert(
                                    v5,
                                    {top = v2, bottom = v2 + n.AbsoluteSize.Y}
                                )
                            end
                        elseif n.ClassName == j
                            and n.AbsolutePosition.X < v4
                            and X < n.AbsolutePosition.X + n.AbsoluteSize.X then
                            v2 = n.AbsolutePosition.Y + Y_2
                            table.insert(
                                v5,
                                {top = v2, bottom = v2 + n.AbsoluteSize.Y}
                            )
                        end
                    end
                end
            end
        end

        v4 = 14
        local v8 = #v5 + 1

        for m = 1, v8 do
            v3 = false

            for i5, i6 in v5 do
                if i6.top < v4 + Y and v4 < i6.bottom then
                    v4 = i6.bottom + 6
                    v3 = true
                end
            end

            if not v3 then
                break
            end
        end

        if u52.Position.Y.Offset ~= v4 then
            u52.Position = UDim2.new(0.5, -u52.AbsoluteSize.X / 2, 0, v4)
        end
    end
end

function v1.start()
    -- Line: 245
    -- upvalues: u51 (ref), LocalPlayer (val), u52 (ref), u41 (val), u53 (ref), u54 (ref), u55 (ref), Remotes (val)
    -- upvalues: u56 (ref), u57 (ref), u58 (ref), u59 (ref), TutorialArrow (val), u62 (ref), u63 (ref)
    -- upvalues: TweenService (val), Config (val), RunService (val), updateMarker (val), clearTopChrome (val)
    u51 = Instance.new("ScreenGui")
    u51.Name = "Objective"
    u51.ResetOnSpawn = false
    u51.IgnoreGuiInset = true
    u51.DisplayOrder = 2
    u51.Parent = LocalPlayer:WaitForChild("PlayerGui")
    u52 = Instance.new("TextLabel")
    u52.Size = UDim2.fromOffset(560, 26)
    u52.AutomaticSize = Enum.AutomaticSize.Y
    u52.RichText = true
    u52.Position = UDim2.new(0.5, -280, 0, 14)
    u52.BackgroundTransparency = 1
    u52.Text = ""
    u52.TextColor3 = Color3.fromRGB(255, 226, 130)
    u52.TextSize = 15
    u52.FontFace = u41.Font.Medium
    u52.TextStrokeTransparency = 0.5
    u52.TextTransparency = 1
    u52.Parent = u51
    u53 = Instance.new("Frame")
    u53.AnchorPoint = Vector2.new(0.5, 0.5)
    u53.Size = UDim2.fromOffset(28, 28)
    u53.BackgroundTransparency = 1
    u53.Visible = false
    u53.Parent = u51
    u54 = Instance.new("Frame")
    u54.AnchorPoint = Vector2.new(0.5, 0.5)
    u54.Position = UDim2.fromScale(0.5, 0.5)
    u54.Size = UDim2.fromOffset(14, 14)
    u54.Rotation = 45
    u54.BackgroundColor3 = Color3.fromRGB(255, 226, 130)
    u54.BorderSizePixel = 0
    u54.Parent = u53
    u55 = Instance.new("UICorner")
    u55.CornerRadius = UDim.new(0, 3)
    u55.Parent = u54

    u41.stroke(u54, Color3.fromRGB(40, 32, 12), 2)

    ;(Remotes.get(Remotes.Objective)).OnClientEvent:Connect(function(a1, a2, a3, a4)
        -- Line: 288
        -- upvalues: u56 (upval), u57 (upval), u58 (upval), u59 (upval), TutorialArrow (upval), u62 (upval), u63 (upval)
        -- upvalues: TweenService (upval), u52 (upval), Config (upval)
        local v1 = a1

        if type(v1) ~= "string" then
            return
        end

        if type(a4) == "string" and a4 ~= "" and a1 ~= "" then
            a1 = ("%*\n<font size=\"12\" color=\"#C8CCD8\">%*</font>"):format(a1, a4)
        end

        u56 = if type(a2) ~= "string" then nil else a2
        local v2 = if typeof(a3) ~= "Vector3" then nil else a3

        if v2 ~= u57 then
            u57 = v2

            if not v2 then
                if u58 then
                    u58:Destroy()
                end

                u58 = nil
                u59 = nil
            else
                if u58 then
                    u58:Destroy()
                end

                u58 = nil
                u59 = nil
                local Folder = Instance.new("Folder")
                Folder.Name = "ObjectiveArrow"
                u59 = TutorialArrow.make(Folder, v2, 0)
                Folder.Parent = workspace
                u58 = Folder

                if u58 and u62 then
                    u58.Parent = nil
                end
            end
        end

        if a1 == u63 then
            return
        end

        u63 = a1
        TweenService:Create(
            u52,
            TweenInfo.new(0.2),
            {TextTransparency = 1}
        ):Play()

        task.delay(
            0.2,
            function()
                -- Line: 327
                -- upvalues: u63 (upval), a1 (ref), u52 (upval), u62 (upval), Config (upval), TweenService (upval)
                if u63 ~= a1 then
                    return
                end

                u52.Text = a1

                if a1 ~= "" and not u62 and Config.Objective.ShowLine then
                    TweenService:Create(
                        u52,
                        TweenInfo.new(0.3),
                        {TextTransparency = 0}
                    ):Play()
                end
            end
        )
    end)

    RunService.RenderStepped:Connect(updateMarker)

    task.spawn(function() -- Line: 341; upvalues: clearTopChrome (upval)
        while true do
            clearTopChrome()
            task.wait(0.5)
        end
    end)
end

return v1