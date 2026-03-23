-- Lanterns

core.register_node("lanterns:lantern", {
    description = "Lantern",
    tiles = {"lanterns_lantern.png"},
    drawtype = "nodebox",
    paramtype = "light",
    light_source = 14,
    groups = {cracky = 3, oddly_breakable_by_hand = 3},
    node_box = {type = "fixed", fixed = {-3/16, -0.5, -3/16, 3/16, 3/16, 3/16}},
})

core.register_node("lanterns:soul_lantern", {
    description = "Soul Lantern",
    tiles = {"lanterns_soul_lantern.png"},
    drawtype = "nodebox",
    paramtype = "light",
    light_source = 10,
    groups = {cracky = 3, oddly_breakable_by_hand = 3},
    node_box = {type = "fixed", fixed = {-3/16, -0.5, -3/16, 3/16, 3/16, 3/16}},
})

core.register_craft({output = "lanterns:lantern", recipe = {
    {"default:steel_ingot", "default:steel_ingot", "default:steel_ingot"},
    {"default:steel_ingot", "default:torch", "default:steel_ingot"},
    {"default:steel_ingot", "default:steel_ingot", "default:steel_ingot"},
}})

core.log("action", "[lanterns] Lanterns loaded")
