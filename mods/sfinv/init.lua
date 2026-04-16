-- Simple Fast Inventory (sfinv)
-- Provides a tabbed inventory formspec framework.

sfinv = {
    pages = {},
    pages_unordered = {},
    contexts = {},
}

-- Register an inventory page/tab.
-- @param name string: unique page name
-- @param def table: { title, get(self, player, context), is_in_nav(self, player, context) }
function sfinv.register_page(name, def)
    def.name = name
    sfinv.pages[name] = def
    table.insert(sfinv.pages_unordered, def)
end

-- Get or create a context for a player.
function sfinv.get_or_create_context(player)
    local pname = player:get_player_name()
    if not sfinv.contexts[pname] then
        sfinv.contexts[pname] = {
            page = sfinv.pages_unordered[1] and sfinv.pages_unordered[1].name or "",
        }
    end
    return sfinv.contexts[pname]
end

-- Set the active page for a player.
function sfinv.set_page(player, pagename)
    local context = sfinv.get_or_create_context(player)
    context.page = pagename
    sfinv.set_player_inventory_formspec(player)
end

-- Build and set the inventory formspec for a player.
function sfinv.set_player_inventory_formspec(player)
    local context = sfinv.get_or_create_context(player)
    local page = sfinv.pages[context.page]
    if not page then
        return
    end

    -- Build tab header
    local tabs = {}
    local current_idx = 1
    for i, p in ipairs(sfinv.pages_unordered) do
        if not p.is_in_nav or p:is_in_nav(player, context) then
            table.insert(tabs, p.title or p.name)
            if p.name == context.page then
                current_idx = #tabs
            end
        end
    end

    local fs = "size[8,8.5]"
    if #tabs > 1 then
        fs = fs .. "tabheader[0,0;sfinv_nav;" .. table.concat(tabs, ",") .. ";" .. current_idx .. ";true;false]"
    end

    if page.get then
        fs = fs .. page:get(player, context)
    end

    player:set_inventory_formspec(fs)
end

-- Register the crafting page as the default
sfinv.register_page("sfinv:crafting", {
    title = "Crafting",
    get = function(self, player, context)
        return "list[current_player;craft;1.75,0.5;3,3;]"
            .. "list[current_player;craftpreview;5.75,1.5;1,1;]"
            .. "list[current_player;main;0,4.25;8,1;]"
            .. "list[current_player;main;0,5.5;8,3;8]"
            .. "listring[current_player;main]"
            .. "listring[current_player;craft]"
    end,
})

-- Handle tab changes
core.register_on_player_receive_fields(function(player, formname, fields)
    if fields.sfinv_nav then
        local idx = tonumber(fields.sfinv_nav)
        if idx and sfinv.pages_unordered[idx] then
            sfinv.set_page(player, sfinv.pages_unordered[idx].name)
        end
        return true
    end
end)

-- Set inventory on join
core.register_on_joinplayer(function(player)
    sfinv.set_player_inventory_formspec(player)
end)

-- Clean up on leave
core.register_on_leaveplayer(function(player)
    sfinv.contexts[player:get_player_name()] = nil
end)

core.log("action", "[sfinv] Inventory framework loaded")
