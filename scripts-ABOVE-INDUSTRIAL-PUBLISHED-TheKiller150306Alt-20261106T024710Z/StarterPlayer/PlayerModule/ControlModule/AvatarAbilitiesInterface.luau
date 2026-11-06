-- Script path: game:GetService("StarterPlayer").PlayerModule.ControlModule.AvatarAbilitiesInterface
-- Decompile time: 8.52 ms

local Players_2 = game:GetService("Players")
local FlagUtil = require(script.Parent.Parent:WaitForChild("CommonUtils")).get("FlagUtil")
local v1 = FlagUtil.getUserFlag("UserPlayerScriptsCCLIntegrationD")
local UserPlayerScriptsPlayerControlState2 = FlagUtil.getUserFlag("UserPlayerScriptsPlayerControlState2")
local UserPlayerScriptsTaskDeferSimulation = FlagUtil.getUserFlag("UserPlayerScriptsTaskDeferSimulation")
local UserPlayerScriptsImportWaitForAbilitiesFolder = FlagUtil.getUserFlag("UserPlayerScriptsImportWaitForAbilitiesFolder")
local u32 = nil

if not UserPlayerScriptsImportWaitForAbilitiesFolder then
    local function waitForChildren(a1, a2, a3) -- Line: 22; types: a1: userdata, a2: table, a3: number?
        local v1

        if #a2 == 0 then
            return nil
        end

        for i, j in a2 do
            v1 = a1:FindFirstChild(j)

            if v1 then
                return v1
            end
        end

        local u16 = coroutine.running()
        local u17 = nil
        local u18 = false

        local function settle(a1) -- Line: 41; upvalues: u18 (ref), u17 (ref), u16 (val); types: a1: userdata?
            if u18 then
                return
            end

            u18 = true
            u17 = a1

            task.spawn(u16)
        end

        local v2 = a1.ChildAdded:Connect(function(a1)
            -- Line: 54
            -- upvalues: a2 (val), u18 (ref), u17 (ref), u16 (val)
            -- types: a1: userdata
            if table.find(a2, a1.Name) then
                if u18 then
                    return
                end

                u18 = true
                u17 = a1

                task.spawn(u16)
            end
        end)
        v1 = nil

        if a3 then
            v1 = task.delay(
                a3,
                function() -- Line: 61; upvalues: u18 (ref), u17 (ref), u16 (val)
                    if u18 then
                        return
                    end

                    u18 = true
                    u17 = nil

                    task.spawn(u16)
                end
            )
        end

        coroutine.yield()
        v2:Disconnect()

        if v1 and coroutine.status(v1) == "suspended" then
            task.cancel(v1)
        end

        return u17
    end

    function u32(a1, a2) -- Line: 85; upvalues: waitForChildren (val); types: a1: userdata, a2: number?
        if not a1 then
            return nil
        end

        local u6 = if not a2 then nil else time() + a2

        local function getRemainingTime() -- Line: 92; upvalues: u6 (val)
            if u6 then
                return (math.max(u6 - time(), 0))
            end

            return nil
        end

        local v1 = waitForChildren(
            a1,
            {"AbilityManagerActor", "Abilities"},
            if not u6 then nil else math.max(u6 - time(), 0)
        )

        if not v1 then
            return nil
        end

        if v1.Name == "Abilities" then
            if v1:IsA("Folder") then
                return v1
            end

            return nil
        end

        local v2 = if not u6 then nil else math.max(u6 - time(), 0)
        local v3 = if not v2 then v1:WaitForChild("Abilities") else v1:WaitForChild("Abilities", v2)

        if v3 and v3:IsA("Folder") then
            return v3
        end

        return nil
    end
end

