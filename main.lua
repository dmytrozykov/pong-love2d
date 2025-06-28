--- A Simple Pong Game

local Player = require("player")

WINDOW_WIDTH = 1280
WINDOW_HEIGHT = 720

local player

function love.load()
  love.window.setMode(WINDOW_WIDTH, WINDOW_HEIGHT, {
    fullscreen = false,
    resizable = false,
    vsync = true
  })

  player = Player:new(WINDOW_HEIGHT)
end

function love.draw()
  player:draw()
end

