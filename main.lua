if arg[2] == "debug" then
    require("lldebugger").start()
end

function love.keypressed(key)
    player:keyPressed(key)
end

function love.load()
    Object = require "objects.classic"
    require "objects.player"
    require "objects.bullet"
    require "objects.timer"

    player = Player()
    ammo = {}
end


function love.update(dt)
    player:update(dt)

    for i, v in ipairs(ammo) do
        v:update(dt)
    end
end

function love.draw()
    player:draw()

    for i, v in ipairs(ammo) do
        v:draw()
    end
end

local love_errorhandler = love.errorhandler

function love.errorhandler(msg)
    if lldebugger then
        error(msg, 2)
    else
        return love_errorhandler(msg)
    end
end