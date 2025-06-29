---@class Paddle
---
---@field x number
---@field y number
---
---@field width number
---@field height number
local Paddle = {}
Paddle.__index = Paddle

---@param x number 
---@param y number
---@return Paddle
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

