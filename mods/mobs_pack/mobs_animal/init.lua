-- Mobs Animals
-- Passive farm and wild animals.

local animals = {
    {name = "cow", hp = 10, drops = {{name = "mobs_animal:beef_raw", chance = 1, min = 1, max = 3}}},
    {name = "sheep", hp = 8, drops = {{name = "wool:white", chance = 1, min = 1, max = 2}}},
    {name = "chicken", hp = 5, drops = {{name = "mobs_animal:egg", chance = 1, min = 1, max = 2}}},
    {name = "pig", hp = 8, drops = {{name = "mobs_animal:pork_raw", chance = 1, min = 1, max = 2}}},
}

for _, animal in ipairs(animals) do
    mobs.register_mob("mobs_animal:" .. animal.name, {
        hp_max = animal.hp,
        collisionbox = {-0.4, -0.5, -0.4, 0.4, 0.8, 0.4},
        textures = {"mobs_" .. animal.name .. ".png"},
        walk_velocity = 1,
        drops = animal.drops,
        view_range = 10,
    })

    mobs.register_spawn({
        name = "mobs_animal:" .. animal.name,
        nodes = {"default:dirt_with_grass"},
        interval = 60,
        chance = 8000,
        min_light = 10,
        max_light = 15,
    })
end

-- Animal products
core.register_craftitem("mobs_animal:beef_raw", {
    description = "Raw Beef",
    inventory_image = "mobs_beef_raw.png",
    on_use = core.item_eat(1),
    groups = {food = 1},
})

core.register_craftitem("mobs_animal:beef_cooked", {
    description = "Cooked Beef",
    inventory_image = "mobs_beef_cooked.png",
    on_use = core.item_eat(6),
    groups = {food = 1},
})
combinatorica.register_food("mobs_animal:beef_cooked", {satiation = 6, heal = 0})

core.register_craft({type = "cooking", output = "mobs_animal:beef_cooked", recipe = "mobs_animal:beef_raw"})

core.register_craftitem("mobs_animal:pork_raw", {
    description = "Raw Pork",
    inventory_image = "mobs_pork_raw.png",
    on_use = core.item_eat(1),
    groups = {food = 1},
})

core.register_craftitem("mobs_animal:egg", {
    description = "Egg",
    inventory_image = "mobs_egg.png",
    groups = {food = 1},
})

core.log("action", "[mobs_animal] Animals loaded")
