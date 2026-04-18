# Combinatorica

A modular Luanti game that bundles popular community mods into one seamless experience with a common API, cross-mod interop, and fine-grained server-admin control.

Combinatorica solves a specific problem: the Luanti modding ecosystem has excellent individual mods, but they don't talk to each other cleanly. Food items from one mod aren't compostable by another. Techage and Asuna use different particle systems. Armor mods don't know about enchanting mods. Combinatorica provides the glue layer that makes these ecosystems feel like one coherent game.

## Bundled Content

**~80 mods** organized into 11 categories. Every mod is individually togglable unless marked *always on*.

### Core

Foundation mods that most gameplay systems depend on.

| Mod | Description | Toggle |
|-----|-------------|--------|
| combinatorica_core | Domain registry, event bus, mod interop, shared group conventions, and feature flags. | *always on* |
| combinatorica_compat | Compatibility shims, namespace bridges, and the domain manifest. | *always on* |
| default | Base nodes, tools, craftitems, crafting, and mapgen. | *always on* |
| player_api | Player model, animations, and attachment framework. | *always on* |
| sfinv | Simple Fast Inventory — the default survival inventory UI. | per-mod |
| creative | Creative-mode inventory and item access. | per-mod |
| game_commands | Chat commands provided by the game (not mods). | per-mod |
| keys | Keychain and lock integration for doors and chests. | per-mod |
| screwdriver | Rotate nodes in-world. | per-mod |
| spawn | Spawn-point selection and initial-spawn handling. | per-mod |
| give_initial_stuff | Starter kit given to new players on first join. | `give_initial_stuff` setting |

### Blocks & Materials

| Mod | Description |
|-----|-------------|
| bucket | Fluid pickup and placement with buckets. |
| doors | Hinged doors and trap doors. |
| dye | Dye items from plants and combinations. |
| moreores | Extra ore types (mithril, silver, tin). |
| stairs | Stair and slab variants for base blocks. |
| tnt | Explosive blocks and ignition mechanics. |
| vessels | Bottles, drinking glasses, and shelves. |
| walls | Cobble / stone wall nodes. |
| wool | Colored wool blocks. |
| xpanes | Glass panes and iron bars. |
| bonemeal | Bonemeal item and accelerated plant growth. |

### World & Environment

| Mod | Description |
|-----|-------------|
| biomes | Base biome definitions for world generation. |
| butterflies | Ambient butterfly entities. |
| env_sounds | Ambient sounds (water, lava, wind). |
| fire | Fire spread, flint & steel, and burn logic. |
| fireflies | Ambient firefly entities. |
| flowers | Wild flower nodes and flower pots. |
| weather | Rain, snow, and weather effects. |
| dungeon_loot | Loot chests populated in generated dungeons. |
| nether | The Nether dimension and associated content. Gated by `combinatorica_nether_enabled`. |

### Player Systems

| Mod | Description |
|-----|-------------|
| 3d_armor | Visible armor pieces with damage reduction. |
| beds | Beds, sleeping, and skip-night mechanics. |
| farming | Crops, soil, hoes, and growth mechanics. |
| hunger | Hunger bar, satiation, and food consumption. Gated by `combinatorica_hunger_enabled`. |

### Mobs (modpack: `mobs_pack`)

All gated by `combinatorica_mobs_enabled`.

| Mod | Description |
|-----|-------------|
| mobs_api | Entity AI, spawning, and mob registration. |
| mobs_animal | Passive animal mobs (cow, sheep, chicken, pig). |
| mobs_monster | Hostile monster mobs. |

### Tech (modpack: `techage_pack`)

All gated by `combinatorica_techage_enabled`.

| Mod | Description |
|-----|-------------|
| techage | Technology progression: power, machines, automation. |
| hyperloop | Hyperloop transport network. |
| signs_bot | Programmable bots that follow signs. |
| ta4_addons | Techage TA4-tier addon machines. |

### Transport (modpack: `transport_pack`)

| Mod | Description |
|-----|-------------|
| advtrains | Realistic train / rail network. |
| automobiles | Rideable cars. |
| boats | Rideable boats. |
| carts | Minecarts and rails. |

