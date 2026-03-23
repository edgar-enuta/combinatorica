-- TNT
-- Explosive blocks with blast radius.

tnt = {}

function tnt.boom(pos, def)
    local radius = def.radius or 3
    combinatorica.emit("explosion", {pos = pos, radius = radius})

    -- Remove nodes in blast radius
    for x = -radius, radius do
        for y = -radius, radius do
            for z = -radius, radius do
                local p = vector.add(pos, vector.new(x, y, z))
                if vector.distance(pos, p) <= radius then
                    local node = core.get_node(p)
                    if node.name ~= "air" and node.name ~= "ignore" then
                        local ndef = core.registered_nodes[node.name]
                        if ndef and not (ndef.groups and ndef.groups.unbreakable) then
                            core.remove_node(p)
                        end
                    end
                end
            end
        end
    end
end

core.register_node("tnt:tnt", {
    description = "TNT",
    tiles = {"tnt_top.png", "tnt_bottom.png", "tnt_side.png"},
    groups = {dig_immediate = 2, mesecon_effector_on = 1, tnt = 1, flammable = 1},
    on_punch = function(pos, node, puncher)
        core.after(4, function()
            core.remove_node(pos)
            tnt.boom(pos, {radius = 3})
        end)
        core.chat_send_player(puncher:get_player_name(), "TNT ignited!")
    end,
})

core.register_craft({
    output = "tnt:tnt",
    recipe = {
        {"", "default:sand", ""},
        {"default:sand", "default:coal_lump", "default:sand"},
        {"", "default:sand", ""},
    },
})

core.log("action", "[tnt] TNT loaded")
