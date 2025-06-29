require("types")

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
  self.speed = 200

  self:resetPosition()

  ---@type Velocity
  self.velocity = {
    x = isFirstServing and -self.speed or self.speed,
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

---@param dt number
function Ball:updateMovement(dt)
  self.x = self.x + self.velocity.x * dt
  self.y = self.y + self.velocity.y * dt
end

return Ball
