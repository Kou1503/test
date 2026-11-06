-- Script path: game:GetService("Players").TheKiller150306Alt.PlayerScripts.Client.Controllers.IslandPermissionsController
-- Decompile time: 9.75 ms

local Players = game:GetService("Players")
local Shared = (game:GetService("ReplicatedStorage")):WaitForChild("Shared")
local Config = require(Shared.Config)
local Remotes = require(Shared.Remotes)
local u26 = require(script.Parent.Parent.Ui)
local SettingsController = require(script.Parent.SettingsController)
local v1 = {}
local LocalPlayer = Players.LocalPlayer
local u36 = Remotes.get(Remotes.RequestPermissionSummary)
local u39 = Remotes.get(Remotes.PermissionSummary)
local u42 = Remotes.get(Remotes.RequestPermissionToggle)
local u45 = Remotes.get(Remotes.RequestFriendAction)
local u50 = Color3.fromRGB(32, 35, 44)
local u55 = Color3.fromRGB(58, 132, 96)
local u60 = Color3.fromRGB(64, 68, 84)
local u65 = Color3.fromRGB(178, 96, 54)
local Gold = u26.Palette.Gold
local u68 = nil
local u69 = nil
local u70 = nil
local u71 = 0
local u72 = false

function v1.isOpen() -- Line: 64; upvalues: u72 (ref)
    return u72
end

local function nextOrder() -- Line: 71; upvalues: u71 (ref)
    u71 = u71 + 1
    return u71
end

local function text(a1, a2, a3, a4, a5, a6)
    -- Line: 76
    -- upvalues: u71 (ref), u26 (val)
    -- types: a1: userdata, a2: string, a3: number, a4: userdata, a5: userdata?, a6: boolean?
    local TextLabel = Instance.new("TextLabel")
    u71 = u71 + 1
    TextLabel.LayoutOrder = u71
    TextLabel.Size = UDim2.fromScale(1, 0)
    TextLabel.AutomaticSize = Enum.AutomaticSize.Y
    TextLabel.BackgroundTransparency = 1
    TextLabel.Text = a2
    TextLabel.TextSize = a3
    TextLabel.TextColor3 = a4
    TextLabel.FontFace = a5 or u26.Font.Regular
    TextLabel.TextXAlignment = Enum.TextXAlignment.Left
    TextLabel.TextWrapped = a6 ~= false
    TextLabel.Parent = a1

    return TextLabel
end

local function heading(a1, a2, a3)
    -- Line: 99
    -- upvalues: u71 (ref), u68 (ref), text (val), u26 (val)
    -- types: a1: string, a2: string?, a3: string?
    local Frame = Instance.new("Frame")
    u71 = u71 + 1
    Frame.LayoutOrder = u71
    Frame.Size = UDim2.fromOffset(0, 4)
    Frame.BackgroundTransparency = 1
    Frame.Parent = u68
    local v1 = (string.upper(a1)) .. (if not a3 then "" else (" %*"):format(a3))

    text(u68, v1, 12, Color3.fromRGB(150, 158, 178), u26.Font.Bold, false)

    if a2 then
        text(u68, a2, 11, u26.Palette.Faint)
    end
end

local function card() -- Line: 113; upvalues: u71 (ref), u50 (val), u68 (ref), u26 (val)
    local Frame = Instance.new("Frame")
    u71 = u71 + 1
    Frame.LayoutOrder = u71
    Frame.Size = UDim2.new(1, -6, 0, 0)
    Frame.AutomaticSize = Enum.AutomaticSize.Y
    Frame.BackgroundColor3 = u50
    Frame.BorderSizePixel = 0
    Frame.Parent = u68

    u26.corner(Frame, 6)

    local UIPadding = Instance.new("UIPadding")
    UIPadding.PaddingTop = UDim.new(0, 8)
    UIPadding.PaddingBottom = UDim.new(0, 8)
    UIPadding.PaddingLeft = UDim.new(0, 12)
    UIPadding.PaddingRight = UDim.new(0, 12)
    UIPadding.Parent = Frame
    local UIListLayout = Instance.new("UIListLayout")
    UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
    UIListLayout.Padding = UDim.new(0, 3)
    UIListLayout.Parent = Frame

    return Frame
end

