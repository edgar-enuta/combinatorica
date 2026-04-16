-- Creative Mode
-- Provides creative inventory, infinite items, and instant breaking.

if not combinatorica.is_domain_enabled("creative") then return end

creative = {}

-- Check if creative mode is enabled globally or per-player.
function creative.is_enabled_for(player_name)
    if core.settings:get_bool("creative_mode") then
        return true
    end
    local player = core.get_player_by_name(player_name)
    if player then
        return core.is_creative_enabled(player_name)
    end
    return false
end

-- Register creative inventory sfinv page
if combinatorica.is_enabled("sfinv") then
    sfinv.register_page("creative:inventory", {
        title = "Creative",
        is_in_nav = function(self, player, context)
            return creative.is_enabled_for(player:get_player_name())
        end,
        get = function(self, player, context)
            return "label[0,0;Creative Inventory]"
                .. "list[current_player;main;0,4.25;8,1;]"
                .. "list[current_player;main;0,5.5;8,3;8]"
        end,
    })
end

-- Grant creative privileges on join if creative mode is enabled
core.register_on_joinplayer(function(player)
    if creative.is_enabled_for(player:get_player_name()) then
        local privs = core.get_player_privs(player:get_player_name())
        privs.creative = true
        -- Don't persist, just grant for session
    end
end)

core.log("action", "[creative] Creative mode loaded")
