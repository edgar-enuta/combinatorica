# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## What This Is

Combinatorica is a Luanti (formerly Minetest) game that bundles ~80 popular community mods into one unified package with a common API layer for cross-mod interop and per-mod server-admin toggling. The interesting problem is **impedance-matching between mod ecosystems** (e.g., Techage particles vs Asuna particles, food items from mod X not tagged as compostable by mod Y). The scaffold and toggle system exist to support that bridging work.

## Commands

```bash
# Lint all mods (requires: luarocks install luacheck)
./utils/lint.sh

# Lint a single mod
./utils/lint.sh farming

# Syntax-check all Lua files without luacheck
find mods -name "*.lua" -exec luac -p {} \;

# Headless smoke test (no GUI needed)
luanti --server --gameid combinatorica --world /tmp/test-world --quiet

# Smoke test with specific settings
echo 'combinatorica_hunger_enabled = false' > /tmp/test.conf
luanti --server --gameid combinatorica --world /tmp/test-world --config /tmp/test.conf --logfile /tmp/test.log --quiet

# Check logs for domain system output
grep -E "Combinatorica|combinatorica_" /tmp/test.log
```

The game must be symlinked into `~/.minetest/games/combinatorica` for Luanti to find it. There are no automated tests; verification is `luac -p` + headless server startup + manual play-testing.

## Architecture

### Core API (`mods/combinatorica_core/`)

Five files loaded in order by `init.lua`:

1. **domains.lua** -- Domain registry. `register_domain(name, {title, description, category, always_on})` stores mod metadata. `list_domains()` returns all sorted by category. `log(domain, level, msg)` is the shared prefixed logger.

2. **api.lua** -- Event bus (`on`/`emit`), mod discovery (`is_enabled`, `register_on_mod_loaded`), pairwise integration registration (`register_integration(mod_a, mod_b, cb)` with pcall safety), and shared group conventions table (`combinatorica.groups.food`, `.compostable`, `.flammable`, etc.). Integrations activate in `core.register_on_mods_loaded`.

3. **interop.lua** -- Shared item registries: `register_food`, `register_ore`, `register_armor`, `register_tool`. Each emits a `*_registered` event so other mods can react without hard deps.

4. **config.lua** -- `config.get_bool`/`get`/`get_number` wrappers around `core.settings`. Five coarse feature flags (`combinatorica.features.hunger/mobs/techage/nether/extra_biomes`). `is_domain_enabled(name)` is the canonical per-mod toggle guard.

### Compatibility layer (`mods/combinatorica_compat/`)

- `domain_manifest.lua` -- Central table registering all 80 domains with metadata (title, description, category). Four marked `always_on`: combinatorica_core, combinatorica_compat, default, player_api.
- `init.lua` -- `minetest = core` bridge for legacy mods; loads manifest; home for future compat shims.

### Mod init.lua pattern

Every mod follows this structure:
```lua
-- Module header comment

if not combinatorica.is_domain_enabled("modname") then return end
-- OR for coarse-flagged mods:
if not combinatorica.features.mobs then return end

modname = {}
-- API functions, node/item/tool registrations, event subscriptions
core.log("action", "[modname] loaded")
```

### Two toggle mechanisms

- **Coarse feature flags** (`combinatorica.features.*`) gate entire subsystems. Used by: hunger, mobs_api, techage, nether, biomes. Sub-mods of coarse-flagged packs (mobs_animal, hyperloop, all worldgen_pack mods) also gate on their parent's coarse flag.
- **Per-domain flags** (`combinatorica_<name>_enabled` bool settings, defaulting true) gate individual mods. Used by everything else (~61 mods).

Both read from `settingtypes.txt` entries. They don't conflict because they key on different settings.

### Modpacks

Five modpacks group related mods (each has `modpack.conf` + sub-mod directories):
- `mobs_pack` (mobs_api, mobs_animal, mobs_monster) -- gated by `combinatorica_mobs_enabled`
- `techage_pack` (techage, hyperloop, signs_bot, ta4_addons) -- gated by `combinatorica_techage_enabled`
- `transport_pack` (advtrains, automobiles, boats, carts) -- individual per-mod toggles
- `voxelibre_pack` (19 mods: enchanting, potions, bows, the_end, etc.) -- individual per-mod toggles
- `worldgen_pack` (caverealms, ethereal, everness, etc.) -- gated by `combinatorica_extra_biomes`

### Dependency conventions

- All mods hard-depend on `combinatorica_core`. Most also depend on `default`.
- Cross-mod communication uses `combinatorica.on`/`emit` events or shared registries, not hard deps.
- `optional_depends` is for load-order hints only. Avoid mutual optional_depends (causes Luanti dep cycles).
- `register_on_mod_loaded` is the safe way to run code conditional on another mod's presence.

## Conventions

- **Lua version**: 5.1 (Luanti standard). Use `core.*` API, not `minetest.*`.
- **Indentation**: tabs in Lua files.
- **Max line length**: 120 characters (enforced by luacheck).
- **Globals**: each mod gets one global namespace matching its directory name. The only cross-mod global is `combinatorica`.
- **Event names**: snake_case (`player_ate`, `food_registered`, `door_toggle`).
- **Logging**: use `combinatorica.log(domain, level, msg)` which prefixes `[Combinatorica:<domain>]`.
- **Settings keys**: `combinatorica_<modname>_enabled` for per-mod toggles.
- **Domain categories**: core, blocks, world, player, mobs, tech, transport, worldgen, voxelibre, qol, ui.
