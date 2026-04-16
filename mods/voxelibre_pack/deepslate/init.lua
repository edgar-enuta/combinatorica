-- Deepslate
-- Underground stone variant found at deep levels.

if not combinatorica.is_domain_enabled("deepslate") then return end

core.register_node("deepslate:deepslate", {
    description = "Deepslate",
    tiles = {"deepslate_top.png", "deepslate_top.png", "deepslate_side.png"},
    groups = {cracky = 3, stone = 1},
    drop = "deepslate:cobbled_deepslate",
})

core.register_node("deepslate:cobbled_deepslate", {
    description = "Cobbled Deepslate",
    tiles = {"deepslate_cobbled.png"},
    groups = {cracky = 3, stone = 1, building = 1},
})

core.register_node("deepslate:deepslate_bricks", {
    description = "Deepslate Bricks",
    tiles = {"deepslate_bricks.png"},
    groups = {cracky = 2, stone = 1, building = 1},
})

core.register_craft({
    output = "deepslate:deepslate_bricks 4",
    recipe = {
        {"deepslate:cobbled_deepslate", "deepslate:cobbled_deepslate"},
        {"deepslate:cobbled_deepslate", "deepslate:cobbled_deepslate"},
    },
})

-- Replace stone with deepslate below y=-256
core.register_ore({
    ore_type = "stratum",
    ore = "deepslate:deepslate",
    wherein = "default:stone",
    y_min = -31000,
    y_max = -256,
    clust_scarcity = 1,
})

core.log("action", "[deepslate] Deepslate loaded")
