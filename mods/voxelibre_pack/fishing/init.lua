-- Fishing
-- Fishing rod, fish items, and loot table.

fishing = {}

local fish_loot = {
    {name = "fishing:cod_raw", chance = 50},
    {name = "fishing:salmon_raw", chance = 30},
    {name = "fishing:tropical_fish", chance = 10},
    {name = "fishing:pufferfish", chance = 5},
    {name = "default:stick", chance = 3},
    {name = "default:book", chance = 2},
}

-- Fish items
core.register_craftitem("fishing:cod_raw", {
    description = "Raw Cod",
    inventory_image = "fishing_cod_raw.png",
    on_use = core.item_eat(2),
    groups = {food = 1},
})

core.register_craftitem("fishing:cod_cooked", {
    description = "Cooked Cod",
    inventory_image = "fishing_cod_cooked.png",
    on_use = core.item_eat(5),
    groups = {food = 1},
})
combinatorica.register_food("fishing:cod_cooked", {satiation = 5})

core.register_craftitem("fishing:salmon_raw", {
    description = "Raw Salmon",
    inventory_image = "fishing_salmon_raw.png",
    on_use = core.item_eat(2),
    groups = {food = 1},
})

core.register_craftitem("fishing:tropical_fish", {
    description = "Tropical Fish",
    inventory_image = "fishing_tropical.png",
    on_use = core.item_eat(1),
    groups = {food = 1},
})

core.register_craftitem("fishing:pufferfish", {
    description = "Pufferfish",
    inventory_image = "fishing_pufferfish.png",
    groups = {food = 1},
})

core.register_craft({type = "cooking", output = "fishing:cod_cooked", recipe = "fishing:cod_raw"})

-- Fishing rod
core.register_tool("fishing:fishing_rod", {
    description = "Fishing Rod",
    inventory_image = "fishing_rod.png",
    on_use = function(itemstack, user, pointed_thing)
        if pointed_thing.type == "node" then
            local node = core.get_node(pointed_thing.under)
            if core.get_item_group(node.name, "water") > 0 then
                -- Random catch
                local total = 0
                for _, loot in ipairs(fish_loot) do total = total + loot.chance end
                local roll = math.random(1, total)
                local cumulative = 0
                for _, loot in ipairs(fish_loot) do
                    cumulative = cumulative + loot.chance
                    if roll <= cumulative then
                        local inv = user:get_inventory()
                        inv:add_item("main", ItemStack(loot.name))
                        core.chat_send_player(user:get_player_name(), "You caught: " .. loot.name)
                        combinatorica.emit("fish_caught", {player = user:get_player_name(), item = loot.name})
                        if combinatorica.is_enabled("experience") then
                            experience.add_xp(user:get_player_name(), 2)
                        end
                        break
                    end
                end
                itemstack:add_wear(65535 / 65)
            end
        end
        return itemstack
    end,
})

core.register_craft({
    output = "fishing:fishing_rod",
    recipe = {
        {"", "", "default:stick"},
        {"", "default:stick", "farming:cotton"},
        {"default:stick", "", "farming:cotton"},
    },
})

core.log("action", "[fishing] Fishing loaded")
