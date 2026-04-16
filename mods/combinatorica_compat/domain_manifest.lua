-- Combinatorica Domain Manifest
-- Central metadata registry for all bundled domains. combinatorica_compat
-- registers these on behalf of the bundled mods so that even third-party
-- mods that don't know about our API still appear in
-- combinatorica.list_domains(). Mods that self-register in their own
-- init.lua override these entries (register_domain is last-writer-wins).

local R = combinatorica.register_domain

-- Core infrastructure: always on, can't be disabled.
R("combinatorica_compat", {
    title = "Combinatorica Compatibility",
    description = "Compatibility shims, namespace bridges, and the domain manifest.",
    category = "core",
    always_on = true,
})
R("default", {
    title = "Default",
    description = "Base nodes, tools, craftitems, crafting, and mapgen.",
    category = "core",
    always_on = true,
})
R("player_api", {
    title = "Player API",
    description = "Player model, animations, and attachment framework.",
    category = "core",
    always_on = true,
})

-- Core infrastructure: togglable.
R("sfinv", {
    title = "Sfinv",
    description = "Simple Fast Inventory — the default survival inventory UI.",
    category = "core",
})
R("creative", {
    title = "Creative",
    description = "Creative-mode inventory and item access.",
    category = "core",
})
R("game_commands", {
    title = "Game Commands",
    description = "Chat commands provided by the game (not mods).",
    category = "core",
})
R("keys", {
    title = "Keys",
    description = "Keychain and lock integration for doors and chests.",
    category = "core",
})
R("screwdriver", {
    title = "Screwdriver",
    description = "Rotate nodes in-world.",
    category = "core",
})
R("spawn", {
    title = "Spawn",
    description = "Spawn-point selection and initial-spawn handling.",
    category = "core",
})
R("give_initial_stuff", {
    title = "Initial Stuff",
    description = "Starter kit given to new players on first join.",
    category = "core",
})

-- Blocks & Materials.
R("bucket",     { title = "Bucket",     description = "Fluid pickup and placement with buckets.", category = "blocks" })
R("doors",      { title = "Doors",      description = "Hinged doors and trap doors.",             category = "blocks" })
R("dye",        { title = "Dye",        description = "Dye items from plants and combinations.",  category = "blocks" })
R("moreores",   { title = "More Ores",  description = "Extra ore types (mithril, silver, tin).",  category = "blocks" })
R("stairs",     { title = "Stairs",     description = "Stair and slab variants for base blocks.", category = "blocks" })
R("tnt",        { title = "TNT",        description = "Explosive blocks and ignition mechanics.", category = "blocks" })
R("vessels",    { title = "Vessels",    description = "Bottles, drinking glasses, and shelves.",  category = "blocks" })
R("walls",      { title = "Walls",      description = "Cobble / stone wall nodes.",               category = "blocks" })
R("wool",       { title = "Wool",       description = "Colored wool blocks.",                     category = "blocks" })
R("xpanes",     { title = "Glass Panes",description = "Glass panes and iron bars.",               category = "blocks" })
R("bonemeal",   { title = "Bonemeal",   description = "Bonemeal item and accelerated plant growth.", category = "blocks" })

-- World & Environment.
R("biomes",       { title = "Biomes",       description = "Base biome definitions for world generation.", category = "world" })
R("butterflies",  { title = "Butterflies",  description = "Ambient butterfly entities.",                  category = "world" })
R("env_sounds",   { title = "Environmental Sounds", description = "Ambient sounds (water, lava, wind).",  category = "world" })
R("fire",         { title = "Fire",         description = "Fire spread, flint & steel, and burn logic.",  category = "world" })
R("fireflies",    { title = "Fireflies",    description = "Ambient firefly entities.",                    category = "world" })
R("flowers",      { title = "Flowers",      description = "Wild flower nodes and flower pots.",           category = "world" })
R("weather",      { title = "Weather",      description = "Rain, snow, and weather effects.",             category = "world" })
R("dungeon_loot", { title = "Dungeon Loot", description = "Loot chests populated in generated dungeons.", category = "world" })
R("nether",       { title = "Nether",       description = "The Nether dimension and associated content.", category = "world" })

-- Player Systems.
R("3d_armor", { title = "3D Armor", description = "Visible armor pieces with damage reduction.", category = "player" })
R("beds",     { title = "Beds",     description = "Beds, sleeping, and skip-night mechanics.",   category = "player" })
R("farming",  { title = "Farming",  description = "Crops, soil, hoes, and growth mechanics.",    category = "player" })
R("hunger",   { title = "Hunger",   description = "Hunger bar, satiation, and food consumption.",category = "player" })

-- Quality of Life.
R("areas",      { title = "Areas",       description = "Area/region protection and land claims.",  category = "qol" })
R("binoculars", { title = "Binoculars",  description = "Binoculars item and zoom framework.",      category = "qol" })
R("bones",      { title = "Bones",       description = "Death drops contained in bone blocks.",    category = "qol" })
R("sethome",    { title = "Sethome",     description = "/sethome and /home teleport commands.",    category = "qol" })
R("worldedit",  { title = "WorldEdit",   description = "In-game world editing tools.",             category = "qol" })