### VoxeLibre Features (modpack: `voxelibre_pack`)

Features inspired by VoxeLibre/Mineclonia, each individually togglable.

| Mod | Description |
|-----|-------------|
| armor_stand | Display stands for armor pieces. |
| banners | Customisable colored banners. |
| beekeeping | Bees, hives, and honey. |
| bows | Bows, arrows, and projectile mechanics. |
| campfires | Campfire light sources and cooking. |
| composters | Composting organics into bonemeal. |
| copper | Copper ore, blocks, and oxidation stages. |
| deepslate | Deep-stratum deepslate variant of stone. |
| enchanting | Enchantment tables and magic tool upgrades. |
| experience | XP points and levels for player progression. |
| fireworks | Fireworks rockets and launching. |
| fishing | Fishing rods, fish, and loot catches. |
| hoppers | Item-transport hoppers between inventories. |
| jukebox | Music disc playback. |
| lanterns | Hanging lantern light sources. |
| potions | Brewing stand, potions, and status effects. |
| shields | Handheld shields for blocking damage. |
| the_end | The End dimension and dragon boss. |
| workstations | Smithing / villager-profession workstations. |

### Extra Worldgen (modpack: `worldgen_pack`)

All gated by `combinatorica_extra_biomes`. Adds 60+ biomes beyond the base set.

| Mod | Description |
|-----|-------------|
| caverealms | Deep cave biomes and decorations. |
| ethereal | Magical biomes (crystal, bamboo, mesa). |
| everness | Rich biome collection. |
| livingjungle | Dense jungle biome. |
| marinara | Ocean and coastal biomes. |
| naturalbiomes | Realistic terrestrial biomes. |

### Quality of Life

| Mod | Description |
|-----|-------------|
| areas | Area/region protection and land claims. |
| binoculars | Binoculars item and zoom framework. |
| bones | Death drops contained in bone blocks. |
| sethome | /sethome and /home teleport commands. |
| worldedit | In-game world editing tools. |

### User Interface

| Mod | Description |
|-----|-------------|
| hudbars | Stacked HUD progress bars for health, hunger, etc. |
| map | Minimap HUD and map items. |
| mtg_craftguide | In-game recipe browser. |
| unified_inventory | Tabbed inventory with crafting browser. |

## Server Admin Guide

### Installation

1. Clone or download into Luanti's games directory:
   ```bash
   cd ~/.minetest/games
   git clone https://github.com/edgar-enuta/combinatorica.git
   ```
   Or symlink from your dev checkout:
   ```bash
   ln -s /path/to/combinatorica ~/.minetest/games/combinatorica
   ```

2. Launch Luanti, select **Combinatorica** from the games list, create a world.

### Configuring What's Enabled

Every mod defaults to **enabled**. Disable what you don't want for your server by adding settings to `minetest.conf`:

**Coarse toggles** disable entire subsystems at once:
```ini
combinatorica_hunger_enabled = false      # no hunger bar
combinatorica_mobs_enabled = false        # no mobs at all
combinatorica_techage_enabled = false     # no tech progression
combinatorica_nether_enabled = false      # no nether dimension
combinatorica_extra_biomes = false        # base biomes only (no worldgen_pack)
```

**Per-mod toggles** disable individual features:
```ini
combinatorica_tnt_enabled = false         # no explosives
combinatorica_bows_enabled = false        # no ranged combat
combinatorica_enchanting_enabled = false  # no enchantments
combinatorica_worldedit_enabled = false   # no worldedit for players
```

The full list of toggles is in `settingtypes.txt`, organized by category. You can also browse them in Luanti's "Settings" tab when Combinatorica is selected.

### Starter Kit

New players receive items defined by the `initial_stuff` setting:
```ini
give_initial_stuff = true
initial_stuff = default:pick_wood 1,default:torch 8,default:apple 4
```

### Verifying Your Configuration

After changing settings, start the server and check `debug.txt` for domain status:
```
[combinatorica_core] Feature flags: hunger=true, mobs=false, ...
[Combinatorica:tnt] disabled by setting
[Combinatorica:bows] disabled by setting
[combinatorica_compat] Registered 80 domains
[combinatorica_core] All integrations activated
```

