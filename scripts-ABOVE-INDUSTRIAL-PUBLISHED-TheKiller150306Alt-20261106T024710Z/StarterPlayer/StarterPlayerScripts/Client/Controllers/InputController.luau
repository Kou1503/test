-- Script path: game:GetService("StarterPlayer").StarterPlayerScripts.Client.Controllers.InputController
-- Decompile time: 23.39 ms

local v1
local Players = game:GetService("Players")
local GuiService = game:GetService("GuiService")
local UserInputService = game:GetService("UserInputService")
local ContextActionService = game:GetService("ContextActionService")
local RunService = game:GetService("RunService")
local StarterGui = game:GetService("StarterGui")
local Shared = (game:GetService("ReplicatedStorage")):WaitForChild("Shared")
local Config = require(Shared.Config)
local Grid = require(Shared.Grid)
local Rails = require(Shared.Rails)
local Remotes = require(Shared.Remotes)
local u56 = require(script.Parent.AnimationController)
local AudioController = require(script.Parent.AudioController)
local BackpackController = require(script.Parent.BackpackController)
local Aim = require(script.Parent.Aim)
local BuildController = require(script.Parent.BuildController)
local CraftingController = require(script.Parent.CraftingController)
local DialogueController = require(script.Parent.DialogueController)
local FriendsController = require(script.Parent.FriendsController)
local AchievementsController = require(script.Parent.AchievementsController)
local CollectionController = require(script.Parent.CollectionController)
local GuestBookController = require(script.Parent.GuestBookController)
local IslandResetController = require(script.Parent.IslandResetController)
local PortalMoveController = require(script.Parent.PortalMoveController)
local PortalSkinController = require(script.Parent.PortalSkinController)
local PremiumShopController = require(script.Parent.PremiumShopController)
local SettingsPanelController = require(script.Parent.SettingsPanelController)
local HotbarController = require(script.Parent.HotbarController)
local Ui = require(script.Parent.Parent.Ui)
local StorageController = require(script.Parent.StorageController)
local ShopController = require(script.Parent.ShopController)
local QuickTeleportController = require(script.Parent.QuickTeleportController)
local PromptController = require(script.Parent.PromptController)
local TargetController = require(script.Parent.TargetController)
local u168 = {}
local SettingsController = require(script.Parent.SettingsController)
local KeyBinds = require(script.Parent.KeyBinds)
local PanelTabs = require(script.Parent.PanelTabs)
local u186 = Remotes.get(Remotes.RequestSprint)
u168.sprinting = false
local LocalPlayer = Players.LocalPlayer
local u192 = Remotes.get(Remotes.RequestSwing)
local u195 = Remotes.get(Remotes.RequestEquipSlot)
local u198 = Remotes.get(Remotes.RequestDrop)
local u201 = Remotes.get(Remotes.RequestUseItem)
local u204 = Remotes.get(Remotes.RequestPollinate)
local u207 = Remotes.get(Remotes.RequestFillWater)
local u210 = Remotes.get(Remotes.RequestConsume)
local u213 = Remotes.get(Remotes.RequestPickup)
local u216 = Remotes.get(Remotes.RequestHarvest)
local u219 = Remotes.get(Remotes.RequestHoldBlock)
local u220 = {
    [Enum.KeyCode.One] = 1,
    [Enum.KeyCode.Two] = 2,
    [Enum.KeyCode.Three] = 3,
    [Enum.KeyCode.Four] = 4,
    [Enum.KeyCode.Five] = 5,
    [Enum.KeyCode.Six] = 6,
    [Enum.KeyCode.Seven] = 7,
    [Enum.KeyCode.Eight] = 8,
    [Enum.KeyCode.Nine] = 9,
}
local v2 = {
    [33] = 1,
    [64] = 2,
    [35] = 3,
    [36] = 4,
    [37] = 5,
    [94] = 6,
    [38] = 7,
    [42] = 8,
    [40] = 9,
}
local u249 = {}

for i, j in Enum.KeyCode:GetEnumItems() do
    v1 = v2[j.Value]

    if v1 then
        u249[j] = v1
    end
end

local function slotForKey(a1) -- Line: 104; upvalues: u220 (val), u249 (val), UserInputService (val)
    local v1 = u220[a1]

    if v1 then
        return v1
    end

    v1 = u249[a1]

    if not v1 then
        return nil
    end

    if not UserInputService:IsKeyDown(Enum.KeyCode.LeftShift)
        and not UserInputService:IsKeyDown(Enum.KeyCode.RightShift) then
        return nil
    end

    return v1
end

local u267 = 0

local function holdInterval() -- Line: 133; upvalues: HotbarController (val), Config (val)
    local v1 = HotbarController.selected()
    local assignedItemId = v1.assignedItemId

    if v1.kind ~= "Tool" and assignedItemId then
        if not Config.Crop.isSeed(assignedItemId)
            and not Config.Bush.isSeed(assignedItemId) then
            return Config.Build.Placement.CooldownSeconds
        end

        return Config.Build.Placement.SeedCooldownSeconds
    end

    return 0.12
end

local function holdDue() -- Line: 149; upvalues: HotbarController (val), u56 (val), u267 (ref), holdInterval (val)
    if HotbarController.selected().kind == "Tool" then
        return u56.swingReady()
    end

    local v1 = os.clock() - u267

    return holdInterval() <= v1
end

