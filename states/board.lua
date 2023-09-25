require 'UI/button'
require 'UI/canvas'
require 'UI/snap'


Board = {
	width = 0,
    height = 0,

    handler = {},
    Parameters = {},

    button = {},
    snap = {},
    canvas = {},

    cur = -1 -- Which button is selected, -1 is none, 0 is snap and 1 is 'Back' button
}

function Board:init(handler, w, h)
    self.width = w
    self.height = h

    self.handler = handler
    self.Parameters = handler.params

    -- Creating the input textboxes
    --- Two columns
    local nrows = #self.Parameters/2
    local posY = 30 + (nrows*(self.height - 240))/(2*(nrows-1))

    -- Creating Canvas
    self.canvas = Canvas:init(handler, self.width, self.height)

    -- Creating buttons
    self.button = Button:init((self.width-Button.width)/2 + Button.width, (self.height-Button.height)*0.94, 'Back') -- yy is already appended anyway
    self.snap = Snap:init((self.width-Button.width)/2 - Button.width, (self.height-Button.height)*0.94)
end

function Board:reset()
    self.canvas:reset()
    self.button.active = false
    self.snap.active = false
end

function Board:update(dt)
    self.canvas:update(dt)
end

function Board:draw()
    self.canvas:draw_self()
    self.button:draw_self()
    self.snap:draw_self()
end

function Board:mousepressed(x, y)
    local switching = self.button:check_click(x, y)
    if switching then return true end

    -- Saves screenshot to %appdata%/LOVE
    if self.snap:check_click(x, y) then
        self:screenshot()
    end

    return false -- Tells main.lua to not switch states
end

function Board:action()
    -- If going back
    if cur ~= 0 then
        return true
    end

    -- If screenshotting
    self.screenshot()
    return false
end

function Board:screenshot()
    love.graphics.captureScreenshot(os.time() .. ".png")
end

function Board:move_cursor(ch)
    -- See the comment near cur = -1 in the table definition
    if ch < 0 then
        cur = 0
        self.snap.active = true
        self.button.active = false
    elseif ch > 0 then
        cur = 1
        self.snap.active = false
        self.button.active = true
    end
end