-- Doors
-- Door, trapdoor, and fence gate registration API.

if not combinatorica.is_domain_enabled("doors") then return end

doors = {}

-- Register a door.
function doors.register(name, def)
    def.groups = def.groups or {}
    def.groups.door = 1

    -- Door open
    core.register_node(name .. "_a", {
        description = def.description or "Door",
        drawtype = "mesh",
        mesh = def.mesh or "door_a.obj",
        tiles = def.tiles,
        paramtype = "light",
        paramtype2 = "facedir",
        groups = def.groups,
        selection_box = {type = "fixed", fixed = {-0.5, -0.5, -0.5, 0.5, 1.5, -6/16}},
        on_rightclick = function(pos, node, clicker)
            local newname = name .. "_b"
            core.swap_node(pos, {name = newname, param2 = node.param2})
            combinatorica.emit("door_toggle", {pos = pos, state = "open"})
        end,
    })

    -- Door closed
    core.register_node(name .. "_b", {
        drawtype = "mesh",
        mesh = def.mesh or "door_b.obj",
        tiles = def.tiles,
        paramtype = "light",
        paramtype2 = "facedir",
        groups = def.groups,
        selection_box = {type = "fixed", fixed = {-0.5, -0.5, -0.5, 0.5, 1.5, -6/16}},
        on_rightclick = function(pos, node, clicker)
            local newname = name .. "_a"
            core.swap_node(pos, {name = newname, param2 = node.param2})
            combinatorica.emit("door_toggle", {pos = pos, state = "closed"})
        end,
        drop = name .. "_a",
    })
end

-- Register a trapdoor.
function doors.register_trapdoor(name, def)
    core.register_node(name, {
        description = def.description or "Trapdoor",
        drawtype = "nodebox",
        tiles = def.tiles,
        paramtype = "light",
        groups = def.groups or {choppy = 2, door = 1},
        node_box = {type = "fixed", fixed = {-0.5, -0.5, -0.5, 0.5, -6/16, 0.5}},
        on_rightclick = function(pos, node, clicker)
            combinatorica.emit("door_toggle", {pos = pos, state = "toggle"})
        end,
    })
end

-- Register default doors
doors.register("doors:door_wood", {
    description = "Wooden Door",
    tiles = {"doors_door_wood.png"},
    groups = {choppy = 2, flammable = 2, door = 1},
})

doors.register("doors:door_steel", {
    description = "Steel Door",
    tiles = {"doors_door_steel.png"},
    groups = {cracky = 1, level = 2, door = 1},
})

core.log("action", "[doors] Doors loaded")
