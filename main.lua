require 'states/start'
require 'states/board'
require 'utils/JSONHandler'

-- Globals
windowWidth = 1024
windowHeight = 620
backgroundColor = {0.9, 0.9, 0.9, 1}
isStart = true

Handler:init()

function love.load()
    -- Set up the game window
    love.window.setMode(windowWidth, windowHeight)
    love.graphics.setBackgroundColor(backgroundColor)
    love.window.setTitle('Alphabet Generator')

    -- States (scenes)
    Start:init(windowWidth, windowHeight)
    Board:init(windowWidth, windowHeight)
end

function love.update(dt)

end

function love.draw()
    if isStart then
        Start:draw()
    else
        Board:draw()
    end
end

function love.mousepressed(x, y)
    local switch = false
    if isStart then
        switch = Start:mousepressed(x, y)
    else
        switch = Board:mousepressed(x, y)
    end

    if switch then
        isStart = not isStart
    end
end

function love.textinput(t)
    if isStart then
        Start:textinput(t)
    end -- No input on the board scene anyway
end

function love.keypressed(key)
    -- Called whenever a key is pressed
end

function love.keyreleased(key)
    -- Called whenever a key is released
end