-- Composters

if not combinatorica.is_domain_enabled("composters") then return end

core.register_node("composters:composter", {
    description = "Composter",
    tiles = {"composters_top.png", "composters_bottom.png", "composters_side.png"},
    groups = {choppy = 2, oddly_breakable_by_hand = 2, flammable = 2},
    on_construct = function(pos)
        local meta = core.get_meta(pos)
        meta:set_int("compost_level", 0)
        meta:set_string("infotext", "Composter (0/7)")
    end,
    on_rightclick = function(pos, node, clicker)
        local meta = core.get_meta(pos)
        local level = meta:get_int("compost_level")
        local wielded = clicker:get_wielded_item()
        if level >= 7 then
            local inv = clicker:get_inventory()
            if combinatorica.is_enabled("bonemeal") then
                inv:add_item("main", "bonemeal:bonemeal")
            end
            meta:set_int("compost_level", 0)
            meta:set_string("infotext", "Composter (0/7)")
        elseif core.get_item_group(wielded:get_name(), "compostable") > 0 then
            wielded:take_item()
            clicker:set_wielded_item(wielded)
            level = level + 1
            meta:set_int("compost_level", level)
            meta:set_string("infotext", "Composter (" .. level .. "/7)")
        end
    end,
})

core.register_craft({output = "composters:composter", recipe = {
    {"default:wood", "", "default:wood"},
    {"default:wood", "", "default:wood"},
    {"default:wood", "default:wood", "default:wood"},
}})

core.log("action", "[composters] Composters loaded")
