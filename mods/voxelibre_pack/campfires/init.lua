-- Campfires

core.register_node("campfires:campfire", {
    description = "Campfire",
    tiles = {"campfires_log.png"},
    drawtype = "mesh",
    light_source = 12,
    damage_per_second = 1,
    groups = {choppy = 2, oddly_breakable_by_hand = 2, flammable = 1},
    on_construct = function(pos)
        local meta = core.get_meta(pos)
        local inv = meta:get_inventory()
        inv:set_size("cooking", 4)
        meta:set_string("infotext", "Campfire")
    end,
})

core.register_craft({output = "campfires:campfire", recipe = {
    {"", "default:stick", ""},
    {"default:stick", "default:coal_lump", "default:stick"},
    {"default:tree", "default:tree", "default:tree"},
}})

core.log("action", "[campfires] Campfires loaded")
