---@class Ball
---
---@field size number
---@field speed number
---
---@field x number
---@field y number
---
---@field velocity Velocity
local Ball = {}
Ball.__index = Ball

---@param isFirstServing boolean
---@return Ball
function Ball:new(isFirstServing)

  self = setmetatable({}, Ball)

  self.size = 24
  self:resetPosition()

  local initialSpeed = 200

  ---@type Velocity
  self.velocity = {
    x = (isFirstServing and -1 or 1) * initialSpeed,
    y = 0
  }

  return self
end

function Ball:resetPosition()
  local width, height, _ = love.window.getMode()
  self.x = width / 2 - self.size / 2
  self.y = height / 2 - self.size / 2
end

function Ball:draw()
  love.graphics.rectangle("fill", self.x, self.y, self.size, self.size)
end

---@param leftPaddle Paddle 
---@param rightPaddle Paddle
function Ball:checkCollisions(leftPaddle, rightPaddle)
   -- check left collision
  local leftHit = (
     self.x <= leftPaddle.x + leftPaddle.width and
     self.y >= leftPaddle.y and self.y <= leftPaddle.y + leftPaddle.height
  )

  -- check right collision
  local rightHit = (
    self.x >= rightPaddle.x - self.size and
    self.y >= rightPaddle.y and self.y <= rightPaddle.y + rightPaddle.height
  )

  local hasCollided = leftHit or rightHit 

  if hasCollided then
    -- mirror horizontal movement and increase velocity
    self.velocity.x = self.velocity.x * -1.03

    -- add random vertical velocity
    self.velocity.y = (self.velocity.y < 0 and -1 or 1) * math.random(10, 150)
  end

  -- add buffer after collision to fix multiple collision detection
  local buffer = 2

  if leftHit then
    self.x = self.x + buffer
  elseif rightHit then
    self.x = self.x - buffer
  end

  -- get window dimensions
  local _, height, _ = love.window.getMode()
  -- bounce of walls
  if self.y >= height - self.size or self.y <= 0 then
    self.velocity.y = -self.velocity.y
  end
end

---@param dt number
function Ball:updateMovement(dt)
  self.x = self.x + self.velocity.x * dt
  self.y = self.y + self.velocity.y * dt
end

return Ball
