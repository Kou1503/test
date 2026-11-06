-- Script path: game:GetService("ReplicatedStorage").Shared.Config.SettingsConfig
-- Decompile time: 3.12 ms

local u0 = {}

local function steps(a1) -- Line: 47; types: a1: table
    local v1 = {}
    local min = a1.min
    local max = a1.max
    local step = a1.step

    for i = min, max, step do
        table.insert(v1, (tostring(i)))
    end

    return v1
end

local v1 = {min = 100, max = 150, step = 5, suffix = "%"}
local u3 = {min = 85, max = 120, step = 5, suffix = "%"}
local v2 = {min = 100, max = 200, step = 5, suffix = "%"}
local v3 = {min = 0, max = 100, step = 5, suffix = "%"}
u0.Categories = {"Graphics", "Gameplay", "Controls", "Island & Social", "Sound"}
u0.KeyChoices = {"F", "G", "H", "T", "V", "X", "Z"}
u0.FixedKeys = {
    {key = "E", action = "Backpack"},
    {key = "Q", action = "Drop (hold for a tool)"},
    {key = "R", action = "Rotate"},
    {key = "1 - 9", action = "Hotbar"},
    {key = "Shift", action = "Sprint"},
    {key = "Space", action = "Jump"},
    {key = "C", action = "Teleport"},
    {key = "L", action = "People"},
    {key = "M", action = "Shop"},
    {key = "F1", action = "Hide the interface"},
}
u0.PadButtons = {
    {key = "ButtonR2", action = "Use / swing / place"},
    {key = "ButtonY", action = "Pick up (hold to clear a pile)"},
    {key = "ButtonX", action = "Use a machine"},
    {key = "ButtonA", action = "Jump"},
    {key = "ButtonL1", action = "Previous hotbar slot"},
    {key = "ButtonR1", action = "Next hotbar slot"},
    {key = "DPadUp", action = "Backpack"},
    {key = "DPadDown", action = "Drop (hold for a tool)"},
    {key = "DPadLeft", action = "Rotate"},
    {key = "ButtonR3", action = "Rotate", vrOnly = true},
    {key = "ButtonL2", action = "Flip upside down, or lay a log on its side"},
    {key = "ButtonL3", action = "Sprint"},
    {key = "ButtonB", action = "Close a panel"},
    {key = "ButtonSelect", action = "Menu (the bar, or the cursor in a panel)"},
}
u0.Settings = {
    {
        id = "SprintMode",
        category = "Gameplay",
        label = "Sprint",
        default = "Hold",
        readBy = "client/Controllers/InputController.luau",
        options = {"Hold", "Toggle", "Auto"},
    },
    {
        id = "PickupKey",
        category = "Controls",
        label = "Pick Up",
        default = "F",
        readBy = "client/Controllers/KeyBinds.luau",
        desktopOnly = true,
        options = u0.KeyChoices,
    },
    {
        id = "UseKey",
        category = "Controls",
        label = "Use (machines, doors)",
        default = "G",
        readBy = "client/Controllers/KeyBinds.luau",
        desktopOnly = true,
        options = u0.KeyChoices,
    },
    {
        id = "ControlMode",
        category = "Controls",
        label = "Controls",
        default = "Auto",
        readBy = "client/Controllers/DeviceMode.luau",
        hybridOnly = true,
        options = {"Auto", "Touch", "Keyboard & Mouse"},
    },
    {
        id = "TouchCrosshair",
        category = "Controls",
        label = "Crosshair",
        default = "On",
        readBy = "client/Controllers/GamepadController.luau",
        touchOnly = true,
        options = {"On", "Off"},
    },
    {
        id = "ControllerVibration",
        category = "Controls",
        label = "Controller Vibration",
        default = "On",
        readBy = "client/Controllers/RumbleController.luau",
        desktopOnly = true,
        options = {"On", "Off"},
    },
    {
        id = "CameraShake",
        category = "Gameplay",
        label = "Impact Shake",
        default = "On",
        readBy = "client/Controllers/HitFeedbackController.luau",
        options = {"On", "Reduced", "Off"},
    },
    {
        id = "GuiScale",
        category = "Graphics",
        label = "UI Scale",
        default = "125",
        readBy = "client/Controllers/GuiScaleController.luau",
        desktopOnly = true,
        options = steps(v1),
        slider = v1,
    },
    {
        id = "PhoneGuiScale",
        category = "Graphics",
        label = "UI Scale",
        default = "100",
        readBy = "client/Controllers/GuiScaleController.luau",
        touchOnly = true,
        options = steps(u3),
        slider = u3,
    },
    {
        id = "ConsoleGuiScale",
        category = "Graphics",
        label = "UI Scale",
        default = "150",
        readBy = "client/Controllers/GuiScaleController.luau",
        consoleOnly = true,
        options = steps(v2),
        slider = v2,
    },
    {
        id = "MachineAnimations",
        category = "Graphics",
        label = "Machine Animations",
        default = "On",
        readBy = "client/Controllers/SpinningArtController.luau",
        options = {"On", "Off"},
    },
    {
        id = "PlowHints",
        category = "Island & Social",
        label = "Plow Water Hints",
        default = "On",
        readBy = "client/Controllers/WaterZoneController.luau",
        options = {"On", "Off"},
    },
    {
        id = "WorldLabels",
        category = "Graphics",
        label = "Labels Over Machines",
        default = "On",
        readBy = "client/Controllers/WorldLabelsController.luau",
        options = {"On", "Off"},
    },
    {
        id = "RareDropEffects",
        category = "Graphics",
        label = "Rare Drop Effects",
        default = "Full",
        readBy = "client/Controllers/SpecialDropController.luau",
        options = {"Full", "Reduced"},
    },
    {
        id = "IslandAccess",
        category = "Island & Social",
        label = "Island Access",
        default = "Open",
        readBy = "server/Services/PermissionService.luau",
        shownIn = "Permissions",
        options = {"Open", "FriendsOnly", "Closed"},
    },
    {
        id = "FriendLuckHud",
        category = "Island & Social",
        label = "Friend Luck Display",
        default = "On",
        readBy = "client/Controllers/HudController.luau",
        options = {"On", "Off"},
    },
    {
        id = "FriendJoinNotifications",
        category = "Island & Social",
        label = "Friend Join Alerts",
        default = "On",
        readBy = "client/Controllers/HudController.luau",
        options = {"On", "Off"},
    },
    {
        id = "ShowServerRegion",
        category = "Island & Social",
        label = "Show Server Region",
        default = "On",
        readBy = "client/Controllers/VersionController.luau",
        options = {"On", "Off"},
    },
    {
        id = "DamageNumbers",
        category = "Gameplay",
        label = "Damage Numbers",
        default = "On",
        readBy = "client/Controllers/FloaterController.luau",
        options = {"On", "Off"},
    },
    {
        id = "BlockCountHud",
        category = "Island & Social",
        label = "Block Count Display",
        default = "Off",
        readBy = "client/Controllers/HudController.luau",
        options = {"On", "Off"},
    },
    {
        id = "LooseItemsHud",
        category = "Island & Social",
        label = "Auto Item Limit",
        default = "Off",
        readBy = "client/Controllers/HudController.luau",
        options = {"On", "Off"},
    },
    {
        id = "DroppedItemsHud",
        category = "Island & Social",
        label = "Dropped Item Limit",
        default = "Off",
        readBy = "client/Controllers/HudController.luau",
        options = {"On", "Off"},
    },
    {
        id = "UiTheme",
        category = "Graphics",
        label = "Interface Theme",
        default = "Dark",
        readBy = "client/Controllers/ThemeController.luau",
        options = {"Dark", "Light"},
    },
    {
        id = "Shadows",
        category = "Graphics",
        label = "Shadows On/Off",
        default = "On",
        readBy = "client/Controllers/TimeController.luau",
        options = {"On", "Off"},
    },
    {
        id = "SfxVolume",
        category = "Sound",
        label = "Sound Effects",
        default = "100",
        readBy = "client/Controllers/AudioController.luau",
        options = steps(v3),
        slider = v3,
    },
    {
        id = "MusicVolume",
        category = "Sound",
        label = "Music",
        default = "50",
        readBy = "client/Controllers/AudioController.luau",
        options = steps(v3),
        slider = v3,
    },
    {
        id = "BoundaryGuide",
        category = "Island & Social",
        label = "Boundary Guide",
        default = "Off",
        readBy = "client/Controllers/BoundaryController.luau",
        options = {"On", "Off"},
    },
}
u0.VolumeLevels = {
    Full = 1,
    Loud = 0.75,
    Half = 0.5,
    Quiet = 0.25,
    Off = 0,
}

