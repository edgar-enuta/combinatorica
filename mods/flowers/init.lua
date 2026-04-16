-- Flowers
-- Decorative flower nodes and mapgen decoration.

if not combinatorica.is_domain_enabled("flowers") then return end

local flowers_list = {
    {"rose", "Red Rose"},
    {"tulip", "Orange Tulip"},
    {"dandelion_yellow", "Yellow Dandelion"},
    {"chrysanthemum_green", "Green Chrysanthemum"},
    {"geranium", "Blue Geranium"},
    {"viola", "Viola"},
    {"dandelion_white", "White Dandelion"},
    {"tulip_black", "Black Tulip"},
}

for _, flower in ipairs(flowers_list) do
    local name, desc = flower[1], flower[2]
    core.register_node("flowers:" .. name, {
        description = desc,
        drawtype = "plantlike",
        tiles = {"flowers_" .. name .. ".png"},
        paramtype = "light",
        sunlight_propagates = true,
        walkable = false,
        buildable_to = true,
        groups = {snappy = 3, flower = 1, flora = 1, attached_node = 1, flammable = 1, compostable = 1},
        selection_box = {
            type = "fixed",
            fixed = {-4 / 16, -0.5, -4 / 16, 4 / 16, 5 / 16, 4 / 16},
        },
    })

    core.register_decoration({
        name = "flowers:" .. name,
        deco_type = "simple",
        place_on = {"default:dirt_with_grass"},
        sidelen = 16,
        noise_params = {
            offset = -0.02,
            scale = 0.04,
            spread = {x = 200, y = 200, z = 200},
            seed = 436 + _,
            octaves = 3,
            persist = 0.6,
        },
        y_min = 1,
        y_max = 31000,
        decoration = "flowers:" .. name,
    })
end

core.log("action", "[flowers] Flowers loaded")
