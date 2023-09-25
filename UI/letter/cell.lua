require 'UI/letter/point'
require 'utils/helper'

Cell = {
	x = 0,
	y = 0,
	
	size = 0,

	points = {}, -- Array to hold all the circles

	nframes = 0, -- Amount of circles
	roughness = 0, -- How intensely the direction changes
	maxroughness = 0, -- Not one of the input values
	strokes = 0, -- Amount of individual strokes, decrements till 0
	dirchanges = 0, -- Amount of times the directon of the pen changes, decrements till 0
	maxwidth = 0,
	maxheight = 0,

	cframes = 0, -- Amount of circles drawn, increases
	cr = 0, -- Current size of circle (intensity of pen press)
	angle = 0, -- Angle the pen is going in, 0 degrees is the Ox axis
	direction = 0, -- Direction the pen is turning towards (recursively increment dir towards this)
	xpos = 0, -- Current position of the pen
	ypos = 0,
}

function Cell:init(handler, x, y, s)
	local o = {}
    setmetatable(o, self)
    self.__index = self
	o.x = x
	o.y = y
	o.size = s

	local val = handler:get_value('length')
	o.nframes = rand_near(val, val/2)
	val = handler:get_value('roughness')
	o.roughness = rand_near(val, 4) -- Ensures not all letters are equally rough
	o.maxroughness = handler:get_limit('roughness', true)
	o.strokes = love.math.random(1, handler:get_value('strokes'))
	o.dirchanges = love.math.random(1, handler:get_value('dirchanges'))
	o.maxwidth = love.math.random(1, handler:get_value('maxwidth'))
	o.maxheight = love.math.random(1, handler:get_value('maxheight'))
	o.points = {}

	o:reset_pen()

	return o
end

function Cell:add_point()
	self.cframes = self.cframes + 1

	self.points[self.cframes] = Point:init(self.x + self.xpos, self.y + self.ypos, self.cr)
end

-- Used for new strokes, like in t, i, j, f...
function Cell:reset_pen()
	self.strokes = self.strokes - 1

	self.cr = 1.2
	self.direction = love.math.random()*math.pi*2
	self.angle = love.math.random()*math.pi*2

	local connected = love.math.random() > 0.5

	if self.cframes <= 0 or connected then
		self.xpos = love.math.random()*self.size
		self.ypos = love.math.random()*self.size
	else
		local randPoint = love.math.random(self.cframes)
		local point = self.points[randPoint]
		self.xpos = point.x
		self.ypos = point.y
		print("crossed")
	end
end

-- Changes dirch to show how to change angle
function Cell:change_dir()
	self.dirchanges = self.dirchanges - 1

	local rough = math.floor(rand_near(self.roughness, self.maxroughness/4)+0.5) -- The +0.5 makes it .round() not .floor()
	self.direction = (self.direction + rough*math.pi/6)%(2*math.pi)
	print("Changed direction")
end

-- This is where the magic randomness happens
function Cell:decide()
	if self.cframes >= self.nframes then return end

	if self.strokes > 0 and make_cut(self.nframes, self.cframes, self.strokes) then
		-- Start a new pen stroke
		self:reset_pen()
	elseif self.dirchanges > 0 and make_cut(self.nframes, self.cframes, self.dirchanges) then
		-- Start turning towards a different direction
		self:change_dir()
	end

	self.cr = clamp(rand_near(self.cr, 0.5), 0.5, 3) -- Varies the size a tiny bit

	if not almost_equal(self.angle, self.direction, 0.005) then
		self.angle = self.angle + (self.direction - self.angle)/self.roughness
	end

	print(self.angle.." "..self.direction)

	-- Calculate the deltas
	local dx = self.cr*math.cos(self.angle)
	local dy = self.cr*math.sin(self.angle)

	self.xpos = clamp(self.xpos + dx, 0, self.size)
	self.ypos = clamp(self.ypos + dy, 0, self.size)

	-- Turn it towards the center
	self.xpos = self.xpos + ((self.size/2 - self.xpos)^3)/self.size^2
	self.ypos = self.ypos + ((self.size/2 - self.ypos)^3)/self.size^2


	self:add_point()
end

function Cell:draw_self()
	-- Drawing the border
	love.graphics.setColor(0.1, 0.1, 0.1, 1)
    love.graphics.rectangle('line',
        self.x, self.y,
        self.size, self.size)

	for i=1, #self.points do
		self.points[i]:draw_self()
	end
end