local u273 = nil
local u274 = {}
local u275 = {}
local u276 = false
local u277 = false

local function selectionKey() -- Line: 180; upvalues: HotbarController (val)
    local v1 = HotbarController.selected()
    local index = v1.index
    local assignedItemId = v1.assignedItemId or v1.itemId or ""

    return (("%*:%*"):format(index, assignedItemId))
end

local u279 = nil

local function handEmpty(a1) -- Line: 193
    local v1 = false

    if a1.kind ~= "Tool" then
        v1 = a1.assignedItemId == nil
    end

    return v1
end

local u281 = "item:none"

local function applySelection(a1)
    -- Line: 216
    -- upvalues: BuildController (val), u56 (val), u281 (ref), u195 (val), u219 (val)
    if a1.kind == "Tool" and a1.toolSlot then
        BuildController.setBuildMode(false)
        u56.setToolInHand(true)

        local v1 = ("tool:%*"):format(a1.toolSlot)

        if v1 ~= u281 then
            u281 = v1
            u195:FireServer(a1.toolSlot)
        end

        return
    end

    u56.setToolInHand(false)

    local itemId = a1.itemId
    BuildController.setSelectedBlock(itemId or "", a1.count, a1.roll)
    BuildController.setBuildMode(a1.placeable)

    local v2 = ("item:%*"):format(itemId or "none")

    if v2 ~= u281 then
        u281 = v2
        u219:FireServer(itemId)
    end
end

local function tryPickup()
    -- Line: 252
    -- upvalues: TargetController (val), u213 (val), u216 (val), AudioController (val)
    local v1 = TargetController.pickupEntityId()

    if v1 then
        u213:FireServer(v1)
        return
    end

    v1 = TargetController.harvestTarget()

    if v1 then
        u216:FireServer(v1)
        AudioController.play("Collect", v1.Position)
    end
end

local function closeOpenPanels()
    -- Line: 274
    -- upvalues: DialogueController (val), ShopController (val), StorageController (val), GuestBookController (val)
    -- upvalues: CollectionController (val), IslandResetController (val), AchievementsController (val)
    -- upvalues: PortalSkinController (val), PremiumShopController (val), SettingsPanelController (val)
    -- upvalues: FriendsController (val), CraftingController (val), BackpackController (val), BuildController (val)
    -- upvalues: QuickTeleportController (val)
    local v1 = false

    if DialogueController.isOpen() then
        DialogueController.close()

        v1 = true
    end

    if ShopController.isOpen() then
        ShopController.close()

        v1 = true
    end

    if StorageController.isOpen() then
        StorageController.close()

        v1 = true
    end

    if GuestBookController.isOpen() then
        GuestBookController.close()

        v1 = true
    end

    if CollectionController.isOpen() then
        CollectionController.close()

        v1 = true
    end

    if IslandResetController.isOpen() then
        IslandResetController.close()

        v1 = true
    end

    if AchievementsController.isOpen() then
        AchievementsController.close()

        v1 = true
    end

    if PortalSkinController.isOpen() then
        PortalSkinController.close()

        v1 = true
    end

    if PremiumShopController.isOpen() then
        PremiumShopController.close()

        v1 = true
    end

    if SettingsPanelController.isOpen() then
        SettingsPanelController.close()

        v1 = true
    end

    if FriendsController.isOpen() then
        FriendsController.close()

        v1 = true
    end

    if CraftingController.isOpen() then
        CraftingController.close()

        v1 = true
    end

    if BackpackController.isOpen() then
        BackpackController.close()

        v1 = true
    end

    if BuildController.closeOpen() then
        v1 = true
    end

    if QuickTeleportController.isOpen() then
        QuickTeleportController.close()

        v1 = true
    end

    return v1
end

