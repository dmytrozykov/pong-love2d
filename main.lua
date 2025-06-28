-- A Simple Pong Game

local Player = require("player")
local Opponent = require("opponent")
local Ball = require("ball")
local Font = require("font")

WINDOW_WIDTH = 1280
WINDOW_HEIGHT = 720

local player, opponent
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

  ball = Ball:new()
end

function love.update(dt)
  -- Exit on 'Esc'
  if love.keyboard.isDown("escape") then
    os.exit()
  end

  player:updateMovement(dt)
end

local function drawScore()
  local windowHalfWidth = WINDOW_WIDTH / 2
  local xOffset = 64
  local y = 32

  love.graphics.setFont(Font.scoreFont)
  love.graphics.print(score[1], windowHalfWidth - xOffset, y)
  love.graphics.print(score[2], windowHalfWidth + xOffset, y)
end

function love.draw()
  drawScore()
  player:draw()
  opponent:draw()
  ball:draw()
end

