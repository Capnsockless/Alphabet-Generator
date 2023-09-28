require 'UI/button'
require 'UI/letter/cell'

Canvas = {
	x = 0,
	y = 0,
    width = 0,
    height = 0,
    borderwidth = 3,
    cells = {},
    handler = {},
    params = {},
    colors = {
    	background = { 0.86, 0.9, 0.9, 0.8 },
        border = { 0.6, 0.45, 0.87, 1 }
    }
}

-- Doesn't take in x and y, takes width and height of the window and fills most of it
function Canvas:init(handler, w)
    local o = {}
    setmetatable(o, self)
    self.__index = self
    
    o.width = w * 0.95
    o.height = (o.width*7)/15

    o.x = (w - o.width)/2
    o.y = o.x

    o.handler = handler
    o.params = handler.params
    love.math.setRandomSeed(handler:get_value("seed"))

    local ncells = handler:get_value("amount") -- Gets the amount of letters requested

    -- 15x6 grid max
    local ii = 15

    local cellsize = o.width/ii

    -- Placing the cells
    for i=0,ncells do
        o.cells[i+1] = Cell:init(handler, o.x + (i%ii)*cellsize, o.y + math.floor(i/ii)*cellsize, cellsize)
    end

    return o
end

function Canvas:reset()
    self.params = self.handler.params
    love.math.setRandomSeed(self.handler:get_value("seed"))

    local ncells = self.handler:get_value("amount") -- Gets the amount of letters requested
    
    -- 15x6 grid max
    local ii = 15

    local cellsize = self.width/ii

    -- Placing the cells
    self.cells = {}

    for i=0,ncells-1 do
        self.cells[i+1] = Cell:init(self.handler, self.x + (i%ii)*cellsize, self.y + math.floor(i/ii)*cellsize, cellsize)
    end
end

function Canvas:update(dt)
    for i=1, #self.cells do
        self.cells[i]:decide()
    end
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

    for i=1, #self.cells do
        self.cells[i]:draw_self()
    end
end