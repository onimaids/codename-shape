local love = require("love")
local Utils = require("utils")

local Shape = {}
Shape.__shapes = {}

WHITE = {255, 255, 255}
BLACK = {0, 0, 0}

function Shape:new(x, y, l, type, color)
	local o = {
		x = x, y = y,
		l = l,
		type = type,
		color = color
	}

	assert(Utils.table_has({"circle", "triangle", "square"}, type))

	setmetatable(o, self)
	o.__shapes = nil
	self.__index = self
	table.insert(Shape.__shapes, o)
	return o
end

function Shape:draw(mode)
	mode = mode or "fill"

	love.graphics.push()
	love.graphics.setColor(self.color)

	if self.type == "square" then
		love.graphics.rectangle(
			mode,
			self.x - self.l / 2,
			self.y - self.l / 2,
			self.l, self.l
		)
	elseif self.type == "circle" then
		love.graphics.circle(mode, self.x, self.y, self.l / 2)
	else
		love.graphics.polygon(mode, {
			-- x 					   y
			self.x - self.l / 2, self.y + self.l / 2,
			self.x,					self.y - self.l / 2,
			self.x + self.l / 2, self.y + self.l / 2
		})
	end

	love.graphics.pop()
end

return Shape
