std = "lua51+luanti"

stds.luanti = {
    read_globals = {
        "core",
        "minetest",
        "vector",
        "ItemStack",
        "dump",
        "VoxelManip",
        "VoxelArea",
        "PseudoRandom",
        "PcgRandom",
        "PerlinNoise",
        "PerlinNoiseMap",
        "Settings",
        "Raycast",

        string = {
            fields = {
                "split",
                "trim",
            },
        },

        table = {
            fields = {
                "copy",
                "indexof",
                "insert_all",
                "key_value_swap",
                "shuffle",
            },
        },

        math = {
            fields = {
                "hypot",
                "sign",
                "factorial",
                "round",
            },
        },
    },
}

-- Game-wide globals
read_globals = {
    "combinatorica",
}

-- Per-mod globals set via mod.conf
files["mods/default/**/*.lua"] = {
    globals = { "default" },
}

files["mods/player_api/**/*.lua"] = {
    globals = { "player_api" },
}

files["mods/sfinv/**/*.lua"] = {
    globals = { "sfinv" },
}

files["mods/creative/**/*.lua"] = {
    globals = { "creative" },
}

files["mods/hunger/**/*.lua"] = {
    globals = { "hunger" },
}

files["mods/farming/**/*.lua"] = {
    globals = { "farming" },
}

files["mods/hudbars/**/*.lua"] = {
    globals = { "hudbars" },
}

-- Ignore max line length for auto-generated registration tables
max_line_length = 120