local function act(a1)
    -- Line: 349
    -- upvalues: LocalPlayer (val), PortalMoveController (val), HotbarController (val), Config (val)
    -- upvalues: TargetController (val), u204 (val), Rails (val), BuildController (val), u201 (val), u207 (val)
    -- upvalues: u273 (ref), Grid (val), AudioController (val), u210 (val), Aim (val), u192 (val), u56 (val)
    -- types: a1: boolean?
    local Character = LocalPlayer.Character
    local Humanoid = Character and Character:FindFirstChildOfClass("Humanoid")

    if Humanoid and not (Humanoid.Health <= 0) then
        if PortalMoveController.isActive() then
            return
        end

        local u16 = HotbarController.selected()
        local v1 = false

        if u16.kind ~= "Tool" then
            v1 = u16.assignedItemId == nil
        end

        if v1 then
            return
        end

        local assignedItemId = u16.assignedItemId

        if u16.kind ~= "Tool" and u16.count <= 0 then
            return
        end

        if assignedItemId == Config.Flower.PollinatorItem then
            if not a1 and 0 < u16.count then
                v1 = TargetController.flowerTarget()

                if v1 then
                    u204:FireServer(v1)
                end
            end

            return
        end

        if Rails.isCart(assignedItemId) then
            if not a1 and 0 < u16.count then
                v1 = BuildController.aimedBlockCell()

                if v1 then
                    u201:FireServer(assignedItemId, v1)
                end
            end

            return
        end

        local v2 = if not (if not assignedItemId then
            nil
        else
            Config.Build.Containers[assignedItemId]) then
            nil
        else
            BuildController.aimedBlockPart()
        local Attribute = v2 and v2:GetAttribute("WaterUses")
        local v3 = false

        if v1 ~= nil then
            v3 = false

            if v2 ~= nil then
                v3 = false

                if (v2:GetAttribute("BlockId")) == v1.places then
                    v3 = false

                    if type(Attribute) == "number" then
                        v3 = Attribute < Config.Build.Farm.WaterUses
                    end
                end
            end
        end

        if v1 and not v3 and 0 < u16.count then
            local v4 = BuildController.aimedWaterPoint()

            if v4 then
                if not a1 then
                    u207:FireServer(v4)
                end

                return
            end
        end

        v2 = true

        if assignedItemId ~= Config.Build.Farm.WateringCan.ItemId then
            v2 = assignedItemId == Config.Recipe.Compost.Output
        end

        v1 = false

        if assignedItemId ~= nil then
            v1 = true

            if Config.Build.Fillables[assignedItemId] == nil then
                v1 = true

                if Config.Build.Converters[assignedItemId] == nil then
                    v1 = v2 or v3
                end
            end
        end

        if v1 and 0 < u16.count then
            v3 = if not v2 then
                BuildController.aimedBlockCell()
            else
                BuildController.aimedBlockCellThroughCrops()
            local v5 = false

            if v3 ~= nil then
                v5 = false

                if u273 ~= nil then
                    v5 = (Grid.key(v3)) == Grid.key(u273)
                end
            end

            if a1 and v5 then
                return
            end

            if v3 then
                u273 = v3
                u201:FireServer(assignedItemId, v3)

                if Config.Sound.Cues[assignedItemId] then
                    AudioController.play(assignedItemId, Grid.cellToWorld(BuildController.islandOrigin() or Vector3.new(0, 0, 0), v3))
                end

                return
            end

            v5 = if not a1 then BuildController.aimedWaterPoint() else nil

            if v5 then
                u207:FireServer(v5)
                return
            end
        end

        if v1 then
            return
        end

        if assignedItemId ~= nil and Config.Food.isFood(assignedItemId) then
            if 0 < u16.count and not a1 then
                u210:FireServer(assignedItemId)
            end

            return
        end

        if assignedItemId ~= nil then
            if u16.placeable then
                if not a1 or not Aim.isTouch() then
                    BuildController.tryPlace()
                end
            end

            return
        end

        local u264 = BuildController.aimedInstance()

        local function hit()
            -- Line: 589
            -- upvalues: u264 (ref), BuildController (upval), u192 (upval), LocalPlayer (upval), Config (upval)
            -- upvalues: u16 (val), AudioController (upval)
            if u264 == nil or u264.Parent == nil then
                u264 = BuildController.aimedInstance()
            end

            u192:FireServer(u264)

            local Character = LocalPlayer.Character
                and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
            local v1 = false

            if Character ~= nil then
                v1 = Character:IsA("BasePart")

                if v1 then
                    v1 = false

                    if u264 ~= nil then
                        v1 = (u264.Position - Character.Position).Magnitude
                            <= Config.Player.InteractReachStuds
                    end
                end
            end

            if v1 and u264 and u264:GetAttribute("NodeType") and u16.toolSlot ~= "Weapon" then
                AudioController.play(if u16.toolSlot ~= "Axe" then "PickaxeHit" else "AxeHit", u264.Position)
            end
        end

        v1 = u56.playSwing(hit)

        if v1 == "Scheduled" or v1 == "Cooldown" then
            return
        end

        hit()
    end
end

function u168.actOnce() -- Line: 650; upvalues: act (val)
    act()
end

function u168.handEmpty(a1) -- Line: 656
    local v1 = false

    if a1.kind ~= "Tool" then
        v1 = a1.assignedItemId == nil
    end

    return v1
end

function u168.setActionHeld(a1, a2)
    -- Line: 666
    -- upvalues: u276 (ref), u274 (val), u267 (ref), u279 (ref), HotbarController (val), act (val), u273 (ref)
    -- types: a1: boolean, a2: string?
    local v1 = u276
    u274[a2 or "button"] = if not a1 then nil else true
    u276 = next(u274) ~= nil

    if not a1 then
        if not u276 then
            u273 = nil
        end

        return
    end

    if v1 then
        return
    end

    u267 = os.clock()
    local v2 = HotbarController.selected()
    u279 = ("%*:%*"):format(v2.index, v2.assignedItemId or v2.itemId or "")

    act()
end

function u168.setPickupHeld(a1, a2)
    -- Line: 689
    -- upvalues: u277 (ref), u275 (val), TargetController (val), u213 (val), u216 (val), AudioController (val)
    -- types: a1: boolean, a2: string?
    local v1 = u277
    u275[a2 or "button"] = if not a1 then nil else true
    u277 = next(u275) ~= nil

    if a1 and not v1 then
        local v2 = TargetController.pickupEntityId()

        if v2 then
            u213:FireServer(v2)
            return
        end

        v2 = TargetController.harvestTarget()

        if v2 then
            u216:FireServer(v2)
            AudioController.play("Collect", v2.Position)
        end
    end
end

function u168.pickupOnce()
    -- Line: 701
    -- upvalues: TargetController (val), u213 (val), u216 (val), AudioController (val)
    local v1 = TargetController.pickupEntityId()

    if v1 then
        u213:FireServer(v1)
        return
    end

    v1 = TargetController.harvestTarget()

    if v1 then
        u216:FireServer(v1)
        AudioController.play("Collect", v1.Position)
    end
