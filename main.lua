require 'textbox'

-- Globals
windowWidth = 1024
windowHeight = 512
backgroundColor = {0.9, 0.9, 0.9, 1}

--- Controls
currActive = -1 -- -1 means no value

--- Alphabet Parameters
amount = 33
complexity = 5
roughness = 10


function love.load()    
    -- Set up the game window
    love.window.setMode(windowWidth, windowHeight)
    love.graphics.setBackgroundColor(backgroundColor)
    love.window.setTitle("Alphabet Generator")

    local secondPosX = TextBox.width + (windowWidth - 80 - 2*TextBox.width) -- starts on 40
    local secondPosY = TextBox.height + (windowHeight - 80 - 2*TextBox.height)

    textBoxArray = {}
    for i=1,4 do
        local xx = 0
        local yy = 0
        if (i%2 == 1) then
            xx = secondPosX
        end
        if (i > 2) then
            yy = secondPosY
        end
        textBoxArray[i] = TextBox:init(40+xx, 40+yy)
    end
end

function love.update(dt)

end

function love.draw()
    for i=1,4 do
        textBoxArray[i]:draw_self()
    end    
end

function love.mousepressed(x, y)
    local found = false
    for i=1,4 do
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