require 'utils/helper'
local json = require 'utils/json'

Handler = {
	filename = 'utils/parameters.json',
	params = {},
	nboxes = 0,

	-- ORDER MATTERS Used for get_value() to get values with the basic names
	name_int = {
		"seed", "amount", "strokes", "length", "roughness", "dirchanges", "maxwidth", "maxheight"
	}
}

function Handler:init()
	local o = {}
    setmetatable(o, self)
    self.__index = self

	local file = love.filesystem.newFile(self.filename, "r")
	local content = file:read("string")

	-- It's a list of "dictionaries"
	o.params = json.decode(content)
	for i=1, #o.params do 
	   o.nboxes = o.nboxes + 1
	end
	file:close()

	return o
end

function Handler:save_input(arr)
	for i=1, #self.params do
		self.params[i].value = clamp(arr[i], self.params[i].min, self.params[i].max)
	end

	local encoded = json.encode(self.params)
	local file = love.filesystem.newFile(self.filename)
	file:open("w")
	file:write(encoded)

	file:close()
end

-- Gets the value of requested parameter by name as string
function Handler:get_value(namestr)
	local ind = 0
	for i=1,#self.name_int,1 do
		if self.name_int[i] == namestr then
			ind = i
			break
		end
	end
	if ind == 0 then
		return -1
	else
		return self.params[ind].value
	end
end

-- Gets the min/max of requested parameter by name as string
function Handler:get_limit(namestr, getmax)
	local ind = 0
	for i=1,#self.name_int,1 do
		if self.name_int[i] == namestr then
			ind = i
			break
		end
	end
	if ind == 0 then
		return -1
	else
		if getmax then
			return self.params[ind].max
		end

		return self.params[ind].min
	end
end