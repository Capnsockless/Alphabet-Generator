require 'textbox'

-- Globals
windowWidth = 1024
windowHeight = 512
backgroundColor = {0.9, 0.9, 0.9, 1}

--- Controls
currActive = -1 -- -1 means no value

--- Alphabet Parameters
unordered_Parameters = {
    seed = { name = 'Random seed', value = 322}, -- Random seed

    amount = { name = 'Amount of letters', value = 33},
    maxstrokes = { name = 'Maximum amount of strokes', value = 5},
    roughness = { name = 'Roughness', value = 10},
    minwidth = { name = 'Minimum width', value = 2},
    maxwidth = { name = 'Maximum width', value = 4},
    minheight = { name = 'Minimum height', value = 1},
    maxheight = { name = 'Maximum height', value = 5}
}

local Parameters = {}

-- Used for sorting the table
for k in pairs(unordered_Parameters) do
    table.insert(Parameters, k)
end

nboxes = 0

for k, v in pairs(Parameters) do 
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

    table.sort(Parameters)
    for i = 1, #Parameters do
        local k, v = Parameters[i], unordered_Parameters[Parameters[i]]
        local xx = 40
        if (i%2 == 1) then
            xx = secondPosX
        end
        textBoxArray[i] = TextBox:init(v.name, xx, yy)
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