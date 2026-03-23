-- More Ores
-- Adds mithril, silver, and tin ores.

local ores = {
    {name = "tin", desc = "Tin", depth = -128, scarcity = 10},
    {name = "silver", desc = "Silver", depth = -256, scarcity = 12},
    {name = "mithril", desc = "Mithril", depth = -512, scarcity = 18},
}

for _, ore in ipairs(ores) do
    -- Ore node
    core.register_node("moreores:mineral_" .. ore.name, {
        description = ore.desc .. " Ore",
        tiles = {"default_stone.png^moreores_mineral_" .. ore.name .. ".png"},
        groups = {cracky = 2, ore = 1},
        drop = "moreores:" .. ore.name .. "_lump",
    })

    -- Lump
    core.register_craftitem("moreores:" .. ore.name .. "_lump", {
        description = ore.desc .. " Lump",
        inventory_image = "moreores_" .. ore.name .. "_lump.png",
    })

    -- Ingot
    core.register_craftitem("moreores:" .. ore.name .. "_ingot", {
        description = ore.desc .. " Ingot",
        inventory_image = "moreores_" .. ore.name .. "_ingot.png",
    })

    -- Smelting
    core.register_craft({
        type = "cooking",
        output = "moreores:" .. ore.name .. "_ingot",
        recipe = "moreores:" .. ore.name .. "_lump",
    })

    -- Ore generation
    core.register_ore({
        ore_type = "scatter",
        ore = "moreores:mineral_" .. ore.name,
        wherein = "default:stone",
        clust_scarcity = ore.scarcity * ore.scarcity * ore.scarcity,
        clust_num_ores = 4,
        clust_size = 3,
        y_min = -31000,
        y_max = ore.depth,
    })

    -- Register with combinatorica
    combinatorica.register_ore("moreores:" .. ore.name .. "_lump", {
        depth_min = -31000, depth_max = ore.depth, rarity = ore.scarcity,
    })
end

core.log("action", "[moreores] Additional ores loaded")
