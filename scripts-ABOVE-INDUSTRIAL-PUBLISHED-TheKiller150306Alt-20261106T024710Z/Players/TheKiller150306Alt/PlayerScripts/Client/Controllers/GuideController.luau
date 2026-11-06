-- Script path: game:GetService("Players").TheKiller150306Alt.PlayerScripts.Client.Controllers.GuideController
-- Decompile time: 16.72 ms

local HttpService = game:GetService("HttpService")
local Players = game:GetService("Players")
local SocialService = game:GetService("SocialService")
local Shared = (game:GetService("ReplicatedStorage")):WaitForChild("Shared")
local Config = require(Shared.Config)
local Format = require(Shared.Format)
local Remotes = require(Shared.Remotes)
local u39 = require(script.Parent.Parent.Ui)
local BuildController = require(script.Parent.BuildController)
local DeviceMode = require(script.Parent.DeviceMode)
local GuideBeam = require(script.Parent.GuideBeam)
local TutorialController = require(script.Parent.TutorialController)
local u60 = {}
local LocalPlayer = Players.LocalPlayer
local u65 = Remotes.get(Remotes.GuidesState)
local u68 = Remotes.get(Remotes.RequestGuides)
local u72 = u39.tap(38)
local u74 = DeviceMode.touchOnly()
local u76 = if not u74 then 300 else 230
local u87 = if not u74 then UDim2.new(0, 70, 0.45, 0) else UDim2.fromOffset(12, 8)
local u88 = {Starter = "STARTER GUIDES", Advanced = "ADVANCED GUIDES"}
local u89 = {}
local u90 = nil
local u91 = nil
local u92 = false
local u93 = false
local u94 = nil
local u95 = nil
local u96 = nil
local u97 = nil
local u98 = nil
local u99 = nil
local u100 = nil
local u101 = {}
local u102 = ""
local u103 = nil
local u104 = nil
local u105 = nil
local u106 = nil
local u107 = nil
local u108 = nil

local function byId(a1) -- Line: 92; upvalues: u89 (ref); types: a1: string?
    for i, j in u89 do
        if j.id == a1 then
            return j
        end
    end

    return nil
end

local function doneCount(a1) -- Line: 101; types: a1: table
    local v1 = 0

    for i, j in a1.steps do
        if j.done then
            v1 = v1 + 1
        end
    end

    return v1
end

local function label(a1, a2, a3, a4, a5)
    -- Line: 111
    -- types: a1: userdata, a2: string, a3: number, a4: userdata, a5: userdata
    local TextLabel = Instance.new("TextLabel")
    TextLabel.BackgroundTransparency = 1
    TextLabel.Text = a2
    TextLabel.TextSize = a3
    TextLabel.FontFace = a4
    TextLabel.TextColor3 = a5
    TextLabel.TextXAlignment = Enum.TextXAlignment.Left
    TextLabel.TextYAlignment = Enum.TextYAlignment.Top
    TextLabel.TextWrapped = true
    TextLabel.Size = UDim2.fromScale(1, 0)
    TextLabel.AutomaticSize = Enum.AutomaticSize.Y
    TextLabel.Parent = a1

    return TextLabel
end

local function column(a1, a2, a3) -- Line: 127; types: a1: userdata, a2: number, a3: number
    local Frame = Instance.new("Frame")
    Frame.BackgroundTransparency = 1
    Frame.Size = UDim2.fromScale(1, 0)
    Frame.AutomaticSize = Enum.AutomaticSize.Y
    Frame.LayoutOrder = a2
    Frame.Parent = a1
    local UIListLayout = Instance.new("UIListLayout")
    UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
    UIListLayout.Padding = UDim.new(0, a3)
    UIListLayout.Parent = Frame

    return Frame
end

