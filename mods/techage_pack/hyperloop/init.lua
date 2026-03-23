-- Hyperloop
-- Fast transportation tube system.

hyperloop = {}

core.register_node("hyperloop:tube", {
    description = "Hyperloop Tube",
    tiles = {"hyperloop_tube.png"},
    groups = {cracky = 2, techage_tier = 4},
    paramtype2 = "facedir",
})

core.register_node("hyperloop:station", {
    description = "Hyperloop Station",
    tiles = {"hyperloop_station_top.png", "hyperloop_station_bottom.png", "hyperloop_station_side.png"},
    groups = {cracky = 2, techage_tier = 4},
    on_rightclick = function(pos, node, clicker)
        core.chat_send_player(clicker:get_player_name(), "Hyperloop Station — set destination to travel.")
    end,
})

core.log("action", "[hyperloop] Hyperloop loaded")
