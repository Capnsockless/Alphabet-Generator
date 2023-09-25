require 'UI/textbox'
require 'UI/button'
local utf8 = require 'utf8'

Start = {
    width = 0,
    height = 0,

    textBoxArray = {},
    button = {},

    handler = {},
    Parameters = {},
    nboxes = 0,

    cur = -1, -- Cursor, -1 means no value
}

function Start:init(handler, w, h)
    self.width = w
    self.height = h

    -- Alphabet Parameters
    self.handler = handler
    self.Parameters = handler.params
    self.nboxes = handler.nboxes

    -- Creating the input textboxes
    --- Two columns
    local nrows = self.nboxes/2
    local secondPosX = TextBox.width + (self.width - 80 - 2*TextBox.width) -- starts on 40
    local addPosY = (self.height - Button.height*4)/(nrows-1)

    local i = 1
    local yy = 30

    for i=1,self.nboxes do
        local xx = 40
        if (i%2 == 0) then
            xx = secondPosX
        end
        self.textBoxArray[i] = TextBox:init(self.Parameters[i].name, xx, yy, tostring(self.Parameters[i].value))
        if (i%2 == 0) then
            yy = yy + addPosY
        end
    end
    -- Creating Button
    self.button = Button:init((self.width-Button.width)/2, (self.height-Button.height)*0.94, 'Generate')
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
        Start:generate() 
        -- Return true to let main.lua switch states
        return true
    end

    -- Checking input boxes
    local found = false
    for i=1,self.nboxes do
        local itis = self.textBoxArray[i]:check_click(x, y)
        if itis then found = true self.cur = i end
    end
    if not found then self.cur = -1 end

    return false
end

function Start:generate()
    local inputs = {}
    for i=1,self.nboxes do
        local value = tonumber(self.textBoxArray[i].text)
        if value == nil then
            value = self.Parameters[i].default
        end
        inputs[i] = value
    end
    self.handler:save_input(inputs)
end

function Start:textinput(t)
    if self.cur ~= -1 then
        -- Adds the char only if it's a digit and the string length is not over 10
        if string.len(self.textBoxArray[self.cur].text) <= 10 and (tonumber(t) ~= nil) then
            self.textBoxArray[self.cur].text = self.textBoxArray[self.cur].text .. t
        end
    end
end

function Start:delete_char()
    -- get the byte offset to the last UTF-8 character in the string.
    local byteoffset = utf8.offset(self.textBoxArray[self.cur].text, -1)

    if byteoffset then
        -- remove the last UTF-8 character.
        -- string.sub operates on bytes rather than UTF-8 characters, so we couldn't do string.sub(text, 1, -2).
        self.textBoxArray[self.cur].text = string.sub(self.textBoxArray[self.cur].text, 1, byteoffset-1)
    end
end

-- Used to move between textboxes and the button using arrow keys
function Start:move_cursor(ch)
    if self.cur == -1 then
        self.cur = 1
    else
        self.textBoxArray[self.cur]:deactivate()
        self.cur = clamp(self.cur + ch, 1, self.nboxes)
    end
    self.textBoxArray[self.cur]:activate()
end