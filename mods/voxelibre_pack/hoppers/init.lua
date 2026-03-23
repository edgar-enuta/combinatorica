-- Hoppers
-- Item transport and sorting.

core.register_node("hoppers:hopper", {
    description = "Hopper",
    tiles = {"hoppers_top.png", "hoppers_bottom.png", "hoppers_side.png"},
    groups = {cracky = 2},
    paramtype2 = "facedir",
    on_construct = function(pos)
        local meta = core.get_meta(pos)
        local inv = meta:get_inventory()
        inv:set_size("main", 5)
        meta:set_string("infotext", "Hopper")
    end,
})

-- Transfer items downward
core.register_abm({
    label = "Hopper transfer",
    nodenames = {"hoppers:hopper"},
    interval = 1,
    chance = 1,
    action = function(pos)
        local meta = core.get_meta(pos)
        local inv = meta:get_inventory()
        local below = vector.add(pos, vector.new(0, -1, 0))
        local below_node = core.get_node(below)
        local below_meta = core.get_meta(below)
        local below_inv = below_meta:get_inventory()
        if below_inv and below_inv:get_size("main") > 0 then
            for i = 1, inv:get_size("main") do
                local stack = inv:get_stack("main", i)
                if not stack:is_empty() then
                    local single = ItemStack(stack:get_name())
                    if below_inv:room_for_item("main", single) then
                        below_inv:add_item("main", single)
                        stack:take_item()
                        inv:set_stack("main", i, stack)
                        return
                    end
                end
            end
        end
    end,
})

core.register_craft({output = "hoppers:hopper", recipe = {
    {"default:steel_ingot", "", "default:steel_ingot"},
    {"default:steel_ingot", "default:steel_ingot", "default:steel_ingot"},
    {"", "default:steel_ingot", ""},
}})

core.log("action", "[hoppers] Hoppers loaded")
