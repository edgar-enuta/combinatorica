-- Potions & Brewing
-- Brewing stand, potion effects, and status effect system.

if not combinatorica.is_domain_enabled("potions") then return end

potions = {}
potions.registered_effects = {}
potions.registered_potions = {}
local player_effects = {}

-- Register a status effect.
function potions.register_effect(name, def)
    potions.registered_effects[name] = {
        description = def.description or name,
        icon = def.icon,
        on_apply = def.on_apply or function() end,
        on_tick = def.on_tick or function() end,
        on_remove = def.on_remove or function() end,
    }
end

-- Apply a status effect to a player.
function potions.apply_effect(player_name, effect_name, duration, level)
    if not potions.registered_effects[effect_name] then return end
    if not player_effects[player_name] then player_effects[player_name] = {} end
    player_effects[player_name][effect_name] = {
        remaining = duration,
        level = level or 1,
    }
    potions.registered_effects[effect_name].on_apply(player_name, level or 1)
    combinatorica.emit("effect_applied", {player = player_name, effect = effect_name, duration = duration, level = level})
end

-- Register a potion item.
function potions.register_potion(name, def)
    potions.registered_potions[name] = def

    core.register_craftitem("potions:" .. name, {
        description = def.description or name,
        inventory_image = def.inventory_image or "potions_" .. name .. ".png",
        stack_max = 1,
        on_use = function(itemstack, user)
            local pname = user:get_player_name()
            for _, effect in ipairs(def.effects or {}) do
                potions.apply_effect(pname, effect.name, effect.duration or 60, effect.level or 1)
            end
            return ItemStack("vessels:glass_bottle")
        end,
        groups = {potion = 1},
    })
end

-- Effect tick
local timer = 0
core.register_globalstep(function(dtime)
    timer = timer + dtime
    if timer < 1 then return end
    timer = 0
    for pname, effects in pairs(player_effects) do
        for ename, data in pairs(effects) do
            data.remaining = data.remaining - 1
            local edef = potions.registered_effects[ename]
            if edef then edef.on_tick(pname, data.level) end
            if data.remaining <= 0 then
                if edef then edef.on_remove(pname) end
                effects[ename] = nil
            end
        end
    end
end)

-- Default effects
potions.register_effect("speed", {
    description = "Speed",
    on_apply = function(pname, level)
        local player = core.get_player_by_name(pname)
        if player then player:set_physics_override({speed = 1 + level * 0.2}) end
    end,
    on_remove = function(pname)
        local player = core.get_player_by_name(pname)
        if player then player:set_physics_override({speed = 1}) end
    end,
})

potions.register_effect("regeneration", {
    description = "Regeneration",
    on_tick = function(pname, level)
        local player = core.get_player_by_name(pname)
        if player then
            local hp = player:get_hp()
            local max_hp = player:get_properties().hp_max
            if hp < max_hp then player:set_hp(math.min(hp + level, max_hp)) end
        end
    end,
})

potions.register_effect("strength", {description = "Strength"})
potions.register_effect("night_vision", {description = "Night Vision"})
potions.register_effect("fire_resistance", {description = "Fire Resistance"})
potions.register_effect("water_breathing", {description = "Water Breathing"})
potions.register_effect("invisibility", {description = "Invisibility"})
potions.register_effect("poison", {
    description = "Poison",
    on_tick = function(pname, level)
        local player = core.get_player_by_name(pname)
        if player then
            local hp = player:get_hp()
            if hp > 1 then player:set_hp(hp - 1) end
        end
    end,
})

-- Default potions
potions.register_potion("speed", {
    description = "Potion of Speed",
    effects = {{name = "speed", duration = 180, level = 1}},
})

potions.register_potion("healing", {
    description = "Potion of Healing",
    effects = {{name = "regeneration", duration = 30, level = 2}},
})

potions.register_potion("strength", {
    description = "Potion of Strength",
    effects = {{name = "strength", duration = 180, level = 1}},
})

potions.register_potion("night_vision", {
    description = "Potion of Night Vision",
    effects = {{name = "night_vision", duration = 180, level = 1}},
})

potions.register_potion("fire_resistance", {
    description = "Potion of Fire Resistance",
    effects = {{name = "fire_resistance", duration = 180, level = 1}},
})

potions.register_potion("poison", {
    description = "Potion of Poison",
    effects = {{name = "poison", duration = 45, level = 1}},
})

-- Brewing stand
core.register_node("potions:brewing_stand", {
    description = "Brewing Stand",
    tiles = {"potions_brewing_stand_top.png", "potions_brewing_stand_bottom.png", "potions_brewing_stand_side.png"},
    groups = {cracky = 2},
    on_construct = function(pos)
        local meta = core.get_meta(pos)
        local inv = meta:get_inventory()
        inv:set_size("input", 1)
        inv:set_size("fuel", 1)
        inv:set_size("output", 3)
        meta:set_string("infotext", "Brewing Stand")
    end,
})

core.register_craft({
    output = "potions:brewing_stand",
    recipe = {
        {"", "default:stick", ""},
        {"default:cobble", "default:cobble", "default:cobble"},
    },
})

core.register_on_leaveplayer(function(player)
    player_effects[player:get_player_name()] = nil
end)

core.log("action", "[potions] Potions & brewing loaded")