local function button(a1, a2, a3, a4)
    -- Line: 135
    -- upvalues: u26 (val), Gold (val)
    -- types: a1: userdata, a2: string, a3: userdata, a4: number
    local TextButton = Instance.new("TextButton")
    TextButton.Size = UDim2.fromOffset(a4, u26.tap(26))
    TextButton.BackgroundColor3 = a3
    TextButton.Text = a2
    local OnGold = if a3 ~= Gold then Color3.fromRGB(245, 246, 252) else u26.Palette.OnGold
    TextButton.TextColor3 = OnGold
    TextButton.TextSize = u26.tapText(12)
    TextButton.FontFace = u26.Font.Bold
    TextButton.AutoButtonColor = true
    TextButton.Parent = a1

    u26.corner(TextButton, 5)

    return TextButton
end

local u79 = nil

local function drawAccess()
    -- Line: 153
    -- upvalues: heading (val), SettingsController (val), u71 (ref), u26 (val), u68 (ref), Config (val), button (val)
    -- upvalues: Gold (val), u60 (val), u79 (ref), text (val)
    local v1, v2
    heading("Who can visit your island")

    local IslandAccess = SettingsController.get("IslandAccess")
    local Frame = Instance.new("Frame")
    u71 = u71 + 1
    Frame.LayoutOrder = u71
    Frame.Size = UDim2.new(1, -6, 0, u26.tap(26) + 2)
    Frame.BackgroundTransparency = 1
    Frame.Parent = u68
    local UIListLayout = Instance.new("UIListLayout")
    UIListLayout.FillDirection = Enum.FillDirection.Horizontal
    UIListLayout.Padding = UDim.new(0, 6)
    UIListLayout.Parent = Frame
    local v3 = nil
    local v4 = nil

    for i, j in Config.Permission.VisitPolicies, v3, v4 do
        v1 = Config.Permission.VisitPolicyLabels[j]
        v2 = IslandAccess == j

        ;(button(Frame, string.upper(v1.label), if not v2 then u60 else Gold, 110)).Activated:Connect(function()
            -- Line: 169
            -- upvalues: SettingsController (upval), j (val), u79 (upval)
            SettingsController.set("IslandAccess", j)
            u79()
        end)
    end

    local v5 = Config.Permission.VisitPolicyLabels[IslandAccess]

    if v5 then
        text(u68, v5.detail, 12, u26.Palette.Gold)
    end
end

local function drawRoles() -- Line: 181; upvalues: heading (val), Config (val), card (val), text (val), u26 (val)
    local v1
    heading("Roles")

    for i, j in Config.Permission.RoleOrder do
        v1 = card()
        text(v1, Config.Permission.RoleLabels[j] or j, 14, u26.Palette.Gold, u26.Font.Bold, false)
        text(v1, Config.Permission.RoleBlurbs[j] or "", 12, u26.Palette.Text)
    end
end

