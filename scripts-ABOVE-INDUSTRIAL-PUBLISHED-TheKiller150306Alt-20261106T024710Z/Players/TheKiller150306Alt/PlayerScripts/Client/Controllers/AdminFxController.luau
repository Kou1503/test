-- Script path: game:GetService("Players").TheKiller150306Alt.PlayerScripts.Client.Controllers.AdminFxController
-- Decompile time: 8.87 ms

local Lighting = game:GetService("Lighting")
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local Shared = (game:GetService("ReplicatedStorage")):WaitForChild("Shared")
local Config = require(Shared.Config)
local Remotes = require(Shared.Remotes)
local u35 = require(script.Parent.AudioController)
local v1 = {}
local LocalPlayer = Players.LocalPlayer
local AdminFun = Config.AdminFun

local function humanoidAndRoot() -- Line: 27; upvalues: LocalPlayer (val)
    local Character = LocalPlayer.Character

    if not Character then
        return nil, nil
    end

    local Humanoid = Character:FindFirstChildOfClass("Humanoid")
    local HumanoidRootPart = Character:FindFirstChild("HumanoidRootPart")
    local v1 = Humanoid

    if HumanoidRootPart and HumanoidRootPart:IsA("BasePart") then
        return v1, HumanoidRootPart
    end

    return v1, nil
end

local function controls() -- Line: 39; upvalues: LocalPlayer (val)
    local success, err = pcall(function() -- Line: 40; upvalues: LocalPlayer (upval)
        local PlayerModule = (LocalPlayer:WaitForChild("PlayerScripts")):WaitForChild("PlayerModule", 2)

        if PlayerModule then
            return (require(PlayerModule):GetControls())
        end

        return nil
    end)

    if success then
        return err
    end

    return nil
end

local function fling() -- Line: 48; upvalues: LocalPlayer (val), AdminFun (val)
    local u12, v1
    local Character = LocalPlayer.Character

    if Character then
        local Humanoid = Character:FindFirstChildOfClass("Humanoid")
        local HumanoidRootPart = Character:FindFirstChild("HumanoidRootPart")
        u12 = Humanoid
        v1 = if not HumanoidRootPart then
            nil
        else
            if not HumanoidRootPart:IsA("BasePart") then nil else HumanoidRootPart
    else
        u12 = nil
        v1 = nil
    end

    if u12 and v1 then
        local v2 = math.random() * 3.141592653589793 * 2
        local v3 = (Vector3.new(math.cos(v2), 0, (math.sin(v2))))
            * AdminFun.Fling.OutSpeed
        u12.PlatformStand = true
        v1.AssemblyLinearVelocity = v3 + Vector3.new(0, AdminFun.Fling.UpSpeed, 0)
        v1.AssemblyAngularVelocity = Vector3.new(math.random() - 0.5, math.random() - 0.5, (math.random()) - 0.5).Unit
            * AdminFun.Fling.Spin

        task.delay(
            AdminFun.Fling.TumbleSeconds,
            function() -- Line: 59; upvalues: u12 (val)
                if u12.Parent then
                    u12.PlatformStand = false
                end
            end
        )
    end
end

local u42 = 0

