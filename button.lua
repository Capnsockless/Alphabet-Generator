Button = {
	x = 0,
	y = 0,
	width = 256,
    height = 128,
	text = ''
}

function TextBox:init(x, y)
    local o = {}
    setmetatable(o, self)
    self.__index = self
    o.x = x
    o.y = y
    return o
end

function TextBox:activate()
    
end