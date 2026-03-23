-- Experience System
-- XP orbs, levels, and experience management.

experience = {}
local player_xp = {}

local XP_PER_LEVEL = 10

function experience.get_xp(player_name)
    return player_xp[player_name] or 0
end

function experience.get_level(player_name)
    return math.floor(experience.get_xp(player_name) / XP_PER_LEVEL)
end

function experience.add_xp(player_name, amount)
    local old_level = experience.get_level(player_name)
    player_xp[player_name] = (player_xp[player_name] or 0) + amount
    local new_level = experience.get_level(player_name)
    if new_level > old_level then
        combinatorica.emit("player_levelup", {player = player_name, level = new_level})
    end
    combinatorica.emit("xp_changed", {player = player_name, xp = player_xp[player_name], level = new_level})
end

function experience.set_xp(player_name, amount)
    player_xp[player_name] = math.max(0, amount)
end

-- Award XP on mob kill
combinatorica.on("mob_died", function(data)
    if data.killer then
        experience.add_xp(data.killer, 5)
    end
end)

-- Award XP on mining ores
combinatorica.on("player_mined_ore", function(data)
    if data.player then
        experience.add_xp(data.player, 2)
    end
end)

-- Register XP HUD bar
if combinatorica.is_enabled("hudbars") then
    hudbars.register_bar("experience", {
        label = "XP",
        color = "#00FF00",
        max = XP_PER_LEVEL,
        icon = "experience_icon.png",
    })
end

core.register_on_joinplayer(function(player)
    player_xp[player:get_player_name()] = 0
end)

core.register_on_leaveplayer(function(player)
    player_xp[player:get_player_name()] = nil
end)

core.log("action", "[experience] XP system loaded")
