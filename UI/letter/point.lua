Point = {
	x = 0,
	y = 0,

	r = 0,
	col = {}
}

function Point:init(x, y, r, c)
	local o = {}
    setmetatable(o, self)
    self.__index = self

	o.x = x
	o.y = y
	o.r = r
	o.col = c

	return o
end

function Point:draw_self()
	love.graphics.setColor(self.col)
	love.graphics.circle('fill', self.x, self.y, self.r, 7)
end