local function dizzy(a1) -- Line: 70; upvalues: u42 (ref), LocalPlayer (val), RunService (val); types: a1: number
    local v1 = os.clock()
    local v2 = u42 <= v1
    u42 = os.clock() + a1

    if not v2 then
        return
    end

    local success, err = pcall(function() -- Line: 40; upvalues: LocalPlayer (upval)
        local PlayerModule = (LocalPlayer:WaitForChild("PlayerScripts")):WaitForChild("PlayerModule", 2)

        if PlayerModule then
            return (require(PlayerModule):GetControls())
        end

        return nil
    end)
    local u16 = if not success then nil else err

    if u16 then
        u16:Disable()
    end

    local u24 = math.random() * 3.141592653589793 * 2
    local u26 = os.clock()

    RunService:BindToRenderStep(
        "AboveAdminDizzy",
        Enum.RenderPriority.Camera.Value + 1,
        function(a1)
            -- Line: 82
            -- upvalues: LocalPlayer (upval), u42 (upval), RunService (upval), u16 (val), u24 (ref), u26 (val)
            local v1
            local v2 = os.clock()
            local Character = LocalPlayer.Character

            if Character then
                local Humanoid = Character:FindFirstChildOfClass("Humanoid")
                local HumanoidRootPart = Character:FindFirstChild("HumanoidRootPart")
                v1 = Humanoid

                if HumanoidRootPart and not HumanoidRootPart:IsA("BasePart") then end
            else
                v1 = nil
            end

            if u42 <= v2 then
                RunService:UnbindFromRenderStep("AboveAdminDizzy")

                if v1 then
                    v1:Move(Vector3.new(0, 0, 0), false)
                end

                if u16 then
                    u16:Enable()
                end

                return
            end

            u24 = u24
                + (math.noise(v2 * 0.7, 3.1) * 6 + math.sin(v2 * 2.3) * 2) * a1

            if v1 then
                v1:Move(Vector3.new(math.cos(u24), 0, (math.sin(u24))), false)
            end

            local CurrentCamera = workspace.CurrentCamera

            if CurrentCamera then
                local v3 = math.min(1, (v2 - u26) / 1.5)
                local v4 = math.sin(v2 * 1.7) * 0.22 * v3
                CurrentCamera.CFrame = CurrentCamera.CFrame
                    * CFrame.Angles(math.sin(v2 * 1.1 + 1) * 0.05 * v3, 0, v4)
            end
        end
    )
end

local function jumpscare() -- Line: 112; upvalues: AdminFun (val), LocalPlayer (val), u35 (val), RunService (val)
    local Jumpscare = AdminFun.Jumpscare
    local ScreenGui = Instance.new("ScreenGui")
    ScreenGui.Name = "AdminJumpscare"
    ScreenGui.IgnoreGuiInset = true
    ScreenGui.ScreenInsets = Enum.ScreenInsets.None
    ScreenGui.DisplayOrder = 1000
    ScreenGui.ResetOnSpawn = false
    local Frame = Instance.new("Frame")
    Frame.Size = UDim2.fromScale(1, 1)
    Frame.BackgroundColor3 = Color3.new(0, 0, 0)
    Frame.BorderSizePixel = 0
    Frame.Parent = ScreenGui

    if not (0 < Jumpscare.ImageId) then
        Frame.BackgroundColor3 = Color3.fromRGB(150, 0, 0)
        local TextLabel = Instance.new("TextLabel")
        TextLabel.Size = UDim2.fromScale(1, 1)
        TextLabel.BackgroundTransparency = 1
        TextLabel.Text = "👁️👄👁️"
        TextLabel.TextScaled = true
        TextLabel.Parent = Frame
    else
        local ImageLabel = Instance.new("ImageLabel")
        ImageLabel.Size = UDim2.fromScale(1, 1)
        ImageLabel.BackgroundTransparency = 1
        ImageLabel.Image = ("rbxassetid://%*"):format(Jumpscare.ImageId)
        ImageLabel.ScaleType = Enum.ScaleType.Crop
        ImageLabel.Parent = Frame
    end

    ScreenGui.Parent = LocalPlayer:WaitForChild("PlayerGui")

    if 0 < Jumpscare.SoundId then
        local Sound = Instance.new("Sound")
        Sound.SoundId = ("rbxassetid://%*"):format(Jumpscare.SoundId)
        Sound.Volume = Jumpscare.Volume

        u35.playSfx(Sound)
    end

    local u80 = os.clock() + Jumpscare.Seconds
    local u81 = nil
    u81 = (RunService.RenderStepped:Connect(function()
        -- Line: 158
        -- upvalues: u80 (val), u81 (ref), ScreenGui (val), Frame (val)
        if not (u80 <= os.clock()) then
            Frame.Position = UDim2.fromOffset(math.random(-14, 14), math.random(-14, 14))
            return
        end

        u81:Disconnect()
        ScreenGui:Destroy()
    end))
