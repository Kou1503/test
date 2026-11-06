-- Script path: game:GetService("StarterPlayer").PlayerModule.CommonUtils.EventBus
-- Decompile time: 0.37 ms

local u0 = {}
u0.__index = u0

function u0.new() -- Line: 20; upvalues: u0 (val)
    local v1 = setmetatable(
        {},
        u0
    )
    v1._events = {}

    return v1
end

function u0:_getOrCreate(a2) -- Line: 26; types: self: table, a2: string
    if not self._events[a2] then
        local BindableEvent = Instance.new("BindableEvent")
        BindableEvent.Name = a2
        self._events[a2] = BindableEvent
    end

    return self._events[a2]
end

function u0.publish(a1, a2, ...) -- Line: 35; types: a1: table, a2: string
    a1:_getOrCreate(a2):Fire(...)
end

function u0.subscribe(a1, a2) -- Line: 40; types: a1: table, a2: string
    return a1:_getOrCreate(a2).Event
end

return u0