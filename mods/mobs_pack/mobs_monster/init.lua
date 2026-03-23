-- Mobs Monsters
-- Hostile mobs that spawn in darkness.

local monsters = {
    {name = "zombie", hp = 20, damage = 3, walk_velocity = 1.5},
    {name = "skeleton", hp = 15, damage = 4, walk_velocity = 1.2},
    {name = "spider", hp = 12, damage = 2, walk_velocity = 2.0},
    {name = "stone_monster", hp = 25, damage = 5, walk_velocity = 0.8},
}

for _, monster in ipairs(monsters) do
    mobs.register_mob("mobs_monster:" .. monster.name, {
        hp_max = monster.hp,
        collisionbox = {-0.4, -0.5, -0.4, 0.4, 1.2, 0.4},
        textures = {"mobs_" .. monster.name .. ".png"},
        walk_velocity = monster.walk_velocity,
        run_velocity = monster.walk_velocity * 2,
        damage = monster.damage,
        attack_type = "dogfight",
        view_range = 16,
        drops = {
            {name = "default:coal_lump", chance = 3, min = 0, max = 2},
        },
    })

    mobs.register_spawn({
        name = "mobs_monster:" .. monster.name,
        nodes = {"default:stone", "default:cobble", "default:dirt"},
        interval = 30,
        chance = 6000,
        min_light = 0,
        max_light = 7,
    })
end

core.log("action", "[mobs_monster] Monsters loaded")
