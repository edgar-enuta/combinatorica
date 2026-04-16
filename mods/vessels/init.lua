-- Vessels
-- Glass bottles, drinking glasses, and display shelves.

core.register_craftitem("vessels:glass_bottle", {
    description = "Empty Glass Bottle",
    inventory_image = "vessels_glass_bottle.png",
    groups = {vessel = 1},
})

core.register_craftitem("vessels:drinking_glass", {
    description = "Empty Drinking Glass",
    inventory_image = "vessels_drinking_glass.png",
    groups = {vessel = 1},
})

core.register_node("vessels:shelf", {
    description = "Vessels Shelf",
    tiles = {"default_wood.png", "default_wood.png", "vessels_shelf.png"},
    groups = {choppy = 3, oddly_breakable_by_hand = 2, flammable = 3},
    on_construct = function(pos)
        local meta = core.get_meta(pos)
        local inv = meta:get_inventory()
        inv:set_size("vessels", 8 * 2)
    end,
})

core.register_craft({
    output = "vessels:glass_bottle 10",
    recipe = {
        {"default:glass", "", "default:glass"},
        {"default:glass", "", "default:glass"},
        {"", "default:glass", ""},
    },
})

core.log("action", "[vessels] Vessels loaded")