end

local u45 = 0

local function glitch(a1) -- Line: 172; upvalues: u45 (ref), Lighting (val), RunService (val); types: a1: number
    local v1 = os.clock()
    local v2 = u45 <= v1
    u45 = os.clock() + a1

    if not v2 then
        return
    end

    local ColorCorrectionEffect = Instance.new("ColorCorrectionEffect")
    ColorCorrectionEffect.Name = "AdminGlitch"
    ColorCorrectionEffect.Parent = Lighting
    local u16 = 0

    RunService:BindToRenderStep(
        "AboveAdminGlitch",
        Enum.RenderPriority.Camera.Value + 2,
        function() -- Line: 184; upvalues: u45 (upval), RunService (upval), ColorCorrectionEffect (val), u16 (ref)
            local v1 = os.clock()

            if u45 <= v1 then
                RunService:UnbindFromRenderStep("AboveAdminGlitch")
                ColorCorrectionEffect:Destroy()

                return
            end

            local v2 = v1 < u16 + 0.12

            if u16 + 0.12 <= v1 and math.random() < 0.04 then
                u16 = v1
            end

            local v3 = if not v2 then math.sin(v1 * 9) * 0.3 else math.random() * 2 - 1
            ColorCorrectionEffect.Saturation = v3
            ColorCorrectionEffect.Contrast = if not v2 then 0.1 else math.random() * 0.8
            v3 = if not v2 then
                Color3.fromRGB(235, 255, 245)
            else
                Color3.fromHSV(math.random(), 0.6, 1)
            ColorCorrectionEffect.TintColor = v3
            local CurrentCamera = workspace.CurrentCamera

            if CurrentCamera then
                v3 = if not v2 then 0.05 else 0.6
                local CFrame_2 = CurrentCamera.CFrame
                local v4 = CFrame.new((math.random() - 0.5) * v3, (math.random() - 0.5) * v3, 0)
                local Angles = CFrame.Angles
                local v5 = if not v2 then
                    math.sin(v1 * 3) * 0.02
                else
                    (math.random() - 0.5) * 0.5
                CurrentCamera.CFrame = CFrame_2 * (v4 * Angles(0, 0, v5))
            end
        end
    )
end

local u47 = nil

