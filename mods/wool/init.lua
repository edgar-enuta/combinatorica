-- Wool
-- Colored wool blocks from dye + white wool.

if not combinatorica.is_domain_enabled("wool") then return end

local colors = {
    "white", "grey", "dark_grey", "black",
    "red", "orange", "yellow", "green",
    "dark_green", "blue", "cyan", "violet",
    "magenta", "pink", "brown",
}

for _, color in ipairs(colors) do
    local desc = color:gsub("_", " "):gsub("(%a)([%w_']*)", function(a, b) return a:upper() .. b end)
    core.register_node("wool:" .. color, {
        description = desc .. " Wool",
        tiles = {"wool_" .. color .. ".png"},
        groups = {snappy = 2, choppy = 2, oddly_breakable_by_hand = 3, flammable = 3, wool = 1},
    })

    if color ~= "white" then
        core.register_craft({
            type = "shapeless",
            output = "wool:" .. color,
            recipe = {"wool:white", "dye:" .. color},
        })
    end
end

core.log("action", "[wool] Wool loaded")
