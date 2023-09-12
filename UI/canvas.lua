require 'UI/button'

Canvas = {
	x = 0,
	y = 0,
    width = 0,
    height = 0,
    borderwidth = 3,
    colors = {
    	background = { 0.87, 0.85, 0.86, 1 },
    	text = { 0.05, 0.07, 0.07, 1 },
    	border = { 0.2, 0.2, 0.5, 1 },
    }
}

-- Doesn't take in x and y, takes width and height of the window and fills most of it
function Canvas:init(w, h)
    local o = {}
    setmetatable(o, self)
    self.__index = self
    
    o.width = w * 0.95
    o.height = h * 0.8

    o.x = (w - o.width)/2
    o.y = o.x

    return o
end

function Canvas:draw_self()
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
end