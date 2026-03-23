-- Jukebox

core.register_node("jukebox:jukebox", {
    description = "Jukebox",
    tiles = {"jukebox_top.png", "jukebox_bottom.png", "jukebox_side.png"},
    groups = {choppy = 2, oddly_breakable_by_hand = 2, flammable = 2},
    on_rightclick = function(pos, node, clicker)
        local wielded = clicker:get_wielded_item()
        if core.get_item_group(wielded:get_name(), "music_disc") > 0 then
            core.chat_send_player(clicker:get_player_name(), "Now playing: " .. wielded:get_short_description())
            -- Sound playback would happen here with actual sound files
        end
    end,
})

core.register_craftitem("jukebox:music_disc_1", {
    description = "Music Disc",
    inventory_image = "jukebox_disc_1.png",
    stack_max = 1,
    groups = {music_disc = 1},
})

core.register_craft({output = "jukebox:jukebox", recipe = {
    {"default:wood", "default:wood", "default:wood"},
    {"default:wood", "default:diamond", "default:wood"},
    {"default:wood", "default:wood", "default:wood"},
}})

core.log("action", "[jukebox] Jukebox loaded")