local function lineRow(a1, a2, a3)
    -- Line: 142
    -- upvalues: u39 (val), label (val), Format (val)
    -- types: a1: userdata, a2: number, a3: table
    local Green
    local Frame = Instance.new("Frame")
    Frame.BackgroundTransparency = 1
    Frame.Size = UDim2.new(1, 0, 0, 18)
    Frame.LayoutOrder = a2
    Frame.Parent = a1
    local v1 = label(Frame, a3.label, 13, u39.Font.Regular, if not (a3.need <= a3.have) then u39.Palette.Text else u39.Palette.Green)
    v1.AutomaticSize = Enum.AutomaticSize.None
    v1.Size = UDim2.new(1, -110, 1, 0)
    v1.TextWrapped = false
    v1.TextTruncate = Enum.TextTruncate.AtEnd
    v1 = label(Frame, ("%* / %*"):format(Format.comma((math.min(a3.have, a3.need))), (Format.comma(a3.need))), 13, u39.Font.Medium, Green)
    v1.AutomaticSize = Enum.AutomaticSize.None
    v1.AnchorPoint = Vector2.new(1, 0)
    v1.Position = UDim2.fromScale(1, 0)
    v1.Size = UDim2.new(0, 104, 1, 0)
    v1.TextXAlignment = Enum.TextXAlignment.Right
end

local function marker(a1, a2, a3) -- Line: 171; upvalues: u39 (val); types: a1: userdata, a2: boolean, a3: boolean
    local Frame = Instance.new("Frame")
    Frame.Size = UDim2.fromOffset(10, 10)
    Frame.Position = UDim2.fromOffset(0, 4)
    Frame.BorderSizePixel = 0
    local Green = if not a2 then
        if not a3 then u39.Palette.Track else u39.Palette.Gold
    else
        u39.Palette.Green
    Frame.BackgroundColor3 = Green
    Frame.Parent = a1

    u39.corner(Frame, 5)

    if not a2 and not a3 then
        u39.stroke(Frame, u39.Palette.Dim, 1)
    end
end

local function invite() -- Line: 184; upvalues: SocialService (val), LocalPlayer (val)
    local success, err = pcall(function() -- Line: 185; upvalues: SocialService (upval), LocalPlayer (upval)
        return SocialService:CanSendGameInviteAsync(LocalPlayer)
    end)

    if success and err then
        pcall(function() -- Line: 189; upvalues: SocialService (upval), LocalPlayer (upval)
            SocialService:PromptGameInvite(LocalPlayer)
        end)
    end
end

