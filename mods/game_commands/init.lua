-- Game Commands
-- Provides gameplay-related chat commands.

if not combinatorica.is_domain_enabled("game_commands") then return end

core.register_chatcommand("killme", {
    description = "Kill yourself to respawn",
    func = function(name)
        local player = core.get_player_by_name(name)
        if player then
            player:set_hp(0, "killme command")
            return true, "You are dead."
        end
        return false, "Player not found."
    end,
})

core.register_chatcommand("clearinv", {
    description = "Clear your inventory",
    privs = {server = true},
    func = function(name)
        local player = core.get_player_by_name(name)
        if player then
            player:get_inventory():set_list("main", {})
            return true, "Inventory cleared."
        end
        return false, "Player not found."
    end,
})

core.log("action", "[game_commands] Commands loaded")
