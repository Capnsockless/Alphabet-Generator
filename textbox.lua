TextBox = {
    x = 0,
    y = 0,
    width = 256,
    height = 64,
    borderwidth = 5,
    text = '',
    active = false,
    colors = {
        background = { 0.76, 0.85, 0.75, 0.8 },
        text = { 0.05, 0.07, 0.07, 1 },
        border = { 0.2, 0.2, 0.5, 1 },
        activeborder = { 0.8, 0.8, 0.2, 0.96 }
    }
}

function TextBox:init(x, y)
    local o = {}
    setmetatable(o, self)
    self.__index = self
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
    if (xx >= self.x and xx <= self.x+self.width and yy >= self.y and yy <= self.y+self.height) then
        clicked = true
        self:activate()
    else
        self:deactivate()
    end
    -- Returns true to let the main program stop checking
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

    -- Drawing text
    love.graphics.setColor(unpack(self.colors.text))
    love.graphics.printf(self.text,
        self.x, self.y,
        self.width, 'left')    
end