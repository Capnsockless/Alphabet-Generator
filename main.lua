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
    if not isStart then
        Board:update(dt)
    end
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

    if switch then switch_state() end
end

function love.textinput(t)
    if isStart then
        Start:textinput(t)
    end -- No input on the board scene anyway
end

function switch_state()
    isStart = not isStart
end

function love.keypressed(key)
    if isStart then
        if key == "backspace" then
            Start:delete_char()
        elseif key == 'return' or key == 'space' then
            Start:generate()
            switch_state()
        elseif key == 'up' then
            Start:move_cursor(-2)
        elseif key == 'down' then
            Start:move_cursor(2)
        elseif key == 'left' then
            Start:move_cursor(-1)
        elseif key == 'right' then
            Start:move_cursor(1)
        end
    end
end