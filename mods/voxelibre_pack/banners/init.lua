-- Banners
-- Decorative banners with customizable patterns.

if not combinatorica.is_domain_enabled("banners") then return end

banners = {}

local colors = {"white","grey","dark_grey","black","red","orange","yellow","green","dark_green","blue","cyan","violet","magenta","pink","brown"}

for _, color in ipairs(colors) do
    local desc = color:gsub("_", " "):gsub("(%a)([%w_']*)", function(a, b) return a:upper() .. b end)
    core.register_node("banners:banner_" .. color, {
        description = desc .. " Banner",
        drawtype = "signlike",
        tiles = {"banners_" .. color .. ".png"},
        paramtype = "light",
        paramtype2 = "wallmounted",
        walkable = false,
        groups = {choppy = 2, attached_node = 1, flammable = 2, banner = 1},
        selection_box = {type = "wallmounted"},
    })
    core.register_craft({output = "banners:banner_" .. color, recipe = {
        {"wool:" .. color, "wool:" .. color, "wool:" .. color},
        {"wool:" .. color, "wool:" .. color, "wool:" .. color},
        {"", "default:stick", ""},
    }})
end

core.log("action", "[banners] Banners loaded")
