Point = {
	x = 0,
	y = 0,

	r = 0
}

function Point:init(x, y, r)
	local o = {}
    setmetatable(o, self)
    self.__index = self

	o.x = x
	o.y = y
	o.r = r

	return o
end

function Point:draw_self()
	love.graphics.setColor(0, 0, 0, 1)
	love.graphics.circle('fill', self.x, self.y, self.r, 7)
end