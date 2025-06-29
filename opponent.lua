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

---@param dt number
---@param ball Ball
function Opponent:updateMovement(dt, ball)
  local _, height, _ = love.window.getMode()
  local verticalVelocity = 0

  if ball.y < self.paddle.y and self.paddle.y > 0 then
    verticalVelocity = -self.speed
  elseif ball.y > self.paddle.y + self.paddle.height and self.paddle.y < height + self.paddle.height then
    verticalVelocity = self.speed
  end

  self.paddle.y = self.paddle.y + verticalVelocity * dt
end

function Opponent:draw()
  self.paddle:draw()
end

return Opponent