if not v1 then
    local Players = game:GetService("Players")
    local v2 = {}
    local u77 = nil
    local u78 = nil
    local BindableEvent = Instance.new("BindableEvent")
    local u82 = nil
    local u83 = false

    local function characterAdded(a1) -- Line: 500; upvalues: u77 (ref), u78 (ref), u82 (ref), BindableEvent (val)
        u77 = nil
        u78 = nil

        if u82 then
            u82:Disconnect()

            u82 = nil
        end

        if a1 then
            u77 = a1:FindFirstChild("AbilityManagerActor")
            u78 = a1:FindFirstChildOfClass("Humanoid")

            while not u78 do
                a1.ChildAdded:wait()

                u78 = a1:FindFirstChildOfClass("Humanoid")
            end

            BindableEvent:Fire()

            u82 = (u78:GetPropertyChangedSignal("EvaluateStateMachine")):Connect(function()
                -- Line: 517
                -- upvalues: BindableEvent (upval)
                BindableEvent:Fire()
            end)
        end
    end

    local function lazyInit() -- Line: 523; upvalues: u83 (ref), Players (val), characterAdded (val)
        if u83 then
            return
        end

        u83 = true
        local LocalPlayer = Players.LocalPlayer

        if LocalPlayer then
            LocalPlayer.characterAdded:Connect(characterAdded)

            if LocalPlayer.Character then
                characterAdded(LocalPlayer.Character)
            end
        end
    end

    function v2.isEnabled()
        -- Line: 538
        -- upvalues: u83 (ref), Players (val), characterAdded (val), u77 (ref), u78 (ref)
        if not u83 then
            u83 = true
            local LocalPlayer = Players.LocalPlayer

            if LocalPlayer then
                LocalPlayer.characterAdded:Connect(characterAdded)

                if LocalPlayer.Character then
                    characterAdded(LocalPlayer.Character)
                end
            end
        end

        local v1 = false

        if u77 ~= nil then
            v1 = u78 and not u78.EvaluateStateMachine
        end

        return v1
    end

    function v2.GetEnabledChangedSignal()
        -- Line: 543
        -- upvalues: u83 (ref), Players (val), characterAdded (val), BindableEvent (val)
        if not u83 then
            u83 = true
            local LocalPlayer = Players.LocalPlayer

            if LocalPlayer then
                LocalPlayer.characterAdded:Connect(characterAdded)

                if LocalPlayer.Character then
                    characterAdded(LocalPlayer.Character)
                end
            end
        end

        return BindableEvent.Event
    end

    return v2
end

local u34 = {}
u34.__index = u34
local u35 = {}

Players_2.PlayerRemoving:Connect(function(a1) -- Line: 125; upvalues: u35 (val)
    wait(1)

    local v1 = u35[a1.UserId]

    if v1 then
        v1:destroy()

        u35[a1.UserId] = nil
    end
end)

local function createAbilitiesByInputNameTable(a1) -- Line: 135
    local Attribute
    local v1 = {}

    for i, j in a1:GetChildren() do
        if j:IsA("Configuration") then
            Attribute = j:GetAttribute("InputName")

            if Attribute then
                v1[Attribute] = j
            end
        end
    end

    return v1
end

local function notifyAbilitiesChanged(a1, a2) -- Line: 148
    local u6 = a1.ChildAdded:Connect(function(a1) -- Line: 149; upvalues: a2 (val)
        if a1:IsA("Configuration") then
            a2(a1, "added")
        end
    end)
    local u11 = a1.ChildRemoved:Connect(function(a1) -- Line: 154; upvalues: a2 (val)
        if a1:IsA("Configuration") then
            a2(a1, "removed")
        end
    end)

    return function() -- Line: 159; upvalues: u6 (val), u11 (val)
        u6:Disconnect()
        u11:Disconnect()
    end
end

