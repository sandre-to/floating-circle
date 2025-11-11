Bullet = Object:extend()

function Bullet:new(holder)
    self.x = holder.x
    self.y = holder.y
    self.radius = 20
    self.speed = 300
    self.isColliding = false
    self.dead = false
end

function Bullet:update(dt)
    self.x = self.x + self.speed * dt
end

function Bullet:draw()
    local mode
    love.graphics.setColor(0, 1, 0)
    if self.isColliding then mode = "fill" else mode = "line" end
    love.graphics.circle(mode, self.x, self.y, self.radius)
end

function Bullet:checkCollision(obj)
    local a_left    = self.x - self.radius
    local a_right   = self.x + self.radius
    local a_top     = self.y - self.radius
    local a_bottom  = self.y + self.radius

    local b_left    = obj.x
    local b_right   = obj.x + obj.width
    local b_top     = obj.y
    local b_bottom  = obj.y + obj.height

    if  a_right > b_left and
        a_left < b_right and
        a_bottom > b_top and
        a_top < b_bottom then
        self.isColliding = true
        return true
    else
        self.isColliding = false
        return false
    end
end