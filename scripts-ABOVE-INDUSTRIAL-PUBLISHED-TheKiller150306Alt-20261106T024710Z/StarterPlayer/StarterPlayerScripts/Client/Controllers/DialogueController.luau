-- Script path: game:GetService("Players").TheKiller150306Alt.PlayerScripts.Client.Controllers.DialogueController
-- Decompile time: 4.91 ms

local render
local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local Shared = (game:GetService("ReplicatedStorage")):WaitForChild("Shared")
local Remotes = require(Shared.Remotes)
local Format = require(Shared.Format)
local u31 = require(script.Parent.Parent.Ui)
local BuildController = require(script.Parent.BuildController)
local CollectionController = require(script.Parent.CollectionController)
local u42 = {}
local LocalPlayer = Players.LocalPlayer
local u47 = Remotes.get(Remotes.NpcDialogue)
local u50 = Remotes.get(Remotes.RequestShopOpen)
local u53 = Remotes.get(Remotes.RequestCollectionTurnIn)
local u56 = Remotes.get(Remotes.RequestExpansion)
local u57 = nil
local u58 = nil
local u59 = nil
local u60 = nil
local u61 = nil
local u62 = nil
local u63 = false

local function clearOptions() -- Line: 81; upvalues: u61 (ref)
    for i, j in u61:GetChildren() do
        if not j:IsA("UIListLayout") then
            j:Destroy()
        end
    end
end

function u42.isOpen() -- Line: 89; upvalues: u58 (ref)
    local Visible = false

    if u58 ~= nil then
        Visible = u58.Visible
    end

    return Visible
end

function u42.close() -- Line: 93; upvalues: u58 (ref), Remotes (val), u62 (ref), u63 (ref), BuildController (val)
    if not u58 then
        return
    end

    if u58.Visible then
        Remotes.get(Remotes.DialogueDismissed):FireServer()
    end

    u58.Visible = false
    u62 = nil
    u63 = false

    BuildController.setUiOpen("Dialogue", false)
end

local u67 = nil

local function resize() -- Line: 128; upvalues: u61 (ref), u58 (ref)
    local v1 = #u61:GetChildren() - 1
    u61.Size = UDim2.new(1, -24, 0, v1 * 34 + math.max(0, v1 - 1) * 6)
    u58.Size = UDim2.fromOffset(460, 92 + u61.AbsoluteSize.Y + 16)
end

