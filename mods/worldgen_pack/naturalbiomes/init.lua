-- Wilhelmines Natural Biomes
-- Realistic natural biome environments.

if not combinatorica.features.extra_biomes then return end

naturalbiomes = {}

local biomes = {
    {name = "alderswamp", desc = "Alder Swamp", heat = 60, humidity = 85},
    {name = "alpine", desc = "Alpine Meadow", heat = 20, humidity = 50},
    {name = "beach", desc = "Tropical Beach", heat = 85, humidity = 60},
    {name = "bushland", desc = "Australian Bushland", heat = 80, humidity = 25},
    {name = "mediterranean", desc = "Mediterranean", heat = 75, humidity = 35},
    {name = "outback", desc = "Outback", heat = 90, humidity = 15},
    {name = "savanna", desc = "African Savanna", heat = 82, humidity = 28},
}

for _, biome in ipairs(biomes) do
    core.register_biome({
        name = "naturalbiomes:" .. biome.name,
        node_top = "default:dirt_with_grass",
        depth_top = 1,
        node_filler = "default:dirt",
        depth_filler = 3,
        y_min = 5,
        y_max = 31000,
        heat_point = biome.heat,
        humidity_point = biome.humidity,
    })
end

core.log("action", "[naturalbiomes] Natural Biomes loaded (" .. #biomes .. " biomes)")
