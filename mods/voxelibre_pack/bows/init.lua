-- Bows & Arrows
-- Ranged combat system.

if not combinatorica.is_domain_enabled("bows") then return end

bows = {}

core.register_craftitem("bows:arrow", {
    description = "Arrow",
    inventory_image = "bows_arrow.png",
    groups = {ammunition = 1},
})

core.register_tool("bows:bow", {
    description = "Bow",
    inventory_image = "bows_bow.png",
    on_use = function(itemstack, user, pointed_thing)
        local inv = user:get_inventory()
        if inv:contains_item("main", "bows:arrow") then
            inv:remove_item("main", "bows:arrow 1")
            local pos = user:get_pos()
            pos.y = pos.y + 1.5
            local dir = user:get_look_dir()
            local entity = core.add_entity(pos, "bows:arrow_entity")
            if entity then
                entity:set_velocity(vector.multiply(dir, 20))
                entity:set_acceleration(vector.new(0, -9.8, 0))
            end
            itemstack:add_wear(65535 / 384)
            combinatorica.emit("arrow_shot", {player = user:get_player_name(), pos = pos})
        end
        return itemstack
    end,
})

-- Arrow entity
core.register_entity("bows:arrow_entity", {
    physical = true,
    collisionbox = {-0.1, -0.1, -0.1, 0.1, 0.1, 0.1},
    visual = "sprite",
    textures = {"bows_arrow.png"},
    _timer = 0,
    _damage = 6,
    on_step = function(self, dtime)
        self._timer = self._timer + dtime
        if self._timer > 10 then self.object:remove() return end
        local pos = self.object:get_pos()
        local node = core.get_node(pos)
        if node.name ~= "air" and node.name ~= "ignore" then
            self.object:remove()
        end
    end,
    on_activate = function(self) self.object:set_armor_groups({immortal = 1}) end,
})

core.register_craft({
    output = "bows:bow",
    recipe = {
        {"", "default:stick", "farming:cotton"},
        {"default:stick", "", "farming:cotton"},
        {"", "default:stick", "farming:cotton"},
    },
})

core.register_craft({
    output = "bows:arrow 4",
    recipe = {
        {"default:steel_ingot"},
        {"default:stick"},
        {""},
    },
})

core.log("action", "[bows] Bows loaded")
