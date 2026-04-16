-- Beds
-- Sleep to skip night and set respawn point.

if not combinatorica.is_domain_enabled("beds") then return end

beds = {}
beds.player_beds = {}

function beds.register_bed(name, def)
    core.register_node(name .. "_bottom", {
        description = def.description or "Bed",
        drawtype = "nodebox",
        tiles = def.tiles and def.tiles.bottom or {"beds_bed_bottom.png"},
        paramtype = "light",
        paramtype2 = "facedir",
        groups = {choppy = 2, oddly_breakable_by_hand = 2, flammable = 3, bed = 1},
        node_box = {
            type = "fixed",
            fixed = {-0.5, -0.5, -0.5, 0.5, 0.06, 0.5},
        },
        on_rightclick = function(pos, node, clicker)
            local pname = clicker:get_player_name()
            beds.player_beds[pname] = pos
            combinatorica.emit("player_sleep", {player = pname, pos = pos})
            core.chat_send_player(pname, "Respawn point set.")
        end,
    })
end

beds.register_bed("beds:bed", {
    description = "Bed",
    tiles = {bottom = {"beds_bed_bottom.png"}},
})

core.register_craft({
    output = "beds:bed_bottom",
    recipe = {
        {"wool:white", "wool:white", "wool:white"},
        {"default:wood", "default:wood", "default:wood"},
    },
})

core.register_on_respawnplayer(function(player)
    local pname = player:get_player_name()
    local bed_pos = beds.player_beds[pname]
    if bed_pos then
        player:set_pos(bed_pos)
        return true
    end
    return false
end)

core.log("action", "[beds] Beds loaded")
