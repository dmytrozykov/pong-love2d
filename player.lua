local Paddle = require("paddle")

---@class Player
---
---@field paddle Paddle
---@field speed number
local Player = {}
Player.__index = Player

---@return Player
function Player:new()
  self = setmetatable({}, Player)
  self.paddle = Paddle:new(0, 0)
  self:reset()
  self.speed = 350
  return self
end

function Player:draw()
  self.paddle:draw()
end

function Player:reset()
  local width, height, _ = love.window.getMode()
  self.paddle.x = width * 0.05 - self.paddle.width
  self.paddle.y = height / 2 - self.paddle.height / 2
end

---@param dt number
function Player:updateMovement(dt)
  local _, height, _ = love.window.getMode()

  local y = self.paddle.y
  local paddleHeight = self.paddle.height

  if love.keyboard.isDown("s") and y < height - paddleHeight then
    self.paddle.y = self.paddle.y + (self.speed * dt)
  elseif love.keyboard.isDown("w") and y > 0 then
    self.paddle.y = self.paddle.y - (self.speed * dt)
  end
end

return Player
