-- Script path: game:GetService("StarterPlayer").StarterPlayerScripts.Client.Controllers.HotbarController
-- Decompile time: 41.44 ms

local Players = game:GetService("Players")
local DeviceMode = require(script.Parent.DeviceMode)
local TweenService = game:GetService("TweenService")
local Shared = (game:GetService("ReplicatedStorage")):WaitForChild("Shared")
local Config = require(Shared.Config)
local ItemKinds = require(Shared.ItemKinds)
local Palette = require(Shared.Palette)
local Remotes = require(Shared.Remotes)
local StackKey = require(Shared.StackKey)
local u45 = require(script.Parent.Parent.Ui)
local u48 = ItemKinds.build(Config)

local function isEquipment(a1) -- Line: 43; upvalues: u48 (val), Config (val); types: a1: string?
    local v1 = true

    if u48.equipSlotOf(a1) == nil then
        v1 = false

        if a1 ~= nil then
            v1 = Config.Wearable.slotOf(a1) ~= nil
        end
    end

    return v1
end

local ControlGlyphs = require(script.Parent.ControlGlyphs)
local ItemIcon = require(script.Parent.ItemIcon)
local u60 = {}
local LocalPlayer = Players.LocalPlayer
local u65 = Remotes.get(Remotes.InventoryChanged)
local u68 = Remotes.get(Remotes.EquipmentChanged)
local u71 = Remotes.get(Remotes.HotbarChanged)
local u74 = Remotes.get(Remotes.RequestSetHotbar)
local u77 = Remotes.get(Remotes.EquippedChanged)
local Slots = Config.Player.Hotbar.Slots
local FirstFreeSlot = Config.Player.Hotbar.FirstFreeSlot
local u84 = {}
local u85 = false
local u90 = Color3.fromRGB(150, 156, 172)
local u91 = {"Weapon", "Pickaxe", "Axe"}
local u95 = {
    [4] = "GrassBlock",
    [5] = "Plow",
    [6] = "WheatSeeds",
    [7] = "Workbench",
    [8] = "BerryBushSeed",
    [9] = "Bucket",
}
local u102 = {}
local u103 = {}
local u104 = {}
local u105 = {}
local u106 = 0
local u107 = (-1 / 0)
local u108 = nil
local u109 = nil
local u110 = nil
local u115 = Color3.fromRGB(15, 16, 20)
local u119 = UDim.new(0, 6)

function u60.dockLeft(a1) -- Line: 177; upvalues: u110 (ref), u115 (val), u119 (val); types: a1: userdata
    local v1 = u110

    if not v1 then
        return false
    end

    a1.AnchorPoint = Vector2.new(1, 0.5)
    a1.Size = UDim2.fromOffset(62, 62)
    a1.Position = UDim2.new(0, -6, 0.5, 0)
    local UIStroke = a1:FindFirstChildOfClass("UIStroke")

    if UIStroke then
        UIStroke.Thickness = 1
        UIStroke.Color = u115
    end

    local UICorner = a1:FindFirstChildOfClass("UICorner")

    if UICorner then
        UICorner.CornerRadius = u119
    end

    a1.Parent = v1

    return true
end

local u121 = {}
local u122 = {}
local u123 = nil
u60.FirstFreeSlot = FirstFreeSlot
u60.TotalSlots = Slots
local u124 = false

function u60.setBarVisible(a1) -- Line: 220; upvalues: u124 (ref), u109 (ref); types: a1: boolean
    u124 = not a1

    if u109 then
        u109.Visible = a1
    end
end

function u60.isPlaceable(a1) -- Line: 227; upvalues: u48 (val), StackKey (val); types: a1: string?
    return u48.isPlaceable(if not a1 then nil else StackKey.item(a1))
end

local function itemForSlot(a1)
    -- Line: 244
    -- upvalues: FirstFreeSlot (val), u104 (ref), u91 (val), u102 (val), u105 (ref)
    -- types: a1: number
    if a1 < FirstFreeSlot then
        return u104[u91[a1]]
    end

    local v1 = u102[a1]

    if v1 and (u105[v1] or 0) <= 0 then
        return nil
    end

    return v1
end

local function slotHolding(a1)
    -- Line: 256
    -- upvalues: FirstFreeSlot (val), Slots (val), u102 (val)
    -- types: a1: string
    for i = FirstFreeSlot, Slots do
        if u102[i] == a1 then
            return i
        end
    end

    return nil
end

function u60.isOnBar(a1) -- Line: 271; upvalues: FirstFreeSlot (val), Slots (val), u102 (val); types: a1: string
    for i = FirstFreeSlot, Slots do
        if u102[i] == a1 then
            return i ~= nil
        end
    end

    return false
end

function u60.firstFreeSlot() -- Line: 281; upvalues: FirstFreeSlot (val), Slots (val), u102 (val)
    for i = FirstFreeSlot, Slots do
        if not u102[i] then
            return i
        end
    end

    return nil
end

function u60.itemAt(a1)
    -- Line: 291
    -- upvalues: FirstFreeSlot (val), u104 (ref), u91 (val), u102 (val), u105 (ref)
    -- types: a1: number
    if a1 < FirstFreeSlot then
        return u104[u91[a1]]
    end

    local v1 = u102[a1]

    if v1 and (u105[v1] or 0) <= 0 then
        return nil
    end

    return v1
end

local u132 = nil
local u133 = nil

function u60.selected()
    -- Line: 311
    -- upvalues: u132 (ref), u105 (ref), StackKey (val), u106 (ref), u60 (val), FirstFreeSlot (val), u104 (ref)
    -- upvalues: u91 (val), u102 (val)
    local v1, v2

    if u132 then
        v1 = u105[u132] or 0

        if v1 > 0 then
            v1 = StackKey.item(u132)
            return {
                kind = "Item",
                index = u106,
                itemId = v1,
                assignedItemId = v1,
                count = u105[u132] or 0,
                placeable = u60.isPlaceable(u132),
                stack = u132,
                roll = StackKey.rollOf(u132),
            }
        end
    end

    if u106 == 0 then
        return {index = 0, kind = "Empty", count = 0, placeable = false}
    end

    local v3 = u106

    if not (v3 < FirstFreeSlot) then
        v2 = u102[v3]
        v1 = if not v2 then v2 else if not ((u105[v2] or 0) <= 0) then v2 else nil
    else
        v1 = u104[u91[v3]]
    end

    v2 = if not (u106 < FirstFreeSlot) then u102[u106] else nil
    local v4 = {index = u106}
    v4.kind = if not v3 then if not v1 then "Empty" else "Item" else "Tool"
    v4.toolSlot = if not v3 then nil else u91[u106]
    v4.itemId = if not v1 then nil else StackKey.item(v1)
    v4.assignedItemId = if not v2 then nil else StackKey.item(v2)
    v4.count = v1 and u105[v1] or 0
    v4.placeable = not v3 and u60.isPlaceable(v1)
    v4.stack = if not v3 then v1 else nil
    v4.roll = if not v1 then nil else if v3 then nil else StackKey.rollOf(v1)

    return v4