-- User Interface.
R("hudbars",           { title = "HUD Bars",          description = "Stacked HUD progress bars for health, hunger, etc.", category = "ui" })
R("map",               { title = "Minimap",           description = "Minimap HUD and map items.",                         category = "ui" })
R("mtg_craftguide",    { title = "Craft Guide",       description = "In-game recipe browser.",                            category = "ui" })
R("unified_inventory", { title = "Unified Inventory", description = "Tabbed inventory with crafting browser.",            category = "ui" })

-- Mobs (covered by combinatorica_mobs_enabled coarse flag).
R("mobs_api",     { title = "Mobs API",     description = "Entity AI, spawning, and mob registration.", category = "mobs" })
R("mobs_animal",  { title = "Mobs Animal",  description = "Passive animal mobs.",                       category = "mobs" })
R("mobs_monster", { title = "Mobs Monster", description = "Hostile monster mobs.",                      category = "mobs" })

-- Techage (covered by combinatorica_techage_enabled coarse flag).
R("techage",    { title = "Techage",        description = "Technology progression: power, machines, automation.", category = "tech" })
R("hyperloop",  { title = "Hyperloop",      description = "Hyperloop transport network.",               category = "tech" })
R("signs_bot",  { title = "Signs Bot",      description = "Programmable bots that follow signs.",       category = "tech" })
R("ta4_addons", { title = "Techage Addons", description = "Techage TA4-tier addon machines.",           category = "tech" })

-- Transport.
R("advtrains",   { title = "Advtrains",   description = "Realistic train / rail network.", category = "transport" })
R("automobiles", { title = "Automobiles", description = "Rideable cars.",                  category = "transport" })
R("boats",       { title = "Boats",       description = "Rideable boats.",                 category = "transport" })
R("carts",       { title = "Carts",       description = "Minecarts and rails.",            category = "transport" })

-- VoxeLibre-inspired pack.
R("armor_stand",  { title = "Armor Stands", description = "Display stands for armor pieces.",               category = "voxelibre" })
R("banners",      { title = "Banners",      description = "Customisable colored banners.",                  category = "voxelibre" })
R("beekeeping",   { title = "Beekeeping",   description = "Bees, hives, and honey.",                        category = "voxelibre" })
R("bows",         { title = "Bows",         description = "Bows, arrows, and projectile mechanics.",        category = "voxelibre" })
R("campfires",    { title = "Campfires",    description = "Campfire light sources and cooking.",            category = "voxelibre" })
R("composters",   { title = "Composters",   description = "Composting organics into bonemeal.",             category = "voxelibre" })
R("copper",       { title = "Copper",       description = "Copper ore, blocks, and oxidation stages.",      category = "voxelibre" })
R("deepslate",    { title = "Deepslate",    description = "Deep-stratum deepslate variant of stone.",       category = "voxelibre" })
R("enchanting",   { title = "Enchanting",   description = "Enchantment tables and magic tool upgrades.",    category = "voxelibre" })
R("experience",   { title = "Experience",   description = "XP points and levels for player progression.",   category = "voxelibre" })
R("fireworks",    { title = "Fireworks",    description = "Fireworks rockets and launching.",               category = "voxelibre" })
R("fishing",      { title = "Fishing",      description = "Fishing rods, fish, and loot catches.",          category = "voxelibre" })
R("hoppers",      { title = "Hoppers",      description = "Item-transport hoppers between inventories.",    category = "voxelibre" })
R("jukebox",      { title = "Jukebox",      description = "Music disc playback.",                           category = "voxelibre" })
R("lanterns",     { title = "Lanterns",     description = "Hanging lantern light sources.",                 category = "voxelibre" })
R("potions",      { title = "Potions",      description = "Brewing stand, potions, and status effects.",    category = "voxelibre" })
R("shields",      { title = "Shields",      description = "Handheld shields for blocking damage.",          category = "voxelibre" })
R("the_end",      { title = "The End",      description = "The End dimension and dragon boss.",             category = "voxelibre" })
R("workstations", { title = "Workstations", description = "Smithing / villager-profession workstations.",   category = "voxelibre" })

-- Extra worldgen (covered by combinatorica_extra_biomes coarse flag).
R("caverealms",    { title = "Cave Realms",    description = "Deep cave biomes and decorations.",         category = "worldgen" })
R("ethereal",      { title = "Ethereal",      description = "Magical biomes (crystal, bamboo, mesa).",   category = "worldgen" })
R("everness",      { title = "Everness",      description = "Rich biome collection.",                    category = "worldgen" })
R("livingjungle",  { title = "Living Jungle", description = "Dense jungle biome.",                       category = "worldgen" })
R("marinara",      { title = "Marinara",     description = "Ocean and coastal biomes.",                  category = "worldgen" })
R("naturalbiomes", { title = "Natural Biomes", description = "Realistic terrestrial biomes.",            category = "worldgen" })

core.log("action", "[combinatorica_compat] Registered "
    .. tostring(#combinatorica.list_domains()) .. " domains")
