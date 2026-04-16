-- Combinatorica Core API
-- The central integration layer for the Combinatorica game.

combinatorica = {}

local modpath = core.get_modpath("combinatorica_core")

dofile(modpath .. "/domains.lua")
dofile(modpath .. "/api.lua")
dofile(modpath .. "/interop.lua")
dofile(modpath .. "/config.lua")

core.log("action", "[combinatorica_core] Core API loaded")
