-- Boats
-- Craftable boats for water travel.

boats = {}

core.register_craftitem("boats:boat", {
    description = "Boat",
    inventory_image = "boats_inventory.png",
    on_place = function(itemstack, placer, pointed_thing)
        if pointed_thing.type ~= "node" then return end
        local pos = pointed_thing.above
        local node_under = core.get_node(pointed_thing.under)
        if core.get_item_group(node_under.name, "water") > 0 then
            core.add_entity(pos, "boats:boat_entity")
            itemstack:take_item()
        end
        return itemstack
    end,
})

core.register_craft({
    output = "boats:boat",
    recipe = {
        {"", "", ""},
        {"default:wood", "", "default:wood"},
        {"default:wood", "default:wood", "default:wood"},
    },
})

core.log("action", "[boats] Boats loaded")
