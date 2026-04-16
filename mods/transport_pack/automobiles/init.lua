-- Automobiles
-- Driveable ground vehicles.
-- This is a stub; the full automobiles mod will be integrated as a dependency.

automobiles = {}

-- Register a vehicle type.
function automobiles.register_vehicle(name, def)
    automobiles[name] = def
    core.log("action", "[automobiles] Registered vehicle: " .. name)
end

core.log("action", "[automobiles] Automobiles stub loaded")