function render()
    -- Line: 134
    -- upvalues: u62 (ref), clearOptions (val), u59 (ref), u60 (ref), u67 (ref), u42 (val), u50 (val), u63 (ref)
    -- upvalues: Format (val), u56 (val), render (val), resize (val), u53 (val), u58 (ref), CollectionController (val)
    -- upvalues: u31 (val)
    local v1 = u62

    if not v1 then
        return
    end

    clearOptions()

    u59.Text = v1.title
    u60.Text = v1.greeting

    if v1.canBuy then
        u67(
            "I want to buy.",
            function() -- Line: 145; upvalues: u42 (upval), u50 (upval)
                u42.close()
                u50:FireServer("Buy")
            end
        )
    end

    if v1.canSell then
        u67(
            "I want to sell.",
            function() -- Line: 151; upvalues: u42 (upval), u50 (upval)
                u42.close()
                u50:FireServer("Sell")
            end
        )
    end

    local expansion = v1.expansion

    if expansion and u63 then
        local v2 = Format.comma(expansion.price)
        u60.Text = (("Your current island build limit is %* blocks. Next upgrade is"):format((Format.comma(expansion.capacity))))
            .. (" %* blocks for <font color=\"rgb(255,226,130)\">%* Coins</font>."):format(Format.comma(expansion.nextCapacity), v2)

        if not expansion.affordable then
            local v3 = Format.comma((math.max(0, expansion.price - expansion.balance)))
            u67(
                ("Not enough Coins. %* more and it's yours."):format(v3),
                function() -- Line: 182
                end,
                true
            )
        else
            u67(
                ("Buy it for %* Coins."):format(v2),
                function() -- Line: 173; upvalues: u63 (upval), u56 (upval)
                    u63 = false
                    u56:FireServer()
                end
            )
        end

        u67(
            "How does expansion work?",
            function()
                -- Line: 184
                -- upvalues: u60 (upval), clearOptions (upval), u67 (upval), render (upval), resize (upval)
                u60.Text = "It expands your build boundary and the max blocks you can place on your island."
                clearOptions()

                u67(
                    "Back.",
                    function() -- Line: 190; upvalues: render (upval)
                        render()
                    end
                )

                resize()
            end
        )

        u67(
            "Not today.",
            function() -- Line: 195; upvalues: u63 (upval), render (upval)
                u63 = false
                render()
            end
        )

        resize()

        return
    end

    if expansion then
        u67(
            ("Expand my island (%* Coins)."):format((Format.comma(expansion.price))),
            function() -- Line: 203; upvalues: u63 (upval), render (upval)
                u63 = true
                render()
            end
        )
    elseif v1.canExpand then
        u60.Text = "You're already at the current max upgrade for your island. Check back later in case I decide to give you more land."
    end

    if v1.canCollect then
        u67(
            "Here are my Shinies.",
            function() -- Line: 217; upvalues: u42 (upval), u53 (upval)
                u42.close()
                u53:FireServer()
            end
        )

        u67(
            "View my Shiny progress.",
            function()
                -- Line: 229
                -- upvalues: u58 (upval), CollectionController (upval), u62 (upval), u31 (upval), render (upval)
                u58.Visible = false
                CollectionController.open(function()
                    -- Line: 231
                    -- upvalues: u62 (upval), u58 (upval), u31 (upval), render (upval)
                    if u62 and not u58.Visible then
                        u58.Visible = true
                        u31.appear(u58)
                        render()
                    end
                end)
            end
        )
    end

    u67(
        "Never mind.",
        function() -- Line: 240; upvalues: u42 (upval)
            u42.close()
        end
    )

    resize()
end

function u67(a1, a2, a3) -- Line: 254; upvalues: u31 (val), u61 (ref); types: a1: string, a2: function, a3: boolean?
    local TextButton = Instance.new("TextButton")
    TextButton.Size = UDim2.new(1, 0, 0, 34)
    local v1 = if not a3 then Color3.fromRGB(28, 31, 39) else Color3.fromRGB(22, 24, 30)
    TextButton.BackgroundColor3 = v1
    TextButton.BorderSizePixel = 0
    TextButton.Text = ("  %*"):format(a1)
    v1 = if not a3 then Color3.fromRGB(210, 215, 228) else Color3.fromRGB(118, 124, 140)
    TextButton.TextColor3 = v1
    TextButton.TextXAlignment = Enum.TextXAlignment.Left
    TextButton.FontFace = u31.Font.Regular
    TextButton.TextSize = 14
    TextButton.AutoButtonColor = false
    TextButton.Parent = u61
    local UICorner = Instance.new("UICorner")
    UICorner.CornerRadius = UDim.new(0, 6)
    UICorner.Parent = TextButton
    local UIStroke = Instance.new("UIStroke")
    UIStroke.Thickness = 1
    UIStroke.Color = Color3.fromRGB(46, 52, 66)
    UIStroke.Parent = TextButton

    if a3 then
        UIStroke.Color = Color3.fromRGB(34, 38, 48)
        return
    end

    TextButton.MouseEnter:Connect(function() -- Line: 283; upvalues: TextButton (val)
        TextButton.BackgroundColor3 = Color3.fromRGB(46, 54, 70)
        TextButton.TextColor3 = Color3.fromRGB(255, 226, 130)
    end)

    TextButton.MouseLeave:Connect(function() -- Line: 287; upvalues: TextButton (val)
        TextButton.BackgroundColor3 = Color3.fromRGB(28, 31, 39)
        TextButton.TextColor3 = Color3.fromRGB(210, 215, 228)
    end)

    TextButton.Activated:Connect(a2)
