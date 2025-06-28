local Font

local fontDirectory = "asset/font/"

Font = {
  scoreFont = love.graphics.newFont(fontDirectory .. "pong-score.otf", 56)
}

return Font