local function renderDetail()
    -- Line: 195
    -- upvalues: u91 (ref), u89 (ref), HttpService (val), u90 (ref), u102 (ref), u97 (ref), u98 (ref), u99 (ref)
    -- upvalues: column (val), marker (val), label (val), u39 (val), lineRow (val), invite (val), u100 (ref)
    local CanvasPosition, Dim, Frame, Track, v1, v2, v3, v4, v5
    local v6 = u91
    local v7 = u89
    local v8 = nil
    local v9 = nil

    for i, j in v7, v8, v9 do
        if j.id == v6 then
            if not j then
                return
            end

            v6 = HttpService:JSONEncode({v1, u90})

            if v6 == u102 then
                return
            end

            u102 = v6
            u97.Text = v1.title
            u98.Text = v1.blurb
            CanvasPosition = u99.CanvasPosition

            for k, n in u99:GetChildren() do
                if not n:IsA("UIListLayout") and not n:IsA("UIPadding") then
                    n:Destroy()
                end
            end

            v8 = nil
            v9 = nil

            for m, i5 in v1.steps, v8, v9 do
                v3 = m == v1.current
                v4 = column(u99, m, 3)
                Frame = Instance.new("Frame")
                Frame.BackgroundTransparency = 1
                Frame.Size = UDim2.fromScale(1, 0)
                Frame.AutomaticSize = Enum.AutomaticSize.Y
                Frame.LayoutOrder = 1
                Frame.Parent = v4

                marker(Frame, i5.done, v3)

                v2 = label(Frame, i5.label, 14, if not v3 then u39.Font.Medium else u39.Font.Bold, if not i5.done then u39.Palette.Text else u39.Palette.Dim)
                v2.Position = UDim2.fromOffset(18, 0)
                v2.Size = UDim2.new(1, -18, 0, 0)

                if not i5.done then
                    v2 = column(v4, 2, 2)
                    v5 = Instance.new("UIPadding")
                    v5.PaddingLeft = UDim.new(0, 18)
                    v5.Parent = v2
                    v5 = 0

                    if i5.where then
                        v5 = v5 + 1
                        label(v2, i5.where, 12, u39.Font.Regular, u39.Palette.Faint).LayoutOrder = v5
                    end

                    for i6, i7 in i5.lines do
                        v5 = v5 + 1
                        lineRow(v2, v5, i7)
                    end

                    if i5.hint then
                        v5 = v5 + 1
                        label(v2, i5.hint, 12, u39.Font.Regular, u39.Palette.Dim).LayoutOrder = v5
                    end

                    if i5.action == "Invite" then
                        v5 = v5 + 1
                        v4 = Instance.new("TextButton")
                        v4.Size = UDim2.fromOffset(150, u39.tap(26))
                        v4.BackgroundColor3 = u39.Palette.Gold
                        v4.TextColor3 = u39.Palette.OnGold
                        v4.Text = "INVITE FRIENDS"
                        v4.FontFace = u39.Font.Bold
                        v4.TextSize = 13
                        v4.LayoutOrder = v5
                        v4.Parent = v2

                        u39.corner(v4, 6)
                        v4.Activated:Connect(invite)
                    end
                end
            end

            u99.CanvasPosition = CanvasPosition
            v8 = if not (u90 == v1.id) then "PIN THIS GUIDE" else "UNPIN"
            u100.Text = v8
            v7 = u100
            Track = if not v6 then u39.Palette.Gold else u39.Palette.Track
            v7.BackgroundColor3 = Track
            v7 = u100
            Dim = if not v6 then u39.Palette.OnGold else u39.Palette.Dim
            v7.TextColor3 = Dim

            return
        end
    end

    if true then
        return
    end

    v6 = HttpService:JSONEncode({v1, u90})

    if v6 == u102 then
        return
    end

    u102 = v6
    u97.Text = v1.title
    u98.Text = v1.blurb
    CanvasPosition = u99.CanvasPosition

    for i8, i9 in u99:GetChildren() do
        if not i9:IsA("UIListLayout") and not i9:IsA("UIPadding") then
            i9:Destroy()
        end
    end

    v8 = nil
    v9 = nil

    for i10, i11 in v1.steps, v8, v9 do
        v3 = i10 == v1.current
        v4 = column(u99, i10, 3)
        Frame = Instance.new("Frame")
        Frame.BackgroundTransparency = 1
        Frame.Size = UDim2.fromScale(1, 0)
        Frame.AutomaticSize = Enum.AutomaticSize.Y
        Frame.LayoutOrder = 1
        Frame.Parent = v4

        marker(Frame, i11.done, v3)

        v2 = label(Frame, i11.label, 14, if not v3 then u39.Font.Medium else u39.Font.Bold, if not i11.done then u39.Palette.Text else u39.Palette.Dim)
        v2.Position = UDim2.fromOffset(18, 0)
        v2.Size = UDim2.new(1, -18, 0, 0)

        if not i11.done then
            v2 = column(v4, 2, 2)
            v5 = Instance.new("UIPadding")
            v5.PaddingLeft = UDim.new(0, 18)
            v5.Parent = v2
            v5 = 0

            if i11.where then
                v5 = v5 + 1
                label(v2, i11.where, 12, u39.Font.Regular, u39.Palette.Faint).LayoutOrder = v5
            end

            for i12, i13 in i11.lines do
                v5 = v5 + 1
                lineRow(v2, v5, i13)
            end

            if i11.hint then
                v5 = v5 + 1
                label(v2, i11.hint, 12, u39.Font.Regular, u39.Palette.Dim).LayoutOrder = v5
            end

            if i11.action == "Invite" then
                v5 = v5 + 1
                v4 = Instance.new("TextButton")
                v4.Size = UDim2.fromOffset(150, u39.tap(26))
                v4.BackgroundColor3 = u39.Palette.Gold
                v4.TextColor3 = u39.Palette.OnGold
                v4.Text = "INVITE FRIENDS"
                v4.FontFace = u39.Font.Bold
                v4.TextSize = 13
                v4.LayoutOrder = v5
                v4.Parent = v2

                u39.corner(v4, 6)
                v4.Activated:Connect(invite)
            end
        end
    end

    u99.CanvasPosition = CanvasPosition
    v8 = if not (u90 == v1.id) then "PIN THIS GUIDE" else "UNPIN"
    u100.Text = v8
    v7 = u100
    Track = if not v6 then u39.Palette.Gold else u39.Palette.Track
    v7.BackgroundColor3 = Track
    v7 = u100
    Dim = if not v6 then u39.Palette.OnGold else u39.Palette.Dim
    v7.TextColor3 = Dim
