-- Screwdriver
-- Node rotation tool.

core.register_tool("screwdriver:screwdriver", {
    description = "Screwdriver (rotate nodes)",
    inventory_image = "screwdriver.png",
    on_use = function(itemstack, user, pointed_thing)
        if pointed_thing.type ~= "node" then return end
        local pos = pointed_thing.under
        local node = core.get_node(pos)
        local ndef = core.registered_nodes[node.name]
        if not ndef or not ndef.paramtype2 or ndef.paramtype2 ~= "facedir" then
            return
        end
        node.param2 = (node.param2 + 1) % 4
        core.swap_node(pos, node)
        itemstack:add_wear(65535 / 200)
        return itemstack
    end,
})

core.register_craft({
    output = "screwdriver:screwdriver",
    recipe = {
        {"default:steel_ingot"},
        {"default:stick"},
    },
})

core.log("action", "[screwdriver] Screwdriver loaded")
