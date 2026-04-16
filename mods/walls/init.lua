-- Walls
-- Wall nodes that connect to neighbors.

walls = {}

function walls.register(name, desc, tiles, recipeitem, groups)
    core.register_node(name, {
        description = desc,
        drawtype = "nodebox",
        tiles = tiles,
        paramtype = "light",
        groups = groups or {cracky = 3, wall = 1, stone = 2},
        node_box = {
            type = "connected",
            fixed = {-1/4, -1/2, -1/4, 1/4, 1/2, 1/4},
            connect_front = {-3/16, -1/2, -1/2, 3/16, 3/8, -1/4},
            connect_back = {-3/16, -1/2, 1/4, 3/16, 3/8, 1/2},
            connect_left = {-1/2, -1/2, -3/16, -1/4, 3/8, 3/16},
            connect_right = {1/4, -1/2, -3/16, 1/2, 3/8, 3/16},
        },
        connects_to = {"group:wall", "group:stone", "group:wood"},
    })

    if recipeitem then
        core.register_craft({
            output = name .. " 6",
            recipe = {
                {recipeitem, recipeitem, recipeitem},
                {recipeitem, recipeitem, recipeitem},
            },
        })
    end
end

walls.register("walls:cobble", "Cobblestone Wall", {"default_cobble.png"}, "default:cobble")
walls.register("walls:desertcobble", "Desert Cobblestone Wall", {"default_desert_cobble.png"}, nil)

core.log("action", "[walls] Walls loaded")
