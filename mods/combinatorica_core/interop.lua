-- Combinatorica Interop
-- Cross-mod communication helpers and shared registries.

-- Shared item registries — mods register their items here so other mods
-- can discover them without hard dependencies.

combinatorica.registered_foods = {}
combinatorica.registered_ores = {}
combinatorica.registered_armor = {}
combinatorica.registered_tools = {}

-- Register a food item for cross-mod discovery.
-- @param itemname string: full item name (e.g. "farming:bread")
-- @param def table: { satiation = number, heal = number, replace_with = string|nil }
function combinatorica.register_food(itemname, def)
    combinatorica.registered_foods[itemname] = def
    combinatorica.emit("food_registered", { item = itemname, def = def })
end

-- Register an ore for cross-mod discovery.
-- @param itemname string: full item name (e.g. "moreores:mithril_lump")
-- @param def table: { depth_min = number, depth_max = number, rarity = number }
function combinatorica.register_ore(itemname, def)
    combinatorica.registered_ores[itemname] = def
    combinatorica.emit("ore_registered", { item = itemname, def = def })
end

-- Register an armor piece for cross-mod discovery.
-- @param itemname string: full armor item name
-- @param def table: { armor_points = number, material = string, slot = string }
function combinatorica.register_armor(itemname, def)
    combinatorica.registered_armor[itemname] = def
    combinatorica.emit("armor_registered", { item = itemname, def = def })
end

-- Register a tool for cross-mod discovery.
-- @param itemname string: full tool item name
-- @param def table: { material = string, tool_type = string }
function combinatorica.register_tool(itemname, def)
    combinatorica.registered_tools[itemname] = def
    combinatorica.emit("tool_registered", { item = itemname, def = def })
end

-- Utility: get all registered foods as a list of { name, def } pairs.
function combinatorica.get_foods()
    local result = {}
    for name, def in pairs(combinatorica.registered_foods) do
        table.insert(result, { name = name, def = def })
    end
    return result
end
