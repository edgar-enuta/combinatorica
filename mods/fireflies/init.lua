-- Fireflies
-- Ambient glowing firefly nodes.

if not combinatorica.is_domain_enabled("fireflies") then return end

core.register_node("fireflies:firefly", {
    description = "Firefly",
    drawtype = "plantlike",
    tiles = {{
        name = "fireflies_firefly_animated.png",
        animation = {type = "vertical_frames", aspect_w = 16, aspect_h = 16, length = 1.5},
    }},
    paramtype = "light",
    light_source = 6,
    sunlight_propagates = true,
    walkable = false,
    buildable_to = true,
    floodable = true,
    groups = {catchable = 1, dig_immediate = 3},
    selection_box = {
        type = "fixed",
        fixed = {-3/16, -0.5, -3/16, 3/16, -2/16, 3/16},
    },
})

core.register_node("fireflies:firefly_bottle", {
    description = "Firefly in a Bottle",
    drawtype = "plantlike",
    tiles = {"fireflies_firefly_bottle.png"},
    paramtype = "light",
    light_source = 9,
    walkable = false,
    groups = {snappy = 3, dig_immediate = 3},
    selection_box = {
        type = "fixed",
        fixed = {-3/16, -0.5, -3/16, 3/16, 3/16, 3/16},
    },
})

core.log("action", "[fireflies] Fireflies loaded")
