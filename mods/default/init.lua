-- Default Mod
-- Provides base nodes, tools, craftitems, and mapgen for the Combinatorica game.

default = {}

local modpath = core.get_modpath("default")

-- Load subsystems
dofile(modpath .. "/nodes.lua")
dofile(modpath .. "/tools.lua")
dofile(modpath .. "/craftitems.lua")
dofile(modpath .. "/crafting.lua")
dofile(modpath .. "/mapgen.lua")

core.log("action", "[default] Base game loaded")
