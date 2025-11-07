local circle = {}

function love.load()
    circle.x = love.graphics.getWidth() / 2
    circle.y = love.graphics.getHeight() / 2
    circle.gravity = 250
    circle.radius = 20
    circle.jumpForce = 10

    -- Collision shape
    collShape = {}
    collShape.x = circle.x
    collShape.y = circle.y
    collShape.width = 30
    collShape.height = 30   

    timer = 0

    listOfPipes = {}
end

function love.update(dt)
    timer = timer + dt
    
    if timer > 1.2 then
        spawnPipe()
        timer = 0
    end

    if listOfPipes then
        for i, v in ipairs(listOfPipes) do
            v.x = v.x - v.speed * dt

            if v.x < 50 then
                table.remove(listOfPipes, i)
            end

            checkCollision(v, collShape)
        end
    end

    -- player gravity
    circle.y = circle.y + circle.gravity * dt

    if circle.y > love.graphics.getHeight() then
        circle.y = 0
    elseif circle.y < 0 then
        circle.y = love.graphics.getHeight()
    end 
    
    if love.keyboard.isDown("space") then
        circle.y = circle.y - circle.jumpForce
    end
    
    collShape.x = circle.x - 15
    collShape.y = circle.y - 15
end

function love.draw()
    love.graphics.circle("line", circle.x, circle.y, circle.radius)
    love.graphics.rectangle("line", collShape.x, collShape.y, collShape.width, collShape.height)

    for i, v in ipairs(listOfPipes) do

        if checkCollision(v, collShape) then
            love.graphics.rectangle("fill", v.x, v.y, v.width, v.height)
        else
            love.graphics.rectangle("line", v.x, v.y, v.width, v.height)
        end
    end
    
    love.graphics.print(timer, 200, 200)
end

function spawnPipe()
    local pipe = {}
    pipe.x = 800
    pipe.y = love.math.random(0, love.graphics.getHeight())
    pipe.width = 50
    pipe.height = 100
    pipe.speed = 200

    table.insert(listOfPipes, pipe)
end

function checkCollision(a, b)
    local a_left = a.x
    local a_right = a.x + a.width
    local a_top = a.y
    local a_bottom = a.y + a.height

    local b_left = b.x
    local b_right = b.x + b.width
    local b_top = b.y
    local b_bottom = b.y + b.height

    if  a_right > b_left and 
        a_left < b_right and 
        a_bottom > b_top and 
        a_top < b_bottom then
        return true
    else
        return false
    end
end