end

function u42.start()
    -- Line: 294
    -- upvalues: u57 (ref), LocalPlayer (val), u58 (ref), u31 (val), u59 (ref), u60 (ref), u61 (ref), u47 (val)
    -- upvalues: u42 (val), u63 (ref), u62 (ref), BuildController (val), render (val), UserInputService (val)
    u57 = Instance.new("ScreenGui")
    u57.Name = "AboveDialogue"
    u57.ResetOnSpawn = false
    u57.IgnoreGuiInset = true
    u57.Parent = LocalPlayer:WaitForChild("PlayerGui")
    u58 = Instance.new("CanvasGroup")
    u58.Size = UDim2.fromOffset(460, 200)
    u58.Position = UDim2.new(0.5, -230, 1, -260)

    u31.fitToScreen(u58)

    u58.BackgroundColor3 = Color3.fromRGB(18, 20, 26)
    u58.BackgroundTransparency = 0.06
    u58.BorderSizePixel = 0
    u58.Visible = false
    u58.Active = true
    u58.Parent = u57
    local UICorner = Instance.new("UICorner")
    UICorner.CornerRadius = UDim.new(0, 10)
    UICorner.Parent = u58
    local UIStroke = Instance.new("UIStroke")
    UIStroke.Thickness = 2
    UIStroke.Color = Color3.fromRGB(46, 52, 66)
    UIStroke.Parent = u58
    u59 = Instance.new("TextLabel")
    u59.Size = UDim2.new(1, -24, 0, 22)
    u59.Position = UDim2.fromOffset(12, 10)
    u59.BackgroundTransparency = 1
    u59.Text = ""
    u59.TextColor3 = Color3.fromRGB(255, 226, 130)
    u59.FontFace = u31.Font.Bold
    u59.TextSize = 16
    u59.TextXAlignment = Enum.TextXAlignment.Left
    u59.Parent = u58
    u60 = Instance.new("TextLabel")
    u60.Size = UDim2.new(1, -24, 0, 48)
    u60.Position = UDim2.fromOffset(12, 34)
    u60.BackgroundTransparency = 1
    u60.Text = ""
    u60.TextColor3 = Color3.fromRGB(196, 204, 220)
    u60.FontFace = u31.Font.Regular
    u60.TextSize = 14
    u60.TextXAlignment = Enum.TextXAlignment.Left
    u60.TextYAlignment = Enum.TextYAlignment.Top
    u60.TextWrapped = true
    u60.RichText = true
    u60.Parent = u58
    u61 = Instance.new("Frame")
    u61.Size = UDim2.new(1, -24, 0, 0)
    u61.Position = UDim2.fromOffset(12, 92)
    u61.BackgroundTransparency = 1
    u61.Parent = u58
    local UIListLayout = Instance.new("UIListLayout")
    UIListLayout.Padding = UDim.new(0, 6)
    UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
    UIListLayout.Parent = u61

    u47.OnClientEvent:Connect(function(a1)
        -- Line: 364
        -- upvalues: u42 (upval), u63 (upval), u62 (upval), u58 (upval), u31 (upval), BuildController (upval)
        -- upvalues: render (upval)
        if type(a1) ~= "table" then
            return
        end

        if a1.close then
            u42.close()
            return
        end

        u63 = false
        u62 = a1
        u58.Visible = true

        u31.appear(u58)
        BuildController.setUiOpen("Dialogue", true)
        render()
    end)

    UserInputService.InputBegan:Connect(function(a1, a2) -- Line: 387; upvalues: u42 (upval)
        if not a2 and u42.isOpen() then
            if a1.KeyCode == Enum.KeyCode.Escape then
                u42.close()
            end
        end
    end)
end

return u42