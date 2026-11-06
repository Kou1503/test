-- Script path: game:GetService("Players").TheKiller150306Alt.PlayerScripts.Client.Controllers.TravelController
-- Decompile time: 5.08 ms

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local Shared = (game:GetService("ReplicatedStorage")):WaitForChild("Shared")
local Config = require(Shared.Config)
local Remotes = require(Shared.Remotes)
local Seats = require(Shared.Seats)
local u38 = require(script.Parent.AudioController)
local u39 = {}
local LocalPlayer = Players.LocalPlayer
local u41 = nil
local u42 = nil
local u43 = nil

local function tween(a1, a2, a3, a4, a5)
    -- Line: 57
    -- upvalues: TweenService (val)
    -- types: a1: userdata, a2: number, a3: table
    local new = TweenInfo.new
    TweenService:Create(a1, new(a2, a4 or Enum.EasingStyle.Quad, a5 or Enum.EasingDirection.Out), a3):Play()
end

local function pulse() -- Line: 77; upvalues: Config (val), u43 (ref), TweenService (val)
    local Travel = Config.Appearance.Travel
    u43.Size = UDim2.fromScale(0.05, 0.05)
    u43.BackgroundTransparency = 0.2
    u43.Visible = true
    local v1 = u43
    local v2 = Travel.OutSeconds + Travel.HoldSeconds
    local v3 = {BackgroundTransparency = 1, Size = UDim2.fromScale(2.4, 2.4)}
    local Quint = Enum.EasingStyle.Quint
    local new = TweenInfo.new

    TweenService:Create(v1, new(v2, Quint or Enum.EasingStyle.Quad, Enum.EasingDirection.Out), v3):Play()
end

local u46 = 0
local u47 = nil

local function release() -- Line: 99; upvalues: u47 (ref)
    local CurrentCamera = workspace.CurrentCamera

    if CurrentCamera and u47 then
        CurrentCamera.CameraType = u47
    end

    u47 = nil
end

local function dive(a1)
    -- Line: 116
    -- upvalues: u46 (ref), u47 (ref), Config (val), TweenService (val)
    -- types: a1: userdata?
    if not a1 then
        return
    end

    local CurrentCamera = workspace.CurrentCamera

    if not CurrentCamera then
        return
    end

    local success, err = pcall(function() -- Line: 125; upvalues: a1 (val)
        return a1:GetPivot()
    end)

    if success and typeof(err) == "CFrame" then
        local CFrame_2 = CurrentCamera.CFrame
        local Position = err.Position

        if (Position - CFrame_2.Position).Magnitude < 1 then
            return
        end

        u46 = u46 + 1
        local u18 = u46
        u47 = u47 or CurrentCamera.CameraType
        CurrentCamera.CameraType = Enum.CameraType.Scriptable
        local Travel = Config.Appearance.Travel
        local v1 = CFrame.lookAt(CFrame_2.Position:Lerp(Position, Travel.ZoomFraction), Position)

        TweenService:Create(
            CurrentCamera,
            TweenInfo.new(Travel.OutSeconds, Enum.EasingStyle.Back, Enum.EasingDirection.In),
            {CFrame = v1}
        ):Play()

        task.delay(
            Travel.OutSeconds,
            function() -- Line: 159; upvalues: u46 (upval), u18 (val), u47 (upval)
                if u46 == u18 then
                    local CurrentCamera = workspace.CurrentCamera

                    if CurrentCamera and u47 then
                        CurrentCamera.CameraType = u47
                    end

                    u47 = nil
                end
            end
        )
    end
end

local function awaitGround(a1)
    -- Line: 169
    -- upvalues: Config (val), LocalPlayer (val), RunService (val)
    -- types: a1: vector?
    local Character, HumanoidRootPart, v1, v2
    local Travel = Config.Appearance.Travel
    local v3 = RaycastParams.new()
    v3.FilterType = Enum.RaycastFilterType.Exclude
    local v4 = os.clock() + Travel.MaxLoadHoldSeconds
    local v5 = nil

    while os.clock() < v4 do
        Character = LocalPlayer.Character
        HumanoidRootPart = Character and Character:FindFirstChild("HumanoidRootPart")

        if HumanoidRootPart and HumanoidRootPart:IsA("BasePart") then
            v2 = true

            if v1 ~= nil then
                v2 = Travel.ArrivedStuds < (HumanoidRootPart.Position - v1).Magnitude
            end

            if v2 then
                if v5 ~= HumanoidRootPart then
                    HumanoidRootPart.Anchored = true
                    v5 = HumanoidRootPart
                end

                v3.FilterDescendantsInstances = {Character}

                if workspace:Raycast(HumanoidRootPart.Position, Vector3.new(0, -Travel.GroundCheckStuds, 0), v3) then
                    break
                end
            end
        end

        RunService.Heartbeat:Wait()
    end

    if v5 and v5.Parent then
        v5.Anchored = false
    end
end