end

local function fireChanged() -- Line: 361; upvalues: u60 (val), u121 (val)
    local v1 = u60.selected()

    for i, j in u121 do
        j(v1)
    end
end

function u60.onChanged(a1) -- Line: 368; upvalues: u121 (val); types: a1: function
    table.insert(u121, a1)
end

function u60.setDropProgress(a1) -- Line: 376; upvalues: u122 (val), u106 (ref), u45 (val); types: a1: number?
    local DropMeter, Frame
    local v1 = nil
    local v2 = nil
    local v3 = a1

    for i, j in u122, v1, v2 do
        DropMeter = j:FindFirstChild("DropMeter")

        if v3 == nil then
            if DropMeter then
                DropMeter:Destroy()
            end
        elseif i == u106 then
            if not DropMeter then
                Frame = Instance.new("Frame")
                Frame.Name = "DropMeter"
                Frame.AnchorPoint = Vector2.new(0, 1)
                Frame.Position = UDim2.fromScale(0, 1)
                Frame.BackgroundColor3 = u45.Palette.Red
                Frame.BackgroundTransparency = 0.45
                Frame.BorderSizePixel = 0
                Frame.ZIndex = 20
                Frame.Parent = j

                u45.corner(Frame, 6)

                DropMeter = Frame
            end

            DropMeter.Size = UDim2.fromScale(1, (math.clamp(v3, 0, 1)))
        elseif DropMeter then
            DropMeter:Destroy()
        end
    end
end

local function renderSlot(a1)
    -- Line: 404
    -- upvalues: u122 (val), FirstFreeSlot (val), u104 (ref), u91 (val), u102 (val), u105 (ref), u106 (ref), u108 (ref)
    -- upvalues: u123 (ref), u45 (val), u90 (val), u133 (ref), Slots (val), TweenService (val), StackKey (val)
    -- upvalues: ItemIcon (val), Palette (val)
    -- types: a1: number
    local Frame, IconHolder, IconHolder_2, UIStroke_2, v1, v2
    local v3 = u122[a1]

    if not v3 then
        return
    end

    if not (a1 < FirstFreeSlot) then
        v2 = u102[a1]
        v1 = if not v2 then v2 else if not ((u105[v2] or 0) <= 0) then v2 else nil
    else
        v1 = u104[u91[a1]]
    end

    v2 = a1 == u106
    local v4 = false

    if u108 ~= nil then
        v4 = FirstFreeSlot <= a1
    end

    local v5 = false

    if a1 == u123 then
        v5 = not u45.TouchOnly
    end

    local UIStroke = v3:FindFirstChildOfClass("UIStroke")

    if UIStroke then
        UIStroke.Color = if not v4 then
            if not v2 then
                if not v5 then Color3.fromRGB(15, 16, 20) else u90
            else
                Color3.fromRGB(255, 214, 110)
        else
            Color3.fromRGB(120, 220, 140)
        UIStroke.Thickness = if v2 then 3 else if not v4 then 1 else 3
    end

    v3.BackgroundTransparency = if not v2 then if not v5 then 0.4 else 0.2 else 0.05
    local GuideGlow = v3:FindFirstChild("GuideGlow")
    v4 = false

    if u133 ~= nil then
        for i = FirstFreeSlot, Slots do
            if u102[i] == u133 then
                v4 = a1 == i

                if not v4 then
                    if not v4 and GuideGlow then
                        GuideGlow:Destroy()
                    end
                elseif not GuideGlow then
                    Frame = Instance.new("Frame")
                    Frame.Name = "GuideGlow"
                    Frame.AnchorPoint = Vector2.new(0.5, 0.5)
                    Frame.Position = UDim2.fromScale(0.5, 0.5)
                    Frame.Size = UDim2.new(1, 10, 1, 10)
                    Frame.BackgroundTransparency = 1
                    Frame.Active = false
                    Frame.Parent = v3

                    u45.corner(Frame, 10)

                    UIStroke_2 = Instance.new("UIStroke")
                    UIStroke_2.Color = Color3.fromRGB(255, 214, 110)
                    UIStroke_2.Thickness = 3
                    UIStroke_2.Parent = Frame

                    TweenService:Create(
                        UIStroke_2,
                        TweenInfo.new(0.6, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut, -1, true),
                        {Transparency = 0.85}
                    ):Play()
                elseif not v4 and GuideGlow then
                    GuideGlow:Destroy()
                end

                IconHolder = v3:FindFirstChild("IconHolder")
                    and v3.IconHolder:FindFirstChildOfClass("UIScale")

                if IconHolder then
                    TweenService:Create(
                        IconHolder,
                        TweenInfo.new(0.14, Enum.EasingStyle.Back, Enum.EasingDirection.Out),
                        {Scale = (if not v2 then 1 else 1.18) * (if not v5 then 1 else 1.22)}
                    ):Play()
                end

                IconHolder_2 = v3:FindFirstChild("IconHolder")
                v5 = v3:FindFirstChild("Name")
                v4 = v3:FindFirstChild("Count")

                if not v1 then
                    v3 = IconHolder_2:FindFirstChild("Icon")

                    if v3 then
                        v3:Destroy()
                    end

                    v5.Text = ""
                else
                    v2 = StackKey.item(v1)

                    if not ItemIcon.existing(IconHolder_2, v2) then
                        ItemIcon.render(IconHolder_2, v2, 30, if not (a1 < FirstFreeSlot) then 3 else 15)
                    end

                    v5.Text = Palette.displayName(v2)
                end

                v5.TextTransparency = 0

                if v1 and FirstFreeSlot <= a1 then
                    v4.Text = ("x%*"):format(u105[v1] or 0)
                    v4.TextColor3 = Color3.new(1, 1, 1)

                    return
                end

                v4.Text = ""

                return
            end
        end

        v4 = a1 == nil
    end

    if not v4 then
        if not v4 and GuideGlow then
            GuideGlow:Destroy()
        end
    elseif not GuideGlow then
        Frame = Instance.new("Frame")
        Frame.Name = "GuideGlow"
        Frame.AnchorPoint = Vector2.new(0.5, 0.5)
        Frame.Position = UDim2.fromScale(0.5, 0.5)
        Frame.Size = UDim2.new(1, 10, 1, 10)
        Frame.BackgroundTransparency = 1
        Frame.Active = false
        Frame.Parent = v3

        u45.corner(Frame, 10)

        UIStroke_2 = Instance.new("UIStroke")
        UIStroke_2.Color = Color3.fromRGB(255, 214, 110)
        UIStroke_2.Thickness = 3
        UIStroke_2.Parent = Frame

        TweenService:Create(
            UIStroke_2,
            TweenInfo.new(0.6, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut, -1, true),
            {Transparency = 0.85}
        ):Play()
    elseif not v4 and GuideGlow then
        GuideGlow:Destroy()
    end

    IconHolder = v3:FindFirstChild("IconHolder") and v3.IconHolder:FindFirstChildOfClass("UIScale")

    if IconHolder then
        TweenService:Create(
            IconHolder,
            TweenInfo.new(0.14, Enum.EasingStyle.Back, Enum.EasingDirection.Out),
            {Scale = (if not v2 then 1 else 1.18) * (if not v5 then 1 else 1.22)}
        ):Play()
    end

    IconHolder_2 = v3:FindFirstChild("IconHolder")
    v5 = v3:FindFirstChild("Name")
    v4 = v3:FindFirstChild("Count")

    if not v1 then
        v3 = IconHolder_2:FindFirstChild("Icon")

        if v3 then
            v3:Destroy()
        end

        v5.Text = ""
    else
        v2 = StackKey.item(v1)

        if not ItemIcon.existing(IconHolder_2, v2) then
            ItemIcon.render(IconHolder_2, v2, 30, if not (a1 < FirstFreeSlot) then 3 else 15)
        end

        v5.Text = Palette.displayName(v2)
    end

    v5.TextTransparency = 0

    if v1 and FirstFreeSlot <= a1 then
        v4.Text = ("x%*"):format(u105[v1] or 0)
        v4.TextColor3 = Color3.new(1, 1, 1)

        return
    end

    v4.Text = ""
