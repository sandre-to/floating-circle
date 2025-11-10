Pipe = Object:extend()

function Pipe:new()
    self.x = love.graphics.getWidth() + self.width
    self.y = love.math.random(self.height, love.graphics.getHeight() - self.height)
    self.width = 30
    self.height = 60
    self.speed = 220
end

function Pipe:update(dt)
    self.x = self.x - self.speed * dt
end

function Pipe:draw()
    love.graphics.rectangle("line", self.x, self.y, self.width, self.height)
end

function Pipe:CheckCollision(other)
    local a_left = self.x
    local a_right = self.x + self.width
    local a_top = self.y
    local a_bottom = self.y + self.height

    local b_left = other.x
    local b_right = other.x + other.width
    local b_top = other.y
    local b_bottom = other.y + other.height

    if  a_right > b_left and
        a_left < b_right and
        a_bottom > b_top and
        a_top < b_bottom then
        return true
    else
        return false
    end
end