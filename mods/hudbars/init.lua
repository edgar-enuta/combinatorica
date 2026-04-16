-- HUD Bars
-- Framework for custom HUD bars (health, hunger, armor, etc.)

if not combinatorica.is_domain_enabled("hudbars") then return end

hudbars = {}
hudbars.registered_bars = {}

local player_bars = {}

-- Register a HUD bar type.
function hudbars.register_bar(identifier, def)
    hudbars.registered_bars[identifier] = {
        label = def.label or identifier,
        color = def.color or "#FFFFFF",
        max = def.max or 20,
        get_value = def.get_value,
        icon = def.icon,
    }
end

-- Initialize bars for a player.
function hudbars.init_player(player)
    local pname = player:get_player_name()
    player_bars[pname] = {}

    for id, bar_def in pairs(hudbars.registered_bars) do
        -- Create HUD elements
        player_bars[pname][id] = {
            value = bar_def.max,
        }
    end
end

-- Update a bar's value.
function hudbars.set_value(player, identifier, value)
    local pname = player:get_player_name()
    if player_bars[pname] and player_bars[pname][identifier] then
        player_bars[pname][identifier].value = value
    end
end

-- Register health bar
hudbars.register_bar("health", {
    label = "Health",
    color = "#FF0000",
    max = 20,
    icon = "hudbars_icon_health.png",
})

core.register_on_joinplayer(function(player)
    hudbars.init_player(player)
end)

core.register_on_leaveplayer(function(player)
    player_bars[player:get_player_name()] = nil
end)

core.log("action", "[hudbars] HUD bars loaded")
