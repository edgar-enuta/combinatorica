-- The End
-- Second alternate dimension accessible via End portal.

if not combinatorica.is_domain_enabled("the_end") then return end

the_end = {}

local END_DEPTH = -27000

-- End nodes
core.register_node("the_end:endstone", {
    description = "End Stone",
    tiles = {"the_end_endstone.png"},
    groups = {cracky = 2, level = 2},
})

core.register_node("the_end:purpur_block", {
    description = "Purpur Block",
    tiles = {"the_end_purpur.png"},
    groups = {cracky = 2, building = 1},
})

core.register_node("the_end:chorus_plant", {
    description = "Chorus Plant",
    tiles = {"the_end_chorus_plant.png"},
    groups = {choppy = 2},
})

core.register_craftitem("the_end:chorus_fruit", {
    description = "Chorus Fruit",
    inventory_image = "the_end_chorus_fruit.png",
    on_use = function(itemstack, user)
        -- Random teleport nearby
        local pos = user:get_pos()
        local new_pos = vector.new(
            pos.x + math.random(-8, 8),
            pos.y,
            pos.z + math.random(-8, 8)
        )
        user:set_pos(new_pos)
        itemstack:take_item()
        return itemstack
    end,
    groups = {food = 1},
})

core.register_craftitem("the_end:ender_pearl", {
    description = "Ender Pearl",
    inventory_image = "the_end_ender_pearl.png",
    on_use = function(itemstack, user)
        local pos = user:get_pos()
        pos.y = pos.y + 1.5
        local dir = user:get_look_dir()
        local entity = core.add_entity(pos, "the_end:pearl_entity")
        if entity then
            entity:set_velocity(vector.multiply(dir, 15))
            entity:set_acceleration(vector.new(0, -9.8, 0))
            entity:get_luaentity()._thrower = user:get_player_name()
        end
        itemstack:take_item()
        return itemstack
    end,
})

core.register_entity("the_end:pearl_entity", {
    physical = true,
    collisionbox = {-0.1, -0.1, -0.1, 0.1, 0.1, 0.1},
    visual = "sprite",
    textures = {"the_end_ender_pearl.png"},
    _thrower = nil,
    _timer = 0,
    on_step = function(self, dtime)
        self._timer = self._timer + dtime
        if self._timer > 5 then self.object:remove() return end
        local pos = self.object:get_pos()
        local node = core.get_node(pos)
        if node.name ~= "air" and node.name ~= "ignore" then
            if self._thrower then
                local player = core.get_player_by_name(self._thrower)
                if player then
                    player:set_pos(pos)
                    player:set_hp(player:get_hp() - 5, "ender_pearl")
                end
            end
            self.object:remove()
        end
    end,
    on_activate = function(self) self.object:set_armor_groups({immortal = 1}) end,
})

-- End portal frame
core.register_node("the_end:portal_frame", {
    description = "End Portal Frame",
    tiles = {"the_end_portal_frame_top.png", "the_end_portal_frame_bottom.png", "the_end_portal_frame_side.png"},
    groups = {cracky = -1, unbreakable = 1},
    paramtype2 = "facedir",
})

core.log("action", "[the_end] End dimension loaded")
