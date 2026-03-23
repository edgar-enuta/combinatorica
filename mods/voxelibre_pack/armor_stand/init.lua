-- Armor Stand

core.register_node("armor_stand:armor_stand", {
    description = "Armor Stand",
    drawtype = "mesh",
    tiles = {"armor_stand.png"},
    paramtype = "light",
    paramtype2 = "facedir",
    groups = {cracky = 2, oddly_breakable_by_hand = 2},
    selection_box = {type = "fixed", fixed = {-0.3, -0.5, -0.3, 0.3, 1.5, 0.3}},
    on_construct = function(pos)
        local meta = core.get_meta(pos)
        local inv = meta:get_inventory()
        inv:set_size("armor", 4)
        meta:set_string("infotext", "Armor Stand")
    end,
})

core.register_craft({output = "armor_stand:armor_stand", recipe = {
    {"default:stick", "default:stick", "default:stick"},
    {"", "default:stick", ""},
    {"default:stick", "default:stick", "default:stick"},
}})

core.log("action", "[armor_stand] Armor stand loaded")
