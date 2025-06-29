local Paddle = require("paddle")

---@class Opponent
---@field paddle Paddle
---@field speed number
local Opponent = {}
Opponent.__index = Opponent

---@return Opponent
function Opponent:new()
  self = setmetatable({}, Opponent)
  self.speed = 200
  self:reset()
  return self
end

function Opponent:reset()
  local width, height, _ = love.window.getMode()
  self.paddle = Paddle:new(width * 0.95, 0)
  self.paddle.y = height / 2 - self.paddle.height / 2
end

function Opponent:draw()
  self.paddle:draw()
end

return Opponent
