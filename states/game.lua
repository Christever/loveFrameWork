local game = {}
local map
local function loseGame()
  
end

function game.load()
  map = require("objects.map")
  map.Init()
  
end

function game.draw()
  love.graphics.setFont(fontLarge)
  map.Draw()
  
end

function game.update(dt)

end

function game.keypressed(key)
  if key=="escape" then
    state=require("states.menu")
    state.load()
  end
end

function game.mousepressed(x,y, btn)
  
end

return game