function u34._new(a1)
    -- Line: 165
    -- upvalues: u34 (val), UserPlayerScriptsPlayerControlState2 (val), UserPlayerScriptsTaskDeferSimulation (val)
    local u4 = setmetatable(
        {},
        u34
    )
    u4._player = a1
    u4._data = {}
    u4._character = nil
    u4._humanoid = nil
    u4._enabledChangedEvent = Instance.new("BindableEvent")
    u4._abilitiesChangedEvent = Instance.new("BindableEvent")
    u4._evaluateStateMachineChangedConnection = nil
    u4._abilityChangedEvents = {}
    u4._abilityChangedConnections = {}
    u4._abilitiesByInputName = {}
    u4._disconnectAbilitiesChanged = nil

    if not UserPlayerScriptsPlayerControlState2 or UserPlayerScriptsTaskDeferSimulation then
        u4._characterAddedConnection = a1.CharacterAdded:Connect(function(a1) -- Line: 188; upvalues: u4 (val)
            u4:_onCharacterAdded(a1)
        end)
    else
        task.spawn(function() -- Line: 182; upvalues: u4 (val), a1 (val)
            u4._characterAddedConnection = a1.CharacterAdded:Connect(function(a1) -- Line: 183; upvalues: u4 (upval)
                u4:_onCharacterAdded(a1)
            end)
        end)
    end

    if a1.Character then
        u4:_onCharacterAdded(a1.Character)
    end

    return u4
end

local u47 = nil

function u34._avatarAbilities() -- Line: 202; upvalues: u47 (ref)
    if not u47 then
        local Packages = (game:GetService("ReplicatedStorage")):FindFirstChild("Packages")
        local AvatarAbilities = if not Packages then nil else Packages:FindFirstChild("AvatarAbilities")
        u47 = if not AvatarAbilities then nil else require(AvatarAbilities)

        if not u47 then
            u47 = require("@rbx/AvatarAbilities")
        end
    end

    return u47
end

function u34.get(a1) -- Line: 215; upvalues: u35 (val), u34 (val)
    if a1 and a1.UserId ~= 0 then
        local v1 = u35[a1.UserId]

        if not v1 then
            v1 = u34._new(a1)
            u35[a1.UserId] = v1
        end

        return v1
    end

    return nil
end

function u34:_hookUpAbilityChangedEvent(a2, a3) -- Line: 225
    local v1
    local v2 = self._abilitiesByInputName[a2]

    if not v2 then
        return
    end

    local SyncedState = v2:FindFirstChild("SyncedState")

    if not SyncedState then
        return
    end

    if not self._abilityChangedConnections[a3] then
        self._abilityChangedConnections[a3] = {}
    end

    if self._abilityChangedConnections[a3][a2] then
        self._abilityChangedConnections[a3][a2]:Disconnect()

        v1 = self._abilityChangedConnections[a3]
        v1[a2] = nil
    end

    v1 = self._abilityChangedConnections[a3]
    v1[a2] = ((SyncedState:GetAttributeChangedSignal(a3)):Connect(function()
        -- Line: 239
        -- upvalues: self (val), a3 (val), a2 (val)
        self._abilityChangedEvents[a3][a2]:Fire()
    end))
end

