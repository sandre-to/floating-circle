if arg[2] == "debug" then
    require("lldebugger").start()
end

function love.load()
    Object = require "objects.classic"
    require "objects.player"
    require "objects.timer"

    player = Player()
    gameTimer = Timer(0, true)
    listofPipes = {}
end

function love.update(dt)
    player:update(dt)
    gameTimer:update(dt)
end

function love.draw()
    player:draw()
    gameTimer:draw()
end

function spawnPipes()
    pipe = Pipe()
    table.insert(listofPipes, pipe)
end

local love_errorhandler = love.errorhandler

function love.errorhandler(msg)
    if lldebugger then
        error(msg, 2)
    else
        return love_errorhandler(msg)
    end
end