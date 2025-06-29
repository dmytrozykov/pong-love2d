local fontDirectory = "asset/font/"

---@enum Font
local Font = {
  scoreFont = love.graphics.newFont(fontDirectory .. "pong-score.otf", 56),
  messageFont = love.graphics.newFont(fontDirectory .. "PressStart2P.ttf", 56)
}

return Font
