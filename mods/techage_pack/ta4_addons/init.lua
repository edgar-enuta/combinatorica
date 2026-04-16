-- TA4 Addons
-- Advanced renewable energy and high-tech machines.

if not combinatorica.features.techage then return end

techage.register_generator("ta4_addons:solar_panel", {
    description = "TA4 Solar Panel",
    tiles = {"ta4_addons_solar_panel.png"},
    tier = techage.TA4,
    power_output = 50,
})

techage.register_generator("ta4_addons:wind_turbine", {
    description = "TA4 Wind Turbine",
    tiles = {"ta4_addons_wind_turbine.png"},
    tier = techage.TA4,
    power_output = 70,
})

techage.register_machine("ta4_addons:electrolyzer", {
    description = "TA4 Electrolyzer",
    tiles = {"ta4_addons_electrolyzer.png"},
    tier = techage.TA4,
    power_input = 35,
})

core.register_node("ta4_addons:energy_storage", {
    description = "TA4 Energy Storage",
    tiles = {"ta4_addons_energy_storage.png"},
    groups = {cracky = 2, techage_tier = 4},
    on_construct = function(pos)
        local meta = core.get_meta(pos)
        meta:set_int("stored_energy", 0)
        meta:set_int("max_energy", 10000)
        meta:set_string("infotext", "TA4 Energy Storage (0/10000)")
    end,
})

core.log("action", "[ta4_addons] TA4 addons loaded")
