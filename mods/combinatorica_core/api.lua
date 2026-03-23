-- Combinatorica Core API
-- Event bus, registration helpers, and shared utilities.

-- Internal state
local event_listeners = {}
local mod_loaded_callbacks = {}
local integrations = {}

---
--- Event Bus
---

-- Register a callback for a named event.
-- @param event string: event name (e.g. "player_ate", "mob_died", "item_crafted")
-- @param callback function(data): called when the event fires
function combinatorica.on(event, callback)
    if not event_listeners[event] then
        event_listeners[event] = {}
    end
    table.insert(event_listeners[event], callback)
end

-- Emit a named event, calling all registered listeners.
-- @param event string: event name
-- @param data table: arbitrary event data passed to listeners
function combinatorica.emit(event, data)
    local listeners = event_listeners[event]
    if not listeners then
        return
    end
    for _, callback in ipairs(listeners) do
        callback(data)
    end
end

---
--- Mod Discovery
---

-- Check whether a mod is currently loaded.
-- @param modname string: the mod's technical name
-- @return boolean
function combinatorica.is_enabled(modname)
    return core.get_modpath(modname) ~= nil
end

-- Register a callback to run if/when a specific mod is loaded.
-- If the mod is already loaded, the callback fires immediately.
-- @param modname string: the mod to watch for
-- @param callback function(): called once the mod is available
function combinatorica.register_on_mod_loaded(modname, callback)
    if combinatorica.is_enabled(modname) then
        callback()
    else
        if not mod_loaded_callbacks[modname] then
            mod_loaded_callbacks[modname] = {}
        end
        table.insert(mod_loaded_callbacks[modname], callback)
    end
end

-- Internal: fire pending mod-loaded callbacks (called at end of load).
function combinatorica._fire_mod_loaded_callbacks()
    for modname, callbacks in pairs(mod_loaded_callbacks) do
        if combinatorica.is_enabled(modname) then
            for _, cb in ipairs(callbacks) do
                cb()
            end
        end
    end
    mod_loaded_callbacks = {}
end

---
--- Integration Registration
---

-- Register integration code that only runs if both mods are present.
-- @param mod_a string: first mod name
-- @param mod_b string: second mod name
-- @param callback function(): integration code to run
function combinatorica.register_integration(mod_a, mod_b, callback)
    table.insert(integrations, {
        mods = { mod_a, mod_b },
        callback = callback,
    })
end

-- Internal: activate all integrations whose dependencies are met.
function combinatorica._activate_integrations()
    for _, integration in ipairs(integrations) do
        local all_present = true
        for _, modname in ipairs(integration.mods) do
            if not combinatorica.is_enabled(modname) then
                all_present = false
                break
            end
        end
        if all_present then
            local ok, err = pcall(integration.callback)
            if not ok then
                core.log("error", "[combinatorica_core] Integration failed ("
                    .. table.concat(integration.mods, " + ") .. "): " .. tostring(err))
            end
        end
    end
end

---
--- Shared Group Conventions
---

-- Standard groups that mods should use for interoperability.
-- Mods register items into these groups so other mods can discover them.
combinatorica.groups = {
    -- Food items: group value = satiation points
    food = "food",
    -- Fuel items: group value = burn time
    fuel = "fuel",
    -- Ore blocks
    ore = "ore",
    -- Armor pieces: group value = armor points
    armor = "armor",
    -- Tools
    tool = "tool",
    -- Building materials
    building = "building",
    -- Flammable items: group value = burn spread chance
    flammable = "flammable",
    -- Items that can be composted
    compostable = "compostable",
}

---
--- Lifecycle
---

-- Run after all mods have loaded to activate integrations.
core.register_on_mods_loaded(function()
    combinatorica._fire_mod_loaded_callbacks()
    combinatorica._activate_integrations()
    core.log("action", "[combinatorica_core] All integrations activated")
end)
