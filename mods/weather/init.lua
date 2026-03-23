-- Weather System
-- Dynamic weather with rain, snow, and thunderstorms.

local weather = {}
local current_weather = "clear"
local weather_timer = 0
local WEATHER_CHANGE_INTERVAL = 300 -- 5 minutes

local WEATHER_TYPES = {"clear", "rain", "snow", "thunder"}

function weather.get_current()
    return current_weather
end

function weather.set(weather_type)
    if current_weather ~= weather_type then
        current_weather = weather_type
        combinatorica.emit("weather_changed", {weather = weather_type})
        core.log("action", "[weather] Weather changed to: " .. weather_type)
    end
end

core.register_globalstep(function(dtime)
    weather_timer = weather_timer + dtime
    if weather_timer < WEATHER_CHANGE_INTERVAL then return end
    weather_timer = 0

    -- Random weather change
    local roll = math.random(1, 100)
    if roll <= 60 then
        weather.set("clear")
    elseif roll <= 80 then
        weather.set("rain")
    elseif roll <= 95 then
        weather.set("snow")
    else
        weather.set("thunder")
    end
end)

core.log("action", "[weather] Weather system loaded")
