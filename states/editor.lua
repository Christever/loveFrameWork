local editor = {}

local map    = require("objects.map")
local ts     = require("utils.tileSelector")
local blink  = 0

function editor.init()

end

function editor.load()
  map.Init()
  ts.Init(map.MAPSIZEWIDTH * map.TILESIZEWIDTH + 200, 5)
end

function editor.draw()
  love.graphics.setFont(fontXXL)
  love.graphics.print("EDITOR", ts.x, ts.y + 5)
  map.Draw()
  ts.Draw()

  if blink > 0 then
    r, g, b = love.graphics.getColor()
    love.graphics.setColor(255, 255, 255)
    love.graphics.rectangle("fill", 0, 0, 400, 60)
    love.graphics.setColor(0, 0, 0)
   
    love.graphics.setColor(r, g, b)
  end
end

function editor.update(dt)
  local x, y = love.mouse.getPosition()
  if love.mouse.isDown(1) then
    ts.ChangeTile(x, y, ts.currentTile)
  elseif love.mouse.isDown(2) then
    ts.ChangeTile(x, y, 0)
  end
  ts.Update(dt)
  if blink > 0 then
    blink = blink - dt
  end
end

function editor.keypressed(key)
  if key == "escape" then
    state = require("states.menu")
    state.load()
  end
end

function editor.mousepressed(x, y, btn)
  if btn == 1 then
    ts.Click(x, y)
  end
end

return editor
