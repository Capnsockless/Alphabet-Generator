-- Contains random scripts I use across the project

function clamp(val, min, max)
    return math.max(min, math.min(val, max));
end

-- Checks if a point is within a rectangle x1:y1 is top left, x2:y2 is bottom right
function between(x, y, x1, y1, x2, y2)
    return (x >= x1 and x <= x2 and y >= y1 and y <= y2)
end