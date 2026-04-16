-- Copper
-- Copper blocks with oxidation stages.

if not combinatorica.is_domain_enabled("copper") then return end

copper = {}

local oxidation_stages = {
    {name = "copper_block", desc = "Copper Block"},
    {name = "exposed_copper", desc = "Exposed Copper"},
    {name = "weathered_copper", desc = "Weathered Copper"},
    {name = "oxidized_copper", desc = "Oxidized Copper"},
}

for i, stage in ipairs(oxidation_stages) do
    core.register_node("copper:" .. stage.name, {
        description = stage.desc,
        tiles = {"copper_" .. stage.name .. ".png"},
        groups = {cracky = 2, building = 1, copper_block = 1, oxidation_stage = i},
    })
end

-- Oxidation ABM
core.register_abm({
    label = "Copper oxidation",
    nodenames = {"copper:copper_block", "copper:exposed_copper", "copper:weathered_copper"},
    interval = 300,
    chance = 10,
    action = function(pos, node)
        local stage = core.get_item_group(node.name, "oxidation_stage")
        if stage < 4 then
            core.set_node(pos, {name = oxidation_stages[stage + 1].name})
        end
    end,
})

-- Waxing (prevent oxidation)
core.register_node("copper:waxed_copper_block", {
    description = "Waxed Copper Block",
    tiles = {"copper_copper_block.png"},
    groups = {cracky = 2, building = 1, not_in_creative_inventory = 0},
})

core.register_craft({
    output = "copper:copper_block",
    recipe = {
        {"default:copper_ingot", "default:copper_ingot", "default:copper_ingot"},
        {"default:copper_ingot", "default:copper_ingot", "default:copper_ingot"},
        {"default:copper_ingot", "default:copper_ingot", "default:copper_ingot"},
    },
})

combinatorica.register_ore("copper:copper_block", {depth_min = -31000, depth_max = -16, rarity = 9})

core.log("action", "[copper] Copper with oxidation loaded")
