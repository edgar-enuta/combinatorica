-- Spawn
-- Manages spawn point placement and teleportation.

if not combinatorica.is_domain_enabled("spawn") then return end

local spawnpoint = core.settings:get("static_spawnpoint")

if spawnpoint then
    local parts = string.split(spawnpoint, ",")
    if #parts == 3 then
        spawnpoint = vector.new(
            tonumber(parts[1]) or 0,
            tonumber(parts[2]) or 0,
            tonumber(parts[3]) or 0
        )
    else
        spawnpoint = nil
    end
end

core.register_on_newplayer(function(player)
    if spawnpoint then
        player:set_pos(spawnpoint)
    end
end)

core.register_on_respawnplayer(function(player)
    if spawnpoint then
        player:set_pos(spawnpoint)
        return true
    end
    return false
end)

core.log("action", "[spawn] Spawn management loaded")