end

local function choose(a1)
    -- Line: 276
    -- upvalues: u91 (ref), u102 (ref), u101 (val), renderDetail (val)
    -- types: a1: string
    u91 = a1
    u102 = ""
    local v1 = nil
    local v2 = nil

    for i, j in u101, v1, v2 do
        j.button.BackgroundTransparency = if i ~= a1 then 1 else 0
    end

    renderDetail()
end

local function buildList()
    -- Line: 286
    -- upvalues: u101 (val), Config (val), label (val), u96 (ref), u88 (val), u39 (val), u89 (ref), u72 (val), u91 (ref)
    -- upvalues: u102 (ref), renderDetail (val)
    local v1, v2, v3

    if next(u101) then
        return
    end

    local v4 = 0
    local v5 = nil
    local v6 = nil

    for i, j in Config.Guide.Groups, v5, v6 do
        v4 = v4 + 1
        v3 = u88[j] or string.upper(j)
        v2 = label(u96, v3, 12, u39.Font.Bold, u39.Palette.Gold)
        v2.AutomaticSize = Enum.AutomaticSize.None
        v2.Size = UDim2.new(1, 0, 0, 26)
        v2.TextYAlignment = Enum.TextYAlignment.Bottom
        v2.LayoutOrder = v4

        for k, n in u89 do
            if n.group == j then
                v4 = v4 + 1
                v2 = Instance.new("TextButton")
                v2.Size = UDim2.new(1, -6, 0, u72)
                v2.BackgroundColor3 = u39.Palette.Raised
                v2.BackgroundTransparency = 1
                v2.AutoButtonColor = false
                v2.Text = ""
                v2.LayoutOrder = v4
                v2.Parent = u96

                u39.corner(v2, u39.Radius.Row)

                v1 = label(v2, n.title, 13, u39.Font.Medium, u39.Palette.Text)
                v1.AutomaticSize = Enum.AutomaticSize.None
                v1.Position = UDim2.fromOffset(8, 0)
                v1.Size = UDim2.new(1, -70, 1, 0)
                v1.TextYAlignment = Enum.TextYAlignment.Center
                v1 = label(v2, "", 11, u39.Font.Bold, u39.Palette.Dim)
                v1.AutomaticSize = Enum.AutomaticSize.None
                v1.AnchorPoint = Vector2.new(1, 0)
                v1.Position = UDim2.new(1, -8, 0, 0)
                v1.Size = UDim2.new(0, 58, 1, 0)
                v1.TextXAlignment = Enum.TextXAlignment.Right
                v1.TextYAlignment = Enum.TextYAlignment.Center
                u101[n.id] = {button = v2, status = v1}
                local id = n.id

                v2.Activated:Connect(function()
                    -- Line: 326
                    -- upvalues: id (val), u91 (upval), u102 (upval), u101 (upval), renderDetail (upval)
                    local v1 = id
                    u91 = v1
                    u102 = ""
                    local v2 = nil
                    local v3 = nil

                    for i, j in u101, v2, v3 do
                        j.button.BackgroundTransparency = if i ~= v1 then 1 else 0
                    end

                    renderDetail()
                end)
            end
        end
    end
end

