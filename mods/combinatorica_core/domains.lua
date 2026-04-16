-- Combinatorica Domain Registry
-- Self-describing metadata for each mod ("domain") in the game, plus a
-- shared logging helper. Paired with combinatorica.is_domain_enabled() in
-- config.lua, this lets mods short-circuit when a server admin has turned
-- their domain off, and lets UI/admin tools enumerate what's installed.

combinatorica.domains = {}

-- Register a domain with the framework.
-- Safe to call from a mod's init.lua (colocated) or from combinatorica_compat
-- on behalf of a third-party mod that doesn't know about us.
--
-- @param name string: domain name (usually the mod's technical name)
-- @param def table:
--   title       (string)  human-readable title
--   description (string)  one-line summary of what the domain provides
--   category    (string)  grouping key: "core", "world", "blocks", "player",
--                         "mobs", "tech", "transport", "worldgen",
--                         "voxelibre", "qol", "ui"
--   always_on   (bool)    if true, cannot be disabled via setting
function combinatorica.register_domain(name, def)
    def = def or {}
    def.name = name
    def.title = def.title or name
    def.description = def.description or ""
    def.category = def.category or "misc"
    def.always_on = def.always_on or false
    combinatorica.domains[name] = def
end

-- Look up a single domain's metadata.
-- @param name string
-- @return table or nil
function combinatorica.get_domain(name)
    return combinatorica.domains[name]
end

-- List all registered domains, sorted by (category, name).
-- Useful for admin UIs and debug output.
-- @return array of domain def tables
function combinatorica.list_domains()
    local list = {}
    for _, def in pairs(combinatorica.domains) do
        table.insert(list, def)
    end
    table.sort(list, function(a, b)
        if a.category ~= b.category then
            return a.category < b.category
        end
        return a.name < b.name
    end)
    return list
end

-- Log helper with a consistent [Combinatorica:<domain>] prefix.
-- @param domain string: domain name (e.g. "farming")
-- @param level string: "error", "warning", "action", "info", "verbose"
-- @param message string
function combinatorica.log(domain, level, message)
    core.log(level, "[Combinatorica:" .. domain .. "] " .. message)
end

-- Self-registration: combinatorica_core is always on.
combinatorica.register_domain("combinatorica_core", {
    title = "Combinatorica Core",
    description = "Domain registry, event bus, mod interop, shared group conventions, and feature flags.",
    category = "core",
    always_on = true,
})
