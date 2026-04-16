-- Areas
-- Protected region management.
-- This is a stub; the full areas mod will be integrated as a dependency.

areas = {}
areas.areas = {}

function areas.canInteract(pos, name)
    -- Default: allow all interaction (no areas defined)
    return true
end

core.register_on_protection_violation(function(pos, name)
    core.chat_send_player(name, "This area is protected.")
end)

core.log("action", "[areas] Area protection stub loaded")
