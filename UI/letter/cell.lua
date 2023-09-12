require 'UI/letter/point'

Cell = {
	x = 0,
	y = 0,
	
	width = 0,
	height = 0,

	fr = 0, -- Current frame index
	points = {} -- Array to hold all the circles
}

function Cell:init(x, y, w, h)
	local o = {}
    setmetatable(o, self)
    self.__index = self
	o.x = x
	o.y = y
	o.width = w
	o.height = h

	return o
end

function Cell:add_point()
	fr = fr + 1

	local xa = 0
	local ya = 0
	local ra = 0

	points[fr] = Point:init(x + xa, y + ya, ra)
end

-- This is where the magic randomness happens
function Cell:decide()

end

function Cell:draw_self()
	for i=1, #points do
		points:draw_self()
	end
end