function u39.play(a1, a2)
    -- Line: 198
    -- upvalues: Config (val), u38 (val), u42 (ref), pulse (val), dive (val), TweenService (val), LocalPlayer (val)
    -- upvalues: awaitGround (val), u43 (ref)
    -- types: a1: number?, a2: userdata?
    local Travel = Config.Appearance.Travel
    u38.play("Portal")

    u42.Visible = true
    u42.BackgroundTransparency = 1

    pulse()
    dive(a2)

    local v1 = u42
    local OutSeconds = Travel.OutSeconds
    local Quad = Enum.EasingStyle.Quad
    local In = Enum.EasingDirection.In
    local v2 = TweenService
    local new = TweenInfo.new

    v2:Create(
        v1,
        new(OutSeconds, Quad or Enum.EasingStyle.Quad, In or Enum.EasingDirection.Out),
        {BackgroundTransparency = 0}
    ):Play()

    local Character = LocalPlayer.Character
        and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
    local Position = if not Character then
        nil
    else
        if not Character:IsA("BasePart") then nil else Character.Position

    task.delay(
        Travel.OutSeconds + Travel.HoldSeconds,
        function()
            -- Line: 222
            -- upvalues: awaitGround (upval), Position (val), u42 (upval), Travel (val), TweenService (upval)
            -- upvalues: u43 (upval)
            awaitGround(Position)

            TweenService:Create(
                u42,
                TweenInfo.new(Travel.InSeconds, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
                {BackgroundTransparency = 1}
            ):Play()

            task.delay(
                Travel.InSeconds,
                function() -- Line: 233; upvalues: u42 (upval), u43 (upval)
                    u42.Visible = false
                    u43.Visible = false
                end
            )
        end
    )
end

function u39.start()
    -- Line: 240
    -- upvalues: u41 (ref), LocalPlayer (val), u42 (ref), u43 (ref), u46 (ref), u47 (ref), Remotes (val), u39 (val)
    -- upvalues: Seats (val), awaitGround (val)
    u41 = Instance.new("ScreenGui")
    u41.Name = "Travel"
    u41.ResetOnSpawn = false
    u41.IgnoreGuiInset = true
    u41.ScreenInsets = Enum.ScreenInsets.None
    u41.DisplayOrder = 50
    u41.Parent = LocalPlayer:WaitForChild("PlayerGui")
    u42 = Instance.new("Frame")
    u42.Size = UDim2.fromScale(1, 1)
    u42.BackgroundColor3 = Color3.fromRGB(8, 6, 16)
    u42.BackgroundTransparency = 1
    u42.BorderSizePixel = 0
    u42.Visible = false
    u42.Parent = u41
    u43 = Instance.new("Frame")
    u43.AnchorPoint = Vector2.new(0.5, 0.5)
    u43.Position = UDim2.fromScale(0.5, 0.5)
    u43.Size = UDim2.fromScale(0.05, 0.05)
    u43.BackgroundColor3 = Color3.fromRGB(150, 120, 255)
    u43.BackgroundTransparency = 1
    u43.BorderSizePixel = 0
    u43.Visible = false
    u43.ZIndex = 2
    u43.Parent = u41
    local UICorner = Instance.new("UICorner")
    UICorner.CornerRadius = UDim.new(1, 0)
    UICorner.Parent = u43
    local UIAspectRatioConstraint = Instance.new("UIAspectRatioConstraint")
    UIAspectRatioConstraint.AspectRatio = 1
    UIAspectRatioConstraint.Parent = u43

    LocalPlayer.CharacterAdded:Connect(function() -- Line: 286; upvalues: u46 (upval), u47 (upval)
        u46 = u46 + 1
        local CurrentCamera = workspace.CurrentCamera

        if CurrentCamera and u47 then
            CurrentCamera.CameraType = u47
        end

        u47 = nil
    end)

    ;(Remotes.get(Remotes.PortalTravel)).OnClientEvent:Connect(u39.play)

    ;(Remotes.get(Remotes.TravelMove)).OnClientEvent:Connect(function(a1)
        -- Line: 297
        -- upvalues: LocalPlayer (upval), Seats (upval), awaitGround (upval)
        if typeof(a1) ~= "CFrame" then
            return
        end

        local Character = LocalPlayer.Character
        local HumanoidRootPart = Character and Character:FindFirstChild("HumanoidRootPart")

        if Character and HumanoidRootPart and HumanoidRootPart:IsA("BasePart") then
            Seats.release(Character)

            if 4 < (HumanoidRootPart.Position - a1.Position).Magnitude then
                HumanoidRootPart.CFrame = a1
            end

            HumanoidRootPart.AssemblyLinearVelocity = Vector3.new(0, 0, 0)
            task.spawn(awaitGround, nil)
        end
    end)

    local function steady(a1) -- Line: 323; types: a1: userdata
        local Humanoid = a1:WaitForChild("Humanoid", 10)

        if Humanoid and Humanoid:IsA("Humanoid") then
            Humanoid:SetStateEnabled(Enum.HumanoidStateType.FallingDown, false)
            Humanoid:SetStateEnabled(Enum.HumanoidStateType.Ragdoll, false)
        end
    end

    if LocalPlayer.Character then
        task.spawn(steady, LocalPlayer.Character)
    end

    LocalPlayer.CharacterAdded:Connect(steady)
end

return u39