-- Keys
-- Key items for locked doors and chests.

core.register_craftitem("keys:key", {
    description = "Key",
    inventory_image = "keys_key.png",
    groups = {key = 1, not_in_creative_inventory = 1},
    stack_max = 1,
    on_use = function(itemstack, user, pointed_thing)
        if pointed_thing.type ~= "node" then return end
        local pos = pointed_thing.under
        local node = core.get_node(pos)
        local ndef = core.registered_nodes[node.name]
        if ndef and ndef.on_key_use then
            ndef.on_key_use(pos, user, itemstack)
        end
    end,
})

core.register_craftitem("keys:skeleton_key", {
    description = "Skeleton Key",
    inventory_image = "keys_skeleton_key.png",
    groups = {key = 2},
    stack_max = 1,
})

core.register_craft({
    output = "keys:skeleton_key",
    recipe = {
        {"default:gold_ingot"},
    },
})

core.log("action", "[keys] Key system loaded")