end

local u323 = nil

local function cancelToolDrop() -- Line: 713; upvalues: u323 (ref), HotbarController (val)
    if u323 then
        u323 = nil
        HotbarController.setDropProgress(nil)
    end
end

local function startDrop() -- Line: 720; upvalues: HotbarController (val), u198 (val), u323 (ref)
    local v1 = HotbarController.selected()

    if not v1.itemId then
        return
    end

    if v1.kind ~= "Tool" then
        u198:FireServer(v1.itemId, v1.roll)
        return
    end

    if v1.count <= 0 then
        return
    end

    u323 = {itemId = v1.itemId, index = v1.index, startedAt = os.clock()}
    HotbarController.setDropProgress(0)
end

local function stepToolDrop() -- Line: 738; upvalues: u323 (ref), HotbarController (val), Config (val), u198 (val)
    local v1 = u323

    if not v1 then
        return
    end

    local v2 = HotbarController.selected()

    if v2.index == v1.index and v2.itemId == v1.itemId then
        v2 = (os.clock() - v1.startedAt) / Config.Player.ToolDropHoldSeconds

        if not (v2 >= 1) then
            HotbarController.setDropProgress(v2)
            return
        end

        if u323 then
            u323 = nil
            HotbarController.setDropProgress(nil)
        end

        u198:FireServer(v1.itemId)

        return
    end

    if u323 then
        u323 = nil
        HotbarController.setDropProgress(nil)
    end
end

function u168.setDropHeld(a1)
    -- Line: 758
    -- upvalues: startDrop (val), u323 (ref), HotbarController (val)
    -- types: a1: boolean
    if a1 then
        startDrop()
        return
    end

    if u323 then
        u323 = nil
        HotbarController.setDropProgress(nil)
    end
end

local function sprintModeNow() -- Line: 766; upvalues: SettingsController (val)
    return SettingsController.get("SprintMode")
end

local u331 = false
local u332 = false
local u333 = false

local function publishSprint()
    -- Line: 774
    -- upvalues: SettingsController (val), u333 (ref), u332 (ref), u331 (ref), u168 (val), u186 (val)
    local SprintMode = SettingsController.get("SprintMode")
    local v1 = u333
        or (if SprintMode ~= "Auto" then if SprintMode ~= "Toggle" then u331 else u332 else true)

    if v1 ~= u168.sprinting then
        u168.sprinting = v1
        u186:FireServer(v1)
    end
end

function u168.setSprintInput(a1)
    -- Line: 786
    -- upvalues: u331 (ref), SettingsController (val), u332 (ref), u333 (ref), u168 (val), u186 (val)
    -- types: a1: boolean
    if a1 and SettingsController.get("SprintMode") == "Toggle" then
        u332 = not u332
    end

    local SprintMode = SettingsController.get("SprintMode")
    local v1 = u333
        or (if SprintMode ~= "Auto" then if SprintMode ~= "Toggle" then a1 else u332 else true)

    if v1 ~= u168.sprinting then
        u168.sprinting = v1
        u186:FireServer(v1)
    end
end

function u168.toggleSprintButton()
    -- Line: 798
    -- upvalues: u333 (ref), SettingsController (val), u332 (ref), u331 (ref), u168 (val), u186 (val)
    u333 = not u333
    local SprintMode = SettingsController.get("SprintMode")
    local v1 = u333
        or (if SprintMode ~= "Auto" then if SprintMode ~= "Toggle" then u331 else u332 else true)

    if v1 ~= u168.sprinting then
        u168.sprinting = v1
        u186:FireServer(v1)
    end

    return u168.sprinting
end

local function onSprintModeChanged()
    -- Line: 807
    -- upvalues: u332 (ref), SettingsController (val), u333 (ref), u331 (ref), u168 (val), u186 (val)
    u332 = false
    local SprintMode = SettingsController.get("SprintMode")
    local v1 = u333
        or (if SprintMode ~= "Auto" then if SprintMode ~= "Toggle" then u331 else u332 else true)

    if v1 ~= u168.sprinting then
        u168.sprinting = v1
        u186:FireServer(v1)
    end
end

local function freecamFlying() -- Line: 818; upvalues: ContextActionService (val)
    for i in ContextActionService:GetAllBoundActionInfo() do
        if i ~= "AboveFreecam" and string.sub(i, 1, 7) ~= "Freecam" then
            continue
        end

        return true
    end

    return false
end

local function backpackKey()
    -- Line: 829
    -- upvalues: ShopController (val), StorageController (val), CraftingController (val), BackpackController (val)
    if ShopController.isOpen() then
        ShopController.close()
        return
    end

    if StorageController.isOpen() then
        StorageController.close()
        return
    end

    if CraftingController.isOpen() then
        CraftingController.close()
        return
    end

    BackpackController.toggle()
end

local function aimedFlowerId() -- Line: 848; upvalues: Aim (val), LocalPlayer (val), Config (val), Grid (val)
    local Attribute
    local v1 = Aim.ray()
    local v2 = RaycastParams.new()
    v2.FilterType = Enum.RaycastFilterType.Exclude
    v2.FilterDescendantsInstances = if not LocalPlayer.Character then {} else {LocalPlayer.Character}
    local v3 = workspace:Raycast(v1.Origin, v1.Direction.Unit * Config.Player.BuildReachCells * Grid.CellSize, v2)
    local Instance = v3 and v3.Instance

    while Instance do
        if Instance == workspace then
            break
        end

        Attribute = Instance:GetAttribute("FlowerId")

        if type(Attribute) == "string" then
            return Attribute
        end

        Instance = Instance.Parent
    end

    return nil
