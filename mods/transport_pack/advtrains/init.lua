-- Advanced Trains
-- Realistic train simulation with track laying, signals, and routing.
-- This is a stub; the full advtrains mod will be integrated as a dependency.

if not combinatorica.is_domain_enabled("advtrains") then return end

advtrains = {}

advtrains.trains = {}
advtrains.wagons = {}

-- Register a wagon type.
function advtrains.register_wagon(name, def)
    advtrains.wagons[name] = def
end

-- Register track node
core.register_node("advtrains:track", {
    description = "Train Track",
    drawtype = "raillike",
    tiles = {"advtrains_track.png"},
    paramtype = "light",
    walkable = false,
    selection_box = {type = "fixed", fixed = {-1/2, -1/2, -1/2, 1/2, -1/2+1/16, 1/2}},
    groups = {dig_immediate = 2, attached_node = 1, advtrains_track = 1},
})

core.register_node("advtrains:signal", {
    description = "Train Signal",
    tiles = {"advtrains_signal.png"},
    groups = {cracky = 2},
    paramtype2 = "facedir",
})

core.log("action", "[advtrains] Advanced Trains stub loaded")
