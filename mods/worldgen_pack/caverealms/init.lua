-- Caverealms Lite
-- Underground cave biomes with crystals, moss, and unique formations.

caverealms = {}

-- Glowing crystal nodes
core.register_node("caverealms:glow_crystal", {
    description = "Glow Crystal",
    tiles = {"caverealms_glow_crystal.png"},
    light_source = 12,
    groups = {cracky = 3},
})

core.register_node("caverealms:glow_emerald", {
    description = "Glow Emerald",
    tiles = {"caverealms_glow_emerald.png"},
    light_source = 10,
    groups = {cracky = 3},
})

core.register_node("caverealms:glow_mese", {
    description = "Glow Mese",
    tiles = {"caverealms_glow_mese.png"},
    light_source = 13,
    groups = {cracky = 2},
})

core.register_node("caverealms:stone_with_moss", {
    description = "Mossy Stone",
    tiles = {"caverealms_stone_moss.png"},
    groups = {cracky = 3, stone = 1},
})

core.register_node("caverealms:thin_ice", {
    description = "Thin Ice",
    tiles = {"caverealms_thin_ice.png"},
    drawtype = "glasslike",
    paramtype = "light",
    sunlight_propagates = true,
    groups = {cracky = 3, oddly_breakable_by_hand = 3},
})

-- Register underground biomes
core.register_biome({
    name = "caverealms:crystal_caves",
    node_filler = "default:stone",
    depth_filler = 1,
    y_min = -500,
    y_max = -100,
    heat_point = 50,
    humidity_point = 50,
})

core.register_biome({
    name = "caverealms:deep_caves",
    node_filler = "default:stone",
    depth_filler = 1,
    y_min = -2000,
    y_max = -500,
    heat_point = 50,
    humidity_point = 50,
})

-- Ore-style crystal generation
core.register_ore({
    ore_type = "scatter",
    ore = "caverealms:glow_crystal",
    wherein = "default:stone",
    clust_scarcity = 20 * 20 * 20,
    clust_num_ores = 6,
    clust_size = 3,
    y_min = -31000,
    y_max = -100,
})

core.register_ore({
    ore_type = "scatter",
    ore = "caverealms:glow_emerald",
    wherein = "default:stone",
    clust_scarcity = 25 * 25 * 25,
    clust_num_ores = 4,
    clust_size = 3,
    y_min = -31000,
    y_max = -200,
})

core.log("action", "[caverealms] Cave biomes loaded")
