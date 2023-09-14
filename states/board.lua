require 'UI/button'
require 'UI/canvas'


Board = {
	width = 0,
    height = 0,

    Parameters = {},

    button = {},
    canvas = {},

    curr = 1 -- Index of current character being drawn
}

function Board:init(w, h)
    self.width = w
    self.height = h

    self.Parameters = Handler.params

    -- Creating the input textboxes
    --- Two columns
    local nrows = #self.Parameters/2
    local posY = 30 + (nrows*(self.height - 240))/(2*(nrows-1))

    -- Creating Canvas
    self.canvas = Canvas:init(self.width, self.height)

    -- Creating Button
    self.button = Button:init((self.width-Button.width)/2, (self.height-Button.height)*0.94, 'Back') -- yy is already appended anyway
end

function Board:reset()
    self.canvas = Canvas:init(self.width, self.height) -- Just replace the old one, GC should handle it
end

function Board:update(dt)
    self.canvas:update(dt)
end

function Board:draw()
    self.canvas:draw_self()
    self.button:draw_self()
end

function Board:mousepressed(x, y)
    return self.button:check_click(x, y)
end