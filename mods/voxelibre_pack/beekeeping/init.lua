-- Beekeeping
-- Bees, hives, honey blocks, and honeycomb.

if not combinatorica.is_domain_enabled("beekeeping") then return end

beekeeping = {}

core.register_node("beekeeping:beehive", {
    description = "Beehive",
    tiles = {"beekeeping_beehive_top.png", "beekeeping_beehive_bottom.png", "beekeeping_beehive_side.png",
             "beekeeping_beehive_side.png", "beekeeping_beehive_side.png", "beekeeping_beehive_front.png"},
    groups = {choppy = 2, flammable = 2},
    on_construct = function(pos)
        local meta = core.get_meta(pos)
        meta:set_int("honey_level", 0)
        meta:set_string("infotext", "Beehive (Empty)")
    end,
    on_rightclick = function(pos, node, clicker)
        local meta = core.get_meta(pos)
        local honey = meta:get_int("honey_level")
        if honey >= 5 then
            local inv = clicker:get_inventory()
            inv:add_item("main", "beekeeping:honeycomb")
            meta:set_int("honey_level", 0)
            meta:set_string("infotext", "Beehive (Empty)")
        end
    end,
})

-- Honey accumulation ABM
core.register_abm({
    label = "Beehive honey production",
    nodenames = {"beekeeping:beehive"},
    neighbors = {"group:flower"},
    interval = 60,
    chance = 3,
    action = function(pos)
        local meta = core.get_meta(pos)
        local honey = meta:get_int("honey_level")
        if honey < 5 then
            meta:set_int("honey_level", honey + 1)
            meta:set_string("infotext", "Beehive (Honey: " .. (honey + 1) .. "/5)")
        end
    end,
})

core.register_craftitem("beekeeping:honeycomb", {
    description = "Honeycomb",
    inventory_image = "beekeeping_honeycomb.png",
})

core.register_craftitem("beekeeping:honey_bottle", {
    description = "Honey Bottle",
    inventory_image = "beekeeping_honey_bottle.png",
    on_use = core.item_eat(6),
    groups = {food = 1},
})
combinatorica.register_food("beekeeping:honey_bottle", {satiation = 6})

core.register_node("beekeeping:honey_block", {
    description = "Honey Block",
    tiles = {"beekeeping_honey_block.png"},
    groups = {snappy = 3, fall_damage_add_percent = -80},
})

core.register_craft({
    output = "beekeeping:honey_bottle 4",
    recipe = {{"beekeeping:honeycomb"}},
})

core.log("action", "[beekeeping] Beekeeping loaded")
