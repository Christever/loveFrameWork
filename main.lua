io.stdout:setvbuf("no")
love.graphics.setDefaultFilter("nearest", "nearest")
require("Reg")

function love.load()
  love.window.setMode(1400, 1024)
  love.window.setFullscreen(true)

  fontSmall  = love.graphics.newFont("assets/fonts/PixelMaster.ttf", 24)
  fontMedium = love.graphics.newFont("assets/fonts/PixelMaster.ttf", 36)
  fontLarge  = love.graphics.newFont("assets/fonts/PixelMaster.ttf", 48)
  fontXXL    = love.graphics.newFont("assets/fonts/PixelMaster.ttf", 64)

  state      = require "states.menu"
  state.load()
end

function love.draw()
  state.draw()
end

function love.update(dt)
  state.update(dt)
end

function love.keypressed(key, isrepeat)
  state.keypressed(key)
end

function love.mousepressed(x, y, btn)
  state.mousepressed(x, y, btn)
end
