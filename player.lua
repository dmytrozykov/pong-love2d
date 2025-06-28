local Paddle = require("paddle")

local Player = {}
Player.__index = Player

function Player:new()
  local width, height, _ = love.window.getMode()

  self = setmetatable({}, Player)
  self.paddle = Paddle:new(width * 0.05, 0)
  self.paddle.y = height / 2 - self.paddle.height / 2
  self.speed = 350

  return self
end

function Player:draw()
  self.paddle:draw()
end

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
