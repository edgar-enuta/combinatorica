-- Everness
-- Rich biome mod with custom surface, underground, and ocean biomes.
-- Includes structures, dungeons, loot chests, and skybox overrides.

if not combinatorica.features.extra_biomes then return end

everness = {}

-- Crystal biomes
core.register_biome({
    name = "everness:crystal_forest",
    node_top = "everness:crystal_dirt",
    depth_top = 1,
    node_filler = "default:dirt",
    depth_filler = 3,
    y_min = 5,
    y_max = 31000,
    heat_point = 40,
    humidity_point = 70,
})

-- Cursed lands
core.register_biome({
    name = "everness:cursed_lands",
    node_top = "everness:cursed_dirt",
    depth_top = 1,
    node_filler = "default:dirt",
    depth_filler = 3,
    y_min = 5,
    y_max = 31000,
    heat_point = 45,
    humidity_point = 85,
})

-- Coral forest
core.register_biome({
    name = "everness:coral_forest",
    node_top = "everness:coral_dirt",
    depth_top = 1,
    node_filler = "default:dirt",
    depth_filler = 3,
    y_min = 5,
    y_max = 31000,
    heat_point = 65,
    humidity_point = 75,
})

-- Frosted icesheet
core.register_biome({
    name = "everness:frosted_icesheet",
    node_top = "everness:frosted_ice",
    depth_top = 3,
    node_filler = "everness:frosted_ice",
    depth_filler = 8,
    y_min = -8,
    y_max = 31000,
    heat_point = -5,
    humidity_point = 50,
})

-- Bamboo forest
core.register_biome({
    name = "everness:bamboo_forest",
    node_top = "everness:bamboo_dirt",
    depth_top = 1,
    node_filler = "default:dirt",
    depth_filler = 4,
    y_min = 5,
    y_max = 31000,
    heat_point = 75,
    humidity_point = 80,
})

-- Register placeholder nodes for everness biomes
local everness_nodes = {
    "crystal_dirt", "cursed_dirt", "coral_dirt", "frosted_ice", "bamboo_dirt",
}

for _, name in ipairs(everness_nodes) do
    core.register_node("everness:" .. name, {
        description = name:gsub("_", " "):gsub("(%a)([%w_']*)", function(a, b) return a:upper() .. b end),
        tiles = {"everness_" .. name .. ".png"},
        groups = {crumbly = 3},
    })
end

core.log("action", "[everness] Everness biomes loaded")
