Player = Object:extend()

function Player:new()
    self.x = love.graphics.getWidth() / 2
    self.y = love.graphics.getHeight() / 2
    self.radius = 30
    self.speed = 200
end

function Player:keyPressed(key)
    if key == "space" then
        table.insert(ammo, Bullet(self))
    end
end

function Player:update(dt)
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
end