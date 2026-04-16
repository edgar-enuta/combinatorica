-- 3D Armor
-- Visible armor with damage reduction.

if not combinatorica.is_domain_enabled("3d_armor") then return end

armor = {}
armor.registered_armor = {}
local player_armor = {}

-- Register an armor piece.
function armor.register_armor(name, def)
    def.groups = def.groups or {}
    def.groups.armor = 1
    def.groups["armor_" .. (def.slot or "torso")] = 1

    core.register_tool(name, {
        description = def.description,
        inventory_image = def.inventory_image,
        groups = def.groups,
        wear_represents = "mechanical_wear",
    })

    armor.registered_armor[name] = def
    combinatorica.register_armor(name, {
        armor_points = def.armor_points or 0,
        material = def.material or "unknown",
        slot = def.slot or "torso",
    })
end

-- Calculate total armor value for a player
function armor.get_armor_value(player)
    local total = 0
    local pname = player:get_player_name()
    local data = player_armor[pname]
    if data then
        for _, item_name in pairs(data) do
            local def = armor.registered_armor[item_name]
            if def then
                total = total + (def.armor_points or 0)
            end
        end
    end
    return total
end

-- Register default armor sets
local armor_materials = {
    {material = "steel", desc = "Steel", points = 3},
    {material = "diamond", desc = "Diamond", points = 5},
    {material = "gold", desc = "Gold", points = 4},
}

local slots = {
    {slot = "helmet", desc = "Helmet"},
    {slot = "chestplate", desc = "Chestplate"},
    {slot = "leggings", desc = "Leggings"},
    {slot = "boots", desc = "Boots"},
}

for _, mat in ipairs(armor_materials) do
    for _, slot in ipairs(slots) do
        armor.register_armor("3d_armor:" .. slot.slot .. "_" .. mat.material, {
            description = mat.desc .. " " .. slot.desc,
            inventory_image = "3d_armor_" .. slot.slot .. "_" .. mat.material .. ".png",
            armor_points = mat.points,
            material = mat.material,
            slot = slot.slot,
        })
    end
end

-- Add armor inventory tab to sfinv
combinatorica.register_on_mod_loaded("sfinv", function()
    sfinv.register_page("3d_armor:armor", {
        title = "Armor",
        get = function(self, player, context)
            return "label[0,0;Armor Equipment]"
                .. "list[current_player;main;0,4.25;8,1;]"
                .. "list[current_player;main;0,5.5;8,3;8]"
        end,
    })
end)

core.register_on_joinplayer(function(player)
    player_armor[player:get_player_name()] = {}
end)

core.register_on_leaveplayer(function(player)
    player_armor[player:get_player_name()] = nil
end)

core.log("action", "[3d_armor] Armor system loaded")
