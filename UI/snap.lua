require 'utils/helper'

-- Another button but it takes screenshots, pretty unnecessary but I got lazy to do it properly(making it another type of Button)
Snap = {
	x = 0,
	y = 0,
    width = 180,
    height = 64,
    borderwidth = 5,
	text = 'Take screenshot',
	active = false,
    colors = {
        background = { 0.86, 0.9, 0.9, 0.8 },
        text = { 0, 0, 0, 1 },
        border = { 0.6, 0.45, 0.87, 1 },
        activeborder = { 0.97, 0.9, 0.13, 1 }
    }
}

function Snap:init(x, y)
    local o = {}
    setmetatable(o, self)
    self.__index = self
    o.x = x
    o.y = y

    return o
end

function Snap:check_click(xx, yy)
    return between(xx, yy, self.x, self.y, self.x+self.width, self.y+self.height)
end    

function Snap:draw_self()
    -- Drawing the border
    local current = self.colors.border
    if self.active then current = self.colors.activeborder end
    love.graphics.setColor(unpack(current))
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