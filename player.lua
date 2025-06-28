local Paddle = require("paddle")

local Player = {}
Player.__index = Player

function Player:new(screenHeight)
  self = setmetatable({}, Player)
  self.paddle = Paddle:new(20, screenHeight / 2)
  return self
end

function Player:draw()
  self.paddle:draw()
end

return Player
