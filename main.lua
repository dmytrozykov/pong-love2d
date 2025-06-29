-- A Simple Pong Game

local Player = require("player")
local Opponent = require("opponent")
local Ball = require("ball")
local Font = require("font")

---@enum state 
local state = {
  SERVE = "serve",
  PLAY = "play",
  WIN = "win"
}

WINDOW_WIDTH = 1280
WINDOW_HEIGHT = 720

MAX_SCORE = 2

---@type Player
local player

---@type Opponent
local opponent

---@type Ball
local ball

local score

---@type state
local currentState = state.SERVE
local isFirstServing = true

local function reset()
  player = Player:new()
  opponent = Opponent:new()
  ball = Ball:new(isFirstServing)
  score = { 0, 0 }
end

function love.load()
  love.window.setTitle("Pong")
  love.window.setMode(WINDOW_WIDTH, WINDOW_HEIGHT, {
    fullscreen = false,
    resizable = false,
    vsync = true
  })

  reset()
end

function love.update(dt)
  -- Exit on 'Esc'
  if love.keyboard.isDown("escape") then
    os.exit()
  end

  if currentState == state.SERVE then
    if love.keyboard.isDown("space") then
      currentState = state.PLAY
      ball:reset(isFirstServing)
    end
  elseif currentState == state.PLAY then
    player:updateMovement(dt)

    opponent:updateMovement(dt, ball)

    ball:checkCollisions(player.paddle, opponent.paddle)
    ball:updateMovement(dt)

    -- get window dimensions
    local width, _, _ = love.window.getMode()
    if ball.x < 0 then
      score[2] = score[2] + 1
      ball:reset(true)
    elseif ball.x > width - ball.size then
      score[1] = score[1] + 1
      ball:reset(false)
    end

    if score[1] == MAX_SCORE then
      currentState = state.WIN
      isFirstServing = false
    elseif score[2] == MAX_SCORE then
      currentState = state.WIN
      isFirstServing = true
    end
  elseif currentState == state.WIN then
    if love.keyboard.isDown("space") then
      currentState = state.SERVE
      reset()
    end
  end
end

local function drawScore()
  local font = Font.scoreFont
  local textWidth = font:getWidth("0")

  local y = 32

  love.graphics.setFont(font)
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

local function drawServeText()
  local font = Font.messageFont
  local text = "Press Space"
  local textWidth = font:getWidth(text)

  local width, height, _ = love.window.getMode()
  local x = width / 2 - textWidth / 2
  local y = height / 2

  love.graphics.setFont(font)
  love.graphics.print(text, x, y)
end

local function drawWinText()
  local font = Font.messageFont
  local text = "Game Over"
  local textWidth = font:getWidth(text)

  local width, height, _ = love.window.getMode()
  local x = width / 2 - textWidth / 2
  local y = height / 2

  love.graphics.setFont(font)
  love.graphics.print(text, x, y)
end

function love.draw()
  if currentState == state.SERVE then
    drawServeText()
  elseif currentState == state.WIN then
    drawWinText()
  end

  drawScore()
  drawLine()
  player:draw()
  opponent:draw()
  ball:draw()
end

