if arg[2] == "debug" then
    require("lldebugger").start()
end

-- phases
local coinPhase = 0
local shopPhase = 1
local battlePhase = 2

-- variables
local isAscending = true
local player
local buyButton
local listOfCoins

-- timers
local spawnTime = 0.8
local coinTimer
local gameTimer

-- ui
local score = 0
local phase = 0

function love.keypressed(key)
    if phase == battlePhase then
        player:keyPressed(key)
    end
end

function love.mousepressed(x, y, button)
    if phase == shopPhase then
        if button == 1 then
            buyButton:mousePressed()
        end
    end
end

function love.load()
    require "load"

    coinTimer = Timer(spawnTime, not isAscending, 300, 300)
    gameTimer = Timer(0, isAscending, 300, 50)
    coinTimer.started = true
    gameTimer.started = true
    
    player = Player()
    buyButton = Button(200, 200)
    listOfCoins = {}
end

function love.update(dt)
    if phase == coinPhase then
        player:update(dt)
        coinTimer:update(dt)
        gameTimer:update(dt)
    
        if gameTimer.waitTime >= 2 then
            phase = shopPhase
            player.x = (love.graphics.getWidth() / 2) - 200
            gameTimer.waitTime = 0
            gameTimer.started = false
        end
        
        if coinTimer.waitTime < 0 then
            coinTimer.waitTime = spawnTime
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
                    table.remove(listOfCoins, i)
                end
            else
                v.hasPickedUp = false
            end
        end
    end 

    if phase == shopPhase then
        buyButton:update(dt)
    end

    if phase == battlePhase then
        for i=1, #listOfCoins do
            table.remove(listOfCoins, i)
        end
        player:update(dt)

        for i, bullet in ipairs(player.ammo) do
            bullet:update(dt)
        end
    end
end

function love.draw()
    player:draw()
    gameTimer:draw()
    
    if phase == shopPhase then
        buyButton:draw()
    end

    for i, v in ipairs(player.ammo) do
        v:draw()
    end

    for i, v in ipairs(listOfCoins) do
        v:draw()
    end

    love.graphics.setColor(1, 1, 1)
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