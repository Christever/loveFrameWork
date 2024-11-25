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
tileSelector.tiles       =
{ 17, 18, 19, 20, 21, 22, 23, 24, 34, 58, 59, 60, 321, 322, 323, 324 }

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

function tileSelector.Draw()
    -- love.graphics.print("TILE SELECTOR", tileSelector.x, tileSelector.y)
    local x = tileSelector.x + tileSelector.decalageX + tileSelector.marginX
    local y = tileSelector.y + tileSelector.decalageY + tileSelector.marginY
    local c = 1
    for q = 1, #tileSelector.tiles do
        local id = tileSelector.tiles[q]
        love.graphics.setColor(255, 255, 255, 255)
        if tileSelector.tiles[q] == tileSelector.currentTile then
            if blinckFlag then
                love.graphics.setColor(255, 126, 126, 200)
            end
        end
        love.graphics.draw(map.image, map.quads[id], x, y)
        x = x + map.TILESIZEWIDTH + 1
        c = c + 1
        if c > tileSelector.columns then
            x = tileSelector.x
            y = y + map.TILESIZEHEIGHT + 1
            c = 1
        end
    end
    love.graphics.setColor(255, 255, 255, 255)
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
    -- local col, lig = map.PixelToMap(x+map.decalageX, y+map.decalageY)
    local col = math.floor((x - map.decalageX) / map.TILESIZEWIDTH) + 1
    local lig = math.floor((y - map.decalageY) / map.TILESIZEHEIGHT) + 1

    if col >= 1 and col <= map.MAPSIZEWIDTH and lig >= 1 and lig <= map.MAPSIZEHEIGHT then
        map.grid[lig][col] = pTile
    end
end

return tileSelector