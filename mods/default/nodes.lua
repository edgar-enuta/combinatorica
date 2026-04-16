-- Default Nodes
-- Stone, dirt, sand, wood, leaves, ores, liquids, etc.

-- Stone
core.register_node("default:stone", {
    description = "Stone",
    tiles = {"default_stone.png"},
    groups = {cracky = 3, stone = 1, building = 1},
    drop = "default:cobble",
    sounds = default.node_sound_stone_defaults and default.node_sound_stone_defaults() or {},
})

core.register_node("default:cobble", {
    description = "Cobblestone",
    tiles = {"default_cobble.png"},
    groups = {cracky = 3, stone = 2, building = 1},
    sounds = {},
})

core.register_node("default:stonebrick", {
    description = "Stone Brick",
    tiles = {"default_stone_brick.png"},
    groups = {cracky = 2, stone = 1, building = 1},
    sounds = {},
})

-- Dirt & Grass
core.register_node("default:dirt", {
    description = "Dirt",
    tiles = {"default_dirt.png"},
    groups = {crumbly = 3, soil = 1},
    sounds = {},
})

core.register_node("default:dirt_with_grass", {
    description = "Dirt with Grass",
    tiles = {"default_grass.png", "default_dirt.png",
        {name = "default_dirt.png^default_grass_side.png", tileable_vertical = false}},
    groups = {crumbly = 3, soil = 1, spreading_dirt_type = 1},
    drop = "default:dirt",
    sounds = {},
})

-- Sand
core.register_node("default:sand", {
    description = "Sand",
    tiles = {"default_sand.png"},
    groups = {crumbly = 3, falling_node = 1, sand = 1},
    sounds = {},
})

core.register_node("default:desert_sand", {
    description = "Desert Sand",
    tiles = {"default_desert_sand.png"},
    groups = {crumbly = 3, falling_node = 1, sand = 1},
    sounds = {},
})

-- Wood
core.register_node("default:wood", {
    description = "Wooden Planks",
    tiles = {"default_wood.png"},
    groups = {choppy = 2, oddly_breakable_by_hand = 2, flammable = 2, wood = 1, building = 1},
    sounds = {},
})

core.register_node("default:tree", {
    description = "Tree",
    tiles = {"default_tree_top.png", "default_tree_top.png", "default_tree.png"},
    groups = {tree = 1, choppy = 2, oddly_breakable_by_hand = 1, flammable = 2},
    sounds = {},
})

core.register_node("default:leaves", {
    description = "Leaves",
    drawtype = "allfaces_optional",
    tiles = {"default_leaves.png"},
    paramtype = "light",
    groups = {snappy = 3, leafdecay = 3, flammable = 2, leaves = 1},
    drop = {
        max_items = 1,
        items = {
            {items = {"default:sapling"}, rarity = 20},
            {items = {"default:leaves"}},
        },
    },
    sounds = {},
})

core.register_node("default:sapling", {
    description = "Sapling",
    drawtype = "plantlike",
    tiles = {"default_sapling.png"},
    paramtype = "light",
    sunlight_propagates = true,
    walkable = false,
    selection_box = {
        type = "fixed",
        fixed = {-4 / 16, -0.5, -4 / 16, 4 / 16, 7 / 16, 4 / 16},
    },
    groups = {snappy = 2, dig_immediate = 3, flammable = 2, attached_node = 1, sapling = 1},
    sounds = {},
})

-- Ores
core.register_node("default:stone_with_coal", {
    description = "Coal Ore",
    tiles = {"default_stone.png^default_mineral_coal.png"},
    groups = {cracky = 3, ore = 1},
    drop = "default:coal_lump",
    sounds = {},
})

core.register_node("default:stone_with_iron", {
    description = "Iron Ore",
    tiles = {"default_stone.png^default_mineral_iron.png"},
    groups = {cracky = 2, ore = 1},
    drop = "default:iron_lump",
    sounds = {},
})

core.register_node("default:stone_with_copper", {
    description = "Copper Ore",
    tiles = {"default_stone.png^default_mineral_copper.png"},
    groups = {cracky = 2, ore = 1},
    drop = "default:copper_lump",
    sounds = {},
})

core.register_node("default:stone_with_gold", {
    description = "Gold Ore",
    tiles = {"default_stone.png^default_mineral_gold.png"},
    groups = {cracky = 2, ore = 1},
    drop = "default:gold_lump",
    sounds = {},
})

