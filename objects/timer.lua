Timer = Object:extend()

function Timer:new(time, ascending, x, y)
    self.x = x
    self.y = y
    self.waitTime = time
    self.started = false
    self.isAscending = ascending
    self.font = love.graphics.newFont(36)
end

function Timer:update(dt)
    if self.started then
        if self.isAscending then
            self.waitTime = self.waitTime + dt
        else
            self.waitTime = self.waitTime - dt
        end
    end
end

function Timer:draw()
    love.graphics.setColor(1, 1, 1)
    love.graphics.setFont(self.font)
    love.graphics.print(string.format("%.2f", self.waitTime), self.x, self.y)
end