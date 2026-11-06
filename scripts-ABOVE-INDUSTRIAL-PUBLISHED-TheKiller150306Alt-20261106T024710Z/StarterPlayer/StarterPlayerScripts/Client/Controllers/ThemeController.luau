-- Script path: game:GetService("Players").TheKiller150306Alt.PlayerScripts.Client.Controllers.ThemeController
-- Decompile time: 7.00 ms

local Players = game:GetService("Players")
local SettingsController = require(script.Parent.SettingsController)
local v1 = {}
local u15 = Color3.fromRGB(38, 68, 158)
local u20 = Color3.fromRGB(245, 246, 252)

local function hueToChannel(a1, a2, a3) -- Line: 65; types: a1: number, a2: number, a3: number
    if a3 < 0 then
        a3 = a3 + 1
    elseif a3 > 1 then
        a3 = a3 - 1
    end

    if a3 < 0.16666666666666666 then
        return a1 + (a2 - a1) * 6 * a3
    end

    if a3 < 0.5 then
        return a2
    end

    if a3 < 0.6666666666666666 then
        return a1 + (a2 - a1) * (0.6666666666666666 - a3) * 6
    end

    return a1
end

local function fromHsl(a1, a2, a3) -- Line: 81; types: a1: number, a2: number, a3: number
    if a2 <= 0 then
        return Color3.new(a3, a3, a3)
    end

    local v1 = if not (a3 < 0.5) then a3 + a2 - a3 * a2 else a3 * (a2 + 1)
    local v2 = a3 * 2 - v1
    local new = Color3.new
    local v3 = a1 + 0.3333333333333333

    if v3 < 0 then
        v3 = v3 + 1
    elseif v3 > 1 then
        v3 = v3 - 1
    end

    local v4 = if not (v3 < 0.16666666666666666) then
        if not (v3 < 0.5) then
            if not (v3 < 0.6666666666666666) then
                v2
            else
                v2 + (v1 - v2) * (0.6666666666666666 - v3) * 6
        else
            v1
    else
        v2 + (v1 - v2) * 6 * v3
    local v5 = a1

    if v5 < 0 then
        v5 = v5 + 1
    elseif v5 > 1 then
        v5 = v5 - 1
    end

    v3 = if not (v5 < 0.16666666666666666) then
        if not (v5 < 0.5) then
            if not (v5 < 0.6666666666666666) then
                v2
            else
                v2 + (v1 - v2) * (0.6666666666666666 - v5) * 6
        else
            v1
    else
        v2 + (v1 - v2) * 6 * v5
    local v6 = a1 - 0.3333333333333333

    if v6 < 0 then
        v6 = v6 + 1
    elseif v6 > 1 then
        v6 = v6 - 1
    end

    return new(v4, v3, if not (v6 < 0.16666666666666666) then if not (v6 < 0.5) then if not (v6 < 0.6666666666666666) then v2 else v2 + (v1 - v2) * (0.6666666666666666 - v6) * 6 else v1 else v2 + (v1 - v2) * 6 * v6)
end

local function toLight(a1, a2) -- Line: 90; upvalues: fromHsl (val); types: a1: userdata, a2: boolean?
    local v1
    local v2 = math.max(a1.R, a1.G, a1.B)
    local v3 = math.min(a1.R, a1.G, a1.B)
    local v4 = (v2 + v3) / 2
    local v5 = 0

    if v2 ~= v3 then
        v1 = v2 - v3
        v5 = if not (v4 > 0.5) then v1 / (v2 + v3) else v1 / (2 - v2 - v3)
    end

    v1 = a1:ToHSV()
    local v6 = (1 - v4) * 0.75 + 0.15
    v4 = false

    if v1 >= 0.5 then
        v4 = v1 <= 0.7222222222222222
    end

    local v7 = false

    if v1 >= 0.09722222222222222 then
        v7 = v1 <= 0.16666666666666666
    end

    if not (v2 - v3 < 0.12) then
        if not a2 then
            if v7 or v4 then
                v5 = 0
                v6 = math.min(v6, 0.3)
            end
        end
    elseif not a2 then
        v5 = 0
    else
        v1 = 0.1
        v5 = 0.3
    end

    return fromHsl(v1, v5, v6)
end

local function isAccentSurface(a1, a2) -- Line: 125; types: a1: userdata, a2: userdata
    local v1

    if (math.max(a2.R, a2.G, a2.B))
        - math.min(a2.R, a2.G, a2.B)
        < 0.12 then
        return false
    end

    local v2 = a2:ToHSV()

    if v2 >= 0.5 and v2 <= 0.7222222222222222 then
        return true
    end

    if a1:IsA("GuiButton") then
        v1 = false

        if v2 >= 0.09722222222222222 then
            v1 = v2 <= 0.16666666666666666
        end
    else
        v1 = false

        if a1:GetAttribute("ThemeAccent") == true then
            v1 = false

            if v2 >= 0.09722222222222222 then
                v1 = v2 <= 0.16666666666666666
            end
        end
    end

    return v1
