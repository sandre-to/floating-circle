Player = Object:extend()

local isAscending = true

function Player:new()
    -- player
    self.width = 50
    self.height = 50
    self.speed = 250
    self.x = love.graphics.getWidth() / 2 - self.width / 2
    self.y = love.graphics.getHeight() / 2
    
    -- weapon/ammo
    self.ammo = {}
    self.weapons = {}
    self.fireRate = Timer(0.8, not isAscending, 200, 200)
    self.canFire = true
end

function Player:keyPressed(key)
    if key == "space" and self.canFire == true then
        table.insert(self.ammo, Bullet(self))
        self.fireRate.started = true
        self.canFire = false
    end
end

function Player:update(dt)
    self.fireRate:update(dt)
    if self.fireRate.waitTime < 0 then
        self.fireRate.waitTime = 2
        self.canFire = true
        self.fireRate.started = false
    end
    
    if love.keyboard.isDown("up") then
        self.y = self.y - self.speed * dt
    end

    if love.keyboard.isDown("down") then
        self.y = self.y + self.speed * dt
    end

    if self.y > love.graphics.getHeight() + self.height then
        self.y = 0
    elseif self.y < 0 - self.height then
        self.y = love.graphics.getHeight() - self.height
    end
end

function Player:draw()
    love.graphics.setColor(1, 1, 1)
    love.graphics.rectangle("fill", self.x, self.y, self.width, self.height)
end