function u34:_onCharacterAdded(a2)
    -- Line: 244
    -- upvalues: UserPlayerScriptsImportWaitForAbilitiesFolder (val), u32 (ref), notifyAbilitiesChanged (val)
    -- upvalues: createAbilitiesByInputNameTable (val)
    self._humanoid = nil
    self._character = a2
    self._abilitiesByInputName = {}
    self._data = {}

    if self._disconnectAbilitiesChanged then
        self._disconnectAbilitiesChanged()

        self._disconnectAbilitiesChanged = nil
    end

    local v1 = nil
    local v2 = nil

    for i, j in self._abilityChangedConnections, v1, v2 do
        for k, n in j do
            n:Disconnect()
        end
    end

    self._abilityChangedConnections = {}

    if self._evaluateStateMachineChangedConnection then
        self._evaluateStateMachineChangedConnection:Disconnect()

        self._evaluateStateMachineChangedConnection = nil
    end

    if not self._character then
        return
    end

    local function isStale() -- Line: 271; upvalues: self (val), a2 (val)
        return self._character ~= a2
    end

    task.spawn(function()
        -- Line: 276
        -- upvalues: UserPlayerScriptsImportWaitForAbilitiesFolder (upval), self (val), a2 (val), u32 (upval)
        -- upvalues: notifyAbilitiesChanged (upval), createAbilitiesByInputNameTable (upval)
        local u58 = if not UserPlayerScriptsImportWaitForAbilitiesFolder then
            u32(a2)
        else
            self._avatarAbilities().waitForAbilitiesFolder(a2)

        if u58 and not (self._character ~= a2) then
            self._humanoid = a2:FindFirstChildOfClass("Humanoid")

            while not self._humanoid do
                a2.ChildAdded:Wait()

                if self._character ~= a2 then
                    return
                end

                self._humanoid = a2:FindFirstChildOfClass("Humanoid")
            end

            if self._evaluateStateMachineChangedConnection then
                self._evaluateStateMachineChangedConnection:Disconnect()

                self._evaluateStateMachineChangedConnection = nil
            end

            local function enabledChanged()
                -- Line: 297
                -- upvalues: self (upval), notifyAbilitiesChanged (upval), u58 (ref)
                -- upvalues: createAbilitiesByInputNameTable (upval)
                if self._disconnectAbilitiesChanged then
                    self._disconnectAbilitiesChanged()

                    self._disconnectAbilitiesChanged = nil
                end

                if self:isEnabled() then
                    self._disconnectAbilitiesChanged = notifyAbilitiesChanged(
                        u58,
                        function(a1, a2) -- Line: 304; upvalues: self (upval)
                            local Attribute = a1:GetAttribute("InputName")

                            if not Attribute then
                                return
                            end

                            if a2 == "added" then
                                self._abilitiesByInputName[Attribute] = a1

                                for k, n in self._abilityChangedEvents do
                                    if n[Attribute] then
                                        self:_hookUpAbilityChangedEvent(Attribute, k)
                                    end
                                end
                            elseif self._abilitiesByInputName[Attribute] == a1 then
                                local v1
                                self._abilitiesByInputName[Attribute] = nil

                                for i, j in self._abilityChangedConnections do
                                    v1 = j[Attribute]

                                    if v1 then
                                        v1:Disconnect()

                                        j[Attribute] = nil
                                    end
                                end
                            end

                            self._abilitiesChangedEvent:Fire()
                        end
                    )
                    self._abilitiesByInputName = createAbilitiesByInputNameTable(u58)

                    self._abilitiesChangedEvent:Fire()

                    local v1 = nil
                    local v2 = nil

                    for i, j in self._abilityChangedEvents, v1, v2 do
                        for k, n in j do
                            n:Fire()
                            self:_hookUpAbilityChangedEvent(k, i)
                        end
                    end
                end

                self._enabledChangedEvent:Fire()
            end

            self._evaluateStateMachineChangedConnection = (self._humanoid:GetPropertyChangedSignal("EvaluateStateMachine")):Connect(function()
                -- Line: 350
                -- upvalues: enabledChanged (val)
                enabledChanged()
            end)

            enabledChanged()
        end
    end)
end

function u34:isEnabled() -- Line: 357
    local v1 = false

    if self._humanoid ~= nil then
        v1 = not self._humanoid.EvaluateStateMachine
    end

    return v1
end

function u34.GetEnabledChangedSignal(a1) -- Line: 361
    return a1._enabledChangedEvent.Event
end

function u34.SendInput(a1, a2, a3) -- Line: 365
    if not a1:isEnabled() then
        return
    end

    if a3 ~= a1._data[a2] then
        a1._data[a2] = a3
        a1._avatarAbilities().setAbilityManagerCommand(a1._character, a2, a3)
    end
end