end

function u60.render() -- Line: 509; upvalues: Slots (val), renderSlot (val)
    for i = 1, Slots do
        renderSlot(i)
    end
end

function u60.suggest(a1, a2)
    -- Line: 536
    -- upvalues: u133 (ref), u60 (val), u132 (ref), u106 (ref), u107 (ref), u121 (val), FirstFreeSlot (val), Slots (val)
    -- upvalues: u102 (val), u105 (ref), renderSlot (val)
    -- types: a1: string?, a2: boolean?
    local v1
    local v2 = a1 ~= u133
    local v3 = u133
    u133 = a1

    if v2 and v3 and not a1 and not a2 then
        local v4
        v1 = u60.selected()

        if v1.assignedItemId == v3 then
            u132 = nil
            u106 = 0
            u107 = os.clock()
            v4 = u60.selected()

            for i, j in u121 do
                j(v4)
            end
        elseif v1.itemId == v3 then
            u132 = nil
            u106 = 0
            u107 = os.clock()
            v4 = u60.selected()

            for k, n in u121 do
                n(v4)
            end
        end
    end

    if a1 and v2 then
        local v5, v6
        v1 = Slots

        for m = FirstFreeSlot, v1 do
            if u102[m] == a1 then
                v3 = m

                if not v3 then
                    v3 = u60.firstFreeSlot()

                    if not v3 then
                        v5 = a1

                        for i5 = Slots, FirstFreeSlot, -1 do
                            v6 = u102[i5]

                            if v6 and (u105[v6] or 0) <= 0 then
                                v3 = i5
                                break
                            end
                        end
                    end

                    v3 = v3 or Slots
                    u60.assign(v3, v5)
                end

                if v3 then
                    u132 = nil
                    u106 = v3
                    u107 = os.clock()
                    v1 = u60.selected()

                    for i6, i7 in u121 do
                        i7(v1)
                    end
                end

                for i8 = 1, Slots do
                    renderSlot(i8)
                end

                return
            end
        end

        v3 = nil

        if not v3 then
            v3 = u60.firstFreeSlot()

            if not v3 then
                v5 = a1

                for i9 = Slots, FirstFreeSlot, -1 do
                    v6 = u102[i9]

                    if v6 and (u105[v6] or 0) <= 0 then
                        v3 = i9
                        break
                    end
                end
            end

            v3 = v3 or Slots
            u60.assign(v3, v5)
        end

        if v3 then
            u132 = nil
            u106 = v3
            u107 = os.clock()
            v1 = u60.selected()

            for i10, i11 in u121 do
                i11(v1)
            end
        end
    end

    for i12 = 1, Slots do
        renderSlot(i12)
    end
end

function u60.selectLoose(a1)
    -- Line: 582
    -- upvalues: u132 (ref), Slots (val), renderSlot (val), u60 (val), u121 (val)
    -- types: a1: string?
    u132 = a1

    for i = 1, Slots do
        renderSlot(i)
    end

    local v1 = u60.selected()

    for j, k in u121 do
        k(v1)
    end
end

function u60.toggle(a1)
    -- Line: 592
    -- upvalues: u106 (ref), u132 (ref), u107 (ref), Slots (val), renderSlot (val), u60 (val), u121 (val)
    -- types: a1: number
    if a1 == u106 and not u132 then
        u106 = 0
        u107 = os.clock()

        for i = 1, Slots do
            renderSlot(i)
        end

        local v1 = u60.selected()

        for j, k in u121 do
            k(v1)
        end

        return
    end

    u60.select(a1)
end

function u60.select(a1)
    -- Line: 603
    -- upvalues: Slots (val), u132 (ref), u106 (ref), u107 (ref), renderSlot (val), u60 (val), u121 (val)
    -- types: a1: number
    if not (a1 < 1) and not (Slots < a1) then
        u132 = nil
        u106 = a1
        u107 = os.clock()

        for i = 1, Slots do
            renderSlot(i)
        end

        local v1 = u60.selected()

        for j, k in u121 do
            k(v1)
        end
    end
end

function u60.pickBlock(a1)
    -- Line: 622
    -- upvalues: u105 (ref), FirstFreeSlot (val), Slots (val), u102 (val), u60 (val), u132 (ref), u106 (ref)
    -- types: a1: string
    if (u105[a1] or 0) <= 0 then
        return false
    end

    for i = FirstFreeSlot, Slots do
        if u102[i] == a1 then
            u60.select(i)
            return true
        end
    end

    if u132 == nil and not (u106 < FirstFreeSlot) and not (Slots < u106) then
        u60.assign(u106, a1)
        u60.select(u106)

        return true
    end

    return false
end

function u60.setPending(a1) -- Line: 640; upvalues: u108 (ref), Slots (val), renderSlot (val); types: a1: string?
    u108 = if u108 ~= a1 then a1 else nil

    for i = 1, Slots do
        renderSlot(i)
    end
end

function u60.pending() -- Line: 645; upvalues: u108 (ref)
    return u108
end

local u147 = false

