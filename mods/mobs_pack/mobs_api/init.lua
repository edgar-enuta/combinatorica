-- Mobs API
-- Core mob engine (Mobs Redo-style).

if not combinatorica.features.mobs then
    core.log("action", "[mobs_api] Mobs disabled by feature flag")
    return
end

mobs = {}
mobs.registered_mobs = {}

-- Register a mob entity.
function mobs.register_mob(name, def)
    def.name = name
    mobs.registered_mobs[name] = def

    local entity_def = {
        hp_max = def.hp_max or 10,
        physical = true,
        collisionbox = def.collisionbox or {-0.4, -0.5, -0.4, 0.4, 1.0, 0.4},
        visual = def.visual or "mesh",
        mesh = def.mesh,
        textures = def.textures or {"mobs_default.png"},
        makes_footstep_sound = true,
        view_range = def.view_range or 16,
        walk_velocity = def.walk_velocity or 1,
        run_velocity = def.run_velocity or 2,
        damage = def.damage or 0,
        attack_type = def.attack_type,
        drops = def.drops or {},

        -- Simple AI state
        _state = "idle",
        _timer = 0,

        on_activate = function(self, staticdata)
            self.object:set_armor_groups({fleshy = 100})
        end,

        on_step = function(self, dtime)
            self._timer = self._timer + dtime
            if self._timer < 1 then return end
            self._timer = 0

            -- Basic wandering AI
            if self._state == "idle" then
                if math.random(1, 3) == 1 then
                    local yaw = math.random() * math.pi * 2
                    self.object:set_yaw(yaw)
                    local dir = vector.new(
                        math.cos(yaw) * self.walk_velocity,
                        0,
                        math.sin(yaw) * self.walk_velocity
                    )
                    self.object:set_velocity(dir)
                    self._state = "walk"
                end
            elseif self._state == "walk" then
                if math.random(1, 4) == 1 then
                    self.object:set_velocity(vector.new(0, 0, 0))
                    self._state = "idle"
                end
            end
        end,

        on_punch = function(self, hitter, time_from_last_punch, tool_capabilities, dir)
            if self.hp_max then
                local hp = self.object:get_hp()
                if hp <= 0 then
                    -- Drop items
                    local pos = self.object:get_pos()
                    for _, drop in ipairs(self.drops) do
                        if math.random(1, drop.chance or 1) == 1 then
                            local count = math.random(drop.min or 1, drop.max or 1)
                            core.add_item(pos, ItemStack(drop.name .. " " .. count))
                        end
                    end
                    combinatorica.emit("mob_died", {
                        name = self.name,
                        pos = pos,
                        killer = hitter and hitter:get_player_name() or nil,
                    })
                end
            end
        end,

        get_staticdata = function(self)
            return ""
        end,
    }

    -- Copy relevant fields
    entity_def.walk_velocity = def.walk_velocity or 1
    entity_def.run_velocity = def.run_velocity or 2
    entity_def.drops = def.drops or {}

    core.register_entity(name, entity_def)
end

-- Register a mob spawn rule.
function mobs.register_spawn(def)
    core.register_abm({
        label = "Mob spawn: " .. def.name,
        nodenames = def.nodes or {"default:dirt_with_grass"},
        interval = def.interval or 30,
        chance = def.chance or 5000,
        action = function(pos)
            local above = vector.add(pos, vector.new(0, 1, 0))
            local node_above = core.get_node(above)
            if node_above.name == "air" then
                local light = core.get_node_light(above)
                if light then
                    local min_light = def.min_light or 0
                    local max_light = def.max_light or 15
                    if light >= min_light and light <= max_light then
                        core.add_entity(above, def.name)
                    end
                end
            end
        end,
    })
end

core.log("action", "[mobs_api] Mob engine loaded")
