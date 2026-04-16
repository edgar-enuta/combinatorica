-- Binoculars
-- Zoom tool for looking at distant objects.

if not combinatorica.is_domain_enabled("binoculars") then return end

core.register_craftitem("binoculars:binoculars", {
    description = "Binoculars",
    inventory_image = "binoculars_binoculars.png",
    stack_max = 1,
})

core.register_craft({
    output = "binoculars:binoculars",
    recipe = {
        {"default:glass", "", "default:glass"},
        {"default:steel_ingot", "default:steel_ingot", "default:steel_ingot"},
        {"default:glass", "", "default:glass"},
    },
})

-- Grant zoom when binoculars are held
core.register_globalstep(function(dtime)
    for _, player in ipairs(core.get_connected_players()) do
        local wielded = player:get_wielded_item()
        if wielded:get_name() == "binoculars:binoculars" then
            player:set_fov(10, false, 0.3)
        end
    end
end)

core.log("action", "[binoculars] Binoculars loaded")