local function scheduleSave()
    -- Line: 654
    -- upvalues: u147 (ref), FirstFreeSlot (val), Slots (val), u102 (val), u74 (val)
    if u147 then
        return
    end

    u147 = true
    task.delay(
        1,
        function()
            -- Line: 659
            -- upvalues: u147 (upval), FirstFreeSlot (upval), Slots (upval), u102 (upval), u74 (upval)
            local v1
            u147 = false
            local v2 = {}
            local v3 = Slots

            for i = FirstFreeSlot, v3 do
                v1 = u102[i]

                if v1 then
                    v2[tostring(i)] = v1
                end
            end

            u74:FireServer(v2)
        end
    )
end

function u60.assign(a1, a2)
    -- Line: 677
    -- upvalues: FirstFreeSlot (val), Slots (val), u48 (val), Config (val), u102 (val), u103 (val), u147 (ref)
    -- upvalues: u74 (val), renderSlot (val), u106 (ref), u60 (val), u121 (val)
    -- types: a1: number, a2: string?
    if not (a1 < FirstFreeSlot) and not (Slots < a1) then
        local v1, v2, v3
        local v4 = true

        if u48.equipSlotOf(a2) == nil then
            v4 = false

            if a2 ~= nil then
                v4 = Config.Wearable.slotOf(a2) ~= nil
            end
        end

        if v4 then
            return
        end

        v4 = u102[a1]

        if not a2 then
            v2, v1 = a2, a1
        else
            v3 = Slots
            v1, v2 = a1, a2

            for i = FirstFreeSlot, v3 do
                if i ~= v1 and u102[i] == v2 then
                    u102[i] = v4
                    v4 = nil
                    break
                end
            end
        end

        u102[v1] = v2

        if v4 then
            u103[v4] = true
        end

        if v2 then
            u103[v2] = nil
        end

        if not u147 then
            u147 = true
            task.delay(
                1,
                function()
                    -- Line: 659
                    -- upvalues: u147 (upval), FirstFreeSlot (upval), Slots (upval), u102 (upval), u74 (upval)
                    local v1
                    u147 = false
                    local v2 = {}
                    local v3 = Slots

                    for i = FirstFreeSlot, v3 do
                        v1 = u102[i]

                        if v1 then
                            v2[tostring(i)] = v1
                        end
                    end

                    u74:FireServer(v2)
                end
            )
        end

        v3 = Slots

        for j = 1, v3 do
            renderSlot(j)
        end

        if v1 == u106 then
            v4 = u60.selected()

            for k, n in u121 do
                n(v4)
            end
        end
    end
end

local function counterpartOf(a1) -- Line: 724; upvalues: Config (val); types: a1: string
    local v1 = Config.Build.Fillables[a1]

    if v1 then
        return v1.becomes
    end

    v1 = Config.Build.Containers[a1]

    if v1 then
        return v1.empties
    end

    return nil
end

local function counterpartSlot(a1)
    -- Line: 742
    -- upvalues: Config (val), FirstFreeSlot (val), Slots (val), u102 (val), u105 (ref)
    -- types: a1: string
    local becomes
    local v1 = Config.Build.Fillables[a1]

    if not v1 then
        v1 = Config.Build.Containers[a1]
        becomes = if not v1 then nil else v1.empties
    else
        becomes = v1.becomes
    end

    if not becomes then
        return nil
    end

    for i = FirstFreeSlot, Slots do
        if u102[i] == becomes then
            v1 = i

            if v1 and (u105[becomes] or 0) <= 0 then
                return v1
            end

            return nil
        end
    end

    v1 = nil

    if v1 and (u105[becomes] or 0) <= 0 then
        return v1
    end

    return nil
end

local function slotForNewItem(a1)
    -- Line: 756
    -- upvalues: Config (val), FirstFreeSlot (val), Slots (val), u102 (val), u105 (ref)
    -- types: a1: string
    local becomes, v1
    local v2 = Config.Build.Fillables[a1]

    if not v2 then
        v2 = Config.Build.Containers[a1]
        becomes = if not v2 then nil else v2.empties
    else
        becomes = v2.becomes
    end

    if becomes then
        for i = FirstFreeSlot, Slots do
            if u102[i] == becomes then
                v2 = i
                v1 = if not v2 then nil else if not ((u105[becomes] or 0) <= 0) then nil else v2

                if v1 then
                    return v1
                end

                for j = FirstFreeSlot, Slots do
                    if not u102[j] then
                        return j
                    end
                end

                return nil
            end
        end

        v2 = nil
        v1 = if not v2 then nil else if not ((u105[becomes] or 0) <= 0) then nil else v2
    else
        v1 = nil
    end

    if v1 then
        return v1
    end

    for k = FirstFreeSlot, Slots do
        if not u102[k] then
            return k
        end
    end

    return nil
end

local function adoptRollStacks()
    -- Line: 790
    -- upvalues: FirstFreeSlot (val), Slots (val), u102 (val), u105 (ref), StackKey (val)
    local v1, v2, v3, v4, v5, v6, v7, v8, v9
    local dispatch = 0

    while true do
        if not (dispatch < 19) then
            return
        end

        v1 = Slots
        local dispatchExit = nil

        for i6 = FirstFreeSlot, v1 do
            local dispatch2 = 1

            while true do
                if not (dispatch2 < 3) then
                    if not (dispatch2 < 9) then
                        table.sort(v6)

                        v7 = v6
                        v8 = nil
                        v9 = nil
                        local dispatchExit3 = nil

                        for i9, i10 in v7, v8, v9 do
                            local dispatch4 = 10

                            while true do
                                if not (dispatch4 < 15) then
                                    if not (dispatch4 < 16) then
                                        u102[i6] = i10
                                        dispatchExit3 = 18
                                        break
                                    end

                                    if v2 then
                                        break
                                    else
                                        dispatch4 = 16
                                    end
                                elseif dispatch4 < 14 then
                                    v3 = Slots
                                    local dispatchExit4 = nil

                                    for i11 = FirstFreeSlot, v3 do
                                        local dispatch5 = 11

                                        while true do
                                            if not (dispatch5 < 12) then
                                                v2 = i11
                                                dispatchExit4 = 15
                                                break
                                            end

                                            if u102[i11] ~= i10 then
                                                break
                                            else
                                                dispatch5 = 12
                                            end
                                        end

                                        if dispatchExit4 then
                                            break
                                        end
                                    end

                                    if dispatchExit4 == 15 then
                                        dispatch4 = 15
                                    else
                                        if not dispatchExit4 then end

                                        dispatch4 = 14
                                    end
                                else
                                    v2 = nil
                                    dispatch4 = 15
                                end
                            end

                            if dispatchExit3 then
                                break
                            end
                        end

                        if not dispatchExit3 then end

                        break
                    end

                    v5 = StackKey.item(v4)
                    v6 = {}
                    v7 = u105
                    v8 = nil
                    v9 = nil
                    local dispatchExit2 = nil

                    for i7, i8 in v7, v8, v9 do
                        local dispatch3 = 4

                        while true do
                            if not (dispatch3 < 6) then
                                if not (dispatch3 < 7) then
                                    table.insert(v6, i7)
                                    break
                                end

                                if StackKey.item(i7) ~= v5 then
                                    break
                                else
                                    dispatch3 = 7
                                end
                            elseif dispatch3 < 5 then
                                if not (i8 > 0) then
                                    break
                                else
                                    dispatch3 = 5
                                end
                            elseif i7 == v5 then
                                break
                            else
                                dispatch3 = 6
                            end
                        end

                        if dispatchExit2 then
                            break
                        end
                    end

                    dispatch2 = 9
                elseif dispatch2 < 2 then
                    v4 = u102[i6]

                    if not v4 then
                        break
                    else
                        dispatch2 = 2
                    end
                elseif not ((u105[v4] or 0) <= 0) then
                    break
                else
                    dispatch2 = 3
                end
            end

            if dispatchExit then
                break
            end
        end

        dispatch = 19
    end
