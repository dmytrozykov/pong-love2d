local Paddle = {}
Paddle.__index = Paddle

function Paddle:new(x, y)
  self = setmetatable({}, Paddle)
  self.x = x
  self.y = y
  self.width = 20
  self.height = 120
  return self
end

function Paddle:draw()
  love.graphics.rectangle("fill", self.x, self.y, self.width, self.height)
end

return Paddle