function u0.volumeOf(a1) -- Line: 485; upvalues: u0 (val); types: a1: string
    local v1 = tonumber(a1)

    if v1 then
        return (math.clamp(v1 / 100, 0, 1))
    end

    return u0.VolumeLevels[a1] or 1
end

local u157 = {}

for i, j in u0.Settings do
    u157[j.id] = j
end

function u0.get(a1) -- Line: 498; upvalues: u157 (val); types: a1: string
    return u157[a1]
end

function u0.isValid(a1, a2) -- Line: 508; upvalues: u157 (val); types: a1: string, a2: string
    local v1 = u157[a1]
    local v2 = false

    if v1 ~= nil then
        v2 = table.find(v1.options, a2) ~= nil
    end

    return v2
end

function u0.defaults() -- Line: 514; upvalues: u0 (val)
    local v1 = {}

    for i, j in u0.Settings do
        v1[j.id] = j.default
    end

    return v1
end

u0.ConsoleSafeMargin = 0.03
u0.ConsoleSafeExempt = {
    LoadingScreen = true,
    AboveCrosshair = true,
    Travel = true,
    AboveShowroomBackdrop = true,
    ConfirmDialog = true,
    AboveDevConsole = true,
    TapDebug = true,
    TapDebugInset = true,
}
u0.GuiScaleExempt = {
    Floaters = true,
    GatherFx = true,
    Objective = true,
    AboveDrag = true,
    AboveVignette = true,
    AdminJumpscare = true,
    TouchControls = true,
    AboveShowroomBackdrop = true,
    AboveCrosshair = true,
}
u0.GuiScales = {Normal = 1, Large = 1.15, ["Extra Large"] = 1.3}