end

local function releaseEmptySlots() -- Line: 812; upvalues: FirstFreeSlot (val), Slots (val), u102 (val), u105 (ref)
    local v1

    for i = FirstFreeSlot, Slots do
        v1 = u102[i]

        if v1 and (u105[v1] or 0) <= 0 then
            u102[i] = nil
        end
    end
end

local function autoAssignNewItems(a1)
    -- Line: 849
    -- upvalues: u105 (ref), FirstFreeSlot (val), Slots (val), u102 (val), u48 (val), Config (val), u103 (val)
    -- types: a1: table
    local becomes, becomes_2, becomes_3, v1, v2, v3, v4, v5, v6, v7, v8, v9, v10
    local dispatch = 0

    while true do
        if dispatch < 54 then
            if dispatch < 53 then
                v2 = {}
                v5 = u105
                v6 = nil
                v7 = nil
                local dispatchExit = nil
                v1 = a1

                for m, i5 in v5, v6, v7 do
                    local dispatch2 = 1

                    while true do
                        if dispatch2 < 28 then
                            if dispatch2 < 14 then
                                if dispatch2 < 9 then
                                    if dispatch2 < 3 then
                                        if dispatch2 < 2 then
                                            v8 = v1[m]

                                            if not v8 then
                                                break
                                            else
                                                dispatch2 = 2
                                            end
                                        elseif i5 <= 0 then
                                            break
                                        else
                                            dispatch2 = 3
                                        end
                                    elseif dispatch2 < 7 then
                                        v10 = Slots
                                        local dispatchExit2 = nil

                                        for i6 = FirstFreeSlot, v10 do
                                            local dispatch3 = 4

                                            while true do
                                                if not (dispatch3 < 5) then
                                                    v9 = i6
                                                    dispatchExit2 = 8
                                                    break
                                                end

                                                if u102[i6] ~= m then
                                                    break
                                                else
                                                    dispatch3 = 5
                                                end
                                            end

                                            if dispatchExit2 then
                                                break
                                            end
                                        end

                                        if dispatchExit2 == 8 then
                                            dispatch2 = 8
                                        else
                                            if not dispatchExit2 then end

                                            dispatch2 = 7
                                        end
                                    elseif dispatch2 < 8 then
                                        v9 = nil
                                        dispatch2 = 8
                                    elseif v9 then
                                        break
                                    else
                                        dispatch2 = 9
                                    end
                                elseif dispatch2 < 11 then
                                    if dispatch2 < 10 then
                                        v9 = true
                                        dispatch2 = if u48.equipSlotOf(m) ~= nil then 14 else 10
                                    else
                                        v9 = false
                                        dispatch2 = if m == nil then 14 else 11
                                    end
                                elseif dispatch2 < 12 then
                                    dispatch2 = if Config.Wearable.slotOf(m) ~= nil then 13 else 12
                                else
                                    v9 = not (dispatch2 < 13)
                                    dispatch2 = 14
                                end
                            elseif dispatch2 < 19 then
                                if dispatch2 < 16 then
                                    if not (dispatch2 < 15) then
                                        dispatch2 = if v8 ~= "More" then 33 else 16
                                    elseif v9 then
                                        break
                                    else
                                        dispatch2 = 15
                                    end
                                elseif dispatch2 < 17 then
                                    v3 = Config.Build.Fillables[m]
                                    dispatch2 = if not v3 then 18 else 17
                                elseif dispatch2 < 18 then
                                    becomes_2 = v3.becomes
                                    dispatch2 = 21
                                else
                                    v3 = Config.Build.Containers[m]
                                    dispatch2 = if not v3 then 20 else 19
                                end
                            elseif dispatch2 < 22 then
                                if dispatch2 < 20 then
                                    becomes_2 = v3.empties
                                    dispatch2 = 21
                                elseif dispatch2 < 21 then
                                    becomes_2 = nil
                                    dispatch2 = 21
                                else
                                    dispatch2 = if becomes_2 then 23 else 22
                                end
                            elseif dispatch2 < 23 then
                                v9 = nil
                                dispatch2 = 32
                            elseif dispatch2 < 27 then
                                v4 = Slots
                                local dispatchExit3 = nil

                                for i7 = FirstFreeSlot, v4 do
                                    local dispatch4 = 24

                                    while true do
                                        if not (dispatch4 < 25) then
                                            v3 = i7
                                            dispatchExit3 = 28
                                            break
                                        end

                                        if u102[i7] ~= becomes_2 then
                                            break
                                        else
                                            dispatch4 = 25
                                        end
                                    end

                                    if dispatchExit3 then
                                        break
                                    end
                                end

                                if dispatchExit3 == 28 then
                                    dispatch2 = 28
                                else
                                    if not dispatchExit3 then end

                                    dispatch2 = 27
                                end
                            else
                                v3 = nil
                                dispatch2 = 28
                            end
                        elseif dispatch2 < 38 then
                            if dispatch2 < 33 then
                                if dispatch2 < 30 then
                                    dispatch2 = if dispatch2 < 29 then
                                        if not v3 then 31 else 29
                                    else
                                        if not ((u105[becomes_2] or 0) <= 0) then 31 else 30
                                elseif dispatch2 < 31 then
                                    v9 = v3
                                    dispatch2 = 32
                                elseif dispatch2 < 32 then
                                    v9 = nil
                                    dispatch2 = 32
                                elseif not v9 then
                                    break
                                else
                                    dispatch2 = 33
                                end
                            elseif dispatch2 < 35 then
                                if dispatch2 < 34 then
                                    dispatch2 = if not u103[m] then 51 else 34
                                else
                                    v10 = Config.Build.Fillables[m]
                                    dispatch2 = if not v10 then 36 else 35
                                end
                            elseif dispatch2 < 36 then
                                becomes_3 = v10.becomes
                                dispatch2 = 39
                            elseif dispatch2 < 37 then
                                v10 = Config.Build.Containers[m]
                                dispatch2 = if not v10 then 38 else 37
                            else
                                becomes_3 = v10.empties
                                dispatch2 = 39
                            end
                        elseif dispatch2 < 46 then
                            if dispatch2 < 40 then
                                if dispatch2 < 39 then
                                    becomes_3 = nil
                                    dispatch2 = 39
                                else
                                    dispatch2 = if becomes_3 then 41 else 40
                                end
                            elseif dispatch2 < 41 then
                                v9 = nil
                                dispatch2 = 50
                            elseif dispatch2 < 45 then
                                v3 = Slots
                                local dispatchExit4 = nil

                                for i8 = FirstFreeSlot, v3 do
                                    local dispatch5 = 42

                                    while true do
                                        if not (dispatch5 < 43) then
                                            v10 = i8
                                            dispatchExit4 = 46
                                            break
                                        end

                                        if u102[i8] ~= becomes_3 then
                                            break
                                        else
                                            dispatch5 = 43
                                        end
                                    end

                                    if dispatchExit4 then
                                        break
                                    end
                                end

                                if dispatchExit4 == 46 then
                                    dispatch2 = 46
                                else
                                    if not dispatchExit4 then end

                                    dispatch2 = 45
                                end
                            else
                                v10 = nil
                                dispatch2 = 46
                            end
                        elseif dispatch2 < 49 then
                            if dispatch2 < 47 then
                                dispatch2 = if not v10 then 49 else 47
                            elseif dispatch2 < 48 then
                                dispatch2 = if not ((u105[becomes_3] or 0) <= 0) then 49 else 48
                            else
                                v9 = v10
                                dispatch2 = 50
                            end
                        elseif dispatch2 < 50 then
                            v9 = nil
                            dispatch2 = 50
                        else
                            if not (dispatch2 < 51) then
                                table.insert(v2, m)
                                break
                            end

                            if not v9 then
                                break
                            else
                                dispatch2 = 51
                            end
                        end
                    end

                    if dispatchExit then
                        break
                    end
                end

                dispatch = 53
            else
                dispatch = if #v2 ~= 0 then 55 else 54
            end
        elseif dispatch < 55 then
            return
        else
            if not (dispatch < 82) then
                return
            end

            table.sort(v2)

            v5 = v2
            v6 = nil
            v7 = nil
            local dispatchExit5 = nil

            for i9, i10 in v5, v6, v7 do
                local dispatch6 = 56

                while true do
                    if dispatch6 < 68 then
                        if dispatch6 < 60 then
                            if dispatch6 < 58 then
                                if dispatch6 < 57 then
                                    v3 = Config.Build.Fillables[i10]
                                    dispatch6 = if not v3 then 58 else 57
                                else
                                    becomes = v3.becomes
                                    dispatch6 = 61
                                end
                            elseif dispatch6 < 59 then
                                v3 = Config.Build.Containers[i10]
                                dispatch6 = if not v3 then 60 else 59
                            else
                                becomes = v3.empties
                                dispatch6 = 61
                            end
                        elseif dispatch6 < 62 then
                            if dispatch6 < 61 then
                                becomes = nil
                                dispatch6 = 61
                            else
                                dispatch6 = if becomes then 63 else 62
                            end
                        elseif dispatch6 < 63 then
                            v9 = nil
                            dispatch6 = 72
                        elseif dispatch6 < 67 then
                            v4 = Slots
                            local dispatchExit6 = nil

                            for i11 = FirstFreeSlot, v4 do
                                local dispatch7 = 64

                                while true do
                                    if not (dispatch7 < 65) then
                                        v3 = i11
                                        dispatchExit6 = 68
                                        break
                                    end

                                    if u102[i11] ~= becomes then
                                        break
                                    else
                                        dispatch7 = 65
                                    end
                                end

                                if dispatchExit6 then
                                    break
                                end
                            end

                            if dispatchExit6 == 68 then
                                dispatch6 = 68
                            else
                                if not dispatchExit6 then end

                                dispatch6 = 67
                            end
                        else
                            v3 = nil
                            dispatch6 = 68
                        end
                    elseif dispatch6 < 73 then
                        if dispatch6 < 70 then
                            dispatch6 = if dispatch6 < 69 then
                                if not v3 then 71 else 69
                            else
                                if not ((u105[becomes] or 0) <= 0) then 71 else 70
                        elseif dispatch6 < 71 then
                            v9 = v3
                            dispatch6 = 72
                        elseif dispatch6 < 72 then
                            v9 = nil
                            dispatch6 = 72
                        else
                            dispatch6 = if not v9 then 74 else 73
                        end
                    elseif dispatch6 < 78 then
                        if dispatch6 < 74 then
                            v8 = v9
                            dispatch6 = 79
                        else
                            v10 = Slots
                            local dispatchExit7 = nil

                            for i12 = FirstFreeSlot, v10 do
                                local dispatch8 = 75

                                while true do
                                    if not (dispatch8 < 76) then
                                        v8 = i12
                                        dispatchExit7 = 79
                                        break
                                    end

                                    if u102[i12] then
                                        break
                                    else
                                        dispatch8 = 76
                                    end
                                end

                                if dispatchExit7 then
                                    break
                                end
                            end

                            if dispatchExit7 == 79 then
                                dispatch6 = 79
                            else
                                if not dispatchExit7 then end

                                dispatch6 = 78
                            end
                        end
                    elseif dispatch6 < 79 then
                        v8 = nil
                        dispatch6 = 79
                    else
                        if not (dispatch6 < 80) then
                            u102[v8] = i10
                            u103[i10] = nil
                            break
                        end

                        if not v8 then
                            return
                        else
                            dispatch6 = 80
                        end
                    end
                end

                if dispatchExit5 then
                    break
                end
            end

            dispatch = 82
        end
    end
