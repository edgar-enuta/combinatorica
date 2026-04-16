-- Techage
-- Complete technology progression system.

if not combinatorica.features.techage then
    core.log("action", "[techage] Techage disabled by feature flag")
    return
end

techage = {}

-- Technology tiers
techage.TA1 = 1  -- Water/wind power era
techage.TA2 = 2  -- Steam power era
techage.TA3 = 3  -- Oil/electricity era
techage.TA4 = 4  -- Future tech / renewable era
techage.TA5 = 5  -- Fusion / space era

-- Power network
techage.power = {}
techage.power.networks = {}

-- Register a power-generating node.
function techage.register_generator(name, def)
    def.groups = def.groups or {}
    def.groups.techage_generator = 1
    def.groups.techage_tier = def.tier or techage.TA1

    core.register_node(name, {
        description = def.description,
        tiles = def.tiles,
        groups = def.groups,
        on_construct = function(pos)
            local meta = core.get_meta(pos)
            meta:set_int("power_output", def.power_output or 0)
            meta:set_string("infotext", def.description .. " (Idle)")
        end,
    })
end

-- Register a power-consuming machine.
function techage.register_machine(name, def)
    def.groups = def.groups or {}
    def.groups.techage_machine = 1
    def.groups.techage_tier = def.tier or techage.TA1

    core.register_node(name, {
        description = def.description,
        tiles = def.tiles,
        groups = def.groups,
        on_construct = function(pos)
            local meta = core.get_meta(pos)
            meta:set_int("power_input", def.power_input or 0)
            meta:set_string("infotext", def.description .. " (No Power)")
            if def.on_construct then def.on_construct(pos) end
        end,
    })
end

-- Register some basic TA1 machines
techage.register_generator("techage:ta1_watermill", {
    description = "TA1 Water Mill",
    tiles = {"techage_ta1_watermill.png"},
    tier = techage.TA1,
    power_output = 5,
})

techage.register_machine("techage:ta1_grinder", {
    description = "TA1 Grinder",
    tiles = {"techage_ta1_grinder.png"},
    tier = techage.TA1,
    power_input = 3,
})

techage.register_machine("techage:ta1_sieve", {
    description = "TA1 Sieve",
    tiles = {"techage_ta1_sieve.png"},
    tier = techage.TA1,
    power_input = 2,
})

-- TA2 Steam engine
techage.register_generator("techage:ta2_steam_engine", {
    description = "TA2 Steam Engine",
    tiles = {"techage_ta2_steam_engine.png"},
    tier = techage.TA2,
    power_output = 25,
})

-- TA3 Coal power station
techage.register_generator("techage:ta3_coal_powerstation", {
    description = "TA3 Coal Power Station",
    tiles = {"techage_ta3_coal_powerstation.png"},
    tier = techage.TA3,
    power_output = 80,
})

-- TA3 Industrial furnace
techage.register_machine("techage:ta3_furnace", {
    description = "TA3 Industrial Furnace",
    tiles = {"techage_ta3_furnace.png"},
    tier = techage.TA3,
    power_input = 14,
})

-- Emit event for other mods to hook into
combinatorica.emit("techage_loaded", {tiers = {techage.TA1, techage.TA2, techage.TA3, techage.TA4, techage.TA5}})

core.log("action", "[techage] Technology system loaded (TA1-TA5)")