local function drawPeople(a1)
    -- Line: 201
    -- upvalues: heading (val), Players (val), LocalPlayer (val), text (val), u68 (ref), u26 (val), card (val)
    -- upvalues: u71 (ref), button (val), u55 (val), Config (val), Gold (val), u60 (val), u45 (val)
    -- types: a1: table
    local Frame, Frame_2, UIListLayout, v1, v2, v3, v4, v5, v6, v7
    heading("People in this server")

    local v8 = {}

    for i, j in a1.roles do
        v8[j.userId] = j.role
    end

    local v9 = {}

    for k, n in a1.coop or {} do
        v9[n] = true
    end

    local v10 = {}

    for m, i5 in Players:GetPlayers() do
        if i5 ~= LocalPlayer then
            table.insert(v10, i5)
        end
    end

    table.sort(
        v10,
        function(a1, a2) -- Line: 218
            return (string.lower(a1.DisplayName)) < string.lower(a2.DisplayName)
        end
    )

    if #v10 == 0 then
        text(u68, "Nobody else is in this server right now.", 12, u26.Palette.Faint)
        return
    end

    local v11 = nil
    local v12 = nil

    for i6, i7 in v10, v11, v12 do
        v7 = card()
        v1 = text(v7, ("%*  <font color=\"#%*\">@%*</font>"):format(i7.DisplayName, u26.Palette.Faint:ToHex(), i7.Name), 13, u26.Palette.Text, u26.Font.Bold, false)
        v1.RichText = true
        Frame = Instance.new("Frame")
        u71 = u71 + 1
        Frame.LayoutOrder = u71
        Frame.Size = UDim2.new(1, 0, 0, u26.tap(26))
        Frame.BackgroundTransparency = 1
        Frame.Parent = v7
        UIListLayout = Instance.new("UIListLayout")
        UIListLayout.FillDirection = Enum.FillDirection.Horizontal
        UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
        UIListLayout.Padding = UDim.new(0, 6)
        UIListLayout.Parent = Frame

        if not v9[i7.UserId] then
            v3 = v8[i7.UserId] or "Visitor"
            v4 = nil
            v5 = nil

            for i8, i9 in Config.Permission.RoleOrder, v4, v5 do
                if v3 == i9 then
                    u209 = true
                else
                    local u209 = false
                end

                v6 = button(Frame, string.upper(Config.Permission.RoleLabels[i9] or i9), if not u209 then u60 else Gold, if i9 ~= "TrustedBuilder" then 84 else 118)
                v6.LayoutOrder = i8

                v6.Activated:Connect(function()
                    -- Line: 261
                    -- upvalues: u209 (val), u45 (upval), i7 (val), i9 (val), Config (upval), u26 (upval)
                    if u209 then
                        return
                    end

                    local function apply() -- Line: 265; upvalues: u45 (upval), i7 (upval), i9 (upval)
                        u45:FireServer("SetRole", i7.UserId, if i9 ~= "Visitor" then i9 else nil)
                    end

                    if i9 ~= "TrustedBuilder" then
                        u45:FireServer("SetRole", i7.UserId, if i9 ~= "Visitor" then i9 else nil)
                        return
                    end

                    local TrustedBuilderWarning = Config.Permission.TrustedBuilderWarning
                    u26.confirm(
                        {
                            danger = true,
                            title = TrustedBuilderWarning.title,
                            body = TrustedBuilderWarning.body,
                            cancel = TrustedBuilderWarning.cancel,
                            confirm = TrustedBuilderWarning.confirm,
                        },
                        function(a1) -- Line: 277; upvalues: u45 (upval), i7 (upval), i9 (upval)
                            if a1 then
                                u45:FireServer("SetRole", i7.UserId, if i9 ~= "Visitor" then i9 else nil)
                            end
                        end
                    )
                end)
            end

            Frame_2 = Instance.new("Frame")
            u71 = u71 + 1
            Frame_2.LayoutOrder = u71
            Frame_2.Size = UDim2.new(1, 0, 0, u26.tap(26))
            Frame_2.BackgroundTransparency = 1
            Frame_2.Parent = v7
            v1 = Instance.new("UIListLayout")
            v1.FillDirection = Enum.FillDirection.Horizontal
            v1.SortOrder = Enum.SortOrder.LayoutOrder
            v1.Padding = UDim.new(0, 6)
            v1.Parent = Frame_2
            v1 = button(Frame_2, "KICK", u60, 84)
            v1.LayoutOrder = 1

            v1.Activated:Connect(function() -- Line: 301; upvalues: u45 (upval), i7 (val)
                u45:FireServer("Kick", i7.UserId)
            end)

            v1 = button(Frame_2, "BAN", u26.Palette.Red, 84)
            v1.LayoutOrder = 2

            v1.Activated:Connect(function() -- Line: 306; upvalues: Config (upval), u26 (upval), u45 (upval), i7 (val)
                local BanWarning = Config.Permission.BanWarning
                u26.confirm(
                    {
                        danger = true,
                        title = BanWarning.title,
                        body = BanWarning.body,
                        cancel = BanWarning.cancel,
                        confirm = BanWarning.confirm,
                    },
                    function(a1) -- Line: 314; upvalues: u45 (upval), i7 (upval)
                        if a1 then
                            u45:FireServer("Ban", i7.UserId)
                        end
                    end
                )
            end)
        else
            v2 = button(Frame, "CO-OP", u55, 96)
            v2.AutoButtonColor = false
        end
    end
end

