-- Set Home
-- /sethome and /home commands.

local homes = {}

core.register_chatcommand("sethome", {
    description = "Set your home position",
    func = function(name)
        local player = core.get_player_by_name(name)
        if not player then return false end
        homes[name] = player:get_pos()
        return true, "Home set."
    end,
})

core.register_chatcommand("home", {
    description = "Teleport to your home",
    func = function(name)
        local player = core.get_player_by_name(name)
        if not player then return false end
        local home = homes[name]
        if not home then
            return false, "No home set. Use /sethome first."
        end
        player:set_pos(home)
        return true, "Teleported home."
    end,
})

core.log("action", "[sethome] Home system loaded")
