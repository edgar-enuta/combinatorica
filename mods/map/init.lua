-- Map
-- Mapping kit item that enables the minimap.

if not combinatorica.is_domain_enabled("map") then return end

core.register_craftitem("map:mapping_kit", {
    description = "Mapping Kit",
    inventory_image = "map_mapping_kit.png",
    stack_max = 1,
})

core.register_craft({
    output = "map:mapping_kit",
    recipe = {
        {"default:glass", "default:glass", "default:glass"},
        {"default:glass", "default:paper", "default:glass"},
        {"default:glass", "default:glass", "default:glass"},
    },
})

core.log("action", "[map] Map loaded")
