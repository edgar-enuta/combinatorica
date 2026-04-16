-- Farming
-- Extended farming system (Farming Redo-style).

if not combinatorica.is_domain_enabled("farming") then return end

farming = {}

-- Register a hoe tool.
function farming.register_hoe(name, def)
    core.register_tool(name, {
        description = def.description,
        inventory_image = def.inventory_image,
        on_use = function(itemstack, user, pointed_thing)
            if pointed_thing.type ~= "node" then return end
            local pos = pointed_thing.under
            local node = core.get_node(pos)
            if core.get_item_group(node.name, "soil") > 0 then
                core.set_node(pos, {name = "farming:soil"})
                itemstack:add_wear(65535 / (def.uses or 30))
                return itemstack
            end
        end,
    })
end

-- Register a crop with growth stages.
function farming.register_plant(name, def)
    local stages = def.stages or 8
    for i = 1, stages do
        local groups = {snappy = 3, flammable = 2, plant = 1, not_in_creative_inventory = 1, attached_node = 1}
        if i == stages then
            groups.not_in_creative_inventory = nil
        end

        core.register_node("farming:" .. name .. "_" .. i, {
            description = def.description .. (i == stages and "" or " (Growing)"),
            drawtype = "plantlike",
            tiles = {"farming_" .. name .. "_" .. i .. ".png"},
            paramtype = "light",
            sunlight_propagates = true,
            walkable = false,
            buildable_to = true,
            groups = groups,
            drop = i == stages and (def.drop or "farming:" .. name) or "",
            selection_box = {
                type = "fixed",
                fixed = {-0.5, -0.5, -0.5, 0.5, -0.5 + (i / stages), 0.5},
            },
        })
    end

    -- Seed item
    core.register_craftitem("farming:" .. name .. "_seed", {
        description = def.description .. " Seed",
        inventory_image = "farming_" .. name .. "_seed.png",
        on_place = function(itemstack, placer, pointed_thing)
            if pointed_thing.type ~= "node" then return end
            local pos = pointed_thing.above
            local under = core.get_node(pointed_thing.under)
            if core.get_item_group(under.name, "soil") > 1 then
                core.set_node(pos, {name = "farming:" .. name .. "_1"})
                itemstack:take_item()
            end
            return itemstack
        end,
        groups = {seed = 1},
    })

    -- Growth ABM
    core.register_abm({
        label = "Farming growth: " .. name,
        nodenames = (function()
            local nodes = {}
            for i = 1, stages - 1 do
                table.insert(nodes, "farming:" .. name .. "_" .. i)
            end
            return nodes
        end)(),
        interval = 30,
        chance = 5,
        action = function(pos, node)
            local current = tonumber(node.name:match("_(%d+)$"))
            if current and current < stages then
                core.set_node(pos, {name = "farming:" .. name .. "_" .. (current + 1)})
            end
        end,
    })

    -- Register as food if edible
    if def.on_use_eat then
        core.register_craftitem("farming:" .. name, {
            description = def.description,
            inventory_image = "farming_" .. name .. ".png",
            on_use = core.item_eat(def.on_use_eat),
            groups = {food = 1, flammable = 2, compostable = 1},
        })
        combinatorica.register_food("farming:" .. name, {satiation = def.on_use_eat, heal = 0})
    end
end

-- Soil node
core.register_node("farming:soil", {
    description = "Soil",
    tiles = {"farming_soil.png", "default_dirt.png"},
    groups = {crumbly = 3, soil = 3, grassland = 1},
    drop = "default:dirt",
})

core.register_node("farming:soil_wet", {
    description = "Wet Soil",
    tiles = {"farming_soil_wet.png", "default_dirt.png"},
    groups = {crumbly = 3, soil = 4, grassland = 1},
    drop = "default:dirt",
})

-- Register hoes
farming.register_hoe("farming:hoe_wood", {
    description = "Wooden Hoe",
    inventory_image = "farming_tool_woodhoe.png",
    uses = 30,
})

farming.register_hoe("farming:hoe_stone", {
    description = "Stone Hoe",
    inventory_image = "farming_tool_stonehoe.png",
    uses = 90,
})

farming.register_hoe("farming:hoe_steel", {
    description = "Steel Hoe",
    inventory_image = "farming_tool_steelhoe.png",
    uses = 200,
})

-- Register crops
farming.register_plant("wheat", {
    description = "Wheat",
    stages = 8,
})

farming.register_plant("cotton", {
    description = "Cotton",
    stages = 8,
})

farming.register_plant("carrot", {
    description = "Carrot",
    stages = 8,
    on_use_eat = 3,
})

farming.register_plant("potato", {
    description = "Potato",
    stages = 4,
    on_use_eat = 2,
})

farming.register_plant("tomato", {
    description = "Tomato",
    stages = 8,
    on_use_eat = 4,
})

-- Bread from wheat
core.register_craftitem("farming:bread", {
    description = "Bread",
    inventory_image = "farming_bread.png",
    on_use = core.item_eat(5),
    groups = {food = 1, flammable = 2},
})
combinatorica.register_food("farming:bread", {satiation = 5, heal = 0})

core.register_craft({
    output = "farming:bread",
    recipe = {
        {"farming:wheat", "farming:wheat", "farming:wheat"},
    },
})

core.log("action", "[farming] Farming system loaded")