end

local function buildSlot(a1, a2)
    -- Line: 897
    -- upvalues: u119 (val), u115 (val), u45 (val), u123 (ref), renderSlot (val), u124 (ref), FirstFreeSlot (val)
    -- upvalues: u102 (val), ControlGlyphs (val), u60 (val), u108 (ref), u122 (val)
    -- types: a1: userdata, a2: number
    local Frame = Instance.new("Frame")
    Frame.Name = ("Slot%*"):format(a2)
    Frame.Size = UDim2.fromOffset(62, 62)
    Frame.BackgroundColor3 = Color3.fromRGB(24, 26, 32)
    Frame.BackgroundTransparency = 0.4
    Frame.LayoutOrder = a2
    Frame.Parent = a1
    local UICorner = Instance.new("UICorner")
    UICorner.CornerRadius = u119
    UICorner.Parent = Frame
    local UIStroke = Instance.new("UIStroke")
    UIStroke.Thickness = 1
    UIStroke.Color = u115
    UIStroke.Parent = Frame
    local TextLabel = Instance.new("TextLabel")
    TextLabel.Name = "Number"
    TextLabel.Size = UDim2.fromOffset(16, 14)
    TextLabel.Position = UDim2.fromOffset(4, 3)
    TextLabel.BackgroundTransparency = 1
    TextLabel.Text = tostring(a2)
    TextLabel.TextColor3 = Color3.fromRGB(190, 195, 210)
    TextLabel.TextSize = 13
    TextLabel.FontFace = u45.Font.Bold
    TextLabel.TextXAlignment = Enum.TextXAlignment.Left
    TextLabel.Parent = Frame
    local Frame_2 = Instance.new("Frame")
    Frame_2.Name = "IconHolder"
    Frame_2.Size = UDim2.fromOffset(30, 30)
    Frame_2.AnchorPoint = Vector2.new(0.5, 0.5)
    Frame_2.Position = UDim2.new(0.5, 0, 0, 25)
    Frame_2.BackgroundTransparency = 1
    local UIScale = Instance.new("UIScale")
    UIScale.Name = "IconScale"
    UIScale.Parent = Frame_2
    Frame_2.Parent = Frame
    local TextLabel_2 = Instance.new("TextLabel")
    TextLabel_2.Name = "Name"
    TextLabel_2.Size = UDim2.new(1, -6, 0, 22)
    TextLabel_2.Position = UDim2.new(0, 3, 1, -24)
    TextLabel_2.BackgroundTransparency = 1
    TextLabel_2.Text = ""
    TextLabel_2.TextColor3 = Color3.fromRGB(238, 241, 248)
    TextLabel_2.TextSize = 10
    TextLabel_2.FontFace = u45.Font.Regular
    TextLabel_2.TextWrapped = true
    TextLabel_2.TextTruncate = Enum.TextTruncate.AtEnd
    TextLabel_2.Parent = Frame
    local v1 = Instance.new("UIStroke")
    v1.Color = Color3.fromRGB(10, 12, 16)
    v1.Thickness = 1.6
    v1.Transparency = 0.15
    v1.Parent = TextLabel_2
    local TextLabel_3 = Instance.new("TextLabel")
    TextLabel_3.Name = "Count"
    TextLabel_3.Size = UDim2.fromOffset(30, 14)
    TextLabel_3.Position = UDim2.new(1, -33, 0, 3)
    TextLabel_3.BackgroundTransparency = 1
    TextLabel_3.Text = ""
    TextLabel_3.TextColor3 = Color3.new(1, 1, 1)
    TextLabel_3.TextSize = 13
    TextLabel_3.FontFace = u45.Font.Bold
    TextLabel_3.TextXAlignment = Enum.TextXAlignment.Right
    TextLabel_3.Parent = Frame
    v1 = Instance.new("UIStroke")
    v1.Color = Color3.fromRGB(10, 12, 16)
    v1.Thickness = 1.6
    v1.Transparency = 0.15
    v1.Parent = TextLabel_3
    local TextButton = Instance.new("TextButton")
    TextButton.Size = UDim2.fromScale(1, 1)
    TextButton.BackgroundTransparency = 1
    TextButton.Text = ""
    TextButton.Parent = Frame

    TextButton.MouseEnter:Connect(function() -- Line: 1008; upvalues: u123 (upval), a2 (val), renderSlot (upval)
        local v1 = u123
        u123 = a2

        if v1 and v1 ~= a2 then
            renderSlot(v1)
        end

        renderSlot(a2)
    end)

    TextButton.MouseLeave:Connect(function() -- Line: 1017; upvalues: u123 (upval), a2 (val), renderSlot (upval)
        if u123 == a2 then
            u123 = nil
            renderSlot(a2)
        end
    end)

    TextButton.Activated:Connect(function()
        -- Line: 1024
        -- upvalues: u124 (upval), a2 (val), FirstFreeSlot (upval), u102 (upval), ControlGlyphs (upval), u60 (upval)
        -- upvalues: u108 (upval)
        if u124 and FirstFreeSlot <= a2 and u102[a2] and ControlGlyphs.bulkHeld() then
            u60.assign(a2, nil)
            return
        end

        if u108 and FirstFreeSlot <= a2 then
            local v1 = u108
            u108 = nil

            u60.assign(a2, v1)
            u60.select(a2)

            return
        end

        u60.toggle(a2)
    end)

    TextButton.MouseButton2Click:Connect(function()
        -- Line: 1054
        -- upvalues: u124 (upval), a2 (val), FirstFreeSlot (upval), u60 (upval)
        if u124 and FirstFreeSlot <= a2 then
            u60.assign(a2, nil)
        end
    end)

    u122[a2] = Frame
