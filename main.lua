-- A Simple Pong Game

local Player = require("player")

WINDOW_WIDTH = 1280
WINDOW_HEIGHT = 720

local player

function love.load()
  love.window.setTitle("Pong")
  love.window.setMode(WINDOW_WIDTH, WINDOW_HEIGHT, {
    fullscreen = false,
    resizable = false,
    vsync = true
  })

  player = Player:new()
end

function love.update(dt)
  -- Exit on 'Esc'
  if love.keyboard.isDown("escape") then
    os.exit()
  end

  player:updateMovement(dt)
end

function love.draw()
  player:draw()
end

