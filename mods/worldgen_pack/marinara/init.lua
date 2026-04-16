-- Wilhelmines Marinara
-- Marine and coastal biomes.

if not combinatorica.features.extra_biomes then return end

marinara = {}

core.register_biome({
    name = "marinara:coral_reef",
    node_top = "default:sand",
    depth_top = 1,
    node_filler = "default:sand",
    depth_filler = 3,
    y_min = -30,
    y_max = -5,
    heat_point = 75,
    humidity_point = 70,
})

core.register_biome({
    name = "marinara:kelp_forest",
    node_top = "default:sand",
    depth_top = 1,
    node_filler = "default:sand",
    depth_filler = 3,
    y_min = -50,
    y_max = -10,
    heat_point = 50,
    humidity_point = 80,
})

core.register_biome({
    name = "marinara:deep_ocean",
    node_top = "default:sand",
    depth_top = 1,
    node_filler = "default:sand",
    depth_filler = 5,
    y_min = -255,
    y_max = -50,
    heat_point = 40,
    humidity_point = 90,
})

core.log("action", "[marinara] Marine biomes loaded")
