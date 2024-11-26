local game = {}
local map
local chip = {}
local function loseGame()

end

function game.load()
  map = require("objects.map")
  map.Init()
  chip.colonne = 1
  chip.ligne   = 1
end

function game.draw()
  local x = (chip.colonne - 1) * TILE_WIDTH
  local y = (chip.ligne - 1) * TILE_HEIGHT
  love.graphics.setFont(fontLarge)
  map.Draw()
  love.graphics.draw(map.image, map.quads[369], x+map.decalageX, y+map.decalageY)
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
