-- Default Crafting Recipes

-- Sticks
core.register_craft({
    output = "default:stick 4",
    recipe = {{"default:wood"}},
})

-- Wooden planks from tree
core.register_craft({
    output = "default:wood 4",
    recipe = {{"default:tree"}},
})

-- Stone brick
core.register_craft({
    output = "default:stonebrick 4",
    recipe = {
        {"default:stone", "default:stone"},
        {"default:stone", "default:stone"},
    },
})

-- Paper
core.register_craft({
    output = "default:paper 4",
    recipe = {
        {"default:papyrus", "default:papyrus", "default:papyrus"},
    },
})

-- Book
core.register_craft({
    output = "default:book",
    recipe = {
        {"default:paper"},
        {"default:paper"},
        {"default:paper"},
    },
})

-- Torch
core.register_craft({
    output = "default:torch 4",
    recipe = {
        {"default:coal_lump"},
        {"default:stick"},
    },
})

-- Glass from sand (cooking)
core.register_craft({
    type = "cooking",
    output = "default:glass",
    recipe = "default:sand",
})

-- Steel ingot from iron lump (cooking)
core.register_craft({
    type = "cooking",
    output = "default:steel_ingot",
    recipe = "default:iron_lump",
})

-- Copper ingot from copper lump (cooking)
core.register_craft({
    type = "cooking",
    output = "default:copper_ingot",
    recipe = "default:copper_lump",
})

-- Gold ingot from gold lump (cooking)
core.register_craft({
    type = "cooking",
    output = "default:gold_ingot",
    recipe = "default:gold_lump",
})

-- Bronze ingot
core.register_craft({
    output = "default:bronze_ingot 9",
    recipe = {
        {"default:copper_ingot", "default:copper_ingot", "default:copper_ingot"},
        {"default:copper_ingot", "default:tin_ingot", "default:copper_ingot"},
        {"default:copper_ingot", "default:copper_ingot", "default:copper_ingot"},
    },
})

-- Coal as fuel
core.register_craft({
    type = "fuel",
    recipe = "default:coal_lump",
    burntime = 40,
})

-- Wood as fuel
core.register_craft({
    type = "fuel",
    recipe = "default:wood",
    burntime = 7,
})

-- Tree as fuel
core.register_craft({
    type = "fuel",
    recipe = "default:tree",
    burntime = 30,
})

core.log("action", "[default] Crafting recipes registered")
