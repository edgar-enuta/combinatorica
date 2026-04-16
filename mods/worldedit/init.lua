-- WorldEdit
-- In-game world editing commands for admins and creative mode.
-- This is a stub; the full WorldEdit mod will be integrated as a dependency.

worldedit = {}

-- Placeholder: position storage per player
worldedit.pos1 = {}
worldedit.pos2 = {}

core.register_chatcommand("we_pos1", {
    description = "Set WorldEdit position 1",
    privs = {worldedit = true},
    func = function(name, param)
        local player = core.get_player_by_name(name)
        if not player then return false end
        worldedit.pos1[name] = vector.round(player:get_pos())
        return true, "Position 1 set to " .. core.pos_to_string(worldedit.pos1[name])
    end,
})

core.register_chatcommand("we_pos2", {
    description = "Set WorldEdit position 2",
    privs = {worldedit = true},
    func = function(name, param)
        local player = core.get_player_by_name(name)
        if not player then return false end
        worldedit.pos2[name] = vector.round(player:get_pos())
        return true, "Position 2 set to " .. core.pos_to_string(worldedit.pos2[name])
    end,
})

core.log("action", "[worldedit] WorldEdit stub loaded")
