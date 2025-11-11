Timer = Object:extend()

function Timer:new(time, ascending, x, y)
    self.x = x
    self.y = y
    self.waitTime = time
    self.isStarting = false
    self.isAscending = ascending
    self.font = love.graphics.newFont(24)
end

function Timer:update(dt)
    if self.isStarting then
        if self.isAscending then
            self.waitTime = self.waitTime + dt
        else
            self.waitTime = self.waitTime - dt
        end
    end
end

function Timer:draw()
    love.graphics.setColor(1, 0, 0)
    love.graphics.setFont(self.font)
    love.graphics.print(string.format("%.2f", self.waitTime), self.x, self.y)
end