end

local function lightRichText(a1) -- Line: 144; upvalues: toLight (val); types: a1: string
    return (string.gsub(
        a1,
        "(color%s*=%s*\")#(%x%x%x%x%x%x)(\")",
        function(a1, a2, a3) -- Line: 146; upvalues: toLight (upval)
            return a1 .. "#" .. (toLight(Color3.fromHex(a2)):ToHex()) .. a3
        end
    ))
end

local u26 = {
    AboveHud = true,
    AboveAlert = true,
    AboveVignette = true,
    AboveDrag = true,
    AboveNotices = true,
    AboveToasts = true,
    Objective = true,
    Floaters = true,
    GatherFx = true,
    TouchControls = true,
    ServerEvent = true,
    SpecialDrop = true,
    PlacementHint = true,
    Tutorial = true,
    Travel = true,
    AdminJumpscare = true,
    LoadingScreen = true,
    PromptUi = true,
}

local function layerOf(a1, a2) -- Line: 182; types: a1: userdata, a2: userdata
    local Parent = a1

    while Parent do
        if Parent.Parent == a2 then
            break
        end

        Parent = Parent.Parent
    end

    return Parent
end

local u28 = {MenuBar = true, AboveTopStrip = true}
local u33 = Color3.fromRGB(90, 90, 90)

local function propertiesOf(a1, a2) -- Line: 200; upvalues: u28 (val); types: a1: userdata, a2: string
    if not a1:IsA("ImageLabel") and not a1:IsA("ImageButton") then
        if a1:IsA("UIStroke") then
            return {"Color"}
        end

        if a1:IsA("TextBox") then
            return {
                "BackgroundColor3",
                "BackgroundTransparency",
                "TextColor3",
                "TextStrokeColor3",
                "PlaceholderColor3",
            }
        end

        if not a1:IsA("TextLabel") and not a1:IsA("TextButton") then
            if a1:IsA("GuiObject") and not a1:IsA("ViewportFrame") then
                return {"BackgroundColor3", "BackgroundTransparency"}
            end

            return {}
        end

        return {"BackgroundColor3", "BackgroundTransparency", "TextColor3", "TextStrokeColor3", "Text"}
    end

    if not u28[a2] and a1:GetAttribute("ThemeTint") ~= true then
        if a1:IsA("UIStroke") then
            return {"Color"}
        end

        if a1:IsA("TextBox") then
            return {
                "BackgroundColor3",
                "BackgroundTransparency",
                "TextColor3",
                "TextStrokeColor3",
                "PlaceholderColor3",
            }
        end

        if not a1:IsA("TextLabel") and not a1:IsA("TextButton") then
            if a1:IsA("GuiObject") and not a1:IsA("ViewportFrame") then
                return {"BackgroundColor3", "BackgroundTransparency"}
            end

            return {}
        end

        return {"BackgroundColor3", "BackgroundTransparency", "TextColor3", "TextStrokeColor3", "Text"}
    end

    return {"BackgroundColor3", "BackgroundTransparency", "ImageColor3"}
end

local u35 = {}

local function onAccent(a1, a2)
    -- Line: 225
    -- upvalues: isAccentSurface (val), u35 (val)
    -- types: a1: userdata, a2: table
    if a2.BackgroundColor3 and (a2.BackgroundTransparency or 0) < 1 then
        return (isAccentSurface(a1, a2.BackgroundColor3))
    end

    local Parent = a1.Parent
    local v1 = if not Parent then nil else u35[Parent]
    local v2 = false

    if Parent ~= nil then
        v2 = false

        if v1 ~= nil then
            v2 = false

            if v1.source.BackgroundColor3 ~= nil then
                v2 = false

                if (v1.source.BackgroundTransparency or 0) < 1 then
                    v2 = isAccentSurface(Parent, v1.source.BackgroundColor3)
                end
            end
        end
    end

    return v2
end

local function mapped(a1, a2, a3, a4)
    -- Line: 238
    -- upvalues: isAccentSurface (val), u15 (val), onAccent (val), u20 (val), u33 (val), toLight (val)
    -- types: a1: userdata, a2: table, a3: string
    if a3 == "BackgroundColor3" and isAccentSurface(a1, a4) then
        return u15
    end

    if a3 == "TextColor3" and onAccent(a1, a2) then
        return u20
    end

    if a3 == "ImageColor3" then
        return Color3.new(a4.R * u33.R, a4.G * u33.G, a4.B * u33.B)
    end

    if a3 == "BackgroundTransparency" then
        if a4 < 0.6 then
            return 0
        end

        return a4
    end

    if a3 == "Text" then
        if a1.RichText then
            return (string.gsub(
                a4,
                "(color%s*=%s*\")#(%x%x%x%x%x%x)(\")",
                function(a1, a2, a3) -- Line: 146; upvalues: toLight (upval)
                    return a1 .. "#" .. (toLight(Color3.fromHex(a2)):ToHex()) .. a3
                end
            ))
        end

        return a4
    end

    local v1 = toLight
    local v2 = true

    if a3 ~= "BackgroundColor3" then
        v2 = a3 == "Color"
    end

    return v1(a4, v2)
