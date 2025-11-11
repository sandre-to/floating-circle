if arg[2] == "debug" then
    require("lldebugger").start()
end
 
local isAscending = true
local spawnTime = 2

function love.keypressed(key)
    player:keyPressed(key)
end

function love.load()
    Object = require "objects.classic"
    require "objects.player"
    require "objects.bullet"
    require "objects.timer"
    require "objects.pipe"

    gameTimer = Timer(spawnTime, not isAscending, 300, 300)
    gameTimer.isStarting = true
    player = Player()
    listOfPipes = {}
end

function love.update(dt)
    player:update(dt)
    gameTimer:update(dt)
    
    if gameTimer.waitTime < 0 then
        gameTimer.waitTime = spawnTime
        spawnPipes()
    end

    for i, v in ipairs(player.ammo) do
        v:update(dt)

        if #listOfPipes > 0 then
            for index, pipe in ipairs(listOfPipes) do
                v:checkCollision(pipe)

            end
        end

        if v.isColliding then
            v.dead = true
            table.remove(player.ammo, i)
        end
    end

    for i, v in ipairs(listOfPipes) do
        v:update(dt)

        if v.x < 0 then
            table.remove(listOfPipes, i)
        end
    end
end

function love.draw()
    player:draw()
    gameTimer:draw()

    for i, v in ipairs(player.ammo) do
        v:draw()
    end

    for i, v in ipairs(listOfPipes) do
        v:draw()
    end
end

function spawnPipes()
    table.insert(listOfPipes, Pipe())
end


local love_errorhandler = love.errorhandler

function love.errorhandler(msg)
    if lldebugger then
        error(msg, 2)
    else
        return love_errorhandler(msg)
    end
end