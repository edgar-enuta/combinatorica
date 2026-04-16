-- Butterflies
-- Ambient decorative butterfly entities.

if not combinatorica.is_domain_enabled("butterflies") then return end

local butterfly_types = {"white", "red", "violet"}

for _, color in ipairs(butterfly_types) do
    core.register_node("butterflies:butterfly_" .. color, {
        description = color:gsub("^%l", string.upper) .. " Butterfly",
        drawtype = "plantlike",
        tiles = {{
            name = "butterflies_butterfly_" .. color .. "_animated.png",
            animation = {type = "vertical_frames", aspect_w = 16, aspect_h = 16, length = 3},
        }},
        paramtype = "light",
        sunlight_propagates = true,
        walkable = false,
        buildable_to = true,
        floodable = true,
        groups = {catchable = 1, dig_immediate = 3},
        selection_box = {
            type = "fixed",
            fixed = {-3/16, -0.5, -3/16, 3/16, 0, 3/16},
        },
    })
end

core.log("action", "[butterflies] Butterflies loaded")
