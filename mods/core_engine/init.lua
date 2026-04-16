-- Combinatorica Core Engine
-- Domain registry and framework API

-- Global namespace
combinatorica = {}

-- Registry storage
combinatorica.domains = {}

--- Register a domain with the framework.
-- @param name string: mod/domain name (e.g. "core_nodes")
-- @param def table: { title, description, tier, depends }
function combinatorica.register_domain(name, def)
	def.name = name
	combinatorica.domains[name] = def
end

--- Check if a domain is active (mod present AND setting enabled).
-- core_engine is always active.
-- @param domain_name string
-- @return boolean
function combinatorica.is_active(domain_name)
	if domain_name == "core_engine" then
		return true
	end
	-- Is the mod present?
	if minetest.get_modpath(domain_name) == nil then
		return false
	end
	-- Is the setting enabled? (defaults to true)
	return minetest.settings:get_bool("cmb_" .. domain_name, true)
end

--- Get domain info.
-- @param domain_name string
-- @return table or nil
function combinatorica.get_domain(domain_name)
	return combinatorica.domains[domain_name]
end

--- Log helper with domain prefix.
-- @param domain string: domain name
-- @param level string: "action", "warning", "error", etc.
-- @param message string
function combinatorica.log(domain, level, message)
	minetest.log(level, "[Combinatorica:" .. domain .. "] " .. message)
end

-- Register core_engine itself
combinatorica.register_domain("core_engine", {
	title = "Core Engine",
	description = "Domain registry and framework for Combinatorica",
	tier = 0,
})

combinatorica.log("core_engine", "action", "loaded")
