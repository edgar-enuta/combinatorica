-- X Panes
-- Glass panes and iron bars that connect to neighbors.

xpanes = {}

function xpanes.register_pane(name, def)
    core.register_node("xpanes:" .. name .. "_flat", {
        description = def.description,
        drawtype = "nodebox",
        tiles = def.tiles,
        paramtype = "light",
        paramtype2 = "facedir",
        sunlight_propagates = true,
        groups = def.groups or {snappy = 2, cracky = 3, oddly_breakable_by_hand = 3, pane = 1},
        node_box = {type = "fixed", fixed = {-0.5, -0.5, -1/32, 0.5, 0.5, 1/32}},
        selection_box = {type = "fixed", fixed = {-0.5, -0.5, -1/32, 0.5, 0.5, 1/32}},
    })
end

xpanes.register_pane("bar", {
    description = "Iron Bars",
    tiles = {"xpanes_bar.png"},
    groups = {cracky = 2, pane = 1},
})

xpanes.register_pane("glass", {
    description = "Glass Pane",
    tiles = {"default_glass.png"},
    groups = {snappy = 2, cracky = 3, oddly_breakable_by_hand = 3, pane = 1},
})

core.log("action", "[xpanes] Panes loaded")
