local menu = {}
local menuSelection

local function play()
  state = require("states.game")
  state.load()
end

local function editor()
  state = require("states.editor")
  state.load()
end

local function instructions()

end

local function credits()

end

local menuEntries = {
  { ['text'] = 'Play',         ['action'] = play },
  { ['text'] = 'Editor',       ['action'] = editor },
  { ['text'] = 'Instructions', ['action'] = instructions },
  { ['text'] = 'Credits',      ['action'] = credits },
  { ['text'] = 'Quit',         ['action'] = love.event.quit }
}

function menu.load()
  fontSmall  = love.graphics.newFont("assets/fonts/PixelMaster.ttf", 24)
  fontMedium = love.graphics.newFont("assets/fonts/PixelMaster.ttf", 36)
  fontLarge  = love.graphics.newFont("assets/fonts/PixelMaster.ttf", 48)
  fontXXL    = love.graphics.newFont("assets/fonts/PixelMaster.ttf", 64)


  menuSelection = 1
  ScreenWidth   = love.graphics.getWidth()
  ScreenHeight  = love.graphics.getHeight()
end

function menu.update(dt)
  -- return state
end

function menu.draw()
  love.graphics.setFont(fontMedium)
  for i = 1, #menuEntries do
    if i == menuSelection then
      love.graphics.print(">", 250, 250 + i * 50)
    end
    love.graphics.print(menuEntries[i].text, 300, 250 + i * 50)
    -- love.graphics.printf(menuEntries[i].text, 0,ScreenWidth/5, ScreenWidth, "left" )
  end
end

function menu.keypressed(key)
  if key == "up" or key == "z" then
    menuSelection = (menuSelection - 2) % (#menuEntries) + 1
  elseif key == "down" or key == "s" then
    menuSelection = (menuSelection) % (#menuEntries) + 1
  elseif key == "return" or key == "space" then
    menuEntries[menuSelection].action()
  elseif key == "escape" then
    love.event.quit()
  end
end

return menu
