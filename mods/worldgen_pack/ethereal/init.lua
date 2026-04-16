-- Ethereal NG
-- Rich overworld biomes with unique trees, plants, and terrain.

if not combinatorica.features.extra_biomes then return end

ethereal = {}

local biomes = {
    {name = "bamboo", heat = 80, humidity = 80, desc = "Bamboo Forest"},
    {name = "mesa", heat = 95, humidity = 10, desc = "Mesa"},
    {name = "alpine", heat = 10, humidity = 40, desc = "Alpine Meadow"},
    {name = "healing", heat = 45, humidity = 65, desc = "Healing Grove"},
    {name = "snowy", heat = 5, humidity = 50, desc = "Snowy Grassland"},
    {name = "frost", heat = 0, humidity = 70, desc = "Frost Forest"},
    {name = "grassy", heat = 55, humidity = 55, desc = "Grassy Plains"},
    {name = "grove", heat = 48, humidity = 60, desc = "Grove"},
    {name = "prairie", heat = 60, humidity = 35, desc = "Prairie"},
    {name = "jumble", heat = 70, humidity = 70, desc = "Jumbled Forest"},
    {name = "junglee", heat = 90, humidity = 85, desc = "Dense Jungle"},
    {name = "desert_ocean", heat = 92, humidity = 16, desc = "Desert Ocean"},
    {name = "plains", heat = 65, humidity = 25, desc = "Dry Plains"},
    {name = "sakura", heat = 55, humidity = 75, desc = "Sakura Grove"},
    {name = "swamp", heat = 75, humidity = 90, desc = "Swampland"},
    {name = "glacier", heat = -10, humidity = 60, desc = "Glacier"},
    {name = "mushroom", heat = 50, humidity = 80, desc = "Mushroom Forest"},
    {name = "fiery", heat = 100, humidity = 20, desc = "Fiery Caverns"},
}

for _, biome in ipairs(biomes) do
    core.register_biome({
        name = "ethereal:" .. biome.name,
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

core.log("action", "[ethereal] Ethereal NG biomes loaded (" .. #biomes .. " biomes)")
