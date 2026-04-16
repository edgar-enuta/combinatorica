-- Fireworks

if not combinatorica.is_domain_enabled("fireworks") then return end

core.register_craftitem("fireworks:rocket", {
    description = "Firework Rocket",
    inventory_image = "fireworks_rocket.png",
    on_use = function(itemstack, user, pointed_thing)
        local pos = user:get_pos()
        pos.y = pos.y + 1
        local entity = core.add_entity(pos, "fireworks:rocket_entity")
        if entity then
            entity:set_velocity(vector.new(0, 15, 0))
            entity:set_acceleration(vector.new(0, -2, 0))
        end
        itemstack:take_item()
        return itemstack
    end,
})

core.register_entity("fireworks:rocket_entity", {
    physical = false,
    visual = "sprite",
    textures = {"fireworks_rocket.png"},
    _timer = 0,
    on_step = function(self, dtime)
        self._timer = self._timer + dtime
        if self._timer > 2 then
            local pos = self.object:get_pos()
            core.add_particlespawner({
                amount = 50, time = 0.5,
                minpos = vector.add(pos, -2), maxpos = vector.add(pos, 2),
                minvel = {x=-3,y=-3,z=-3}, maxvel = {x=3,y=3,z=3},
                minacc = {x=0,y=-5,z=0}, maxacc = {x=0,y=-5,z=0},
                minexptime = 1, maxexptime = 2,
                minsize = 2, maxsize = 4,
                texture = "fireworks_particle.png",
                glow = 14,
            })
            self.object:remove()
        end
    end,
    on_activate = function(self) self.object:set_armor_groups({immortal = 1}) end,
})

core.register_craft({output = "fireworks:rocket 3", recipe = {
    {"", "default:paper", ""},
    {"", "default:coal_lump", ""},
    {"", "default:paper", ""},
}})

core.log("action", "[fireworks] Fireworks loaded")
