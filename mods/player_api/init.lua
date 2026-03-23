-- Player API
-- Manages player models, animations, and visual attachments.

player_api = {}

local registered_models = {}

-- Register a player model.
-- @param name string: model filename (e.g. "character.b3d")
-- @param def table: { textures, animations, collisionbox, stepheight, eye_height }
function player_api.register_model(name, def)
    registered_models[name] = def
end

-- Get a registered model definition.
function player_api.get_model(name)
    return registered_models[name]
end

-- Set a player's model and textures.
function player_api.set_model(player, model_name)
    local model = registered_models[model_name]
    if not model then
        return
    end
    player:set_properties({
        mesh = model_name,
        textures = model.textures or {"character.png"},
        visual = "mesh",
        visual_size = model.visual_size or {x = 1, y = 1},
        collisionbox = model.collisionbox or {-0.3, 0, -0.3, 0.3, 1.7, 0.3},
        stepheight = model.stepheight or 0.6,
        eye_height = model.eye_height or 1.47,
    })
end

-- Set a player's animation.
function player_api.set_animation(player, anim_name, speed)
    local model_name = player:get_properties().mesh
    local model = registered_models[model_name]
    if not model or not model.animations or not model.animations[anim_name] then
        return
    end
    local anim = model.animations[anim_name]
    player:set_animation(anim, speed or model.animation_speed or 30)
end

-- Register default character model
player_api.register_model("character.b3d", {
    textures = {"character.png"},
    animations = {
        stand     = {x = 0,   y = 79},
        lay       = {x = 162, y = 166},
        walk      = {x = 168, y = 187},
        mine      = {x = 189, y = 198},
        walk_mine = {x = 200, y = 219},
        sit       = {x = 81,  y = 160},
    },
    collisionbox = {-0.3, 0, -0.3, 0.3, 1.7, 0.3},
    stepheight = 0.6,
    eye_height = 1.47,
})

-- Set model for joining players
core.register_on_joinplayer(function(player)
    player_api.set_model(player, "character.b3d")
    player_api.set_animation(player, "stand")
end)

core.log("action", "[player_api] Player API loaded")