end

local function cycleHotbar(a1) -- Line: 867; upvalues: Config (val), HotbarController (val); types: a1: number
    local Slots = Config.Player.Hotbar.Slots
    local index = HotbarController.selected().index

    HotbarController.select(((if type(index) ~= "number" then if not (a1 > 0) then 1 else 0 else if not (index >= 1) then if not (a1 > 0) then 1 else 0 else index) - 1 + a1) % Slots + 1)
end

local u344 = {
    [Enum.KeyCode.DPadUp] = true,
    [Enum.KeyCode.DPadDown] = true,
    [Enum.KeyCode.DPadLeft] = true,
    [Enum.KeyCode.DPadRight] = true,
}

local function gamepadBegan(a1)
    -- Line: 889
    -- upvalues: u344 (val), GuiService (val), PortalMoveController (val), BuildController (val), u168 (val)
    -- upvalues: PanelTabs (val), Config (val), HotbarController (val), backpackKey (val), startDrop (val), Aim (val)
    -- upvalues: CraftingController (val), closeOpenPanels (val)
    if u344[a1] and GuiService.SelectedObject ~= nil then
        return false
    end

    if PortalMoveController.isActive() and a1 == Enum.KeyCode.ButtonR2 then
        PortalMoveController.confirm()
        return true
    end

    if a1 == Enum.KeyCode.ButtonR2 then
        if not BuildController.isUiOpen() then
            u168.setActionHeld(true, "gamepad")
        end

        return true
    end

    if a1 == Enum.KeyCode.ButtonY then
        if not BuildController.isUiOpen() then
            u168.setPickupHeld(true, "gamepad")
        end

        return true
    end

    if a1 ~= Enum.KeyCode.ButtonR1 and a1 ~= Enum.KeyCode.ButtonL1 then
        if a1 == Enum.KeyCode.DPadUp then
            backpackKey()
            return true
        end

        if a1 == Enum.KeyCode.DPadDown then
            startDrop()
            return true
        end

        if a1 == Enum.KeyCode.DPadLeft then
            if not PortalMoveController.isActive() then
                BuildController.rotate()
            else
                PortalMoveController.rotate()
            end

            return true
        end

        if a1 == Enum.KeyCode.ButtonR3 and Aim.isVR() then
            if not PortalMoveController.isActive() then
                BuildController.rotate()
            else
                PortalMoveController.rotate()
            end

            return true
        end

        if a1 == Enum.KeyCode.DPadRight then
            CraftingController.toggleHandCrafting()
            return true
        end

        if a1 == Enum.KeyCode.ButtonL2 then
            if not BuildController.isUiOpen() then
                BuildController.flip()
            end

            return true
        end

        if a1 == Enum.KeyCode.ButtonL3 then
            u168.toggleSprintButton()
            return true
        end

        if a1 ~= Enum.KeyCode.ButtonB then
            return false
        end

        if PortalMoveController.isActive() then
            PortalMoveController.cancel()
            return true
        end

        closeOpenPanels()

        return true
    end

    local v1 = if a1 ~= Enum.KeyCode.ButtonR1 then -1 else 1

    if not BuildController.isUiOpen() or not PanelTabs.step(v1) then
        local Slots = Config.Player.Hotbar.Slots
        local index = HotbarController.selected().index

        HotbarController.select(((if type(index) ~= "number" then if not (v1 > 0) then 1 else 0 else if not (index >= 1) then if not (v1 > 0) then 1 else 0 else index) - 1 + v1) % Slots + 1)
    end

    return true
end

local function gamepadEnded(a1) -- Line: 959; upvalues: u168 (val), u323 (ref), HotbarController (val)
    if a1 == Enum.KeyCode.ButtonR2 then
        u168.setActionHeld(false, "gamepad")
        return
    end

    if a1 == Enum.KeyCode.ButtonY then
        u168.setPickupHeld(false, "gamepad")
        return
    end

    if a1 == Enum.KeyCode.DPadDown and u323 then
        u323 = nil
        HotbarController.setDropProgress(nil)
    end
end

