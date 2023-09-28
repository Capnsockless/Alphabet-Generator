require 'utils/helper'

TextBox = {
    x = 0,
    y = 0,
    width = 256,
    height = 32,
    borderwidth = 5,
    title = '',
    limits = '',
    text = '',
    active = false,
    colors = {
        background = { 0.86, 0.9, 0.9, 0.8 },
        text = { 0, 0, 0, 1 },
        border = { 0.42, 0.37, 0.68, 1 },
        activeborder = { 0.97, 0.9, 0.13, 1 }
    }
}

function TextBox:init(name, x, y, text, min, max)
    local o = {}
    setmetatable(o, self)
    self.__index = self
    o.title = name
    o.text = text
    o.limits = '[' .. min .. '; ' .. max .. ']'

    o.x = x
    o.y = y
    return o
end

-- Used for toggling
function TextBox:activate()
    self.active = true
end
function TextBox:deactivate()
    self.active = false
end

-- Checks whether a click was in place or not, activates if it was
function TextBox:check_click(xx, yy)
    local clicked = false
    if between(xx, yy, self.x, self.y, self.x+self.width, self.y+self.height) then
        clicked = true
        self:activate()
    else
        self:deactivate()
    end

    return clicked
end

function TextBox:draw_self()
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

    -- Drawing title
    love.graphics.setColor(unpack(self.colors.text))
    love.graphics.printf(self.title,
        self.x, self.y-4*self.borderwidth,
        self.width, 'left', 0, 1, 1)
    -- Drawing limits
    love.graphics.printf(self.limits,
        self.x, self.y+self.height+2*self.borderwidth,
        self.width, 'left', 0, 1, 1)
    -- Drawing input
    love.graphics.printf(self.text,
        self.x+5, self.y+self.height/5,
        self.width, 'left', 0, 1, 1)
end