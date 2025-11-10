Timer = Object:extend()

function Timer:new(time, ascending)
    self.waitTime = time
    self.hasStopped = false
    self.isAscending = ascending
    self.font = love.graphics.newFont(24)
end

function Timer:update(dt)
    if self.isAscending then
        self.waitTime = self.waitTime + dt
    else
        self.waitTime = self.waitTime - dt
    end
end

function Timer:draw()
    love.graphics.setColor(1, 0, 0)
    love.graphics.setFont(self.font)
    love.graphics.print(
        string.format("%.2f", self.waitTime),
        (love.graphics.getWidth() / 2), 50
    )
end