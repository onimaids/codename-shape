local love = require("love")
local Shape = require("shape")

function love.load()
	Test = Shape:new(10, 10, 10, "circle", WHITE)
	Test2 = Shape:new(10, 30, 10, "square", WHITE)
	Test3 = Shape:new(10, 50, 10, "triangle", WHITE)
end

function love.update(dt)
end

function love.draw()
	Test:draw("line")
	Test2:draw("line")
	Test3:draw("line")
end
