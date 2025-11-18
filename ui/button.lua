Button = Object:extend()

function Button:new(x, y)
    self.x = x
    self.y = y
    self.width = 100
    self.height = 40
    
    
    self.color = {0.3, 0.8, 0.4}
    self.hoverColor = {0.2, 0.4, 0.7}
    
    self.isHovered = false
    self.text = "Press here!"
    self.onClick = function ()
        print("Button clicked")
    end
end

function Button:mousePressed()
    if self.isHovered then
        self.onClick()
    end
end

function Button:update(dt)
    local mouse_x, mouse_y = love.mouse.getPosition()

    if  mouse_x > self.x and 
        mouse_x < self.x + self.width and
        mouse_y > self.y and
        mouse_y < self.y + self.height then
        self.isHovered = true
    else
        self.isHovered = false
    end
end

function Button:draw()
    if self.isHovered then
        love.graphics.setColor(self.hoverColor)
    else
        love.graphics.setColor(self.color)
    end

    love.graphics.rectangle("fill", self.x, self.y, self.width, self.height)
    
    --love.graphics.setColor(1, 1, 1)
    --love.graphics.print(self.text, self.x + self.width / 2, self.y + self.height / 2)
end