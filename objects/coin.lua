Coin = Object:extend()

function Coin:new()
    self.width = 50
    self.height = 50
    self.speed = 220
    self.x = love.graphics.getWidth()
    self.y = love.math.random(self.height, love.graphics.getHeight() - self.height)
    self.isColliding = false
    self.hasPickedUp = false
    self.dead = false
end

function Coin:update(dt)
    self.x = self.x - self.speed * dt
end

function Coin:draw()
    local mode
    love.graphics.setColor(1, 1, 1)
    if self.isColliding then mode = "fill" else mode = "line" end
    love.graphics.rectangle(mode, self.x, self.y, self.width, self.height)
end

function Coin:checkCollision(obj)
    local a_left    = self.x
    local a_right   = self.x + self.width
    local a_top     = self.y
    local a_bottom  = self.y + self.height

    local b_left    = obj.x
    local b_right   = obj.x + obj.width
    local b_top     = obj.y
    local b_bottom  = obj.y + obj.height

    if  a_left < b_right and
        a_right > b_left and
        a_bottom > b_top and
        a_top < b_bottom then
        self.isColliding = true
        return true
    else
        self.isColliding = false
        return false
    end
end