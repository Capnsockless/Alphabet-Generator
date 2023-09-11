require 'UI/button'

Board = {
	width = 0,
    height = 0,

    Parameters = {},

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

    -- Creating Button
    self.button = Button:init((self.width-Button.width)/2, posY) -- yy is already appended anyway
end

function Board:update(dt)

end

function Board:draw()


    self.button:draw_self()
end

function Board:mousepressed(x, y)
    -- Checking button
    local bclick = self.button:check_click(x, y)
    if bclick then
        
    end
end