local function party() -- Line: 215; upvalues: LocalPlayer (val), AdminFun (val), u47 (ref)
    local v1
    local Character = LocalPlayer.Character

    if Character then
        local Humanoid = Character:FindFirstChildOfClass("Humanoid")
        local HumanoidRootPart = Character:FindFirstChild("HumanoidRootPart")
        v1 = Humanoid

        if HumanoidRootPart and not HumanoidRootPart:IsA("BasePart") then end
    else
        v1 = nil
    end

    local Animator = v1

    if Animator then
        Animator = v1:FindFirstChildOfClass("Animator")
    end

    if v1 and Animator then
        local DancesR6 = if v1.RigType ~= Enum.HumanoidRigType.R6 then
            AdminFun.Party.DancesR15
        else
            AdminFun.Party.DancesR6
        local u38 = Instance.new("Animation")
        u38.AnimationId = DancesR6[math.random(1, #DancesR6)]
        local success, err = pcall(function() -- Line: 230; upvalues: Animator (val), u38 (val)
            return Animator:LoadAnimation(u38)
        end)

        if success and err then
            if u47 then
                u47:Stop(0.2)
            end

            u47 = err
            err.Priority = Enum.AnimationPriority.Action
            err.Looped = true

            err:Play(0.2)

            task.delay(
                AdminFun.Party.Seconds,
                function() -- Line: 243; upvalues: u47 (upval), err (val)
                    if u47 == err then
                        err:Stop(0.4)

                        u47 = nil
                    end
                end
            )
        end
    end
end

local u49 = nil
local u50 = nil

local function pointCameraAt(a1) -- Line: 255; upvalues: LocalPlayer (val); types: a1: userdata?
    local v1
    local CurrentCamera = workspace.CurrentCamera

    if not CurrentCamera then
        return
    end

    local Humanoid = if not a1 then
        nil
    else
        if not a1.Character then nil else a1.Character:FindFirstChildOfClass("Humanoid")

    if Humanoid then
        CurrentCamera.CameraSubject = Humanoid
        return
    end

    local Character = LocalPlayer.Character

    if Character then
        local Humanoid_2 = Character:FindFirstChildOfClass("Humanoid")
        local HumanoidRootPart = Character:FindFirstChild("HumanoidRootPart")
        v1 = Humanoid_2

        if HumanoidRootPart and not HumanoidRootPart:IsA("BasePart") then end
    else
        v1 = nil
    end

    if v1 then
        CurrentCamera.CameraSubject = v1
    end
end

local function spectate(a1) -- Line: 271; upvalues: u50 (ref), u49 (ref), LocalPlayer (val); types: a1: userdata?
    if u50 then
        u50:Disconnect()

        u50 = nil
    end

    u49 = a1
    local CurrentCamera = workspace.CurrentCamera

    if CurrentCamera then
        local Humanoid = if not a1 then
            nil
        else
            if not a1.Character then nil else a1.Character:FindFirstChildOfClass("Humanoid")

        if not Humanoid then
            local v1
            local Character = LocalPlayer.Character

            if Character then
                local Humanoid_2 = Character:FindFirstChildOfClass("Humanoid")
                local HumanoidRootPart = Character:FindFirstChild("HumanoidRootPart")
                v1 = Humanoid_2

                if HumanoidRootPart and not HumanoidRootPart:IsA("BasePart") then end
            else
                v1 = nil
            end

            if v1 then
                CurrentCamera.CameraSubject = v1
            end
        else
            CurrentCamera.CameraSubject = Humanoid
        end
    end

    if a1 then
        u50 = a1.CharacterAdded:Connect(function() -- Line: 280; upvalues: u49 (upval), a1 (val), LocalPlayer (upval)
            task.wait(0.1)

            if u49 == a1 then
                local v1
                local CurrentCamera = workspace.CurrentCamera

                if not CurrentCamera then
                    return
                end

                local Humanoid = if not a1 then
                    nil
                else
                    if not a1.Character then nil else a1.Character:FindFirstChildOfClass("Humanoid")

                if Humanoid then
                    CurrentCamera.CameraSubject = Humanoid
                    return
                end

                local Character = LocalPlayer.Character

                if Character then
                    local Humanoid_2 = Character:FindFirstChildOfClass("Humanoid")
                    local HumanoidRootPart = Character:FindFirstChild("HumanoidRootPart")
                    v1 = Humanoid_2

                    if HumanoidRootPart and not HumanoidRootPart:IsA("BasePart") then end
                else
                    v1 = nil
                end

                if v1 then
                    CurrentCamera.CameraSubject = v1
                end
            end
        end)
    end
end

function v1.start()
    -- Line: 289
    -- upvalues: Remotes (val), fling (val), dizzy (val), AdminFun (val), jumpscare (val), glitch (val), party (val)
    -- upvalues: u50 (ref), u49 (ref), LocalPlayer (val)
    (Remotes.get(Remotes.AdminFx)).OnClientEvent:Connect(function(a1, a2)
        -- Line: 290
        -- upvalues: fling (upval), dizzy (upval), AdminFun (upval), jumpscare (upval), glitch (upval), party (upval)
        -- upvalues: u50 (upval), u49 (upval), LocalPlayer (upval)
        -- types: a1: string
        if a1 == "fling" then
            fling()
            return
        end

        if a1 == "dizzy" then
            dizzy(if type(a2) ~= "number" then AdminFun.DizzySeconds else a2)
            return
        end

        if a1 == "jumpscare" then
            jumpscare()
            return
        end

        if a1 == "glitch" then
            glitch(if type(a2) ~= "number" then AdminFun.GlitchSeconds else a2)
            return
        end

        if a1 == "party" then
            party()
            return
        end

        if a1 == "spectate" then
            local u36 = if typeof(a2) ~= "Instance" then
                nil
            else
                if not a2:IsA("Player") then nil else a2

            if u50 then
                u50:Disconnect()

                u50 = nil
            end

            u49 = u36
            local CurrentCamera = workspace.CurrentCamera

            if CurrentCamera then
                local Humanoid = if not u36 then
                    nil
                else
                    if not u36.Character then
                        nil
                    else
                        u36.Character:FindFirstChildOfClass("Humanoid")

                if not Humanoid then
                    local v1
                    local Character = LocalPlayer.Character

                    if Character then
                        local Humanoid_2 = Character:FindFirstChildOfClass("Humanoid")
                        local HumanoidRootPart = Character:FindFirstChild("HumanoidRootPart")
                        v1 = Humanoid_2

                        if HumanoidRootPart and not HumanoidRootPart:IsA("BasePart") then end
                    else
                        v1 = nil
                    end

                    if v1 then
                        CurrentCamera.CameraSubject = v1
                    end
                else
                    CurrentCamera.CameraSubject = Humanoid
                end
            end

            if u36 then
                u50 = u36.CharacterAdded:Connect(function()
                    -- Line: 280
                    -- upvalues: u49 (upval), u36 (val), LocalPlayer (upval)
                    task.wait(0.1)

                    if u49 == u36 then
                        local v1
                        local CurrentCamera = workspace.CurrentCamera

                        if not CurrentCamera then
                            return
                        end

                        local Humanoid = if not u36 then
                            nil
                        else
                            if not u36.Character then
                                nil
                            else
                                u36.Character:FindFirstChildOfClass("Humanoid")

                        if Humanoid then
                            CurrentCamera.CameraSubject = Humanoid
                            return
                        end

                        local Character = LocalPlayer.Character

                        if Character then
                            local Humanoid_2 = Character:FindFirstChildOfClass("Humanoid")
                            local HumanoidRootPart = Character:FindFirstChild("HumanoidRootPart")
                            v1 = Humanoid_2

                            if HumanoidRootPart and not HumanoidRootPart:IsA("BasePart") then end
                        else
                            v1 = nil
                        end

                        if v1 then
                            CurrentCamera.CameraSubject = v1
                        end
                    end
                end)
            end
        end
    end)

    LocalPlayer.CharacterAdded:Connect(function() -- Line: 306; upvalues: u49 (upval), LocalPlayer (upval)
        if u49 then
            local v1
            task.wait(0.1)

            local v2 = u49
            local CurrentCamera = workspace.CurrentCamera

            if not CurrentCamera then
                return
            end

            local Humanoid = if not v2 then
                nil
            else
                if not v2.Character then nil else v2.Character:FindFirstChildOfClass("Humanoid")

            if Humanoid then
                CurrentCamera.CameraSubject = Humanoid
                return
            end

            local Character = LocalPlayer.Character

            if Character then
                local Humanoid_2 = Character:FindFirstChildOfClass("Humanoid")
                local HumanoidRootPart = Character:FindFirstChild("HumanoidRootPart")
                v1 = Humanoid_2

                if HumanoidRootPart and not HumanoidRootPart:IsA("BasePart") then end
            else
                v1 = nil
            end

            if v1 then
                CurrentCamera.CameraSubject = v1
            end
        end
    end)
end

return v1