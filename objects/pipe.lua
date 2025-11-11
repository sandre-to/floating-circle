Pipe = Object:extend()

function Pipe:new()
    self.width = 50
    self.height = 100
    self.speed = 220
    self.x = love.graphics.getWidth()
    self.y = love.math.random(self.height, love.graphics.getHeight() - self.height)
end

function Pipe:update(dt)
    self.x = self.x - self.speed * dt
end

function Pipe:draw()
    love.graphics.setColor(1, 1, 1)
    love.graphics.rectangle("line", self.x, self.y, self.width, self.height)
end