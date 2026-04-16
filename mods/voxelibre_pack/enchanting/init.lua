-- Enchanting
-- Enchantment table, enchantment registration, and tool/armor enchanting.

if not combinatorica.is_domain_enabled("enchanting") then return end

enchanting = {}
enchanting.registered_enchantments = {}

-- Register an enchantment.
function enchanting.register(name, def)
    enchanting.registered_enchantments[name] = {
        description = def.description or name,
        max_level = def.max_level or 3,
        applies_to = def.applies_to or {},  -- e.g. {"pick", "sword"}
        modifier = def.modifier or function() end,
        xp_cost = def.xp_cost or 5,
    }
end

-- Apply an enchantment to an itemstack.
function enchanting.enchant(itemstack, enchantment_name, level)
    local ench = enchanting.registered_enchantments[enchantment_name]
    if not ench then return false end
    level = math.min(level, ench.max_level)
    local meta = itemstack:get_meta()
    local enchants = core.deserialize(meta:get_string("enchantments")) or {}
    enchants[enchantment_name] = level
    meta:set_string("enchantments", core.serialize(enchants))
    -- Update description
    local desc = itemstack:get_short_description() or ""
    meta:set_string("description", desc .. "\n" .. ench.description .. " " .. tostring(level))
    return true
end

-- Get enchantments on an item.
function enchanting.get_enchantments(itemstack)
    local meta = itemstack:get_meta()
    return core.deserialize(meta:get_string("enchantments")) or {}
end

-- Default enchantments
enchanting.register("sharpness", {
    description = "Sharpness",
    max_level = 5,
    applies_to = {"sword", "axe"},
    xp_cost = 3,
})

enchanting.register("efficiency", {
    description = "Efficiency",
    max_level = 5,
    applies_to = {"pick", "shovel", "axe"},
    xp_cost = 3,
})

enchanting.register("unbreaking", {
    description = "Unbreaking",
    max_level = 3,
    applies_to = {"pick", "shovel", "axe", "sword", "armor"},
    xp_cost = 5,
})

enchanting.register("fortune", {
    description = "Fortune",
    max_level = 3,
    applies_to = {"pick"},
    xp_cost = 8,
})

enchanting.register("protection", {
    description = "Protection",
    max_level = 4,
    applies_to = {"armor"},
    xp_cost = 5,
})

enchanting.register("fire_aspect", {
    description = "Fire Aspect",
    max_level = 2,
    applies_to = {"sword"},
    xp_cost = 6,
})

-- Enchantment table
core.register_node("enchanting:table", {
    description = "Enchantment Table",
    tiles = {"enchanting_table_top.png", "enchanting_table_bottom.png", "enchanting_table_side.png"},
    groups = {cracky = 1, level = 2},
    light_source = 7,
    on_rightclick = function(pos, node, clicker)
        local pname = clicker:get_player_name()
        local level = experience.get_level(pname)
        local fs = "size[8,6]"
            .. "label[0,0;Enchantment Table]"
            .. "label[0,0.5;Your level: " .. level .. "]"
            .. "list[current_player;main;0,2;8,1;]"
            .. "list[current_player;main;0,3.25;8,3;8]"
        core.show_formspec(pname, "enchanting:table", fs)
    end,
})

core.register_craft({
    output = "enchanting:table",
    recipe = {
        {"", "default:book", ""},
        {"default:diamond", "default:obsidian", "default:diamond"},
        {"default:obsidian", "default:obsidian", "default:obsidian"},
    },
})

core.log("action", "[enchanting] Enchanting system loaded")
