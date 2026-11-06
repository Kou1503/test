-- Script path: game:GetService("Players").TheKiller150306Alt.PlayerScripts.Client.Controllers.LeaderboardYouController
-- Decompile time: 1.82 ms

local CollectionService = game:GetService("CollectionService")
local Workspace = game:GetService("Workspace")
local Shared = (game:GetService("ReplicatedStorage")):WaitForChild("Shared")
local Config = require(Shared.Config)
local Format = require(Shared.Format)
local Remotes = require(Shared.Remotes)
local v1 = {}
local SpendBoard = Config.SpendBoard
local u34 = Font.new("rbxasset://fonts/families/Roboto.json", Enum.FontWeight.Bold)
local u39 = Color3.fromRGB(255, 226, 130)
local u40 = {}

local function textFor(a1, a2) -- Line: 29; upvalues: SpendBoard (val), Format (val); types: a1: string, a2: table
    if a1 == "Coins" and not a2.solo then
        return "Your rank: solo islands only"
    end

    local v1 = if not a2.place then
        ("%*+"):format(SpendBoard.RankDepth)
    else
        ("#%*"):format(a2.place)

    if a2.amount then
        return (("Your rank: %*  ·  %*"):format(v1, (Format.comma(a2.amount))))
    end

    return (("Your rank: %*"):format(v1))
end

local function surfaceOf(a1) -- Line: 40; types: a1: userdata
    local v1

    for i, j in {"SpendBoard", "Preview"} do
        v1 = a1:FindFirstChild(j)

        if v1 and v1:IsA("SurfaceGui") then
            return v1
        end
    end

    return nil
end

local function apply(a1)
    -- Line: 50
    -- upvalues: Workspace (val), SpendBoard (val), u40 (ref), surfaceOf (val), u39 (val), u34 (val), textFor (val)
    -- types: a1: userdata
    if a1:IsA("BasePart") and a1:IsDescendantOf(Workspace) then
        local Attribute_2 = a1:GetAttribute(SpendBoard.Attribute)
        local v1 = if type(Attribute_2) ~= "string" then nil else u40[Attribute_2]
        local v2 = surfaceOf(a1)

        if v1 and v2 then
            local You = v2:FindFirstChild("You")

            if not You or not You:IsA("TextLabel") then
                local TextLabel = Instance.new("TextLabel")
                TextLabel.Name = "You"
                TextLabel.BackgroundTransparency = 1
                TextLabel.AnchorPoint = Vector2.new(0.5, 1)
                TextLabel.Position = UDim2.fromScale(0.5, 0.995)
                TextLabel.Size = UDim2.fromScale(0.9, 0.06)
                TextLabel.TextScaled = true
                TextLabel.TextColor3 = u39
                TextLabel.FontFace = u34
                TextLabel.Parent = v2
                You = TextLabel
            end

            You.Text = textFor(Attribute_2, v1)
        end
    end
end

local function applyAll() -- Line: 77; upvalues: CollectionService (val), SpendBoard (val), apply (val)
    for i, j in CollectionService:GetTagged(SpendBoard.Tag) do
        apply(j)
    end
end

function v1.start()
    -- Line: 83
    -- upvalues: Remotes (val), u40 (ref), CollectionService (val), SpendBoard (val), apply (val)
    (Remotes.get(Remotes.LeaderboardYou)).OnClientEvent:Connect(function(a1)
        -- Line: 84
        -- upvalues: u40 (upval), CollectionService (upval), SpendBoard (upval), apply (upval)
        if type(a1) ~= "table" then
            return
        end

        u40 = a1

        for i, j in CollectionService:GetTagged(SpendBoard.Tag) do
            apply(j)
        end
    end)

    ;(CollectionService:GetInstanceAddedSignal(SpendBoard.Tag)):Connect(function(a1)
        -- Line: 92
        -- upvalues: apply (upval)
        task.defer(apply, a1)
    end)
end

return v1