local function scaleOf(a1, a2) -- Line: 571; types: a1: string?, a2: table
    local v1 = tonumber(a1)

    if v1 and v1 == v1 and v1 > 0 then
        return v1 / 100
    end

    return a2[a1 or ""] or 1
end

function u0.guiScaleOf(a1) -- Line: 580; upvalues: u0 (val); types: a1: string?
    local GuiScales = u0.GuiScales
    local v1 = tonumber(a1)

    if v1 and v1 == v1 and v1 > 0 then
        return v1 / 100
    end

    return GuiScales[a1 or ""] or 1
end

u0.LegacyDefaults = {UseKey = "F"}
u0.ChangedOnlyMarker = "_changedOnly"

function u0.migrate(a1, a2) -- Line: 601; upvalues: u0 (val), u3 (val); types: a1: string, a2: string
    if a1 == "GuiScale" and u0.GuiScales[a2] then
        return (tostring((math.round(u0.GuiScales[a2] * 100))))
    end

    if a1 ~= "SfxVolume" and a1 ~= "MusicVolume" then
        if a1 == "PhoneGuiScale" and u0.PhoneGuiScales[a2] then
            return (tostring((math.round(u0.PhoneGuiScales[a2] * 100 / u3.step)) * u3.step))
        end

        return a2
    end

    if u0.VolumeLevels[a2] then
        return (tostring((math.round(u0.VolumeLevels[a2] * 100))))
    end

    if a1 == "PhoneGuiScale" and u0.PhoneGuiScales[a2] then
        return (tostring((math.round(u0.PhoneGuiScales[a2] * 100 / u3.step)) * u3.step))
    end

    return a2
end

u0.PhoneGuiScales = {Small = 0.85, Medium = 1, Large = 1.12}

function u0.phoneGuiScaleOf(a1) -- Line: 626; upvalues: u0 (val); types: a1: string?
    local PhoneGuiScales = u0.PhoneGuiScales
    local v1 = tonumber(a1)

    if v1 and v1 == v1 and v1 > 0 then
        return v1 / 100
    end

    return PhoneGuiScales[a1 or ""] or 1
end

return u0