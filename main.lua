require 'textbox'
require 'button'
require 'JSONHandler'


-- Globals
windowWidth = 1024
windowHeight = 620
backgroundColor = {0.9, 0.9, 0.9, 1}

--- Controls
currActive = -1 -- -1 means no value

--- Alphabet Parameters
Handler:init()
local Parameters = Handler.params
local nboxes = Handler.nboxes

textBoxArray = {}
button = {}
function love.load()
    -- Set up the game window
    love.window.setMode(windowWidth, windowHeight)
    love.graphics.setBackgroundColor(backgroundColor)
    love.window.setTitle('Alphabet Generator')

    -- Creating the input textboxes
    --- Two columns
    local nrows = nboxes / 2
    local secondPosX = TextBox.width + (windowWidth - 80 - 2*TextBox.width) -- starts on 40
    local addPosY = (windowHeight - 240)/(nrows-1)

    local i = 1
    local yy = 30

    for i = 1, #Parameters do
        local xx = 40
        if (i%2 == 0) then
            xx = secondPosX
        end
        textBoxArray[i] = TextBox:init(Parameters[i].name, xx, yy)
        if (i%2 == 0) then
            yy = yy + addPosY
        end
    end

    -- Creating Button
    button = Button:init((windowWidth-Button.width)/2, yy) -- yy is already appended anyway
end

function love.update(dt)

end

function love.draw()
    for i=1,nboxes,1 do
        textBoxArray[i]:draw_self()
    end
    button:draw_self()
end

function love.mousepressed(x, y)
    -- Checking button
    local bclick = button:check_click(x, y)
    if bclick then
        local inputs = {}
        for i=1,nboxes do
            local value = tonumber(textBoxArray[i].text)
            if value == nil then
                value = Parameters[i].default
            end
            inputs[i] = value
        end
        Handler:save_input(inputs)
    end

    -- Checking input boxes
    local found = false
    for i=1,nboxes do
        local itis = textBoxArray[i]:check_click(x, y)
        if itis then found = true currActive = i end
    end
    if not found then currActive = -1 end
end

function love.textinput(t)
    if currActive ~= -1 then
        if(tonumber(t) ~= nil) then
            textBoxArray[currActive].text = textBoxArray[currActive].text .. t
        end
    end
end

function love.keypressed(key)
    -- Called whenever a key is pressed
end

function love.keyreleased(key)
    -- Called whenever a key is released
end