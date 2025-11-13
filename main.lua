if arg[2] == "debug" then
    require("lldebugger").start()
end

-- variables
local isAscending = true
local spawnTime = 2
local coinTimer
local player
local listOfCoins

-- ui
local score = 0
local phase = 1

function love.keypressed(key)
    if not phase == 1 then
        player:keyPressed(key)
    end
end

function love.load()
    Object = require "objects.classic"
    require "objects.player"
    require "objects.bullet"
    require "objects.timer"
    require "objects.coin"

    coinTimer = Timer(spawnTime, not isAscending, 300, 300)
    coinTimer.isStarting = true
    player = Player()
    listOfCoins = {}
end

function love.update(dt)
    player:update(dt)
    coinTimer  :update(dt)
    
    if coinTimer.waitTime < 0 then
        coinTimer.waitTime = spawnTime
        spawnTime = spawnTime - dt
        table.insert(listOfCoins, Coin())
    end

    for i, v in ipairs(listOfCoins) do
        v:update(dt)

        if v.x < -50 then
            table.remove(listOfCoins, i)
        end

        if v:checkCollision(player) then
            v.isColliding = true
            if not v.hasPickedUp then
                score = score + 1
                v.hasPickedUp = true
            end
        else
            v.hasPickedUp = false
        end
    end
end

function love.draw()
    player:draw()
    coinTimer:draw()

    for i, v in ipairs(player.ammo) do
        v:draw()
    end

    for i, v in ipairs(listOfCoins) do
        v:draw()
    end

    love.graphics.setFont(love.graphics.newFont(60))
    love.graphics.print(string.format("%.0f", score), love.graphics.getWidth() / 2, 50)
end


local love_errorhandler = love.errorhandler

function love.errorhandler(msg)
    if lldebugger then
        error(msg, 2)
    else
        return love_errorhandler(msg)
    end
end