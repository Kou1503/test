-- Script path: game:GetService("Players").TheKiller150306Alt.PlayerScripts.Client.Controllers.FriendsController
-- Decompile time: 14.28 ms

local render
local ContextActionService = game:GetService("ContextActionService")
local Players = game:GetService("Players")
local SocialService = game:GetService("SocialService")
local Shared = (game:GetService("ReplicatedStorage")):WaitForChild("Shared")
local Config = require(Shared.Config)
local Remotes = require(Shared.Remotes)
local u36 = require(script.Parent.Parent.Ui)
local BuildController = require(script.Parent.BuildController)
local HudController = require(script.Parent.HudController)
local FriendPresence = require(script.Parent.FriendPresence)
local u52 = {}
local LocalPlayer = Players.LocalPlayer
local u57 = Remotes.get(Remotes.RequestFriendList)
local u60 = Remotes.get(Remotes.FriendList)
local u63 = Remotes.get(Remotes.RequestFriendAction)
local u66 = Remotes.get(Remotes.RequestIslandInvite)
local u71 = 18 + u36.tap(26)
local u76 = u71 + u36.tap(30) + 10
local u77 = {"Self", "InServer", "OtherServer", "Online"}
local u82 = {Self = "YOU", InServer = "IN YOUR SERVER", OtherServer = "PLAYING ABOVE", Online = "ONLINE"}
local u83 = {InServer = true, OtherServer = true}
local u84 = {Self = "Home", InServer = "Visit", OtherServer = "Join", Online = "Invite"}
local u85 = nil
local u86 = nil
local u87 = nil
local u88 = nil
local u89 = nil
local u90 = false
local u91 = nil
local u92 = {}
local u93 = {}
local u94 = {}
local u95 = ""

function u52.isOpen() -- Line: 96; upvalues: u86 (ref)
    local Visible = false

    if u86 ~= nil then
        Visible = u86.Visible
    end

    return Visible
end

local function matches(a1) -- Line: 103; upvalues: u95 (ref); types: a1: table
    if u95 == "" then
        return true
    end

    local v1 = string.lower(u95)
    local v2 = true

    if string.find(string.lower(a1.displayName), v1, 1, true) == nil then
        v2 = string.find(string.lower(a1.name), v1, 1, true) ~= nil
    end

    return v2
end

local function promptInvite(a1)
    -- Line: 116
    -- upvalues: LocalPlayer (val), SocialService (val), HudController (val)
    -- types: a1: number?
    task.spawn(function()
        -- Line: 117
        -- upvalues: a1 (val), LocalPlayer (upval), SocialService (upval), HudController (upval)
        local ExperienceInviteOptions = Instance.new("ExperienceInviteOptions")

        if a1 then
            ExperienceInviteOptions.InviteUser = a1
        end

        ExperienceInviteOptions.LaunchData = ("inviter=%*"):format(LocalPlayer.UserId)
        local success, err = pcall(function()
            -- Line: 125
            -- upvalues: SocialService (upval), LocalPlayer (upval), a1 (upval)
            return SocialService:CanSendGameInviteAsync(LocalPlayer, a1)
        end)

        if success and err == false then
            HudController.showAlert("Your account can't send invites (check Roblox privacy settings)")
            return
        end

        if not pcall(function()
            -- Line: 132
            -- upvalues: SocialService (upval), LocalPlayer (upval), ExperienceInviteOptions (val)
            SocialService:PromptGameInvite(LocalPlayer, ExperienceInviteOptions)
        end) then
            HudController.showAlert("Couldn't open the invite panel")
        end
    end)
end

local function makeButton(a1, a2, a3, a4)
    -- Line: 141
    -- upvalues: u36 (val)
    -- types: a1: userdata, a2: string, a3: number, a4: userdata
    local TextButton = Instance.new("TextButton")
    TextButton.Size = UDim2.fromOffset(a3, u36.tap(26))
    TextButton.BackgroundColor3 = a4
    TextButton.Text = a2
    TextButton.TextColor3 = Color3.fromRGB(245, 245, 250)
    TextButton.TextSize = u36.tapText(12)
    TextButton.FontFace = u36.Font.Bold
    TextButton.AutoButtonColor = true
    TextButton.Parent = a1
    local UICorner = Instance.new("UICorner")
    UICorner.CornerRadius = UDim.new(0, 5)
    UICorner.Parent = TextButton

    return TextButton
end

