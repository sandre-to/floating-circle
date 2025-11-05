local circle = {}

function love.load()
    circle.x = love.graphics.getWidth() / 2
    circle.y = love.graphics.getHeight() / 2
    circle.gravity = 250
    circle.radius = 20
    circle.jumpForce = 10

    timer = 0

    listOfRectangles = {}
end

function love.update(dt)
    timer = timer + dt
    
    if timer > 2 then
        spawnPipes()
        timer = 0
    end

    if listOfRectangles then
        for i, v in ipairs(listOfRectangles) do
            v.x = v.x - v.speed * dt

            if v.x < 50 then
                table.remove(listOfRectangles, i)
            end
        end
    end
    
    -- player gravity
    circle.y = circle.y + circle.gravity * dt

    if love.keyboard.isDown("space") then
        circle.y = circle.y - circle.jumpForce
    end
end

function love.draw()
    love.graphics.circle("fill", circle.x, circle.y, circle.radius)
    
    for i, v in ipairs(listOfRectangles) do
        love.graphics.rectangle("line", v.x, v.y, v.width, v.height)
    end
    
    love.graphics.print(timer, 200, 200)
end

function spawnPipes()
    local pipe = {}
    pipe.x = 800
    pipe.y = love.math.random(0, love.graphics.getHeight())
    pipe.width = 50
    pipe.height = 100
    pipe.speed = 200

    table.insert(listOfRectangles, pipe)
end