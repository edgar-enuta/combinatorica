-- Nether Dimension
-- Adds a Nether dimension accessible via portals.

if not combinatorica.features.nether then
    core.log("action", "[nether] Nether disabled by feature flag")
    return
end

local NETHER_DEPTH = -28000

-- Nether nodes
core.register_node("nether:rack", {
    description = "Netherrack",
    tiles = {"nether_rack.png"},
    groups = {cracky = 3, level = 2},
    sounds = {},
})

core.register_node("nether:glowstone", {
    description = "Glowstone",
    tiles = {"nether_glowstone.png"},
    light_source = core.LIGHT_MAX,
    groups = {cracky = 3, oddly_breakable_by_hand = 3},
    sounds = {},
})

core.register_node("nether:portal", {
    description = "Nether Portal",
    tiles = {{
        name = "nether_portal.png",
        animation = {type = "vertical_frames", aspect_w = 16, aspect_h = 16, length = 1},
    }},
    drawtype = "nodebox",
    paramtype = "light",
    light_source = 5,
    walkable = false,
    diggable = false,
    pointable = false,
    buildable_to = false,
    is_ground_content = false,
    drop = "",
    damage_per_second = 0,
    node_box = {
        type = "fixed",
        fixed = {-0.5, -0.5, -0.1, 0.5, 0.5, 0.1},
    },
    groups = {not_in_creative_inventory = 1},
})

-- Portal creation: obsidian frame
core.register_abm({
    label = "Nether portal ignition check",
    nodenames = {"fire:basic_flame"},
    neighbors = {"default:obsidian"},
    interval = 1,
    chance = 1,
    action = function(pos)
        -- Check for obsidian portal frame and convert to portal
        -- Full implementation would check frame geometry
        combinatorica.emit("nether_portal_ignited", {pos = pos})
    end,
})

core.log("action", "[nether] Nether dimension loaded")