local function renderList() -- Line: 333; upvalues: buildList (val), u89 (ref), u101 (val), u90 (ref), u39 (val)
    local status, v1, v2
    buildList()

    local v3 = nil
    local v4 = nil

    for i, j in u89, v3, v4 do
        v1 = u101[j.id]

        if v1 then
            if j.id == u90 then
                v1.status.Text = "PINNED"
                v1.status.TextColor3 = u39.Palette.Gold
            elseif not j.done then
                status = v1.status
                v2 = 0

                for k, n in j.steps do
                    if n.done then
                        v2 = v2 + 1
                    end
                end

                status.Text = ("%* / %*"):format(v2, #j.steps)
                v1.status.TextColor3 = u39.Palette.Dim
            else
                v1.status.Text = "DONE"
                v1.status.TextColor3 = u39.Palette.Green
            end
        end
    end
end

local function renderCard()
    -- Line: 355
    -- upvalues: u90 (ref), u89 (ref), TutorialController (val), u92 (ref), u104 (ref), u105 (ref), u106 (ref)
    -- upvalues: u107 (ref), u108 (ref), Format (val), u93 (ref), GuideBeam (val)
    local guideTo, v1, v2
    local v3 = u90
    local v4 = u89
    local v5 = nil

    for i, j in v4, nil, v5 do
        if j.id == v3 then
            v3 = TutorialController.isActive() or TutorialController.isShowing()
            v4 = false

            if j ~= nil then
                v4 = not v3 and not u92
            end

            u104.Visible = v4
            guideTo = nil

            if v1 and v4 then
                if not v1.done then
                    v5 = v1.current or 1
                    v2 = v1.steps[v5]
                    u105.Text = ("GUIDE · STEP %* OF %*"):format(v5, #v1.steps)
                    u106.Text = v1.title
                    u107.Text = v2.label
                    v5 = nil

                    for k, n in v2.lines do
                        if n.have < n.need then
                            v5 = n
                            break
                        end
                    end

                    u108.Visible = v5 ~= nil

                    if v5 then
                        u108.Text = ("%*  %* / %*"):format(v5.label, Format.comma(v5.have), (Format.comma(v5.need)))
                    end

                    guideTo = v2.guideTo
                else
                    u105.Text = "GUIDE DONE"
                    u106.Text = v1.title
                    u107.Text = "Open the planner to pick your next one"
                    u108.Visible = false
                end
            end

            if v3 then
                u93 = false
                return
            end

            if guideTo then
                GuideBeam.set(guideTo)

                u93 = true

                return
            end

            if u93 then
                GuideBeam.set(nil)

                u93 = false
            end

            return
        end
    end

    v3 = TutorialController.isActive() or TutorialController.isShowing()
    v4 = false

    if false then
        v4 = not v3 and not u92
    end

    u104.Visible = v4
    guideTo = nil

    if v1 and v4 then
        if not v1.done then
            v5 = v1.current or 1
            v2 = v1.steps[v5]
            u105.Text = ("GUIDE · STEP %* OF %*"):format(v5, #v1.steps)
            u106.Text = v1.title
            u107.Text = v2.label
            v5 = nil

            for m, i5 in v2.lines do
                if i5.have < i5.need then
                    v5 = i5
                    break
                end
            end

            u108.Visible = v5 ~= nil

            if v5 then
                u108.Text = ("%*  %* / %*"):format(v5.label, Format.comma(v5.have), (Format.comma(v5.need)))
            end

            guideTo = v2.guideTo
        else
            u105.Text = "GUIDE DONE"
            u106.Text = v1.title
            u107.Text = "Open the planner to pick your next one"
            u108.Visible = false
        end
    end

    if v3 then
        u93 = false
        return
    end

    if guideTo then
        GuideBeam.set(guideTo)

        u93 = true

        return
    end

    if u93 then
        GuideBeam.set(nil)

        u93 = false
    end
end

local function render()
    -- Line: 399
    -- upvalues: renderList (val), u91 (ref), u89 (ref), u90 (ref), u102 (ref), u101 (val), renderDetail (val)
    -- upvalues: renderCard (val)
    local id, v1, v2, v3
    renderList()

    if not u91 then
        v2 = nil
        v3 = nil

        for i, j in u89, v2, v3 do
            if j.id == u90 then
                v1 = j or u89[1]

                if v1 then
                    id = v1.id
                    u91 = id
                    u102 = ""
                    v2 = nil
                    v3 = nil

                    for k, n in u101, v2, v3 do
                        n.button.BackgroundTransparency = if k ~= id then 1 else 0
                    end

                    renderDetail()
                end

                renderCard()

                return
            end
        end

        v1 = u89[1]

        if v1 then
            id = v1.id
            u91 = id
            u102 = ""
            v2 = nil
            v3 = nil

            for m, i5 in u101, v2, v3 do
                i5.button.BackgroundTransparency = if m ~= id then 1 else 0
            end

            renderDetail()
        end
    else
        v2 = nil
        v3 = nil

        for i6, i7 in u89, v2, v3 do
            if i7.id == u91 then
                v1 = i7

                if v1 then
                    renderDetail()
                else
                    v2 = nil
                    v3 = nil

                    for i8, i9 in u89, v2, v3 do
                        if i9.id == u90 then
                            v1 = i9 or u89[1]

                            if v1 then
                                id = v1.id
                                u91 = id
                                u102 = ""
                                v2 = nil
                                v3 = nil

                                for i10, i11 in u101, v2, v3 do
                                    i11.button.BackgroundTransparency = if i10 ~= id then 1 else 0
                                end

                                renderDetail()
                            end

                            renderCard()

                            return
                        end
                    end

                    v1 = u89[1]

                    if v1 then
                        id = v1.id
                        u91 = id
                        u102 = ""
                        v2 = nil
                        v3 = nil

                        for i12, i13 in u101, v2, v3 do
                            i13.button.BackgroundTransparency = if i12 ~= id then 1 else 0
                        end

                        renderDetail()
                    end
                end

                renderCard()

                return
            end
        end

        v1 = nil

        if v1 then
            renderDetail()
        else
            v2 = nil
            v3 = nil

            for i14, i15 in u89, v2, v3 do
                if i15.id == u90 then
                    v1 = i15 or u89[1]

                    if v1 then
                        id = v1.id
                        u91 = id
                        u102 = ""
                        v2 = nil
                        v3 = nil

                        for i16, i17 in u101, v2, v3 do
                            i17.button.BackgroundTransparency = if i16 ~= id then 1 else 0
                        end

                        renderDetail()
                    end

                    renderCard()

                    return
                end
            end

            v1 = u89[1]

            if v1 then
                id = v1.id
                u91 = id
                u102 = ""
                v2 = nil
                v3 = nil

                for i18, i19 in u101, v2, v3 do
                    i19.button.BackgroundTransparency = if i18 ~= id then 1 else 0
                end

                renderDetail()
            end
        end
    end

    renderCard()
end

function u60.close() -- Line: 412; upvalues: u92 (ref), u95 (ref), BuildController (val), renderCard (val)
    if not u92 then
        return
    end

    u92 = false
    u95.Visible = false

    BuildController.setUiOpen("Guides", false)
    renderCard()
end

function u60.show()
    -- Line: 422
    -- upvalues: u92 (ref), u95 (ref), BuildController (val), u39 (val), render (val), u68 (val)
    u92 = true
    u95.Visible = true

    BuildController.setUiOpen("Guides", true)
    u39.appear(u95)
    render()
    u68:FireServer("refresh")
end

local function buildPanel()
    -- Line: 431
    -- upvalues: u94 (ref), LocalPlayer (val), u95 (ref), u39 (val), label (val), u60 (val), u96 (ref), u97 (ref)
    -- upvalues: u98 (ref), u99 (ref), u100 (ref), u91 (ref), u90 (ref), u68 (val), u102 (ref), render (val)
    u94 = Instance.new("ScreenGui")
    u94.Name = "AboveGuides"
    u94.ResetOnSpawn = false
    u94.Parent = LocalPlayer:WaitForChild("PlayerGui")
    u95 = Instance.new("CanvasGroup")
    u95.Size = UDim2.fromOffset(680, 470)
    u95.Position = UDim2.new(0.5, -340, 0.5, -235)

    u39.fitToScreen(u95)

    u95.BackgroundColor3 = u39.Palette.Card
    u95.BackgroundTransparency = 0
    u95.Visible = false
    u95.Active = true
    u95.Parent = u94

    u39.corner(u95, 8)
    u39.stroke(u95, u39.Palette.Stroke, 1)

    local v1 = label(u95, "ISLAND PLANNER", 18, u39.Font.Bold, u39.Palette.Gold)
    v1.AutomaticSize = Enum.AutomaticSize.None
    v1.Size = UDim2.new(1, -60, 0, 24)
    v1.Position = UDim2.fromOffset(16, 12)
    v1 = label(u95, "Pick something to build and pin it. Nothing is locked.", 13, u39.Font.Regular, u39.Palette.Dim)
    v1.AutomaticSize = Enum.AutomaticSize.None
    v1.Size = UDim2.new(1, -60, 0, 16)
    v1.Position = UDim2.fromOffset(16, 36)

    u39.closeButton(u95, 12, u60.close)

    u96 = Instance.new("ScrollingFrame")
    u96.Size = UDim2.new(0, 236, 1, -72)
    u96.Position = UDim2.fromOffset(10, 62)
    u96.BackgroundTransparency = 1
    u96.BorderSizePixel = 0
    u96.ScrollBarThickness = 4
    u96.ScrollBarImageColor3 = u39.Palette.Stroke
    u96.AutomaticCanvasSize = Enum.AutomaticSize.Y
    u96.CanvasSize = UDim2.new()
    u96.Parent = u95
    local UIListLayout = Instance.new("UIListLayout")
    UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
    UIListLayout.Padding = UDim.new(0, 2)
    UIListLayout.Parent = u96
    local Frame = Instance.new("Frame")
    Frame.Size = UDim2.new(0, 1, 1, -80)
    Frame.Position = UDim2.fromOffset(254, 66)
    Frame.BackgroundColor3 = u39.Palette.Stroke
    Frame.BorderSizePixel = 0
    Frame.Parent = u95
    u97 = label(u95, "", 17, u39.Font.Bold, u39.Palette.Text)
    u97.Position = UDim2.fromOffset(268, 64)
    u97.Size = UDim2.new(1, -284, 0, 0)
    u98 = label(u95, "", 13, u39.Font.Regular, u39.Palette.Dim)
    u98.AutomaticSize = Enum.AutomaticSize.None
    u98.Position = UDim2.fromOffset(268, 88)
    u98.Size = UDim2.new(1, -284, 0, 34)
    u99 = Instance.new("ScrollingFrame")
    u99.Position = UDim2.fromOffset(268, 128)
    u99.Size = UDim2.new(1, -278, 1, -186)
    u99.BackgroundTransparency = 1
    u99.BorderSizePixel = 0
    u99.ScrollBarThickness = 4
    u99.ScrollBarImageColor3 = u39.Palette.Stroke
    u99.AutomaticCanvasSize = Enum.AutomaticSize.Y
    u99.CanvasSize = UDim2.new()
    u99.Parent = u95
    local UIListLayout_2 = Instance.new("UIListLayout")
    UIListLayout_2.SortOrder = Enum.SortOrder.LayoutOrder
    UIListLayout_2.Padding = UDim.new(0, 10)
    UIListLayout_2.Parent = u99
    local UIPadding = Instance.new("UIPadding")
    UIPadding.PaddingRight = UDim.new(0, 10)
    UIPadding.Parent = u99
    u100 = Instance.new("TextButton")
    u100.AnchorPoint = Vector2.new(1, 1)
    u100.Position = UDim2.new(1, -16, 1, -14)
    u100.Size = UDim2.fromOffset(170, u39.tap(32))
    u100.BorderSizePixel = 0
    u100.FontFace = u39.Font.Bold
    u100.TextSize = 14
    u100.Text = "PIN THIS GUIDE"
    u100.Parent = u95

    u39.corner(u100, 6)

    u100.Activated:Connect(function()
        -- Line: 519
        -- upvalues: u91 (upval), u90 (upval), u68 (upval), u102 (upval), render (upval)
        local v1 = u91

        if not v1 then
            return
        end

        if u90 ~= v1 then
            u90 = v1
            u68:FireServer("pin", v1)
        else
            u90 = nil
            u68:FireServer("unpin")
        end

        u102 = ""
        render()
    end)
end

local function buildCard()
    -- Line: 537
    -- upvalues: u103 (ref), LocalPlayer (val), BuildController (val), u104 (ref), u76 (val), u87 (val), u39 (val)
    -- upvalues: u74 (val), u105 (ref), label (val), u106 (ref), u107 (ref), u108 (ref), u60 (val)
    u103 = Instance.new("ScreenGui")
    u103.Name = "AboveGuideCard"
    u103.ResetOnSpawn = false
    u103.IgnoreGuiInset = false
    u103.DisplayOrder = 4
    u103.Parent = LocalPlayer:WaitForChild("PlayerGui")

    BuildController.onUiOpenChanged(function(a1) -- Line: 545; upvalues: u103 (upval)
        u103.Enabled = not a1
    end)

    u104 = Instance.new("Frame")
    u104.Size = UDim2.fromOffset(u76, 0)
    u104.AutomaticSize = Enum.AutomaticSize.Y
    u104.Position = u87
    u104.BackgroundColor3 = Color3.fromRGB(18, 20, 30)
    u104.BackgroundTransparency = 0.15
    u104.BorderSizePixel = 0
    u104.Visible = false
    u104.Parent = u103

    u39.corner(u104, 8)

    local v1 = u39.stroke(u104, u39.Palette.Gold, 1)
    v1.Transparency = 0.6
    local UIPadding = Instance.new("UIPadding")
    UIPadding.PaddingTop = UDim.new(0, if not u74 then 10 else 8)
    UIPadding.PaddingBottom = UDim.new(0, if not u74 then 10 else 8)
    UIPadding.PaddingLeft = UDim.new(0, if not u74 then 12 else 10)
    UIPadding.PaddingRight = UDim.new(0, if not u74 then 12 else 10)
    UIPadding.Parent = u104
    local UIListLayout = Instance.new("UIListLayout")
    UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
    UIListLayout.Padding = UDim.new(0, 3)
    UIListLayout.Parent = u104
    u105 = label(u104, "", 11, u39.Font.Bold, u39.Palette.Gold)
    u105.LayoutOrder = 1
    u106 = label(u104, "", if not u74 then 16 else 14, u39.Font.Bold, u39.Palette.Text)
    u106.LayoutOrder = 2
    u107 = label(u104, "", if not u74 then 14 else 13, u39.Font.Medium, Color3.fromRGB(222, 228, 240))
    u107.LayoutOrder = 3
    u108 = label(u104, "", 13, u39.Font.Regular, u39.Palette.Dim)
    u108.LayoutOrder = 4
    u104.Active = true

    u104.InputBegan:Connect(function(a1) -- Line: 582; upvalues: u60 (upval)
        if a1.UserInputType == Enum.UserInputType.MouseButton1
            or a1.UserInputType == Enum.UserInputType.Touch then
            u60.show()
        end
    end)
end

function u60.start()
    -- Line: 592
    -- upvalues: buildPanel (val), buildCard (val), BuildController (val), u60 (val), u65 (val), u89 (ref), u90 (ref)
    -- upvalues: u92 (ref), render (val), Config (val), LocalPlayer (val), u68 (val), renderCard (val)
    buildPanel()
    buildCard()
    BuildController.registerClose("Guides", u60.close)

    u65.OnClientEvent:Connect(function(a1)
        -- Line: 598
        -- upvalues: u89 (upval), u90 (upval), u92 (upval), u60 (upval), render (upval)
        if type(a1) == "table" and type(a1.guides) == "table" then
            u89 = a1.guides
            u90 = if type(a1.pinned) ~= "string" then nil else a1.pinned

            if a1.open and not u92 then
                u60.show()
                return
            end

            render()
        end
    end)

    if Config.Release.isAdmin(LocalPlayer) then
        u68:FireServer("refresh")
    end

    ;(LocalPlayer:GetAttributeChangedSignal(Config.Release.AdminAttribute)):Connect(function()
        -- Line: 613
        -- upvalues: Config (upval), LocalPlayer (upval), u68 (upval)
        if Config.Release.isAdmin(LocalPlayer) then
            u68:FireServer("refresh")
        end
    end)

    task.spawn(function()
        -- Line: 623
        -- upvalues: Config (upval), LocalPlayer (upval), u92 (upval), u90 (upval), u68 (upval), renderCard (upval)
        while true do
            task.wait(Config.Guide.RefreshSeconds)

            if Config.Release.isAdmin(LocalPlayer) then
                if u92 or u90 then
                    u68:FireServer("refresh")
                end
            end

            if u90 then
                renderCard()
            end
        end
    end)
end

return u60