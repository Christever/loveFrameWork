local tileSelector       = {}
local map                = require("objects.map")

local blinckTimer        = 0
local blinkDuration      = 0.2
local blinckFlag         = false

tileSelector.x           = 0
tileSelector.y           = 0
tileSelector.decalageX   = 0
tileSelector.decalageY   = 60
tileSelector.marginX     = 0
tileSelector.marginY     = 16
tileSelector.columns     = 6

-- Tiles slectionnables
tileSelector.tiles       = { 17, 18, 19, 20, 21, 22, 23, 24, 34, 58, 59, 60, 321, 322, 323, 324 }


tileSelector.currentTile = tileSelector.tiles[1]

-- FONCTIONS LOCALES

function setPosition(x, y)
    tileSelector.x = x
    tileSelector.y = y
end

-- ==============================================

---comment
---@param pX number
---@param pY number
function tileSelector.Init(pX, pY)
    setPosition(pX, pY)
end

---comment
---@param pX number
---@param pY number
function tileSelector.Click(pX, pY)
    if pX < tileSelector.x then
        return
    end
    local x = pX - tileSelector.x
    local y = pY - tileSelector.marginY - tileSelector.decalageY
    local c, l = map.PixelToMap(x, y)

    local n = (l - 1) * tileSelector.columns + c
    if n <= #tileSelector.tiles then
        tileSelector.currentTile = tileSelector.tiles[n]
    end
end

function tileSelector.DrawQuads()
    local oldFont = love.graphics.getFont()
    love.graphics.setFont(fontSmall)
    love.graphics.push()
    love.graphics.setBackgroundColor(Color.RAYWHITE)
    local x, y = 0, 0
    for n = 1, #map.quads do
        x = x + 34
        love.graphics.draw(map.image, map.quads[n], x, y)
        love.graphics.setColor(Color.BLACK)
        love.graphics.print(tostring(n), x, y + 30)
        love.graphics.setColor(Color.WHITE)
        if x > 1800 - TILE_WIDTH then
            x = 0
            y = y + TILE_HEIGHT + 30
        end
    end

    love.graphics.pop()

    love.graphics.setFont(oldFont)
end

function tileSelector.Draw()
    local x = tileSelector.x + tileSelector.decalageX + tileSelector.marginX
    local y = tileSelector.y + tileSelector.decalageY + tileSelector.marginY
    local c = 1
    local oldFont = love.graphics.getFont()
    love.graphics.push()
    love.graphics.setFont(fontSmall)
    love.graphics.setBackgroundColor(Color.BLACK)
    for q = 1, #tileSelector.tiles do
        local id = tileSelector.tiles[q]
        love.graphics.setColor(Color.WHITE)
        if tileSelector.tiles[q] == tileSelector.currentTile then
            if blinckFlag then
                love.graphics.setColor(Color.BLANK)
            end
        end
        love.graphics.draw(TILES_IMAGE, map.quads[id], x, y)
        x = x + TILE_WIDTH + 1
        c = c + 1
        if c > tileSelector.columns then
            x = tileSelector.x
            y = y + TILE_HEIGHT + 1
            c = 1
        end
    end
    love.graphics.pop()
    love.graphics.setFont(oldFont)
end

function tileSelector.Update(dt)
    blinckTimer = blinckTimer + dt
    if blinckTimer > blinkDuration then
        blinckTimer = 0
        blinckFlag = not blinckFlag
    end
end

--- Change le tile aux coordonées x et y
---@param x number
---@param y number
---@param pTile number
function tileSelector.ChangeTile(x, y, pTile)
    local col, lig = map.PixelToMap(x - MAP_DECALX, y - MAP_DECALY)
    if col >= 1 and col <= MAP_WIDTH and lig >= 1 and lig <= MAP_HEIGHT then
        map.grid[lig][col] = pTile
    end
end

return tileSelector