end

function u60.start()
    -- Line: 1063
    -- upvalues: u95 (val), u102 (val), LocalPlayer (val), Slots (val), u109 (ref), DeviceMode (val), Config (val)
    -- upvalues: u110 (ref), buildSlot (val), ControlGlyphs (val), u65 (val), StackKey (val), u85 (ref), u84 (ref)
    -- upvalues: u105 (ref), u132 (ref), autoAssignNewItems (val), adoptRollStacks (val), FirstFreeSlot (val)
    -- upvalues: renderSlot (val), u60 (val), u121 (val), u147 (ref), u74 (val), u71 (val), u48 (val), u68 (val)
    -- upvalues: u104 (ref), u106 (ref), u77 (val), u107 (ref), u91 (val)
    for i, j in u95 do
        u102[i] = j
    end

    local ScreenGui = Instance.new("ScreenGui")
    ScreenGui.Name = "AboveHotbar"
    ScreenGui.ResetOnSpawn = false
    ScreenGui.IgnoreGuiInset = true
    ScreenGui.Parent = LocalPlayer:WaitForChild("PlayerGui")
    local v1 = Slots * 62 + (Slots - 1) * 6
    local Frame = Instance.new("Frame")
    Frame.Name = "Hotbar"
    Frame.Size = UDim2.fromOffset(v1, 62)
    Frame.Position = UDim2.new(0.5, -v1 / 2, 1, -80)
    Frame.BackgroundTransparency = 1
    Frame.Parent = ScreenGui
    u109 = Frame

    if DeviceMode.touchOnly() then
        Frame.AnchorPoint = Vector2.new(0.5, 1)
        Frame.Position = UDim2.new(0.5, 0, 1, -18)
        v1 = Instance.new("UIScale")
        v1.Scale = Config.Touch.Hud.HotbarScale
        v1.Parent = Frame
    end

    local Frame_3 = Instance.new("Frame")
    Frame_3.Name = "Dock"
    Frame_3.Size = Frame.Size
    Frame_3.AnchorPoint = Frame.AnchorPoint
    Frame_3.Position = Frame.Position
    Frame_3.BackgroundTransparency = 1
    Frame_3.Parent = ScreenGui

    if DeviceMode.touchOnly() then
        local UIScale = Instance.new("UIScale")
        UIScale.Scale = Config.Touch.Hud.HotbarScale
        UIScale.Parent = Frame_3
    end

    u110 = Frame_3
    local UIListLayout = Instance.new("UIListLayout")
    UIListLayout.FillDirection = Enum.FillDirection.Horizontal
    UIListLayout.Padding = UDim.new(0, 6)
    UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
    UIListLayout.Parent = Frame
    local v2 = Slots

    for k = 1, v2 do
        buildSlot(Frame, k)
    end

    local Frame_2 = Instance.new("Frame")
    Frame_2.Name = "Shoulders"
    Frame_2.Size = Frame.Size
    Frame_2.Position = Frame.Position
    Frame_2.BackgroundTransparency = 1
    Frame_2.Visible = false
    Frame_2.Parent = ScreenGui
    local u127 = ControlGlyphs.icon(Enum.KeyCode.ButtonL1, 30)
    u127.AnchorPoint = Vector2.new(1, 0.5)
    u127.Position = UDim2.new(0, -8, 0.5, 0)
    u127.Parent = Frame_2
    local u142 = ControlGlyphs.icon(Enum.KeyCode.ButtonR1, 30)
    u142.AnchorPoint = Vector2.new(0, 0.5)
    u142.Position = UDim2.new(1, 8, 0.5, 0)
    u142.Parent = Frame_2

    local function showDevice()
        -- Line: 1140
        -- upvalues: ControlGlyphs (upval), Frame_2 (val), u127 (val), u142 (val), Frame (val)
        local Number
        local v1 = ControlGlyphs.usingGamepad()
        Frame_2.Visible = v1
        u127.Image = ControlGlyphs.image(Enum.KeyCode.ButtonL1)
        u142.Image = ControlGlyphs.image(Enum.KeyCode.ButtonR1)

        for i, j in Frame:GetChildren() do
            Number = j:FindFirstChild("Number")

            if Number and Number:IsA("TextLabel") then
                Number.Visible = not v1
            end
        end
    end

    showDevice()
    ControlGlyphs.onChanged(showDevice)

    u65.OnClientEvent:Connect(function(a1, a2, a3, a4, a5, a6, a7)
        -- Line: 1156
        -- upvalues: StackKey (upval), u85 (upval), u84 (upval), u105 (upval), u132 (upval), autoAssignNewItems (upval)
        -- upvalues: adoptRollStacks (upval), FirstFreeSlot (upval), Slots (upval), u102 (upval), renderSlot (upval)
        -- upvalues: u60 (upval), u121 (upval), u147 (upval), u74 (upval)
        local v1 = StackKey.split(a1, if type(a7) ~= "table" then nil else a7)
        local v2 = {}

        if u85 then
            local v3, v4
            local v5 = nil
            local v6 = nil

            for i, j in v1, v5, v6 do
                v3 = u84[i] or 0

                if v3 < j then
                    v4 = if not (v3 <= 0) then "More" else "New"
                    v2[i] = v4
                end
            end
        elseif a6 == true then
            u85 = true
        end

        u84 = table.clone(v1)
        u105 = v1

        if u132 and (u105[u132] or 0) <= 0 then
            u132 = nil
        end

        autoAssignNewItems(v2)
        adoptRollStacks()

        local v7 = Slots

        for k = FirstFreeSlot, v7 do
            v2 = u102[k]

            if v2 and (u105[v2] or 0) <= 0 then
                u102[k] = nil
            end
        end

        v7 = Slots

        for n = 1, v7 do
            renderSlot(n)
        end

        v1 = u60.selected()

        for m, i5 in u121 do
            i5(v1)
        end

        if u85 then
            if u147 then
                return
            end

            u147 = true
            task.delay(
                1,
                function()
                    -- Line: 659
                    -- upvalues: u147 (upval), FirstFreeSlot (upval), Slots (upval), u102 (upval), u74 (upval)
                    local v1
                    u147 = false
                    local v2 = {}
                    local v3 = Slots

                    for i = FirstFreeSlot, v3 do
                        v1 = u102[i]

                        if v1 then
                            v2[tostring(i)] = v1
                        end
                    end

                    u74:FireServer(v2)
                end
            )
        end
    end)

    u71.OnClientEvent:Connect(function(a1)
        -- Line: 1204
        -- upvalues: FirstFreeSlot (upval), Slots (upval), u102 (upval), u48 (upval), Config (upval)
        -- upvalues: adoptRollStacks (upval), renderSlot (upval), u60 (upval), u121 (upval)
        local v1, v2, v3, v4

        if type(a1) ~= "table" then
            return
        end

        for i = FirstFreeSlot, Slots do
            v1 = a1[tostring(i)]
            v2 = u102

            if type(v1) ~= "string" then
                v3 = nil
            else
                v4 = true

                if u48.equipSlotOf(v1) == nil then
                    v4 = false

                    if v1 ~= nil then
                        v4 = Config.Wearable.slotOf(v1) ~= nil
                    end
                end

                v3 = if v4 then nil else v1
            end

            v2[i] = v3
        end

        adoptRollStacks()

        local v5 = Slots

        for j = 1, v5 do
            renderSlot(j)
        end

        v5 = u60.selected()

        for k, n in u121 do
            n(v5)
        end
    end)

    u68.OnClientEvent:Connect(function(a1)
        -- Line: 1217
        -- upvalues: u104 (upval), Slots (upval), renderSlot (upval), u106 (upval), FirstFreeSlot (upval), u60 (upval)
        -- upvalues: u121 (upval)
        u104 = a1
        local v1 = Slots

        for i = 1, v1 do
            renderSlot(i)
        end

        if u106 ~= 0 and u106 < FirstFreeSlot then
            v1 = u60.selected()

            for j, k in u121 do
                k(v1)
            end
        end
    end)

    u77.OnClientEvent:Connect(function(a1, a2, a3, a4, a5)
        -- Line: 1235
        -- upvalues: u107 (upval), Config (upval), u106 (upval), u132 (upval), FirstFreeSlot (upval), Slots (upval)
        -- upvalues: renderSlot (upval), u60 (upval), u121 (upval), u91 (upval)
        -- types: a1: string, a2: string?, a3: number?, a4: boolean?, a5: string?
        local v1

        if os.clock() - u107 < Config.Player.EquipEchoGraceSeconds or a5 then
            return
        end

        if not a4 then
            v1 = table.find(u91, a1)

            if v1 and v1 ~= u106 then
                u60.select(v1)
                return
            end

            return
        end

        if u106 ~= 0 and not u132 and u106 < FirstFreeSlot then
            u106 = 0
            v1 = Slots

            for i = 1, v1 do
                renderSlot(i)
            end

            v1 = u60.selected()

            for j, k in u121 do
                k(v1)
            end
        end
    end)

    local v3 = Slots

    for n = 1, v3 do
        renderSlot(n)
    end
end

return u60