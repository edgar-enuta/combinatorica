-- Environmental Sounds
-- Plays ambient sounds based on player surroundings.

local SOUND_INTERVAL = 2.0

local function get_ambience(player)
    local pos = player:get_pos()
    if not pos then return nil end

    -- Check if underwater
    local head_pos = vector.new(pos.x, pos.y + 1.4, pos.z)
    local head_node = core.get_node(head_pos)
    if core.get_item_group(head_node.name, "water") > 0 then
        return "env_sounds_underwater"
    end

    -- Check if underground
    if pos.y < -10 then
        return "env_sounds_cave"
    end

    return nil
end

local timer = 0
core.register_globalstep(function(dtime)
    timer = timer + dtime
    if timer < SOUND_INTERVAL then return end
    timer = 0

    for _, player in ipairs(core.get_connected_players()) do
        local sound = get_ambience(player)
        -- Sound playback would happen here with actual sound files
    end
end)

core.log("action", "[env_sounds] Environmental sounds loaded")
