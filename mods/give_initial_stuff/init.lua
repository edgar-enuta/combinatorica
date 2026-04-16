-- Give Initial Stuff
-- Provides starter items to new players.

if not combinatorica.is_domain_enabled("give_initial_stuff") then return end

local function give_initial_stuff(player)
    local inv = player:get_inventory()
    local items_str = combinatorica.config.get("initial_stuff",
        "default:pick_wood 1,default:torch 8,default:apple 4")

    for _, entry in ipairs(string.split(items_str, ",")) do
        entry = entry:trim()
        if entry ~= "" then
            inv:add_item("main", ItemStack(entry))
        end
    end
end

if core.settings:get_bool("give_initial_stuff", true) then
    core.register_on_newplayer(function(player)
        give_initial_stuff(player)
    end)
end

core.log("action", "[give_initial_stuff] Initial stuff loaded")
