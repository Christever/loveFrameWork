io.stdout:setvbuf("no")
love.graphics.setDefaultFilter("nearest", "nearest")
require("Reg")

function love.load()
  love.window.setMode(1400, 1024)
  love.window.setFullscreen(true)
  state = require "states.menu"
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