function u34:GetAbilityAttribute(a2, a3, a4) -- Line: 374
    local v1 = self._abilitiesByInputName[a2]

    if not v1 then
        return a4
    end

    local SyncedState = v1:FindFirstChild("SyncedState")

    if not SyncedState then
        return a4
    end

    v1 = SyncedState:GetAttribute(a3)

    if v1 == nil then
        return a4
    end

    return v1
end

function u34:GetAbilityAttributeChangedSignal(a2, a3) -- Line: 384
    if not self._abilityChangedEvents[a3] then
        self._abilityChangedEvents[a3] = {}
    end

    if self._abilityChangedEvents[a3][a2] then
        return self._abilityChangedEvents[a3][a2].Event
    end

    local BindableEvent = Instance.new("BindableEvent")
    self._abilityChangedEvents[a3][a2] = BindableEvent

    self:_hookUpAbilityChangedEvent(a2, a3)

    return BindableEvent.Event
end

function u34.GetAbilityEnabled(a1, a2) -- Line: 400
    return a1:GetAbilityAttribute(a2, "Enabled", false)
end

function u34.GetAbilityEnabledChangedSignal(a1, a2) -- Line: 404
    return a1:GetAbilityAttributeChangedSignal(a2, "Enabled")
end

function u34.GetAbilitySuspended(a1, a2) -- Line: 408
    return a1:GetAbilityAttribute(a2, "Suspended", false)
end

function u34.GetAbilitySuspendedChangedSignal(a1, a2) -- Line: 412
    return a1:GetAbilityAttributeChangedSignal(a2, "Suspended")
end

function u34.GetAbilityActive(a1, a2) -- Line: 416
    return a1:GetAbilityAttribute(a2, "Active", false)
end

function u34.GetAbilityActiveChangedSignal(a1, a2) -- Line: 420
    return a1:GetAbilityAttributeChangedSignal(a2, "Active")
end

function u34.GetAbilityValid(a1, a2) -- Line: 424
    return a1:GetAbilityAttribute(a2, "IsValid", true)
end

function u34.GetAbilityValidChangedSignal(a1, a2) -- Line: 428
    return a1:GetAbilityAttributeChangedSignal(a2, "IsValid")
end

function u34.GetAbilities(a1) -- Line: 432
    local v1 = {}

    for i in a1._abilitiesByInputName do
        table.insert(v1, i)
    end

    return v1
end

function u34.GetAbilitiesChangedSignal(a1) -- Line: 440
    return a1._abilitiesChangedEvent.Event
end

function u34.GetAbilityConfig(a1, a2) -- Line: 444
    local v1 = {Slot = -1}
    local v2 = a1._abilitiesByInputName[a2]

    if not v2 then
        return v1
    end

    local Attribute = v2:GetAttribute("ActionSlot")

    if not Attribute then
        return v1
    end

    return {
        Slot = tonumber(Attribute),
        ButtonAssetId = v2:GetAttribute("CustomIcon"),
        ButtonPressedAssetId = v2:GetAttribute("CustomIconActive"),
        ButtonInvalidAssetId = v2:GetAttribute("CustomIconInvalid"),
    }
end

function u34:destroy() -- Line: 466
    if self._characterAddedConnection then
        self._characterAddedConnection:Disconnect()

        self._characterAddedConnection = nil
    end

    if self._evaluateStateMachineChangedConnection then
        self._evaluateStateMachineChangedConnection:Disconnect()

        self._evaluateStateMachineChangedConnection = nil
    end

    if self._disconnectAbilitiesChanged then
        self._disconnectAbilitiesChanged()

        self._disconnectAbilitiesChanged = nil
    end

    local v1 = nil
    local v2 = nil

    for i, j in self._abilityChangedConnections, v1, v2 do
        for k, n in j do
            n:Disconnect()
        end
    end

    self._abilityChangedConnections = {}
end

return u34