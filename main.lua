require 'UI/textbox'
require 'UI/button'
require 'utils/JSONHandler'
require 'states/start'

-- Globals
windowWidth = 1024
windowHeight = 620
backgroundColor = {0.9, 0.9, 0.9, 1}



function love.load()
    -- Set up the game window
    love.window.setMode(windowWidth, windowHeight)
    love.graphics.setBackgroundColor(backgroundColor)
    love.window.setTitle('Alphabet Generator')

    -- States (scenes)
    Start:init(windowWidth, windowHeight)
end

function love.draw()
    Start:draw()
end

function love.mousepressed(x, y)
    Start:mousepressed(x, y)
end

function love.textinput(t)
    Start:textinput(t)
end

function love.keypressed(key)
    -- Called whenever a key is pressed
end

function love.keyreleased(key)
    -- Called whenever a key is released
end