-- Default Tools
-- Picks, shovels, axes, swords across material tiers.

local materials = {
    { name = "wood",    desc = "Wooden",  groups = {flammable = 2},
      pick = {maxlevel = 1, uses = 10, times = {[1] = 3.0, [2] = 1.6, [3] = 0.6}},
      shovel = {maxlevel = 1, uses = 10, times = {[1] = 1.5, [2] = 0.9, [3] = 0.4}},
      axe = {maxlevel = 1, uses = 10, times = {[1] = 2.5, [2] = 1.4, [3] = 0.6}},
      sword = {maxlevel = 1, uses = 10, times = {[1] = 2.5, [2] = 1.2, [3] = 0.35}},
      damage = 2 },
    { name = "stone",   desc = "Stone",   groups = {},
      pick = {maxlevel = 3, uses = 20, times = {[1] = 2.0, [2] = 1.2, [3] = 0.5}},
      shovel = {maxlevel = 1, uses = 20, times = {[1] = 1.2, [2] = 0.7, [3] = 0.35}},
      axe = {maxlevel = 1, uses = 20, times = {[1] = 2.0, [2] = 1.0, [3] = 0.5}},
      sword = {maxlevel = 1, uses = 20, times = {[1] = 2.0, [2] = 0.9, [3] = 0.3}},
      damage = 3 },
    { name = "steel",   desc = "Steel",   groups = {},
      pick = {maxlevel = 5, uses = 30, times = {[1] = 1.4, [2] = 0.8, [3] = 0.4}},
      shovel = {maxlevel = 1, uses = 30, times = {[1] = 1.0, [2] = 0.5, [3] = 0.3}},
      axe = {maxlevel = 2, uses = 30, times = {[1] = 1.5, [2] = 0.8, [3] = 0.4}},
      sword = {maxlevel = 2, uses = 30, times = {[1] = 1.5, [2] = 0.7, [3] = 0.25}},
      damage = 4 },
    { name = "diamond", desc = "Diamond", groups = {},
      pick = {maxlevel = 7, uses = 50, times = {[1] = 1.0, [2] = 0.5, [3] = 0.3}},
      shovel = {maxlevel = 1, uses = 50, times = {[1] = 0.8, [2] = 0.4, [3] = 0.2}},
      axe = {maxlevel = 2, uses = 50, times = {[1] = 1.0, [2] = 0.5, [3] = 0.3}},
      sword = {maxlevel = 2, uses = 50, times = {[1] = 1.0, [2] = 0.5, [3] = 0.2}},
      damage = 7 },
}

for _, mat in ipairs(materials) do
    -- Pickaxe
    core.register_tool("default:pick_" .. mat.name, {
        description = mat.desc .. " Pickaxe",
        inventory_image = "default_tool_" .. mat.name .. "pick.png",
        tool_capabilities = {
            full_punch_interval = 1.0,
            max_drop_level = mat.pick.maxlevel,
            groupcaps = {
                cracky = {times = mat.pick.times, uses = mat.pick.uses, maxlevel = mat.pick.maxlevel},
            },
            damage_groups = {fleshy = mat.damage},
        },
        groups = mat.groups,
    })

    -- Shovel
    core.register_tool("default:shovel_" .. mat.name, {
        description = mat.desc .. " Shovel",
        inventory_image = "default_tool_" .. mat.name .. "shovel.png",
        tool_capabilities = {
            full_punch_interval = 1.0,
            max_drop_level = mat.shovel.maxlevel,
            groupcaps = {
                crumbly = {times = mat.shovel.times, uses = mat.shovel.uses, maxlevel = mat.shovel.maxlevel},
            },
            damage_groups = {fleshy = mat.damage - 1},
        },
        groups = mat.groups,
    })

    -- Axe
    core.register_tool("default:axe_" .. mat.name, {
        description = mat.desc .. " Axe",
        inventory_image = "default_tool_" .. mat.name .. "axe.png",
        tool_capabilities = {
            full_punch_interval = 1.0,
            max_drop_level = mat.axe.maxlevel,
            groupcaps = {
                choppy = {times = mat.axe.times, uses = mat.axe.uses, maxlevel = mat.axe.maxlevel},
            },
            damage_groups = {fleshy = mat.damage},
        },
        groups = mat.groups,
    })

    -- Sword
    core.register_tool("default:sword_" .. mat.name, {
        description = mat.desc .. " Sword",
        inventory_image = "default_tool_" .. mat.name .. "sword.png",
        tool_capabilities = {
            full_punch_interval = 0.8,
            max_drop_level = mat.sword.maxlevel,
            groupcaps = {
                snappy = {times = mat.sword.times, uses = mat.sword.uses, maxlevel = mat.sword.maxlevel},
            },
            damage_groups = {fleshy = mat.damage + 1},
        },
        groups = mat.groups,
    })

    -- Register tools with combinatorica
    combinatorica.register_tool("default:pick_" .. mat.name, {material = mat.name, tool_type = "pick"})
    combinatorica.register_tool("default:shovel_" .. mat.name, {material = mat.name, tool_type = "shovel"})
    combinatorica.register_tool("default:axe_" .. mat.name, {material = mat.name, tool_type = "axe"})
    combinatorica.register_tool("default:sword_" .. mat.name, {material = mat.name, tool_type = "sword"})
end

core.log("action", "[default] Tools registered")
