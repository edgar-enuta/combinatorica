-- Shields
-- Blocking shield item.

if not combinatorica.is_domain_enabled("shields") then return end

shields = {}

core.register_tool("shields:shield_wood", {
    description = "Wooden Shield",
    inventory_image = "shields_wood.png",
    groups = {shield = 1},
    tool_capabilities = {full_punch_interval = 1.0},
})

core.register_tool("shields:shield_steel", {
    description = "Steel Shield",
    inventory_image = "shields_steel.png",
    groups = {shield = 1},
    tool_capabilities = {full_punch_interval = 1.0},
})

core.register_craft({
    output = "shields:shield_wood",
    recipe = {
        {"default:wood", "default:steel_ingot", "default:wood"},
        {"default:wood", "default:wood", "default:wood"},
        {"", "default:wood", ""},
    },
})

core.register_craft({
    output = "shields:shield_steel",
    recipe = {
        {"default:steel_ingot", "default:steel_ingot", "default:steel_ingot"},
        {"default:steel_ingot", "default:steel_ingot", "default:steel_ingot"},
        {"", "default:steel_ingot", ""},
    },
})

core.log("action", "[shields] Shields loaded")
