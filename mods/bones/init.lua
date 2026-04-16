-- Bones
-- Drops a bone node containing player inventory on death.

core.register_node("bones:bones", {
    description = "Bones",
    tiles = {
        "bones_top.png", "bones_bottom.png",
        "bones_side.png", "bones_side.png",
        "bones_rear.png", "bones_front.png",
    },
    paramtype2 = "facedir",
    groups = {dig_immediate = 2},
    on_construct = function(pos)
        local meta = core.get_meta(pos)
        local inv = meta:get_inventory()
        inv:set_size("main", 8 * 4)
    end,
    can_dig = function(pos, player)
        local meta = core.get_meta(pos)
        local inv = meta:get_inventory()
        return inv:is_empty("main")
    end,
})

core.register_on_dieplayer(function(player, reason)
    local pos = vector.round(player:get_pos())
    local inv = player:get_inventory()

    -- Place bones
    core.set_node(pos, {name = "bones:bones", param2 = 0})
    local bone_meta = core.get_meta(pos)
    local bone_inv = bone_meta:get_inventory()
    bone_inv:set_size("main", 8 * 4)

    -- Move items to bones
    for i = 1, inv:get_size("main") do
        local stack = inv:get_stack("main", i)
        if not stack:is_empty() then
            bone_inv:add_item("main", stack)
            inv:set_stack("main", i, ItemStack(""))
        end
    end

    bone_meta:set_string("owner", player:get_player_name())
    bone_meta:set_string("infotext", player:get_player_name() .. "'s bones")

    combinatorica.emit("player_died", {
        player = player:get_player_name(),
        pos = pos,
        reason = reason,
    })
end)

core.log("action", "[bones] Bones loaded")
