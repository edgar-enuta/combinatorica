-- Default Craft Items
-- Lumps, ingots, gems, sticks, paper, etc.

-- Lumps (raw ore)
core.register_craftitem("default:coal_lump", {
    description = "Coal Lump",
    inventory_image = "default_coal_lump.png",
    groups = {coal = 1, flammable = 1, fuel = 1},
})

core.register_craftitem("default:iron_lump", {
    description = "Iron Lump",
    inventory_image = "default_iron_lump.png",
})

core.register_craftitem("default:copper_lump", {
    description = "Copper Lump",
    inventory_image = "default_copper_lump.png",
})

core.register_craftitem("default:gold_lump", {
    description = "Gold Lump",
    inventory_image = "default_gold_lump.png",
})

-- Ingots (smelted)
core.register_craftitem("default:steel_ingot", {
    description = "Steel Ingot",
    inventory_image = "default_steel_ingot.png",
})

core.register_craftitem("default:copper_ingot", {
    description = "Copper Ingot",
    inventory_image = "default_copper_ingot.png",
})

core.register_craftitem("default:gold_ingot", {
    description = "Gold Ingot",
    inventory_image = "default_gold_ingot.png",
})

core.register_craftitem("default:bronze_ingot", {
    description = "Bronze Ingot",
    inventory_image = "default_bronze_ingot.png",
})

-- Gems & materials
core.register_craftitem("default:diamond", {
    description = "Diamond",
    inventory_image = "default_diamond.png",
})

core.register_craftitem("default:clay_lump", {
    description = "Clay Lump",
    inventory_image = "default_clay_lump.png",
})

core.register_craftitem("default:stick", {
    description = "Stick",
    inventory_image = "default_stick.png",
    groups = {stick = 1, flammable = 2},
})

core.register_craftitem("default:paper", {
    description = "Paper",
    inventory_image = "default_paper.png",
})

core.register_craftitem("default:book", {
    description = "Book",
    inventory_image = "default_book.png",
})

-- Food
core.register_craftitem("default:apple", {
    description = "Apple",
    inventory_image = "default_apple.png",
    on_use = core.item_eat(2),
    groups = {food = 1, flammable = 2, compostable = 1},
})

combinatorica.register_food("default:apple", {satiation = 2, heal = 0})

core.log("action", "[default] Craft items registered")
