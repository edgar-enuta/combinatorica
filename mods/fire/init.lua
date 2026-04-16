-- Fire
-- Fire nodes and spreading mechanics.

if not combinatorica.is_domain_enabled("fire") then return end

core.register_node("fire:basic_flame", {
    description = "Fire",
    drawtype = "firelike",
    tiles = {{
        name = "fire_basic_flame_animated.png",
        animation = {type = "vertical_frames", aspect_w = 16, aspect_h = 16, length = 1},
    }},
    paramtype = "light",
    light_source = 13,
    walkable = false,
    buildable_to = true,
    sunlight_propagates = true,
    damage_per_second = 4,
    groups = {igniter = 2, dig_immediate = 3, not_in_creative_inventory = 1},
    drop = "",
    on_construct = function(pos)
        core.after(0, function()
            if core.get_node(pos).name == "fire:basic_flame" then
                combinatorica.emit("fire_started", {pos = pos})
            end
        end)
    end,
})

-- Extinguish fire if no flammable neighbors
local function check_fire(pos)
    local found_flammable = false
    for _, offset in ipairs({
        {x=0,y=-1,z=0}, {x=0,y=1,z=0},
        {x=1,y=0,z=0}, {x=-1,y=0,z=0},
        {x=0,y=0,z=1}, {x=0,y=0,z=-1},
    }) do
        local neighbor = vector.add(pos, offset)
        local node = core.get_node(neighbor)
        if core.get_item_group(node.name, "flammable") > 0 then
            found_flammable = true
            break
        end
    end
    if not found_flammable then
        core.remove_node(pos)
    end
end

core.register_abm({
    label = "Fire check",
    nodenames = {"fire:basic_flame"},
    interval = 5,
    chance = 2,
    action = check_fire,
})

core.log("action", "[fire] Fire system loaded")
