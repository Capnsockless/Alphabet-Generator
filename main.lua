require 'textbox'
local json = require 'json'

-- Globals
windowWidth = 1024
windowHeight = 512
backgroundColor = {0.9, 0.9, 0.9, 1}

--- Controls
currActive = -1 -- -1 means no value

--- Alphabet Parameters
local file = io.open('parameters.json', 'r')
local content = file:read('a')

local Parameters = json.decode(content)
print(Parameters[1].name)


nboxes = 0

for i=1, #Parameters do 
   nboxes = nboxes + 1
end

textBoxArray = {}
function love.load()
    -- Set up the game window
    love.window.setMode(windowWidth, windowHeight)
    love.graphics.setBackgroundColor(backgroundColor)
    love.window.setTitle('Alphabet Generator')

    -- Two columns
    local nrows = nboxes / 2
    local secondPosX = TextBox.width + (windowWidth - 80 - 2*TextBox.width) -- starts on 40
    local addPosY = (windowHeight - 70)/(nrows-1)

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
end

function love.update(dt)

end

function love.draw()
    for i=1,nboxes,1 do
        textBoxArray[i]:draw_self()
    end    
end

function love.mousepressed(x, y)
    local found = false
    for i=1,nboxes do
        local itis = textBoxArray[i]:check_click(x, y)
        if itis then found = true currActive = i end
    end
    if not found then currActive = -1 end
    print(currActive)
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