Any mod disabled via setting will log `disabled by setting`. Missing log lines for a mod mean it loaded normally.

### Mapgen

Supported: `v7` (default), `carpathian`, `valleys`, `flat`, `fractal`, `singlenode`. Set via `mg_name` in `minetest.conf`.

## Core API

The `combinatorica_core` mod provides the integration layer that all other mods build on:

- **Domain Registry** -- mods register metadata (title, description, category) and can be enumerated at runtime via `combinatorica.list_domains()`
- **Event Bus** -- `combinatorica.on(event, callback)` / `combinatorica.emit(event, data)` for decoupled cross-mod communication
- **Shared Registries** -- `register_food`, `register_ore`, `register_armor`, `register_tool` let mods discover each other's items without hard dependencies
- **Integration System** -- `register_integration(mod_a, mod_b, callback)` runs code only when both mods are present
- **Feature Flags** -- coarse flags (`combinatorica.features.*`) and per-mod flags (`combinatorica.is_domain_enabled(name)`) for server customization

## Adding a New Mod

### 1. Create the mod directory

Standalone mods go in `mods/<modname>/`. Mods that belong to an existing modpack go in `mods/<packname>/<modname>/`.

### 2. Write `mod.conf`

```
name = my_mod
title = My Mod
description = One-line summary of what this mod does.
depends = combinatorica_core, default
optional_depends = farming
```

- Always depend on `combinatorica_core`.
- Depend on `default` if you use any base nodes, tools, or craftitems.
- Use `optional_depends` for mods you integrate with but don't require. Prefer the event bus or `register_on_mod_loaded` over hard deps for cross-mod features.
- Do not create mutual `optional_depends` between two mods (Luanti treats it as a dependency cycle).

### 3. Write `init.lua`

```lua
-- My Mod
-- One-line description.

if not combinatorica.is_domain_enabled("my_mod") then return end

my_mod = {}

-- Your registrations: nodes, items, tools, crafts, ABMs, globalsteps, etc.

-- Publish to shared registries where appropriate
combinatorica.register_food("my_mod:apple_pie", { satiation = 6, heal = 2 })

-- React to other mods via events
combinatorica.on("food_registered", function(data)
    -- handle new food items from other mods
end)

-- Conditional integration with optional deps
combinatorica.register_on_mod_loaded("farming", function()
    -- code that only runs if farming is present
end)

core.log("action", "[my_mod] loaded")
```

Use tabs for indentation. The domain guard (`is_domain_enabled`) must be the first executable line so the mod cleanly short-circuits when disabled.

If your mod belongs to a coarse-flagged modpack (mobs_pack, techage_pack, worldgen_pack), use the pack's feature flag instead:

```lua
if not combinatorica.features.mobs then return end
```

### 4. Register in the domain manifest

Add an entry to `mods/combinatorica_compat/domain_manifest.lua`:

```lua
R("my_mod", {
    title = "My Mod",
    description = "One-line summary.",
    category = "blocks",  -- or: core, world, player, mobs, tech, transport, worldgen, voxelibre, qol, ui
})
```

### 5. Add a settings toggle

Add a line to `settingtypes.txt` under the appropriate `[Section]`:

```
combinatorica_my_mod_enabled (Enable my mod) bool true
```

### 6. Update `.luacheckrc` (if your mod creates a global)

If your mod sets a global namespace (`my_mod = {}`), add a luacheck entry so the linter doesn't warn:

```lua
files["mods/my_mod/**/*.lua"] = {
    globals = { "my_mod" },
}
```

### 7. Verify

```bash
./utils/lint.sh my_mod                          # lint your mod
find mods -name "*.lua" -exec luac -p {} \;     # syntax-check everything
luanti --server --gameid combinatorica \
    --world /tmp/test-world --quiet              # smoke test
```

Check `debug.txt` for your mod's log line and confirm no errors.

## License

MIT. See [LICENSE.txt](LICENSE.txt).
