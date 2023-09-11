require 'UI/textbox'
require 'UI/button'
require 'utils/JSONHandler'

Start = {
    width = 0,
    height = 0,

    textBoxArray = {},
    button = {},

    Parameters = {},
    nboxes = 0,

    cur = -1, -- Cursor, -1 means no value
}

function Start:init(w, h)
    self.width = w
    self.height = h

    -- Alphabet Parameters
    self.Parameters = Handler.params
    self.nboxes = Handler.nboxes

    -- Creating the input textboxes
    --- Two columns
    local nrows = self.nboxes/2
    local secondPosX = TextBox.width + (self.width - 80 - 2*TextBox.width) -- starts on 40
    local addPosY = (self.height - 240)/(nrows-1)

    local i = 1
    local yy = 30

    for i=1,self.nboxes do
        local xx = 40
        if (i%2 == 0) then
            xx = secondPosX
        end
        self.textBoxArray[i] = TextBox:init(self.Parameters[i].name, xx, yy)
        if (i%2 == 0) then
            yy = yy + addPosY
        end
    end
    -- Creating Button
    self.button = Button:init((self.width-Button.width)/2, yy) -- yy is already appended anyway
end

function Start:draw()
    for i=1,self.nboxes,1 do
        self.textBoxArray[i]:draw_self()
    end
    self.button:draw_self()
end

function Start:mousepressed(x, y)
    -- Checking button
    local bclick = self.button:check_click(x, y)
    if bclick then
        local inputs = {}
        for i=1,self.nboxes do
            local value = tonumber(self.textBoxArray[i].text)
            if value == nil then
                value = self.Parameters[i].default
            end
            inputs[i] = value
        end
        Handler:save_input(inputs)
    end

    -- Checking input boxes
    local found = false
    for i=1,self.nboxes do
        local itis = self.textBoxArray[i]:check_click(x, y)
        if itis then found = true self.cur = i end
    end
    if not found then self.cur = -1 end
end

function Start:textinput(t)
    if self.cur ~= -1 then
        if(tonumber(t) ~= nil) then
            self.textBoxArray[self.cur].text = self.textBoxArray[self.cur].text .. t
        end
    end
end