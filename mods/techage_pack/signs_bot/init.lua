-- Signs Bot
-- Programmable robot that follows sign instructions.

if not combinatorica.features.techage then return end

signs_bot = {}

core.register_node("signs_bot:bot_box", {
    description = "Signs Bot Box",
    tiles = {"signs_bot_box_top.png", "signs_bot_box_bottom.png", "signs_bot_box_side.png"},
    groups = {cracky = 2, techage_tier = 2},
    on_construct = function(pos)
        local meta = core.get_meta(pos)
        meta:set_string("infotext", "Signs Bot Box (Stopped)")
        meta:set_string("program", "")
    end,
})

core.register_node("signs_bot:sign", {
    description = "Bot Control Sign",
    tiles = {"signs_bot_sign.png"},
    drawtype = "signlike",
    paramtype = "light",
    paramtype2 = "wallmounted",
    groups = {choppy = 2, attached_node = 1},
    selection_box = {type = "wallmounted"},
})

core.log("action", "[signs_bot] Signs Bot loaded")
