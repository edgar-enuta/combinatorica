local modname = minetest.get_current_modname()
local modpath = minetest.get_modpath(modname)
local S = minetest.get_translator(modname)

-- Register with domain system
combinatorica.register_domain(modname, {
	title = "Core Player",
	description = "Player model, animations, health, hunger, and basic player mechanics",
	tier = 1,
})

-- Check if this domain is enabled
if not combinatorica.is_active(modname) then
	return
end

-- Create namespace
local mod = {}
_G[modname] = mod

combinatorica.log(modname, "action", "loaded")
