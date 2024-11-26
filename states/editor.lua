local editor  = {}

local map     = require("objects.map")
local ts      = require("utils.tileSelector")
local blink   = 0
local message = ""
local debug   = false

function Message(pMessage)
  message = pMessage
  blink   = 2
end

function editor.init()

end

function editor.load()
  map.Init()
  ts.Init(MAP_WIDTH * TILE_WIDTH + 200, 5)
  debug = false
end

function editor.draw()
  if not debug then
    love.graphics.setFont(fontXXL)
    love.graphics.setColor(Color.RAYWHITE)
    love.graphics.print("EDITOR", ts.x, ts.y + 5)
    map.Draw()
    ts.Draw()
    if blink > 0 then
      r, g, b = love.graphics.getColor()
      love.graphics.setColor(Color.GRAY)
      love.graphics.rectangle("fill", 0, 0, 800, 90)
      love.graphics.setColor(Color.GREEN)
      love.graphics.printf(message, MAP_DECALX, 2, 900, "center")
      love.graphics.setColor(r, g, b)
    end
  else
    ts.DrawQuads()
  end
end

function editor.update(dt)
  if blink > 0 then
    blink = blink - dt
  else
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
end

function editor.keypressed(key)
  if key == "escape" then
    state = require("states.menu")
    state.load()
  end
  if key == "space" then
    debug = not debug
  end
  if key == "s" then
    map.Save()
    Message("SAUVEGARDE EFFECTUEE")
  end
end

function editor.mousepressed(x, y, btn)
  if btn == 1 then
    ts.Click(x, y)
  end
end

return editor
