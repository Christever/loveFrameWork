local game = {}
local map
local chip = require("objects.player")
local function loseGame()

end

function game.load()
  map = require("objects.map")
  map.Init()
  chip.Init(1,1)
end

function game.draw()
  -- local x = (chip.colonne - 1) * TILE_WIDTH + MAP_DECALX
  -- local y = (chip.ligne - 1) * TILE_HEIGHT + MAP_DECALY
  love.graphics.setFont(fontLarge)
  map.Draw()

end

function game.update(dt)

end

function game.keypressed(key)
  if key == "escape" then
    state = require("states.menu")
    state.load()
  end
end

function game.mousepressed(x, y, btn)

end

return game
