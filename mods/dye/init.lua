-- Dye
-- Craftable dyes from flowers and other materials.

dye = {}

local dye_colors = {
    {"white",      "White"},
    {"grey",       "Grey"},
    {"dark_grey",  "Dark Grey"},
    {"black",      "Black"},
    {"red",        "Red"},
    {"orange",     "Orange"},
    {"yellow",     "Yellow"},
    {"green",      "Green"},
    {"dark_green", "Dark Green"},
    {"blue",       "Blue"},
    {"cyan",       "Cyan"},
    {"violet",     "Violet"},
    {"magenta",    "Magenta"},
    {"pink",       "Pink"},
    {"brown",      "Brown"},
}

for _, entry in ipairs(dye_colors) do
    local name, desc = entry[1], entry[2]
    core.register_craftitem("dye:" .. name, {
        description = desc .. " Dye",
        inventory_image = "dye_" .. name .. ".png",
        groups = {dye = 1},
    })
end

-- Flower-based dye recipes
combinatorica.register_on_mod_loaded("flowers", function()
    core.register_craft({type = "shapeless", output = "dye:red", recipe = {"flowers:rose"}})
    core.register_craft({type = "shapeless", output = "dye:yellow", recipe = {"flowers:dandelion_yellow"}})
    core.register_craft({type = "shapeless", output = "dye:blue", recipe = {"flowers:geranium"}})
    core.register_craft({type = "shapeless", output = "dye:violet", recipe = {"flowers:viola"}})
    core.register_craft({type = "shapeless", output = "dye:white", recipe = {"flowers:dandelion_white"}})
    core.register_craft({type = "shapeless", output = "dye:orange", recipe = {"flowers:tulip"}})
end)

core.log("action", "[dye] Dye system loaded")
