-- Wilhelmines Living Jungle
-- Dense, vibrant jungle biomes.

if not combinatorica.features.extra_biomes then return end

livingjungle = {}

core.register_biome({
    name = "livingjungle:jungle",
    node_top = "default:dirt_with_grass",
    depth_top = 1,
    node_filler = "default:dirt",
    depth_filler = 5,
    y_min = 1,
    y_max = 31000,
    heat_point = 88,
    humidity_point = 92,
})

core.register_biome({
    name = "livingjungle:jungle_canopy",
    node_top = "default:dirt_with_grass",
    depth_top = 1,
    node_filler = "default:dirt",
    depth_filler = 5,
    y_min = 1,
    y_max = 31000,
    heat_point = 92,
    humidity_point = 95,
})

core.log("action", "[livingjungle] Living Jungle biomes loaded")
