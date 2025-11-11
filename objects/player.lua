Player = Object:extend()

local isAscending = true

function Player:new()
    self.x = love.graphics.getWidth() / 2
    self.y = love.graphics.getHeight() / 2
    self.radius = 30
    self.speed = 200
    self.ammo = {}
    self.fireRate = Timer(2, not isAscending, 200, 200)
    self.canFire = true
end

function Player:keyPressed(key)
    if key == "space" and self.canFire == true then
        table.insert(self.ammo, Bullet(self))
        self.fireRate.isStarting = true
        self.canFire = false
    end
end

function Player:update(dt)
    self.fireRate:update(dt)
    if self.fireRate.waitTime < 0 then
        self.fireRate.waitTime = 2
        self.canFire = true
        self.fireRate.isStarting = false
    end
    
    if love.keyboard.isDown("up") then
        self.y = self.y - self.speed * dt
    end

    if love.keyboard.isDown("down") then
        self.y = self.y + self.speed * dt
    end

    if self.y > love.graphics.getHeight() then
        self.y = 0 + self.radius / 2
    elseif self.y < 0 then
        self.y = love.graphics.getHeight() - self.radius / 2
    end
end

function Player:draw()
    love.graphics.setColor(1, 1, 1)
    love.graphics.circle("fill", self.x, self.y, self.radius)
    self.fireRate:draw()
end