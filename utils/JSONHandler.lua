require 'utils/helper'
local json = require 'utils/json'

Handler = {
	filename = 'utils/parameters.json',
	params = {},
	nboxes = 0,
}

function Handler:init()
	local file = io.open(self.filename, 'r')
	local content = file:read('a')

	-- It's a list of "dictionaries"
	self.params = json.decode(content)
	for i=1, #self.params do 
	   self.nboxes = self.nboxes + 1
	end
	io.close(file)
end

function Handler:save_input(arr)
	for i=1, #self.params do
		self.params[i].value = clamp(arr[i], self.params[i].min, self.params[i].max)
	end

	local encoded = json.encode(self.params)
	local file = io.open(self.filename, 'w')
	file:write(encoded)
end