core.register_node("default:stone_with_diamond", {
    description = "Diamond Ore",
    tiles = {"default_stone.png^default_mineral_diamond.png"},
    groups = {cracky = 1, ore = 1},
    drop = "default:diamond",
    sounds = {},
})

-- Glass
core.register_node("default:glass", {
    description = "Glass",
    drawtype = "glasslike_framed_optional",
    tiles = {"default_glass.png", "default_glass_detail.png"},
    paramtype = "light",
    sunlight_propagates = true,
    groups = {cracky = 3, oddly_breakable_by_hand = 3},
    drop = "",
    sounds = {},
})

-- Liquids
core.register_node("default:water_source", {
    description = "Water Source",
    drawtype = "liquid",
    tiles = {"default_water.png"},
    special_tiles = {"default_water.png"},
    paramtype = "light",
    walkable = false,
    pointable = false,
    diggable = false,
    buildable_to = true,
    is_ground_content = false,
    drowning = 1,
    liquidtype = "source",
    liquid_alternative_flowing = "default:water_flowing",
    liquid_alternative_source = "default:water_source",
    liquid_viscosity = 1,
    post_effect_color = {a = 103, r = 30, g = 60, b = 90},
    groups = {water = 3, liquid = 3, cools_lava = 1},
    sounds = {},
})

core.register_node("default:water_flowing", {
    description = "Flowing Water",
    drawtype = "flowingliquid",
    tiles = {"default_water.png"},
    special_tiles = {"default_water.png"},
    paramtype = "light",
    paramtype2 = "flowingliquid",
    walkable = false,
    pointable = false,
    diggable = false,
    buildable_to = true,
    is_ground_content = false,
    drowning = 1,
    liquidtype = "flowing",
    liquid_alternative_flowing = "default:water_flowing",
    liquid_alternative_source = "default:water_source",
    liquid_viscosity = 1,
    post_effect_color = {a = 103, r = 30, g = 60, b = 90},
    groups = {water = 3, liquid = 3, not_in_creative_inventory = 1, cools_lava = 1},
    sounds = {},
})

core.register_node("default:lava_source", {
    description = "Lava Source",
    drawtype = "liquid",
    tiles = {"default_lava.png"},
    special_tiles = {"default_lava.png"},
    paramtype = "light",
    light_source = core.LIGHT_MAX - 1,
    walkable = false,
    pointable = false,
    diggable = false,
    buildable_to = true,
    is_ground_content = false,
    damage_per_second = 4 * 2,
    liquidtype = "source",
    liquid_alternative_flowing = "default:lava_flowing",
    liquid_alternative_source = "default:lava_source",
    liquid_viscosity = 7,
    post_effect_color = {a = 191, r = 255, g = 64, b = 0},
    groups = {lava = 3, liquid = 2, igniter = 1},
    sounds = {},
})

core.register_node("default:lava_flowing", {
    description = "Flowing Lava",
    drawtype = "flowingliquid",
    tiles = {"default_lava.png"},
    special_tiles = {"default_lava.png"},
    paramtype = "light",
    paramtype2 = "flowingliquid",
    light_source = core.LIGHT_MAX - 1,
    walkable = false,
    pointable = false,
    diggable = false,
    buildable_to = true,
    is_ground_content = false,
    damage_per_second = 4 * 2,
    liquidtype = "flowing",
    liquid_alternative_flowing = "default:lava_flowing",
    liquid_alternative_source = "default:lava_source",
    liquid_viscosity = 7,
    post_effect_color = {a = 191, r = 255, g = 64, b = 0},
    groups = {lava = 3, liquid = 2, igniter = 1, not_in_creative_inventory = 1},
    sounds = {},
})

-- Torch
core.register_node("default:torch", {
    description = "Torch",
    drawtype = "torchlike",
    tiles = {"default_torch_on_floor.png", "default_torch_on_ceiling.png", "default_torch.png"},
    paramtype = "light",
    paramtype2 = "wallmounted",
    sunlight_propagates = true,
    walkable = false,
    light_source = core.LIGHT_MAX - 1,
    groups = {choppy = 2, dig_immediate = 3, flammable = 1, attached_node = 1},
    sounds = {},
})

core.log("action", "[default] Nodes registered")
