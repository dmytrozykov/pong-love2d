local Ball = {}
Ball.__index = Ball

function Ball:new()
  local width, height, _ = love.window.getMode()

  self = setmetatable({}, Ball)
  self.size = 24
  self.x = width / 2 - self.size / 2
  self.y = height / 2 - self.size / 2

  return self
end

function Ball:draw()
  love.graphics.rectangle("fill", self.x, self.y, self.size, self.size)
end

return Ball
