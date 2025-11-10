Bullet = Object:extend()

function Bullet:new(holder)
    self.x = holder.x
    self.y = holder.y
    self.radius = 20
    self.speed = 300
end

function Bullet:update(dt)
    self.x = self.x + self.speed * dt
end

function Bullet:draw()
    love.graphics.circle("fill", self.x, self.y, self.radius)
end