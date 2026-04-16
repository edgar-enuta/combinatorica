-- Bonemeal
-- Growth acceleration for plants and saplings.

bonemeal = {}

-- Apply bonemeal to a position, growing the plant if applicable.
function bonemeal.on_use(pos)
    local node = core.get_node(pos)

    -- Check if it's a growing crop
    local current_stage = tonumber(node.name:match("_(%d+)$"))
    if current_stage then
        local base_name = node.name:match("^(.+)_%d+$")
        local next_name = base_name .. "_" .. (current_stage + 1)
        if core.registered_nodes[next_name] then
            core.set_node(pos, {name = next_name})
            return true
        end
    end

    -- Check if it's a sapling
    if core.get_item_group(node.name, "sapling") > 0 then
        combinatorica.emit("bonemeal_sapling", {pos = pos, node = node})
        return true
    end

    return false
end

core.register_craftitem("bonemeal:bone", {
    description = "Bone",
    inventory_image = "bonemeal_bone.png",
})

core.register_craftitem("bonemeal:bonemeal", {
    description = "Bonemeal",
    inventory_image = "bonemeal_bonemeal.png",
    on_use = function(itemstack, user, pointed_thing)
        if pointed_thing.type ~= "node" then return end
        if bonemeal.on_use(pointed_thing.under) then
            itemstack:take_item()
        end
        return itemstack
    end,
})

core.register_craft({
    output = "bonemeal:bonemeal 4",
    recipe = {{"bonemeal:bone"}},
})

core.log("action", "[bonemeal] Bonemeal loaded")
