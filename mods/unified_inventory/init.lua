-- Unified Inventory
-- Advanced inventory system (alternative to sfinv).
-- This is a stub; the full unified_inventory mod will be integrated as a dependency.

unified_inventory = {}

unified_inventory.pages = {}

function unified_inventory.register_page(name, def)
    unified_inventory.pages[name] = def
end

core.log("action", "[unified_inventory] Unified Inventory stub loaded")
