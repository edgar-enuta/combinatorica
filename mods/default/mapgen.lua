-- Default Mapgen
-- Ore distribution and basic mapgen aliases.

-- Register mapgen aliases
core.register_alias("mapgen_stone", "default:stone")
core.register_alias("mapgen_water_source", "default:water_source")
core.register_alias("mapgen_river_water_source", "default:water_source")
core.register_alias("mapgen_lava_source", "default:lava_source")
core.register_alias("mapgen_cobble", "default:cobble")

-- Ore registrations
core.register_ore({
    ore_type = "scatter",
    ore = "default:stone_with_coal",
    wherein = "default:stone",
    clust_scarcity = 8 * 8 * 8,
    clust_num_ores = 9,
    clust_size = 3,
    y_min = -31000,
    y_max = 64,
})

core.register_ore({
    ore_type = "scatter",
    ore = "default:stone_with_iron",
    wherein = "default:stone",
    clust_scarcity = 9 * 9 * 9,
    clust_num_ores = 12,
    clust_size = 3,
    y_min = -31000,
    y_max = 2,
})

core.register_ore({
    ore_type = "scatter",
    ore = "default:stone_with_copper",
    wherein = "default:stone",
    clust_scarcity = 9 * 9 * 9,
    clust_num_ores = 5,
    clust_size = 3,
    y_min = -31000,
    y_max = -16,
})

core.register_ore({
    ore_type = "scatter",
    ore = "default:stone_with_gold",
    wherein = "default:stone",
    clust_scarcity = 13 * 13 * 13,
    clust_num_ores = 5,
    clust_size = 3,
    y_min = -31000,
    y_max = -64,
})

core.register_ore({
    ore_type = "scatter",
    ore = "default:stone_with_diamond",
    wherein = "default:stone",
    clust_scarcity = 15 * 15 * 15,
    clust_num_ores = 4,
    clust_size = 3,
    y_min = -31000,
    y_max = -128,
})

core.log("action", "[default] Mapgen registered")
