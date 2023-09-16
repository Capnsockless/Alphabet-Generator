require 'UI/letter/point'
require 'utils/JSONHandler'
require 'utils/helper'

Cell = {
	x = 0,
	y = 0,
	
	size = 0,

	points = {}, -- Array to hold all the circles

	nframes = 0, -- Amount of circles
	fr = 0, -- Current frame index / how many circles are drawn
	cr = 0, -- Current size of circle (intensity of pen press)
	dir = 0, -- Direction the pen is going in
	xpos = 0, -- Current position of the pen
	ypos = 0,
}

function Cell:init(x, y, s)
	local o = {}
    setmetatable(o, self)
    self.__index = self
	o.x = x
	o.y = y
	o.size = s

	o.nframes = love.math.random(10, 30)

	o:reset_pen()

	return o
end

function Cell:add_point()
	self.fr = self.fr + 1

	self.points[self.fr] = Point:init(self.x + self.xpos, self.y + self.ypos, self.cr)
end

function Cell:reset_pen()
	self.cr = love.math.random()*3 + 1
	self.dir = love.math.random()*math.pi*2
	self.xpos = love.math.random()*self.size
	self.ypos = love.math.random()*self.size
end

-- This is where the magic randomness happens
function Cell:decide()
	if self.fr >= self.nframes then return end

	self.cr = self.cr + love.math.random() - 0.5 -- Varies the size a tiny bit
	self.dir = clamp(self.dir + love.math.random() - 0.5, 0, math.pi)

	-- Calculate the deltas
	local dx = self.cr*math.cos(self.dir)
	local dy = self.cr*math.sin(self.dir)

	self.xpos = self.xpos + dx
	self.ypos = self.ypos + dy

	self:add_point()
end

function Cell:draw_self()
	-- Drawing the border
    love.graphics.setColor(0.4, 0.22, 0.69, 1)
    love.graphics.rectangle('line',
        self.x, self.y,
        self.size, self.size)


	for i=1, #self.points do
		self.points[i]:draw_self()
	end
end