-- Hunger
-- Hunger bar and satiation system.

if not combinatorica.features.hunger then
    core.log("action", "[hunger] Hunger disabled by feature flag")
    return
end

hunger = {}
local player_hunger = {}

local MAX_HUNGER = 20
local HUNGER_TICK = 2.0
local EXHAUST_MOVE = 0.01
local EXHAUST_DIG = 0.025

function hunger.get(player_name)
    return player_hunger[player_name] or MAX_HUNGER
end

function hunger.set(player_name, value)
    player_hunger[player_name] = math.max(0, math.min(MAX_HUNGER, value))
    combinatorica.emit("hunger_changed", {
        player = player_name,
        hunger = player_hunger[player_name],
    })
end

function hunger.feed(player_name, amount)
    hunger.set(player_name, hunger.get(player_name) + amount)
    combinatorica.emit("player_ate", {
        player = player_name,
        amount = amount,
    })
end

-- Initialize on join
core.register_on_joinplayer(function(player)
    local pname = player:get_player_name()
    player_hunger[pname] = MAX_HUNGER
end)

core.register_on_leaveplayer(function(player)
    player_hunger[player:get_player_name()] = nil
end)

-- Hunger tick
local timer = 0
core.register_globalstep(function(dtime)
    timer = timer + dtime
    if timer < HUNGER_TICK then return end
    timer = 0

    for _, player in ipairs(core.get_connected_players()) do
        local pname = player:get_player_name()
        local h = hunger.get(pname)

        -- Slow exhaustion
        hunger.set(pname, h - EXHAUST_MOVE)

        -- Health effects
        if h <= 0 then
            local hp = player:get_hp()
            if hp > 0 then
                player:set_hp(hp - 1, "hunger")
            end
        elseif h >= MAX_HUNGER * 0.8 then
            local hp = player:get_hp()
            local max_hp = player:get_properties().hp_max
            if hp < max_hp then
                player:set_hp(hp + 1, "satiated_regen")
            end
        end
    end
end)

-- Integrate with food items
combinatorica.on("food_registered", function(data)
    local old_on_use = core.registered_craftitems[data.item]
        and core.registered_craftitems[data.item].on_use
    -- Food items use the combinatorica food registry for hunger integration
end)

core.log("action", "[hunger] Hunger system loaded")