local function drawBans(a1)
    -- Line: 325
    -- upvalues: heading (val), text (val), u68 (ref), u26 (val), card (val), u71 (ref), button (val), u55 (val)
    -- upvalues: u45 (val)
    -- types: a1: table
    local Frame, v1
    heading("Banned from this island")

    local bans = a1.bans or {}

    if #bans == 0 then
        text(u68, "Nobody is banned.", 12, u26.Palette.Faint)
        return
    end

    for i, j in bans do
        v1 = card()
        Frame = Instance.new("Frame")
        u71 = u71 + 1
        Frame.LayoutOrder = u71
        Frame.Size = UDim2.new(1, 0, 0, u26.tap(26))
        Frame.BackgroundTransparency = 1
        Frame.Parent = v1
        v1 = Instance.new("UIListLayout")
        v1.FillDirection = Enum.FillDirection.Horizontal
        v1.SortOrder = Enum.SortOrder.LayoutOrder
        v1.VerticalAlignment = Enum.VerticalAlignment.Center
        v1.Padding = UDim.new(0, 8)
        v1.Parent = Frame
        v1 = text(Frame, ("@%*"):format(j.name), 13, u26.Palette.Text, u26.Font.Bold, false)
        v1.LayoutOrder = 1
        v1.Size = UDim2.new(1, -100, 0, u26.tap(26))
        v1 = button(Frame, "UNBAN", u55, 84)
        v1.LayoutOrder = 2

        v1.Activated:Connect(function() -- Line: 350; upvalues: u45 (upval), j (val)
            u45:FireServer("Unban", j.userId)
        end)
    end
end

local function drawToggleGroup(a1, a2, a3)
    -- Line: 356
    -- upvalues: u70 (ref), u71 (ref), u26 (val), u50 (val), u68 (ref), Config (val), button (val), u65 (val), u55 (val)
    -- upvalues: u60 (val), u79 (ref), u42 (val), text (val)
    -- types: a1: string, a3: table
    local Frame, TextLabel, TextLabel_2, v1, v2
    local v3 = {}

    for i in a2 do
        table.insert(v3, i)
    end

    table.sort(v3)

    local v4 = nil
    local v5 = nil
    local v6, v7 = a2, a3

    for j, k in v3, v4, v5 do
        local u28 = v6[k]

        if not u28.deferred then
            if v7[k] == true then
                u33 = true
            else
                local u33 = false
            end

            if u70 == k then
                u37 = true
            else
                local u37 = false
            end

            Frame = Instance.new("Frame")
            u71 = u71 + 1
            Frame.LayoutOrder = u71
            Frame.Size = UDim2.new(1, -6, 0, u26.tapRow(46))
            Frame.BackgroundColor3 = u50
            Frame.BorderSizePixel = 0
            Frame.Parent = u68

            u26.corner(Frame, 6)

            v1 = if a1 ~= "Storage" then Config.Permission.reachOf(u28.minimum) else nil
            TextLabel = Instance.new("TextLabel")
            TextLabel.Size = UDim2.new(1, -124, 0, 18)
            v2 = if not v1 then UDim2.new(0, 12, 0.5, -9) else UDim2.fromOffset(12, 6)
            TextLabel.Position = v2
            TextLabel.BackgroundTransparency = 1
            TextLabel.Text = u28.label
            TextLabel.TextSize = 13
            TextLabel.TextColor3 = u26.Palette.Text
            TextLabel.FontFace = u26.Font.Medium
            TextLabel.TextXAlignment = Enum.TextXAlignment.Left
            TextLabel.TextTruncate = Enum.TextTruncate.AtEnd
            TextLabel.Parent = Frame

            if v1 then
                TextLabel_2 = Instance.new("TextLabel")
                TextLabel_2.Size = UDim2.new(1, -124, 0, 14)
                TextLabel_2.Position = UDim2.fromOffset(12, 25)
                TextLabel_2.BackgroundTransparency = 1
                TextLabel_2.Text = v1
                TextLabel_2.TextSize = 11
                TextLabel_2.TextColor3 = u26.Palette.Faint
                TextLabel_2.FontFace = u26.Font.Regular
                TextLabel_2.TextXAlignment = Enum.TextXAlignment.Left
                TextLabel_2.Parent = Frame
            end

            v2 = button(Frame, if not u37 then if not u33 then "OFF" else "ON" else "CONFIRM?", if not u37 then if not u33 then u60 else u55 else u65, 96)
            v2.AnchorPoint = Vector2.new(1, 0.5)
            v2.Position = UDim2.new(1, -10, 0.5, 0)

            v2.Activated:Connect(function()
                -- Line: 406
                -- upvalues: u33 (val), u28 (val), u37 (val), u70 (upval), k (val), u79 (upval), u42 (upval), a1 (val)
                if not u33 and u28.warnOnEnable and not u37 then
                    u70 = k
                    u79()

                    return
                end

                u70 = nil
                u42:FireServer(a1, k, not u33)
            end)

            if u37 then
                text(u68, "They will be able to TAKE anything out of your storage. Press CONFIRM? to allow it.", 11, Color3.fromRGB(226, 146, 96), u26.Font.Medium)
            end
        end
    end
end

