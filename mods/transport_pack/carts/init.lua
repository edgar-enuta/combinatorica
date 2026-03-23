-- Minecarts
-- Rail system with rideable minecarts.

carts = {}

core.register_node("carts:rail", {
    description = "Rail",
    drawtype = "raillike",
    tiles = {"carts_rail_straight.png", "carts_rail_curved.png", "carts_rail_t_junction.png", "carts_rail_crossing.png"},
    paramtype = "light",
    sunlight_propagates = true,
    walkable = false,
    selection_box = {type = "fixed", fixed = {-1/2, -1/2, -1/2, 1/2, -1/2+1/16, 1/2}},
    groups = {dig_immediate = 2, attached_node = 1, rail = 1, connect_to_raillike = core.raillike_group("rail")},
})

core.register_node("carts:powerrail", {
    description = "Powered Rail",
    drawtype = "raillike",
    tiles = {"carts_rail_straight_pwr.png", "carts_rail_curved_pwr.png", "carts_rail_t_junction_pwr.png", "carts_rail_crossing_pwr.png"},
    paramtype = "light",
    sunlight_propagates = true,
    walkable = false,
    selection_box = {type = "fixed", fixed = {-1/2, -1/2, -1/2, 1/2, -1/2+1/16, 1/2}},
    groups = {dig_immediate = 2, attached_node = 1, rail = 1, connect_to_raillike = core.raillike_group("rail")},
})

core.register_craftitem("carts:cart", {
    description = "Minecart",
    inventory_image = "carts_cart.png",
    on_place = function(itemstack, placer, pointed_thing)
        if pointed_thing.type ~= "node" then return end
        local pos = pointed_thing.above
        local node = core.get_node(pointed_thing.under)
        if core.get_item_group(node.name, "rail") > 0 then
            core.add_entity(pointed_thing.under, "carts:cart_entity")
            itemstack:take_item()
        end
        return itemstack
    end,
})

core.register_craft({
    output = "carts:cart",
    recipe = {
        {"default:steel_ingot", "", "default:steel_ingot"},
        {"default:steel_ingot", "default:steel_ingot", "default:steel_ingot"},
    },
})

core.register_craft({
    output = "carts:rail 16",
    recipe = {
        {"default:steel_ingot", "", "default:steel_ingot"},
        {"default:steel_ingot", "default:stick", "default:steel_ingot"},
        {"default:steel_ingot", "", "default:steel_ingot"},
    },
})

core.log("action", "[carts] Minecarts loaded")