end

local u38 = nil

local function paint(a1, a2, a3)
    -- Line: 262
    -- upvalues: mapped (val), onAccent (val), u20 (val), toLight (val)
    -- types: a1: userdata, a2: table, a3: string
    local v1 = a1[a3]

    if a2.applied[a3] ~= nil and a2.applied[a3] == v1 then
        return
    end

    a2.source[a3] = v1
    local v2 = mapped(a1, a2.source, a3, v1)
    a2.applied[a3] = v2

    if v2 ~= v1 then
        a1[a3] = v2
    end

    if a3 == "BackgroundColor3" and a2.source.TextColor3 ~= nil then
        local source = a2.source
        local TextColor3 = a2.source.TextColor3
        v2 = if not onAccent(a1, source) then toLight(TextColor3, false) else u20
        a2.applied.TextColor3 = v2

        if a1.TextColor3 ~= v2 then
            a1.TextColor3 = v2
        end
    end
end

local function watch(a1, a2)
    -- Line: 286
    -- upvalues: u35 (val), u26 (val), propertiesOf (val), paint (val)
    -- types: a1: userdata, a2: userdata
    if not u35[a1] and not a1:FindFirstAncestorWhichIsA("ViewportFrame") then
        local Parent = a1

        while Parent do
            if Parent.Parent == a2 then
                break
            end

            Parent = Parent.Parent
        end

        if Parent and not u26[Parent.Name] then
            local v1 = propertiesOf(a1, Parent.Name)

            if #v1 == 0 then
                return
            end

            local u24 = {source = {}, applied = {}, connections = {}}
            u35[a1] = u24

            for i, j in v1 do
                paint(a1, u24, j)

                table.insert(
                    u24.connections,
                    ((a1:GetPropertyChangedSignal(j)):Connect(function()
                        -- Line: 304
                        -- upvalues: paint (upval), a1 (val), u24 (val), j (val)
                        paint(a1, u24, j)
                    end))
                )
            end

            table.insert(
                u24.connections,
                (a1.Destroying:Connect(function() -- Line: 311; upvalues: u35 (upval), a1 (val)
                    local v1 = u35[a1]

                    if v1 then
                        for i, j in v1.connections do
                            j:Disconnect()
                        end

                        u35[a1] = nil
                    end
                end))
            )
        end
    end
end

local function applyLight(a1) -- Line: 323; upvalues: u38 (ref), watch (val); types: a1: userdata
    if u38 then
        return
    end

    for i, j in a1:GetDescendants() do
        watch(j, a1)
    end

    u38 = a1.DescendantAdded:Connect(function(a1_2) -- Line: 330; upvalues: watch (upval), a1 (val)
        watch(a1_2, a1)
    end)
end

local function applyDark() -- Line: 336; upvalues: u38 (ref), u35 (val)
    if u38 then
        u38:Disconnect()

        u38 = nil
    end

    local v1 = nil
    local v2 = nil

    for i, j in u35, v1, v2 do
        for k, n in j.connections do
            n:Disconnect()
        end

        for m, i5 in j.source do
            pcall(function() -- Line: 346; upvalues: i (val), m (val), i5 (val)
                i[m] = i5
            end)
        end
    end

    table.clear(u35)
end

function v1.start() -- Line: 354; upvalues: Players (val), SettingsController (val), applyLight (val), applyDark (val)
    local PlayerGui = Players.LocalPlayer:WaitForChild("PlayerGui")

    local function apply()
        -- Line: 356
        -- upvalues: SettingsController (upval), applyLight (upval), PlayerGui (val), applyDark (upval)
        if SettingsController.is("UiTheme", "Light") then
            applyLight(PlayerGui)
            return
        end

        applyDark()
    end

    SettingsController.onChanged(function(a1)
        -- Line: 363
        -- upvalues: SettingsController (upval), applyLight (upval), PlayerGui (val), applyDark (upval)
        if a1 == "UiTheme" then
            if SettingsController.is("UiTheme", "Light") then
                applyLight(PlayerGui)
                return
            end

            applyDark()
        end
    end)

    if SettingsController.is("UiTheme", "Light") then
        applyLight(PlayerGui)
        return
    end

    applyDark()
end

return v1