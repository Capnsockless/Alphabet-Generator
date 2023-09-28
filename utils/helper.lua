-- Contains random scripts I use across the project

function clamp(val, min, max)
    return math.max(min, math.min(val, max))
end

function in_clamp(val, min, max)
    return (val >= min and val <= max)
end

-- Checks if a point is within a rectangle x1:y1 is top left, x2:y2 is bottom right
function between(x, y, x1, y1, x2, y2)
    return (x >= x1 and x <= x2 and y >= y1 and y <= y2)
end

-- Checks if two numbers are equal with a determined epsilon
function almost_equal(num1, num2, eps)
    return math.abs(num1 - num2) <= eps
end

-- Gives random binary direction
function rand_dir()
    local n = love.math.random(0, 1)
    if n == 0 then return -1 end
    return 1
end

-- Gives a number near the given argument
function rand_near(num, variance)
    local add = love.math.random()*variance*rand_dir()
    return num + add
end

-- Used in letter segment divisions,
-- lower the value, higher the chance to make a split to ensure all splits are of adequate length
function make_cut(full, covered, n) 
    -- full - full length | covered - covered length | n - cuts left to make
    local ldiff = covered/full -- More = higher chance
    local ndiff = 1/n -- Less = lower chance
    local chance = love.math.random()

    return ndiff-ldiff < chance
end

-- Takes in [0, 999] number and generates a unique color
function make_color(num)
    local r = math.floor(num/100)
    local g = math.floor((num%100)/10)
    local b = num%10
    return {r/10, g/10, b/10}
end