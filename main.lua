-- A Simple Pong Game

local Player = require("player")
local Opponent = require("opponent")
local Ball = require("ball")
local Font = require("font")

WINDOW_WIDTH = 1280
WINDOW_HEIGHT = 720

local player, opponent
---@type Ball
local ball

local score = { 0, 0 }

function love.load()
  love.window.setTitle("Pong")
  love.window.setMode(WINDOW_WIDTH, WINDOW_HEIGHT, {
    fullscreen = false,
    resizable = false,
    vsync = true
  })

  player = Player:new()
  opponent = Opponent:new()

  ball = Ball:new(true)
end

function love.update(dt)
  -- Exit on 'Esc'
  if love.keyboard.isDown("escape") then
    os.exit()
  end

  player:updateMovement(dt)
  ball:updateMovement(dt)
end

local function drawScore()
  local font = Font.scoreFont
  local textWidth = font:getWidth("0")

  local y = 32

  love.graphics.setFont(Font.scoreFont)
  love.graphics.print(score[1], WINDOW_WIDTH / 2 - textWidth * 1.5, y)
  love.graphics.print(score[2], WINDOW_WIDTH / 2 + textWidth, y)
end

local function drawLine()
  local lineHeight = 32
  local lineWidth = 4
  local offset = 8

  local lineCount = math.floor(WINDOW_HEIGHT / (lineHeight + offset))

  local x = WINDOW_WIDTH / 2 - lineWidth / 2
  for i = 0, lineCount, 1 do
    local y = (lineHeight + offset) * i
    love.graphics.rectangle("fill", x, y, lineWidth, lineHeight)
  end
end

function love.draw()
  drawScore()
  drawLine()
  player:draw()
  opponent:draw()
  ball:draw()
end