function render()
    -- Line: 158
    -- upvalues: u88 (ref), u77 (val), u92 (ref), matches (val), u82 (val), u36 (val), Config (val), LocalPlayer (val)
    -- upvalues: u83 (val), u84 (val), makeButton (val), SocialService (val), HudController (val), u63 (val), u94 (ref)
    -- upvalues: u66 (val), u91 (ref), render (val), u90 (ref), u89 (ref), u95 (ref)
    local Gold, TextLabel_2, TextLabel_3, UICorner, UIListLayout, UIListLayout_2, v1, v2, v3, v4, v5, v6, v7, v8, v9,
        v10, v11, v12, v13

    for i, j in u88:GetChildren() do
        if j:IsA("Frame") or j:IsA("TextLabel") then
            j:Destroy()
        end
    end

    local v14 = 0
    local v15 = 0
    local v16 = nil
    local v17 = nil

    for k, n in u77, v16, v17 do
        v12 = {}
        v13 = u92
        v1 = nil

        for m, i5 in v13, nil, v1 do
            if i5.group == n and matches(i5) then
                table.insert(v12, i5)
            end
        end

        if #v12 ~= 0 then
            table.sort(
                v12,
                function(a1, a2) -- Line: 181
                    return (string.lower(a1.displayName)) < string.lower(a2.displayName)
                end
            )

            TextLabel_2 = Instance.new("TextLabel")
            TextLabel_2.Size = UDim2.new(1, -12, 0, 22)
            TextLabel_2.Position = UDim2.fromOffset(6, v15)
            TextLabel_2.BackgroundTransparency = 1
            TextLabel_2.Text = ("%*  (%*)"):format(u82[n], #v12)
            TextLabel_2.TextColor3 = Color3.fromRGB(150, 158, 178)
            TextLabel_2.TextSize = 12
            TextLabel_2.FontFace = u36.Font.Bold
            TextLabel_2.TextXAlignment = Enum.TextXAlignment.Left
            TextLabel_2.Parent = u88
            v15 = v15 + 24
            v1 = nil
            v2 = nil

            for i6, i7 in v12, v1, v2 do
                v14 = v14 + 1
                v13 = Instance.new("Frame")
                v13.Size = UDim2.new(1, -12, 0, 46)
                v13.Position = UDim2.fromOffset(6, v15)
                v13.BackgroundColor3 = Color3.fromRGB(32, 35, 44)
                v13.BorderSizePixel = 0
                v13.Parent = u88
                UICorner = Instance.new("UICorner")
                UICorner.CornerRadius = UDim.new(0, 6)
                UICorner.Parent = v13
                local u755 = workspace:GetAttribute(Config.Place.Showroom.PublishedAttribute)
                    == true

                if u755 then
                    u755 = LocalPlayer:GetAttribute(Config.Place.Showroom.VisitorAttribute)
                        ~= true
                end

                v5 = (if not u83[i7.group] then 0 else 80) + 96
                v4 = v5
                    + (if i7.group ~= "InServer" then 0 else if u755 then 118 else if v3 then 0 else 118)
                TextLabel_3 = Instance.new("TextLabel")
                TextLabel_3.Size = UDim2.new(1, -v4, 1, 0)
                TextLabel_3.Position = UDim2.fromOffset(12, 0)
                TextLabel_3.BackgroundTransparency = 1
                TextLabel_3.Text = i7.displayName

                u36.asWritten(TextLabel_3)

                TextLabel_3.TextColor3 = Color3.fromRGB(238, 240, 248)
                TextLabel_3.TextSize = 14
                TextLabel_3.FontFace = u36.Font.Medium
                TextLabel_3.TextXAlignment = Enum.TextXAlignment.Left
                TextLabel_3.TextTruncate = Enum.TextTruncate.AtEnd
                TextLabel_3.Parent = v13
                local u270 = u84[i7.group]

                if u270 then
                    v4 = makeButton(v13, string.upper(u270), 74, u36.Palette.Gold)
                    v4.TextColor3 = u36.Palette.OnGold
                    v4.Position = UDim2.new(1, -84, 0.5, -u36.tap(26) / 2)

                    v4.MouseButton1Click:Connect(function()
                        -- Line: 235
                        -- upvalues: u270 (val), i7 (val), LocalPlayer (upval), SocialService (upval)
                        -- upvalues: HudController (upval), u755 (val), Config (upval), u36 (upval), u63 (upval)
                        if u270 == "Invite" then
                            local userId = i7.userId
                            task.spawn(function()
                                -- Line: 117
                                -- upvalues: userId (val), LocalPlayer (upval), SocialService (upval)
                                -- upvalues: HudController (upval)
                                local ExperienceInviteOptions = Instance.new("ExperienceInviteOptions")

                                if userId then
                                    ExperienceInviteOptions.InviteUser = userId
                                end

                                ExperienceInviteOptions.LaunchData = ("inviter=%*"):format(LocalPlayer.UserId)
                                local success, err = pcall(function()
                                    -- Line: 125
                                    -- upvalues: SocialService (upval), LocalPlayer (upval), userId (upval)
                                    return SocialService:CanSendGameInviteAsync(LocalPlayer, userId)
                                end)

                                if success and err == false then
                                    HudController.showAlert("Your account can't send invites (check Roblox privacy settings)")
                                    return
                                end

                                if not pcall(function()
                                    -- Line: 132
                                    -- upvalues: SocialService (upval), LocalPlayer (upval)
                                    -- upvalues: ExperienceInviteOptions (val)
                                    SocialService:PromptGameInvite(LocalPlayer, ExperienceInviteOptions)
                                end) then
                                    HudController.showAlert("Couldn't open the invite panel")
                                end
                            end)

                            return
                        end

                        if u270 == "Join" and u755 then
                            local LeaveWarning = Config.Place.Showroom.LeaveWarning
                            u36.confirm(
                                {
                                    danger = true,
                                    title = LeaveWarning.title,
                                    body = LeaveWarning.body,
                                    cancel = LeaveWarning.cancel,
                                    confirm = LeaveWarning.confirm,
                                },
                                function(a1) -- Line: 248; upvalues: u63 (upval), u270 (upval), i7 (upval)
                                    if a1 then
                                        u63:FireServer(u270, i7.userId)
                                    end
                                end
                            )

                            return
                        end

                        u63:FireServer(u270, i7.userId)
                    end)
                end

                if not u83[i7.group] then
                    if u83[i7.group] then
                        v6 = makeButton(v13, "INVITE", 74, Color3.fromRGB(52, 120, 150))
                        v6.Position = UDim2.new(1, -164, 0.5, -u36.tap(26) / 2)

                        v6.MouseButton1Click:Connect(function() -- Line: 271; upvalues: u66 (upval), i7 (val)
                            u66:FireServer(i7.userId)
                        end)
                    end
                elseif u94[i7.userId] then
                    v6 = makeButton(v13, "UNBAN", 74, u36.Palette.Red)
                    v6.Position = UDim2.new(1, -164, 0.5, -u36.tap(26) / 2)

                    v6.MouseButton1Click:Connect(function() -- Line: 265; upvalues: u63 (upval), i7 (val)
                        u63:FireServer("Unban", i7.userId)
                    end)
                elseif u83[i7.group] then
                    v6 = makeButton(v13, "INVITE", 74, Color3.fromRGB(52, 120, 150))
                    v6.Position = UDim2.new(1, -164, 0.5, -u36.tap(26) / 2)

                    v6.MouseButton1Click:Connect(function() -- Line: 271; upvalues: u66 (upval), i7 (val)
                        u66:FireServer(i7.userId)
                    end)
                end

                if i7.group == "InServer" then
                    if u755 or not v3 then
                        v6 = i7.role or "Visitor"

                        if v6 ~= "Owner" then
                            v8 = makeButton(v13, string.upper(Config.Permission.RoleLabels[v6] or v6), 112, Color3.fromRGB(70, 74, 92))
                            v8.Position = UDim2.new(1, -284, 0.5, -u36.tap(26) / 2)

                            v8.MouseButton1Click:Connect(function()
                                -- Line: 295
                                -- upvalues: u91 (upval), i7 (val), render (upval)
                                u91 = if u91 ~= i7.userId then i7.userId else nil
                                render()
                            end)
                        else
                            v7 = makeButton(v13, "CO-OP", 112, Color3.fromRGB(44, 96, 66))
                            v7.Position = UDim2.new(1, -284, 0.5, -u36.tap(26) / 2)
                            v7.AutoButtonColor = false
                        end
                    end
                end

                v15 = v15 + 52

                if i7.group == "InServer" and u91 == i7.userId and i7.role ~= "Owner" then
                    v13 = Instance.new("Frame")
                    v13.Size = UDim2.new(1, -12, 0, u36.tap(26) + 8)
                    v13.Position = UDim2.fromOffset(6, v15 - 4)
                    v13.BackgroundTransparency = 1
                    v13.Parent = u88
                    UIListLayout = Instance.new("UIListLayout")
                    UIListLayout.FillDirection = Enum.FillDirection.Horizontal
                    UIListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Right
                    UIListLayout.Padding = UDim.new(0, 6)
                    UIListLayout.Parent = v13
                    v8 = nil
                    v9 = nil

                    for i8, i9 in Config.Permission.RoleOrder, v8, v9 do
                        if (i7.role or "Visitor") == i9 then
                            u656 = true
                        else
                            local u656 = false
                        end

                        v11 = string.upper(Config.Permission.RoleLabels[i9] or i9)
                        Gold = if not u656 then
                            Color3.fromRGB(52, 56, 70)
                        else
                            u36.Palette.Gold
                        v10 = makeButton(v13, v11, if i9 ~= "TrustedBuilder" then 84 else 118, Gold)

                        if u656 then
                            v10.TextColor3 = u36.Palette.OnGold
                        end

                        v10.MouseButton1Click:Connect(function()
                            -- Line: 327
                            -- upvalues: u91 (upval), u63 (upval), i7 (val), i9 (val), u656 (val), render (upval)
                            -- upvalues: Config (upval), u36 (upval)
                            u91 = nil

                            local function apply() -- Line: 329; upvalues: u63 (upval), i7 (upval), i9 (upval)
                                u63:FireServer("SetRole", i7.userId, if i9 ~= "Visitor" then i9 else nil)
                            end

                            if u656 then
                                render()
                                return
                            end

                            if i9 ~= "TrustedBuilder" then
                                u63:FireServer("SetRole", i7.userId, if i9 ~= "Visitor" then i9 else nil)
                            else
                                local TrustedBuilderWarning = Config.Permission.TrustedBuilderWarning
                                u36.confirm(
                                    {
                                        danger = true,
                                        title = TrustedBuilderWarning.title,
                                        body = TrustedBuilderWarning.body,
                                        cancel = TrustedBuilderWarning.cancel,
                                        confirm = TrustedBuilderWarning.confirm,
                                    },
                                    function(a1) -- Line: 349; upvalues: u63 (upval), i7 (upval), i9 (upval)
                                        if a1 then
                                            u63:FireServer("SetRole", i7.userId, if i9 ~= "Visitor" then i9 else nil)
                                        end
                                    end
                                )
                            end

                            render()
                        end)
                    end

                    v15 = v15 + (u36.tap(26) + 10)

                    if v3 and u755 then
                        v13 = Instance.new("Frame")
                        v13.Size = UDim2.new(1, -12, 0, u36.tap(26) + 8)
                        v13.Position = UDim2.fromOffset(6, v15 - 4)
                        v13.BackgroundTransparency = 1
                        v13.Parent = u88
                        UIListLayout_2 = Instance.new("UIListLayout")
                        UIListLayout_2.FillDirection = Enum.FillDirection.Horizontal
                        UIListLayout_2.HorizontalAlignment = Enum.HorizontalAlignment.Right
                        UIListLayout_2.Padding = UDim.new(0, 6)
                        UIListLayout_2.Parent = v13

                        ;(makeButton(v13, "KICK", 84, (Color3.fromRGB(70, 74, 92)))).MouseButton1Click:Connect(function()
                            -- Line: 376
                            -- upvalues: u91 (upval), u63 (upval), i7 (val), render (upval)
                            u91 = nil
                            u63:FireServer("Kick", i7.userId)
                            render()
                        end)

                        ;(makeButton(v13, "BAN", 84, u36.Palette.Red)).MouseButton1Click:Connect(function()
                            -- Line: 382
                            -- upvalues: Config (upval), u36 (upval), u91 (upval), u63 (upval), i7 (val), render (upval)
                            local BanWarning = Config.Permission.BanWarning
                            u36.confirm(
                                {
                                    danger = true,
                                    title = BanWarning.title,
                                    body = BanWarning.body,
                                    cancel = BanWarning.cancel,
                                    confirm = BanWarning.confirm,
                                },
                                function(a1)
                                    -- Line: 390
                                    -- upvalues: u91 (upval), u63 (upval), i7 (upval), render (upval)
                                    if a1 then
                                        u91 = nil
                                        u63:FireServer("Ban", i7.userId)
                                        render()
                                    end
                                end
                            )
                        end)

                        v15 = v15 + (u36.tap(26) + 10)
                    end
                end
            end

            v15 = v15 + 6
        end
    end

    if u90 and v14 > 0 then
        local TextLabel = Instance.new("TextLabel")
        TextLabel.Size = UDim2.new(1, -12, 0, 22)
        TextLabel.Position = UDim2.fromOffset(6, v15)
        TextLabel.BackgroundTransparency = 1
        TextLabel.Text = "LOADING FRIENDS…"
        TextLabel.TextColor3 = Color3.fromRGB(120, 126, 145)
        TextLabel.TextSize = 12
        TextLabel.FontFace = u36.Font.Bold
        TextLabel.TextXAlignment = Enum.TextXAlignment.Left
        TextLabel.Parent = u88
        v15 = v15 + 24
    end

    u88.CanvasSize = UDim2.fromOffset(0, v15)
    u89.Visible = v14 == 0

    if u90 and v14 == 0 then
        if string.sub(u89.Text, 1, 7) == "LOADING" then
            return
        end

        u89.Text = "LOADING FRIENDS"

        return
    end

    u89.Text = if u95 ~= "" then "NOBODY BY THAT NAME" else "NOBODY ELSE IS HERE, AND NO FRIENDS FOUND"
end

function u52.close() -- Line: 431; upvalues: u86 (ref), BuildController (val), u91 (ref)
    local Visible = false

    if u86 ~= nil then
        Visible = u86.Visible
    end

    if not Visible then
        return
    end

    u86.Visible = false
    BuildController.setUiOpen("Friends", false)

    u91 = nil
end

function u52.open()
    -- Line: 440
    -- upvalues: u86 (ref), u36 (val), BuildController (val), u92 (ref), LocalPlayer (val), u90 (ref), u57 (val)
    -- upvalues: Remotes (val), render (val), u93 (ref), FriendPresence (val), u89 (ref)
    u86.Visible = true
    u36.appear(u86)
    BuildController.setUiOpen("Friends", true)

    local v1 = false

    for i, j in u92 do
        if j.group == "Self" then
            v1 = true
        end
    end

    if not v1 then
        table.insert(
            u92,
            1,
            {
                group = "Self",
                userId = LocalPlayer.UserId,
                name = LocalPlayer.Name,
                displayName = LocalPlayer.DisplayName,
            }
        )
    end

    u90 = true
    u57:FireServer()
    Remotes.get(Remotes.RequestPermissionSummary):FireServer()
    render()

    task.spawn(function()
        -- Line: 470
        -- upvalues: u93 (upval), FriendPresence (upval), u92 (upval), u86 (upval), render (upval)
        u93 = FriendPresence.fetch()
        FriendPresence.apply(u92, u93)

        local Visible = false

        if u86 ~= nil then
            Visible = u86.Visible
        end

        if Visible then
            render()
        end
    end)

    task.spawn(function() -- Line: 480; upvalues: u90 (upval), u86 (upval), u89 (upval)
        local Visible
        local v1 = 0

        while u90 do
            Visible = false

            if u86 ~= nil then
                Visible = u86.Visible
            end

            if not Visible then
                break
            end

            v1 = v1 % 3 + 1
            u89.Text = "LOADING FRIENDS" .. string.rep(".", v1)

            task.wait(0.4)
        end
    end)
end

function u52.toggle() -- Line: 490; upvalues: u86 (ref), u52 (val)
    local Visible = false

    if u86 ~= nil then
        Visible = u86.Visible
    end

    if Visible then
        u52.close()
        return
    end

    u52.open()
end

function u52.start()
    -- Line: 498
    -- upvalues: BuildController (val), u52 (val), u85 (ref), LocalPlayer (val), u86 (ref), u36 (val), u71 (val)
    -- upvalues: SocialService (val), HudController (val), u87 (ref), u88 (ref), u76 (val), u89 (ref), u95 (ref)
    -- upvalues: render (val), u60 (val), u92 (ref), FriendPresence (val), u93 (ref), u90 (ref), Remotes (val)
    -- upvalues: u94 (ref), ContextActionService (val)
    BuildController.registerMenu("Friends", u52.close)

    u85 = Instance.new("ScreenGui")
    u85.Name = "Friends"
    u85.ResetOnSpawn = false
    u85.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    u85.Parent = LocalPlayer:WaitForChild("PlayerGui")
    u86 = Instance.new("CanvasGroup")
    u86.Size = UDim2.fromOffset(460, 440)
    u86.Position = UDim2.new(0.5, -230, 0.5, -220)

    u36.fitToScreen(u86)

    u86.BackgroundColor3 = Color3.fromRGB(22, 24, 30)
    u86.BackgroundTransparency = 0.05
    u86.BorderSizePixel = 0
    u86.Visible = false
    u86.Active = true
    u86.Parent = u85

    u36.closeButton(u86, 10, u52.close)

    local UICorner = Instance.new("UICorner")
    UICorner.CornerRadius = UDim.new(0, 10)
    UICorner.Parent = u86
    local UIStroke = Instance.new("UIStroke")
    UIStroke.Color = Color3.fromRGB(58, 62, 78)
    UIStroke.Thickness = 1
    UIStroke.Parent = u86
    local TextLabel = Instance.new("TextLabel")
    TextLabel.Size = UDim2.new(1, -24, 0, 30)
    TextLabel.Position = UDim2.fromOffset(14, 10)
    TextLabel.BackgroundTransparency = 1
    TextLabel.Text = "PEOPLE"
    TextLabel.TextColor3 = Color3.fromRGB(238, 240, 248)
    TextLabel.TextSize = 17
    TextLabel.FontFace = u36.Font.Bold
    TextLabel.TextXAlignment = Enum.TextXAlignment.Left
    TextLabel.Parent = u86
    local TextButton = Instance.new("TextButton")
    TextButton.Size = UDim2.fromOffset(134, u36.tap(30))
    TextButton.Position = UDim2.new(1, -148, 0, u71)
    TextButton.BackgroundColor3 = u36.Palette.Gold
    TextButton.BorderSizePixel = 0
    TextButton.Text = "INVITE FRIENDS"
    TextButton.TextColor3 = u36.Palette.OnGold
    TextButton.TextSize = u36.tapText(12)
    TextButton.FontFace = u36.Font.Bold
    TextButton.AutoButtonColor = true
    TextButton.Parent = u86
    local UICorner_2 = Instance.new("UICorner")
    UICorner_2.CornerRadius = UDim.new(0, 6)
    UICorner_2.Parent = TextButton

    TextButton.Activated:Connect(function()
        -- Line: 565
        -- upvalues: LocalPlayer (upval), SocialService (upval), HudController (upval)
        local spawn = task.spawn
        local u1 = nil

        spawn(function()
            -- Line: 117
            -- upvalues: u1 (val), LocalPlayer (upval), SocialService (upval), HudController (upval)
            local ExperienceInviteOptions = Instance.new("ExperienceInviteOptions")

            if u1 then
                ExperienceInviteOptions.InviteUser = u1
            end

            ExperienceInviteOptions.LaunchData = ("inviter=%*"):format(LocalPlayer.UserId)
            local success, err = pcall(function()
                -- Line: 125
                -- upvalues: SocialService (upval), LocalPlayer (upval), u1 (upval)
                return SocialService:CanSendGameInviteAsync(LocalPlayer, u1)
            end)

            if success and err == false then
                HudController.showAlert("Your account can't send invites (check Roblox privacy settings)")
                return
            end

            if not pcall(function()
                -- Line: 132
                -- upvalues: SocialService (upval), LocalPlayer (upval), ExperienceInviteOptions (val)
                SocialService:PromptGameInvite(LocalPlayer, ExperienceInviteOptions)
            end) then
                HudController.showAlert("Couldn't open the invite panel")
            end
        end)
    end)

    u87 = Instance.new("TextBox")
    u87.Size = UDim2.new(1, -170, 0, u36.tap(30))
    u87.Position = UDim2.fromOffset(14, u71)
    u87.BackgroundColor3 = Color3.fromRGB(32, 35, 44)
    u87.BorderSizePixel = 0
    u87.PlaceholderText = "Search"
    u87.Text = ""
    u87.TextColor3 = Color3.fromRGB(238, 240, 248)
    u87.PlaceholderColor3 = Color3.fromRGB(120, 126, 145)
    u87.TextSize = 13
    u87.FontFace = u36.Font.Regular
    u87.TextXAlignment = Enum.TextXAlignment.Left
    u87.ClearTextOnFocus = false
    u87.Parent = u86
    local UICorner_3 = Instance.new("UICorner")
    UICorner_3.CornerRadius = UDim.new(0, 6)
    UICorner_3.Parent = u87
    local UIPadding = Instance.new("UIPadding")
    UIPadding.PaddingLeft = UDim.new(0, 10)
    UIPadding.Parent = u87
    u88 = Instance.new("ScrollingFrame")
    u88.Size = UDim2.new(1, -20, 1, -(u76 + 34))
    u88.Position = UDim2.fromOffset(10, u76)
    u88.BackgroundTransparency = 1
    u88.BorderSizePixel = 0
    u88.ScrollBarThickness = 5
    u88.CanvasSize = UDim2.fromOffset(0, 0)
    u88.Parent = u86
    u89 = Instance.new("TextLabel")
    u89.Size = UDim2.new(1, -28, 0, 40)
    u89.Position = UDim2.new(0, 14, 1, -74)
    u89.BackgroundTransparency = 1
    u89.Text = ""
    u89.TextColor3 = Color3.fromRGB(140, 146, 165)
    u89.TextSize = 12
    u89.FontFace = u36.Font.Regular
    u89.Visible = false
    u89.Parent = u86
    local TextLabel_2 = Instance.new("TextLabel")
    TextLabel_2.Size = UDim2.new(1, -28, 0, 16)
    TextLabel_2.Position = UDim2.new(0, 14, 1, -26)
    TextLabel_2.BackgroundTransparency = 1
    TextLabel_2.Text = "FRIENDS IN YOUR SERVER RAISE FRIEND LUCK"
    TextLabel_2.TextColor3 = Color3.fromRGB(120, 126, 145)
    TextLabel_2.TextSize = 11
    TextLabel_2.FontFace = u36.Font.Regular
    TextLabel_2.TextXAlignment = Enum.TextXAlignment.Left
    TextLabel_2.TextWrapped = true
    TextLabel_2.Parent = u86

    ;(u87:GetPropertyChangedSignal("Text")):Connect(function()
        -- Line: 626
        -- upvalues: u95 (upval), u87 (upval), render (upval)
        u95 = u87.Text
        render()
    end)

    u60.OnClientEvent:Connect(function(a1, a2)
        -- Line: 631
        -- upvalues: u92 (upval), FriendPresence (upval), u93 (upval), u90 (upval), u86 (upval), render (upval)
        if type(a1) ~= "table" then
            return
        end

        local v1 = {}

        for i, j in a1 do
            if type(j) == "table" and type(j.userId) == "number" then
                table.insert(v1, j)
            end
        end

        FriendPresence.apply(v1, u93)

        u90 = a2 == true
        local Visible = false

        if u86 ~= nil then
            Visible = u86.Visible
        end

        if Visible then
            render()
        end
    end)

    ;(Remotes.get(Remotes.PermissionSummary)).OnClientEvent:Connect(function(a1)
        -- Line: 651
        -- upvalues: u94 (upval), u86 (upval), render (upval)
        if type(a1) == "table" and type(a1.bans) == "table" then
            local v1 = {}

            for i, j in a1.bans do
                if type(j) == "table" and type(j.userId) == "number" then
                    v1[j.userId] = true
                end
            end

            u94 = v1
            local Visible = false

            if u86 ~= nil then
                Visible = u86.Visible
            end

            if Visible then
                render()
            end
        end
    end)

    ;(Remotes.get(Remotes.FriendRoleChanged)).OnClientEvent:Connect(function(a1, a2)
        -- Line: 671
        -- upvalues: u92 (upval), u86 (upval), render (upval)
        local v1

        if type(a1) ~= "number" then
            return
        end

        local v2 = u92
        local v3 = nil
        local v4 = nil
        local v5, v6 = a1, a2

        for i, j in v2, v3, v4 do
            if j.userId == v5 then
                v1 = if type(v6) ~= "string" then nil else v6
                j.role = v1
            end
        end

        local Visible = false

        if u86 ~= nil then
            Visible = u86.Visible
        end

        if Visible then
            render()
        end
    end)

    local L = Enum.KeyCode.L
    ContextActionService:BindAction(
        "ToggleFriends",
        function(a1, a2) -- Line: 687; upvalues: u52 (upval)
            if a2 == Enum.UserInputState.Begin then
                u52.toggle()
            end

            return Enum.ContextActionResult.Sink
        end,
        false,
        L
    )
end

return u52