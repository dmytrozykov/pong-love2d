local Paddle = require("paddle")

local Opponent = {}
Opponent.__index = Opponent

function Opponent:new()
  local width, height, _ = love.window.getMode()

  self = setmetatable({}, Opponent)
  self.paddle = Paddle:new(width * 0.95, 0)
  self.paddle.y = height / 2 - self.paddle.height / 2
  self.speed = 200

  return self
end

function Opponent:draw()
  self.paddle:draw()
end

return Opponent
