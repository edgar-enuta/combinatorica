-- Combinatorica Config
-- Runtime configuration and feature flag management.

local settings = core.settings

combinatorica.config = {}

-- Read a boolean setting with a default value.
-- @param key string: setting name (e.g. "combinatorica_hunger_enabled")
-- @param default boolean: fallback value if not set
-- @return boolean
function combinatorica.config.get_bool(key, default)
    local val = settings:get_bool(key)
    if val == nil then
        return default
    end
    return val
end

-- Read a string setting with a default value.
function combinatorica.config.get(key, default)
    return settings:get(key) or default
end

-- Read a numeric setting with a default value.
function combinatorica.config.get_number(key, default)
    local val = tonumber(settings:get(key))
    if val == nil then
        return default
    end
    return val
end

-- Feature flags — these map to settingtypes.txt entries.
combinatorica.features = {
    hunger = combinatorica.config.get_bool("combinatorica_hunger_enabled", true),
    mobs = combinatorica.config.get_bool("combinatorica_mobs_enabled", true),
    techage = combinatorica.config.get_bool("combinatorica_techage_enabled", true),
    nether = combinatorica.config.get_bool("combinatorica_nether_enabled", true),
    extra_biomes = combinatorica.config.get_bool("combinatorica_extra_biomes", true),
}

core.log("action", "[combinatorica_core] Feature flags: "
    .. "hunger=" .. tostring(combinatorica.features.hunger)
    .. ", mobs=" .. tostring(combinatorica.features.mobs)
    .. ", techage=" .. tostring(combinatorica.features.techage)
    .. ", nether=" .. tostring(combinatorica.features.nether)
    .. ", extra_biomes=" .. tostring(combinatorica.features.extra_biomes))

-- Check whether a domain is enabled. A domain is enabled iff:
--   (a) it has been registered with always_on = true, OR
--   (b) its combinatorica_<name>_enabled setting is unset or true.
-- Defaults to true so that new mods work out-of-the-box without a setting.
--
-- Usage at the top of a mod's init.lua:
--   if not combinatorica.is_domain_enabled(core.get_current_modname()) then return end
--
-- @param name string: domain name
-- @return boolean
function combinatorica.is_domain_enabled(name)
    local domain = combinatorica.domains[name]
    if domain and domain.always_on then
        return true
    end
    local val = settings:get_bool("combinatorica_" .. name .. "_enabled")
    if val == nil then
        return true
    end
    return val
end
