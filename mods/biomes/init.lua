-- Biomes
-- Registers biome definitions for world generation.

if not combinatorica.is_domain_enabled("biomes") then return end

local function register_base_biomes()
    -- Grassland
    core.register_biome({
        name = "grassland",
        node_top = "default:dirt_with_grass",
        depth_top = 1,
        node_filler = "default:dirt",
        depth_filler = 3,
        node_riverbed = "default:sand",
        depth_riverbed = 2,
        y_min = 5,
        y_max = 31000,
        heat_point = 50,
        humidity_point = 50,
    })

    -- Desert
    core.register_biome({
        name = "desert",
        node_top = "default:desert_sand",
        depth_top = 1,
        node_filler = "default:desert_sand",
        depth_filler = 3,
        y_min = 5,
        y_max = 31000,
        heat_point = 92,
        humidity_point = 16,
    })

    -- Taiga / Snowy Forest
    core.register_biome({
        name = "taiga",
        node_top = "default:dirt_with_grass",
        depth_top = 1,
        node_filler = "default:dirt",
        depth_filler = 3,
        y_min = 5,
        y_max = 31000,
        heat_point = 15,
        humidity_point = 65,
    })

    -- Beach
    core.register_biome({
        name = "beach",
        node_top = "default:sand",
        depth_top = 1,
        node_filler = "default:sand",
        depth_filler = 3,
        y_min = -1,
        y_max = 4,
        heat_point = 60,
        humidity_point = 50,
    })

    -- Ocean
    core.register_biome({
        name = "ocean",
        node_top = "default:sand",
        depth_top = 1,
        node_filler = "default:sand",
        depth_filler = 3,
        y_min = -255,
        y_max = -2,
        heat_point = 50,
        humidity_point = 50,
    })

    -- Tundra
    core.register_biome({
        name = "tundra",
        node_top = "default:dirt_with_grass",
        depth_top = 1,
        node_filler = "default:dirt",
        depth_filler = 1,
        y_min = 5,
        y_max = 31000,
        heat_point = 0,
        humidity_point = 40,
    })

    -- Savanna
    core.register_biome({
        name = "savanna",
        node_top = "default:dirt_with_grass",
        depth_top = 1,
        node_filler = "default:dirt",
        depth_filler = 3,
        y_min = 5,
        y_max = 31000,
        heat_point = 80,
        humidity_point = 30,
    })

    -- Rainforest
    core.register_biome({
        name = "rainforest",
        node_top = "default:dirt_with_grass",
        depth_top = 1,
        node_filler = "default:dirt",
        depth_filler = 4,
        y_min = 5,
        y_max = 31000,
        heat_point = 86,
        humidity_point = 80,
    })
end

register_base_biomes()

-- Extra biomes are registered if the feature flag is enabled.
-- These will be expanded with Asuna-style worldgen mods.
if combinatorica.features.extra_biomes then
    core.log("action", "[biomes] Extra biomes enabled — will load additional biome packs")
end

core.log("action", "[biomes] Biome definitions registered")
