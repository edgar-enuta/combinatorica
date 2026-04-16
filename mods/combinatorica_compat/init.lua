-- Combinatorica Compatibility Layer
-- Provides namespace bridges so third-party mods expecting specific APIs
-- (e.g. minetest_game's default.*) can find them.

local modpath = core.get_modpath("combinatorica_compat")

-- Bridge: make "minetest" namespace calls work alongside "core"
-- (Luanti renamed minetest -> core, but many mods still use minetest.*)
if not minetest then
    minetest = core
end

-- Register metadata for all bundled domains.
dofile(modpath .. "/domain_manifest.lua")

-- Register compatibility shims for common mod APIs.
-- These are activated via the integration system so they only run
-- when the relevant mods are actually loaded.

combinatorica.register_on_mod_loaded("default", function()
    core.log("action", "[combinatorica_compat] default mod detected, registering shims")
end)

core.log("action", "[combinatorica_compat] Compatibility layer loaded")
