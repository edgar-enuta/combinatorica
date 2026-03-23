-- Stairs
-- API for registering stairs and slabs from any node.

stairs = {}

-- Register a stair node from a base material.
function stairs.register_stair(subname, recipeitem, groups, images, description)
    core.register_node("stairs:stair_" .. subname, {
        description = description .. " Stair",
        drawtype = "nodebox",
        tiles = images,
        paramtype = "light",
        paramtype2 = "facedir",
        groups = groups,
        node_box = {
            type = "fixed",
            fixed = {
                {-0.5, -0.5, -0.5, 0.5, 0, 0.5},
                {-0.5, 0, 0, 0.5, 0.5, 0.5},
            },
        },
    })

    if recipeitem then
        core.register_craft({
            output = "stairs:stair_" .. subname .. " 6",
            recipe = {
                {recipeitem, "", ""},
                {recipeitem, recipeitem, ""},
                {recipeitem, recipeitem, recipeitem},
            },
        })
    end
end

-- Register a slab node from a base material.
function stairs.register_slab(subname, recipeitem, groups, images, description)
    core.register_node("stairs:slab_" .. subname, {
        description = description .. " Slab",
        drawtype = "nodebox",
        tiles = images,
        paramtype = "light",
        groups = groups,
        node_box = {
            type = "fixed",
            fixed = {-0.5, -0.5, -0.5, 0.5, 0, 0.5},
        },
    })

    if recipeitem then
        core.register_craft({
            output = "stairs:slab_" .. subname .. " 6",
            recipe = {
                {recipeitem, recipeitem, recipeitem},
            },
        })
    end
end

-- Convenience: register both stair and slab
function stairs.register_stair_and_slab(subname, recipeitem, groups, images, desc_stair, desc_slab)
    stairs.register_stair(subname, recipeitem, groups, images, desc_stair or subname)
    stairs.register_slab(subname, recipeitem, groups, images, desc_slab or subname)
end

-- Register default stairs
stairs.register_stair_and_slab("wood", "default:wood",
    {choppy = 2, flammable = 2}, {"default_wood.png"}, "Wooden", "Wooden")
stairs.register_stair_and_slab("stone", "default:stone",
    {cracky = 3}, {"default_stone.png"}, "Stone", "Stone")
stairs.register_stair_and_slab("cobble", "default:cobble",
    {cracky = 3}, {"default_cobble.png"}, "Cobblestone", "Cobblestone")
stairs.register_stair_and_slab("stonebrick", "default:stonebrick",
    {cracky = 2}, {"default_stone_brick.png"}, "Stone Brick", "Stone Brick")

core.log("action", "[stairs] Stairs and slabs loaded")
