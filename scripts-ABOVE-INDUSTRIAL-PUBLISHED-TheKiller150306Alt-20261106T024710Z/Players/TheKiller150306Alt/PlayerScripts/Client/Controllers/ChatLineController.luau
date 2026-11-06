-- Script path: game:GetService("Players").TheKiller150306Alt.PlayerScripts.Client.Controllers.ChatLineController
-- Decompile time: 1.28 ms

local Players = game:GetService("Players")
local TextChatService = game:GetService("TextChatService")
local Shared = game:GetService("ReplicatedStorage"):WaitForChild("Shared")
local u22 = require(Shared.Remotes)
local Config = require(Shared.Config)
local v1 = {}
local u27 = {Death = "#E08A7A", Find = "#FFD66E"}

local function escape(a1) -- Line: 25; types: a1: string
    return (string.gsub(
        a1,
        "[&<>\"']",
        {
            ["&"] = "&amp;",
            ["<"] = "&lt;",
            [">"] = "&gt;",
            ["\""] = "&quot;",
            ["'"] = "&apos;",
        }
    ))
end

local u38 = ("<font color=\"%*\">%*</font>"):format(Config.Player.ModTag.color, Config.Player.ModTag.text)

local function tagged(a1) -- Line: 46; upvalues: Players (val), Config (val), u38 (val); types: a1: userdata
    local TextChatMessageProperties = Instance.new("TextChatMessageProperties")
    local TextSource = a1.TextSource
    local PlayerByUserId = if not TextSource then nil else Players:GetPlayerByUserId(TextSource.UserId)

    if PlayerByUserId then
        local v1 = PlayerByUserId:GetAttribute(Config.Player.ModAttribute) == true
        local v2 = PlayerByUserId:GetAttribute("Vip") == true

        if v1 or v2 then
            TextChatMessageProperties.PrefixText = (if not v1 then "" else u38)
                .. (if not v2 then "" else "<font color=\"#FFD66E\">[VIP]</font>") .. " " .. a1.PrefixText
        end
    end

    return TextChatMessageProperties
end

function v1.start() -- Line: 63; upvalues: TextChatService (val), tagged (val), u22 (val), u27 (val)
    TextChatService.OnIncomingMessage = tagged
    ;(u22.get(u22.ChatLine)).OnClientEvent:Connect(function(a1, a2)
        -- Line: 68
        -- upvalues: TextChatService (upval), u27 (upval)
        if type(a1) == "string" and a1 ~= "" then
            local TextChannels = TextChatService:FindFirstChild("TextChannels")
            local RBXGeneral = TextChannels and TextChannels:FindFirstChild("RBXGeneral")

            if RBXGeneral and RBXGeneral:IsA("TextChannel") then
                RBXGeneral:DisplaySystemMessage(
                    (("<font color=\"%*\">%*</font>"):format(
                        not (type(a2) ~= "string") and u27[a2] or "#C8CCD6",
                        (string.gsub(
                            a1,
                            "[&<>\"']",
                            {
                                ["&"] = "&amp;",
                                ["<"] = "&lt;",
                                [">"] = "&gt;",
                                ["\""] = "&quot;",
                                ["'"] = "&apos;",
                            }
                        ))
                    ))
                )
            end
        end
    end)
end

return v1