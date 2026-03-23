-- Dungeon Loot
-- Generates loot chests in dungeon structures.

dungeon_loot = {}
dungeon_loot.registered_loot = {}

-- Register a loot item.
function dungeon_loot.register(def)
    table.insert(dungeon_loot.registered_loot, def)
end

-- Default loot table
dungeon_loot.register({name = "default:apple", chance = 0.5, count = {1, 3}})
dungeon_loot.register({name = "default:steel_ingot", chance = 0.3, count = {1, 2}})
dungeon_loot.register({name = "default:gold_ingot", chance = 0.15, count = {1, 2}})
dungeon_loot.register({name = "default:diamond", chance = 0.05, count = {1, 1}})
dungeon_loot.register({name = "default:coal_lump", chance = 0.6, count = {2, 5}})

core.log("action", "[dungeon_loot] Dungeon loot loaded")
