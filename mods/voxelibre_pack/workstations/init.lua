-- Workstations
-- Specialized crafting and processing stations.

if not combinatorica.is_domain_enabled("workstations") then return end

workstations = {}

-- Anvil: repair and rename items
core.register_node("workstations:anvil", {
    description = "Anvil",
    tiles = {"workstations_anvil_top.png", "workstations_anvil_bottom.png", "workstations_anvil_side.png"},
    groups = {cracky = 1, level = 2},
    paramtype2 = "facedir",
    on_rightclick = function(pos, node, clicker)
        core.show_formspec(clicker:get_player_name(), "workstations:anvil",
            "size[8,6]label[0,0;Anvil - Repair & Rename]"
            .. "list[current_player;main;0,2;8,1;]"
            .. "list[current_player;main;0,3.25;8,3;8]")
    end,
})

-- Grindstone: remove enchantments
core.register_node("workstations:grindstone", {
    description = "Grindstone",
    tiles = {"workstations_grindstone.png"},
    groups = {cracky = 2},
    on_rightclick = function(pos, node, clicker)
        core.show_formspec(clicker:get_player_name(), "workstations:grindstone",
            "size[8,6]label[0,0;Grindstone - Remove Enchantments]"
            .. "list[current_player;main;0,2;8,1;]"
            .. "list[current_player;main;0,3.25;8,3;8]")
    end,
})

-- Stonecutter: efficient stone variant crafting
core.register_node("workstations:stonecutter", {
    description = "Stonecutter",
    tiles = {"workstations_stonecutter_top.png", "workstations_stonecutter_bottom.png", "workstations_stonecutter_side.png"},
    groups = {cracky = 2},
    on_rightclick = function(pos, node, clicker)
        core.show_formspec(clicker:get_player_name(), "workstations:stonecutter",
            "size[8,6]label[0,0;Stonecutter]"
            .. "list[current_player;main;0,2;8,1;]"
            .. "list[current_player;main;0,3.25;8,3;8]")
    end,
})

-- Smithing table: upgrade tools
core.register_node("workstations:smithing_table", {
    description = "Smithing Table",
    tiles = {"workstations_smithing_top.png", "workstations_smithing_bottom.png", "workstations_smithing_side.png"},
    groups = {choppy = 2},
    on_rightclick = function(pos, node, clicker)
        core.show_formspec(clicker:get_player_name(), "workstations:smithing_table",
            "size[8,6]label[0,0;Smithing Table - Upgrade Tools]"
            .. "list[current_player;main;0,2;8,1;]"
            .. "list[current_player;main;0,3.25;8,3;8]")
    end,
})

-- Loom: banner pattern crafting
core.register_node("workstations:loom", {
    description = "Loom",
    tiles = {"workstations_loom_top.png", "workstations_loom_bottom.png", "workstations_loom_side.png"},
    groups = {choppy = 2, flammable = 2},
    on_rightclick = function(pos, node, clicker)
        core.show_formspec(clicker:get_player_name(), "workstations:loom",
            "size[8,6]label[0,0;Loom - Banner Patterns]"
            .. "list[current_player;main;0,2;8,1;]"
            .. "list[current_player;main;0,3.25;8,3;8]")
    end,
})

core.register_craft({output = "workstations:anvil", recipe = {
    {"default:steel_ingot", "default:steel_ingot", "default:steel_ingot"},
    {"", "default:steel_ingot", ""},
    {"default:steel_ingot", "default:steel_ingot", "default:steel_ingot"},
}})

core.register_craft({output = "workstations:grindstone", recipe = {
    {"default:stick", "default:stone", "default:stick"},
    {"default:wood", "", "default:wood"},
}})

core.register_craft({output = "workstations:stonecutter", recipe = {
    {"", "default:steel_ingot", ""},
    {"default:stone", "default:stone", "default:stone"},
}})

core.register_craft({output = "workstations:smithing_table", recipe = {
    {"default:steel_ingot", "default:steel_ingot"},
    {"default:wood", "default:wood"},
    {"default:wood", "default:wood"},
}})

core.register_craft({output = "workstations:loom", recipe = {
    {"farming:cotton", "farming:cotton"},
    {"default:wood", "default:wood"},
}})

core.log("action", "[workstations] Workstations loaded")