function u168.start()
    -- Line: 969
    -- upvalues: StarterGui (val), UserInputService (val), LocalPlayer (val), SettingsController (val), u332 (ref)
    -- upvalues: u333 (ref), u331 (ref), u168 (val), u186 (val), HotbarController (val), applySelection (val)
    -- upvalues: Remotes (val), u281 (ref), Config (val), ContextActionService (val), GuiService (val)
    -- upvalues: closeOpenPanels (val), gamepadBegan (val), aimedFlowerId (val), BuildController (val), u220 (val)
    -- upvalues: u249 (val), PortalMoveController (val), CraftingController (val), backpackKey (val)
    -- upvalues: ShopController (val), StorageController (val), BackpackController (val), FriendsController (val)
    -- upvalues: SettingsPanelController (val), PremiumShopController (val), PortalSkinController (val)
    -- upvalues: CollectionController (val), AchievementsController (val), GuestBookController (val)
    -- upvalues: IslandResetController (val), KeyBinds (val), startDrop (val), Aim (val), Ui (val)
    -- upvalues: PromptController (val), gamepadEnded (val), u323 (ref), RunService (val), stepToolDrop (val)
    -- upvalues: u276 (ref), u56 (val), u267 (ref), holdInterval (val), u279 (ref), act (val), u277 (ref)
    -- upvalues: TargetController (val), u213 (val), u216 (val), AudioController (val)
    task.spawn(function() -- Line: 978; upvalues: StarterGui (upval)
        for i = 1, 10 do
            if pcall(function() -- Line: 980; upvalues: StarterGui (upval)
                StarterGui:SetCoreGuiEnabled(Enum.CoreGuiType.Backpack, false)
                StarterGui:SetCoreGuiEnabled(Enum.CoreGuiType.Health, false)
            end) then
                return
            end

            task.wait(0.5)
        end
    end)

    task.spawn(function() -- Line: 1004; upvalues: UserInputService (upval), LocalPlayer (upval)
        local FocusedTextBox, Parent, PlayerGui, v1

        while true do
            task.wait(0.25)

            FocusedTextBox = UserInputService:GetFocusedTextBox()

            if FocusedTextBox then
                PlayerGui = LocalPlayer:FindFirstChildOfClass("PlayerGui") or game

                if not FocusedTextBox:IsDescendantOf(PlayerGui) then
                    FocusedTextBox:ReleaseFocus()
                elseif FocusedTextBox then
                    v1 = true
                    Parent = FocusedTextBox

                    while Parent do
                        if Parent:IsA("ScreenGui") then
                            break
                        end

                        if Parent:IsA("GuiObject") and not Parent.Visible then
                            v1 = false
                            break
                        end

                        Parent = Parent.Parent
                    end

                    if not v1 then
                        FocusedTextBox:ReleaseFocus()
                    end
                end
            elseif FocusedTextBox then
                v1 = true
                Parent = FocusedTextBox

                while Parent do
                    if Parent:IsA("ScreenGui") then
                        break
                    end

                    if Parent:IsA("GuiObject") and not Parent.Visible then
                        v1 = false
                        break
                    end

                    Parent = Parent.Parent
                end

                if not v1 then
                    FocusedTextBox:ReleaseFocus()
                end
            end
        end
    end)

    SettingsController.onChanged(function(a1)
        -- Line: 1029
        -- upvalues: u332 (upval), SettingsController (upval), u333 (upval), u331 (upval), u168 (upval), u186 (upval)
        if a1 == "SprintMode" then
            u332 = false
            local SprintMode = SettingsController.get("SprintMode")
            local v1 = u333
                or (if SprintMode ~= "Auto" then if SprintMode ~= "Toggle" then u331 else u332 else true)

            if v1 ~= u168.sprinting then
                u168.sprinting = v1
                u186:FireServer(v1)
            end
        end
    end)

    HotbarController.onChanged(applySelection)
    applySelection(HotbarController.selected())

    ;(Remotes.get(Remotes.EquippedChanged)).OnClientEvent:Connect(function(a1, a2, a3, a4, a5)
        -- Line: 1045
        -- upvalues: u281 (upval)
        -- types: a1: string, a2: string?, a3: number?, a4: boolean?, a5: string?
        if a4 then
            u281 = "item:none"
            return
        end

        if type(a5) == "string" then
            u281 = ("item:%*"):format(a5)
            return
        end

        if type(a1) == "string" then
            u281 = ("tool:%*"):format(a1)
        end
    end)

    local u29 = false
    LocalPlayer.Idled:Connect(function(a1)
        -- Line: 1060
        -- upvalues: u29 (ref), Config (upval), Remotes (upval)
        -- types: a1: number
        if a1 < 120 then
            u29 = false
        end

        if not u29 and Config.Player.IdleRejoinSeconds <= a1 then
            u29 = true
            Remotes.get(Remotes.RequestRejoin):FireServer()
        end
    end)

    LocalPlayer.CharacterAdded:Connect(function()
        -- Line: 1074
        -- upvalues: u281 (upval), HotbarController (upval), applySelection (upval)
        task.wait(0.3)

        u281 = nil
        HotbarController.render()
        applySelection(HotbarController.selected())
    end)

    UserInputService.InputBegan:Connect(function(a1, a2)
        -- Line: 1081
        -- upvalues: ContextActionService (upval), GuiService (upval), closeOpenPanels (upval), gamepadBegan (upval)
        -- upvalues: u168 (upval), aimedFlowerId (upval), HotbarController (upval), BuildController (upval)
        -- upvalues: Config (upval), u220 (upval), u249 (upval), UserInputService (upval), PortalMoveController (upval)
        -- upvalues: CraftingController (upval), backpackKey (upval), ShopController (upval), StorageController (upval)
        -- upvalues: BackpackController (upval), FriendsController (upval), SettingsPanelController (upval)
        -- upvalues: PremiumShopController (upval), PortalSkinController (upval), CollectionController (upval)
        -- upvalues: AchievementsController (upval), GuestBookController (upval), IslandResetController (upval)
        -- upvalues: KeyBinds (upval), startDrop (upval), Aim (upval), Ui (upval), PromptController (upval)
        local KeyCode, v1, v2
        local dispatch = 0

        while true do
            if dispatch < 39 then
                if dispatch < 23 then
                    if dispatch < 15 then
                        if dispatch < 7 then
                            if dispatch < 1 then
                                dispatch = if a1.KeyCode ~= Enum.KeyCode.ButtonB then 9 else 1
                            elseif dispatch < 6 then
                                local dispatchExit = nil

                                for n in ContextActionService:GetAllBoundActionInfo() do
                                    local dispatch2 = 2

                                    while true do
                                        if dispatch2 < 3 then
                                            dispatch2 = if n == "AboveFreecam" then 4 else 3
                                        else
                                            if not (dispatch2 < 4) then
                                                v1 = true
                                                dispatchExit = 7
                                                break
                                            end

                                            if string.sub(n, 1, 7) ~= "Freecam" then
                                                break
                                            else
                                                dispatch2 = 4
                                            end
                                        end
                                    end

                                    if dispatchExit then
                                        break
                                    end
                                end

                                dispatch = if dispatchExit == 7 then 7 else 6
                            else
                                v1 = false
                                dispatch = 7
                            end
                        elseif dispatch < 9 then
                            if not (dispatch < 8) then
                                GuiService.SelectedObject = nil
                                closeOpenPanels()

                                return
                            end

                            dispatch = if v1 then 9 else 8
                        elseif dispatch < 10 then
                            dispatch = if a2 then 17 else 10
                        else
                            local dispatchExit2 = nil

                            for m in ContextActionService:GetAllBoundActionInfo() do
                                local dispatch3 = 11

                                while true do
                                    if dispatch3 < 12 then
                                        dispatch3 = if m == "AboveFreecam" then 13 else 12
                                    else
                                        if not (dispatch3 < 13) then
                                            v1 = true
                                            dispatchExit2 = 16
                                            break
                                        end

                                        if string.sub(m, 1, 7) ~= "Freecam" then
                                            break
                                        else
                                            dispatch3 = 13
                                        end
                                    end
                                end

                                if dispatchExit2 then
                                    break
                                end
                            end

                            dispatch = if dispatchExit2 == 16 then 16 else 15
                        end
                    elseif dispatch < 19 then
                        if dispatch < 17 then
                            if dispatch < 16 then
                                v1 = false
                                dispatch = 16
                            else
                                dispatch = if not v1 then 18 else 17
                            end
                        elseif dispatch < 18 then
                            return
                        else
                            dispatch = if not gamepadBegan(a1.KeyCode) then 20 else 19
                        end
                    elseif not (dispatch < 21) then
                        if not (dispatch < 22) then
                            u168.setSprintInput(true)
                            return
                        end

                        dispatch = if a1.KeyCode ~= Enum.KeyCode.RightShift then 23 else 22
                    elseif dispatch < 20 then
                        return
                    else
                        dispatch = if a1.KeyCode == Enum.KeyCode.LeftShift then 22 else 21
                    end
                elseif dispatch < 31 then
                    if dispatch < 27 then
                        if dispatch < 25 then
                            if dispatch < 24 then
                                dispatch = if a1.UserInputType
                                    ~= Enum.UserInputType.MouseButton3 then
                                    29
                                else
                                    24
                            else
                                v1 = aimedFlowerId()
                                dispatch = if not v1 then 26 else 25
                            end
                        elseif dispatch < 26 then
                            HotbarController.pickBlock(v1)
                            return
                        else
                            v1 = BuildController.aimedBlockId()
                            dispatch = if not v1 then 28 else 27
                        end
                    elseif dispatch < 29 then
                        if not (dispatch < 28) then
                            return
                        end

                        HotbarController.pickBlock(Config.Build.breakDropOf(v1))

                        dispatch = 28
                    elseif dispatch < 30 then
                        KeyCode = a1.KeyCode
                        v2 = u220[KeyCode]
                        dispatch = if not v2 then 31 else 30
                    else
                        v1 = v2
                        dispatch = 36
                    end
                elseif dispatch < 35 then
                    if dispatch < 33 then
                        if dispatch < 32 then
                            v2 = u249[KeyCode]
                            dispatch = if not v2 then 35 else 32
                        else
                            dispatch = if UserInputService:IsKeyDown(Enum.KeyCode.LeftShift) then
                                34
                            else
                                33
                        end
                    elseif dispatch < 34 then
                        dispatch = if not UserInputService:IsKeyDown(Enum.KeyCode.RightShift) then
                            35
                        else
                            34
                    else
                        v1 = v2
                        dispatch = 36
                    end
                elseif dispatch < 37 then
                    if dispatch < 36 then
                        v1 = nil
                        dispatch = 36
                    else
                        dispatch = if not v1 then 38 else 37
                    end
                elseif dispatch < 38 then
                    HotbarController.toggle(v1)
                    return
                else
                    dispatch = if a1.KeyCode ~= Enum.KeyCode.R then 42 else 39
                end
            elseif dispatch < 54 then
                if dispatch < 46 then
                    if dispatch < 42 then
                        if not (dispatch < 40) then
                            if not (dispatch < 41) then
                                BuildController.rotate()
                                return
                            end

                            PortalMoveController.rotate()

                            return
                        end

                        dispatch = if not PortalMoveController.isActive() then 41 else 40
                    elseif dispatch < 44 then
                        if not (dispatch < 43) then
                            BuildController.tilt()
                            return
                        end

                        dispatch = if a1.KeyCode ~= Enum.KeyCode.Y then 44 else 43
                    else
                        if not (dispatch < 45) then
                            CraftingController.toggleHandCrafting()
                            return
                        end

                        dispatch = if a1.KeyCode ~= Enum.KeyCode.B then 46 else 45
                    end
                elseif dispatch < 50 then
                    if dispatch < 48 then
                        dispatch = if dispatch < 47 then
                            if a1.KeyCode == Enum.KeyCode.E then 48 else 47
                        else
                            if a1.KeyCode ~= Enum.KeyCode.Backquote then 49 else 48
                    elseif dispatch < 49 then
                        backpackKey()
                        return
                    else
                        dispatch = if a1.KeyCode ~= Enum.KeyCode.Escape then 52 else 50
                    end
                elseif dispatch < 52 then
                    if not (dispatch < 51) then
                        PortalMoveController.cancel()
                        return
                    end

                    dispatch = if not PortalMoveController.isActive() then 52 else 51
                else
                    if not (dispatch < 53) then
                        ShopController.close()
                        StorageController.close()
                        CraftingController.close()
                        BackpackController.close()
                        FriendsController.close()
                        SettingsPanelController.close()
                        PremiumShopController.close()
                        PortalSkinController.close()
                        CollectionController.close()
                        AchievementsController.close()
                        GuestBookController.close()
                        IslandResetController.close()

                        return
                    end

                    dispatch = if a1.KeyCode ~= Enum.KeyCode.Escape then 54 else 53
                end
            elseif dispatch < 62 then
                if not (dispatch < 58) then
                    dispatch = if dispatch < 60 then
                        if dispatch < 59 then
                            if a1.UserInputType == Enum.UserInputType.MouseButton1 then 61 else 59
                        else
                            if a1.UserInputType ~= Enum.UserInputType.Touch then 69 else 60
                    else
                        if dispatch < 61 then
                            if Aim.isTouch() then 69 else 61
                        else
                            if Ui.pointerOverGui() then 63 else 62
                elseif dispatch < 56 then
                    if not (dispatch < 55) then
                        u168.setPickupHeld(true, "key")
                        return
                    end

                    dispatch = if a1.KeyCode ~= KeyBinds.pickup() then 56 else 55
                else
                    if not (dispatch < 57) then
                        startDrop()
                        return
                    end

                    dispatch = if a1.KeyCode ~= Enum.KeyCode.Q then 58 else 57
                end
            elseif dispatch < 66 then
                if dispatch < 64 then
                    if not (dispatch < 63) then
                        return
                    end

                    dispatch = if not PromptController.pointerOverPrompt() then 64 else 63
                else
                    if not (dispatch < 65) then
                        PortalMoveController.confirm()
                        return
                    end

                    dispatch = if not PortalMoveController.isActive() then 66 else 65
                end
            elseif dispatch < 68 then
                if not (dispatch < 67) then
                    return
                end

                dispatch = if not closeOpenPanels() then 68 else 67
            else
                if not (dispatch < 69) then
                    return
                end

                u168.setActionHeld(true, "mouse")

                dispatch = 69
            end
        end
    end)

    UserInputService.InputEnded:Connect(function(a1)
        -- Line: 1237
        -- upvalues: gamepadEnded (upval), Aim (upval), u168 (upval), KeyBinds (upval), u323 (upval)
        -- upvalues: HotbarController (upval)
        gamepadEnded(a1.KeyCode)

        if a1.UserInputType == Enum.UserInputType.MouseButton1
            or a1.UserInputType == Enum.UserInputType.Touch and not Aim.isTouch() then
            u168.setActionHeld(false, "mouse")
        end

        if a1.KeyCode == KeyBinds.pickup() then
            u168.setPickupHeld(false, "key")
        end

        if a1.KeyCode == Enum.KeyCode.Q and u323 then
            u323 = nil
            HotbarController.setDropProgress(nil)
        end

        if a1.KeyCode == Enum.KeyCode.LeftShift
            or a1.KeyCode == Enum.KeyCode.RightShift then
            u168.setSprintInput(false)
        end
    end)

    RunService.Heartbeat:Connect(function()
        -- Line: 1262
        -- upvalues: stepToolDrop (upval), u276 (upval), HotbarController (upval), u56 (upval), u267 (upval)
        -- upvalues: holdInterval (upval), u279 (upval), act (upval)
        stepToolDrop()

        if u276 then
            local v1

            if HotbarController.selected().kind ~= "Tool" then
                local v2 = os.clock() - u267
                v1 = holdInterval() <= v2
            else
                v1 = u56.swingReady()
            end

            if v1 then
                u267 = os.clock()
                local v3 = HotbarController.selected()
                local index = v3.index
                local assignedItemId = v3.assignedItemId or v3.itemId or ""

                if ("%*:%*"):format(index, assignedItemId) == u279 then
                    act(true)
                end
            end
        end
    end)

    task.spawn(function()
        -- Line: 1272
        -- upvalues: Config (upval), u277 (upval), TargetController (upval), u213 (upval), u216 (upval)
        -- upvalues: AudioController (upval)
        local v1

        while true do
            task.wait(Config.Build.Pickup.RepeatSeconds)

            if u277 then
                v1 = TargetController.pickupEntityId()

                if not v1 then
                    v1 = TargetController.harvestTarget()

                    if v1 then
                        u216:FireServer(v1)
                        AudioController.play("Collect", v1.Position)
                    end
                else
                    u213:FireServer(v1)
                end
            end
        end
    end)
end

return u168