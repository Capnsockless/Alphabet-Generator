require 'utils/helper'

Button = {
	x = 0,
	y = 0,
    width = 180,
    height = 64,
    borderwidth = 5,
	text = '',
    active = false,
    colors = {
        background = { 0.76, 0.85, 0.75, 0.8 },
        text = { 0.05, 0.07, 0.07, 1 },
        border = { 0.2, 0.2, 0.5, 1 },
    }
}

function Button:init(x, y, t)
    local o = {}
    setmetatable(o, self)
    self.__index = self
    
    o.x = x
    o.y = y
    o.text = t

    return o
end

function Button:check_click(xx, yy)
    return between(xx, yy, self.x, self.y, self.x+self.width, self.y+self.height)
end    

function Button:draw_self()
    -- Drawing the border
    love.graphics.setColor(unpack(self.colors.border))
    love.graphics.rectangle('fill',
        self.x-self.borderwidth, self.y-self.borderwidth,
        self.width+2*self.borderwidth, self.height+2*self.borderwidth)

    -- Draw the "flesh" of the box
    love.graphics.setColor(unpack(self.colors.background))
    love.graphics.rectangle('fill',
        self.x, self.y,
        self.width, self.height)

    -- Drawing text
    love.graphics.setColor(unpack(self.colors.text))
    love.graphics.printf(self.text,
        self.x, self.y+self.height/3,
        self.width, 'center', 0, 1, 1)
end