function u79()
    -- Line: 429
    -- upvalues: u68 (ref), u71 (ref), drawAccess (val), u69 (ref), heading (val), text (val), u26 (val)
    -- upvalues: drawRoles (val), drawPeople (val), drawBans (val), drawToggleGroup (val), Config (val)
    for i, j in u68:GetChildren() do
        if j:IsA("GuiObject") then
            j:Destroy()
        end
    end

    u71 = 0
    drawAccess()

    local v1 = u69

    if not v1 then
        heading("Roles")
        text(u68, "Loading…", 12, u26.Palette.Faint)

        return
    end

    drawRoles()
    drawPeople(v1)
    drawBans(v1)
    heading("Storage permissions", nil, "(Helper and above)")
    drawToggleGroup("Storage", Config.Permission.StorageToggles, v1.storage)
    heading("Additional permissions", "Only applies to the role(s) specified under the setting.")
    drawToggleGroup("Island", Config.Permission.IslandToggles, v1.island)
end

local u86 = nil

local function moveIntoHost() -- Line: 456; upvalues: u86 (ref), u68 (ref), u26 (val)
    local v1 = u86

    if v1 and u68 then
        u68.Size = UDim2.fromScale(1, 1)
        u68.Position = UDim2.new()
        u68.ScrollBarImageColor3 = u26.Palette.Stroke

        if not u68:FindFirstChild("EmbedPadding") then
            local UIPadding = Instance.new("UIPadding")
            UIPadding.Name = "EmbedPadding"
            UIPadding.PaddingRight = UDim.new(0, 8)
            UIPadding.Parent = u68
        end

        u68.Parent = v1
    end
end

function v1.embed(a1) -- Line: 474; upvalues: u86 (ref), moveIntoHost (val); types: a1: userdata
    u86 = a1
    moveIntoHost()
end

function v1.showEmbedded(a1) -- Line: 481; upvalues: u72 (ref), u70 (ref), u36 (val), u79 (ref); types: a1: boolean
    if a1 == u72 then
        return
    end

    u72 = a1
    u70 = nil

    if a1 then
        u36:FireServer()
        u79()
    end
end

function v1.start()
    -- Line: 493
    -- upvalues: u68 (ref), moveIntoHost (val), u39 (val), u69 (ref), u70 (ref), u72 (ref), u79 (ref)
    -- upvalues: SettingsController (val), Remotes (val), u36 (val), Players (val)
    u68 = Instance.new("ScrollingFrame")
    u68.Size = UDim2.fromScale(1, 1)
    u68.BackgroundTransparency = 1
    u68.BorderSizePixel = 0
    u68.ScrollBarThickness = 5
    u68.AutomaticCanvasSize = Enum.AutomaticSize.Y
    u68.CanvasSize = UDim2.new()
    local UIListLayout = Instance.new("UIListLayout")
    UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
    UIListLayout.Padding = UDim.new(0, 6)
    UIListLayout.Parent = u68

    moveIntoHost()

    u39.OnClientEvent:Connect(function(a1) -- Line: 510; upvalues: u69 (upval), u70 (upval), u72 (upval), u79 (upval)
        if type(a1) ~= "table" then
            return
        end

        u69 = a1
        u70 = nil

        if u72 then
            u79()
        end
    end)

    SettingsController.onChanged(function(a1) -- Line: 520; upvalues: u72 (upval), u79 (upval)
        if a1 == "IslandAccess" and u72 then
            u79()
        end
    end)

    ;(Remotes.get(Remotes.FriendRoleChanged)).OnClientEvent:Connect(function(a1, a2)
        -- Line: 527
        -- upvalues: u69 (upval), u72 (upval), u79 (upval)
        local v1 = u69

        if type(a1) == "number" and v1 then
            local v2 = {}

            for i, j in v1.roles do
                if j.userId ~= a1 then
                    table.insert(v2, j)
                end
            end

            if type(a2) == "string" then
                table.insert(
                    v2,
                    {userId = a1, role = a2}
                )
            end

            v1.roles = v2

            if u72 then
                u79()
            end
        end
    end)

    local function rosterChanged() -- Line: 548; upvalues: u72 (upval), u36 (upval)
        if u72 then
            u36:FireServer()
        end
    end

    Players.PlayerAdded:Connect(rosterChanged)

    Players.PlayerRemoving:Connect(function() -- Line: 554; upvalues: rosterChanged (val)
        task.defer(rosterChanged)
    end)
end

return v1