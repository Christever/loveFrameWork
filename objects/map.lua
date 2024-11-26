local map          = {}

local json         = require("utils.JSON2")


map.image          = love.graphics.newImage("assets/images/chips01.png")
map.quads          = {}
map.grid           = {}
map.decalageX      = 30 -- Decalage affichage de la map sur les X
map.decalageY      = 50 -- Decalage affichage de la map sur les Y

map.currentLevel   = 1



--- Initialisation de la carte
function map.Init()
    map.Reset()
    map.quads = map.Quads()
    map.Load()
end

--- Dessine la carte
function map.Draw()
    for l = 1, MAP_HEIGHT do
        for c = 1, MAP_WIDTH do
            local x, y = map.MapToPixel(c, l)
            local id = map.grid[l][c]
            love.graphics.draw(map.image, map.quads[33], x + map.decalageX, y + map.decalageY)
            if id ~= nil and id ~= 0 then
                love.graphics.draw(map.image, map.quads[id], x + map.decalageX, y + map.decalageY)
            end
        end
    end
end

--- Reset de la map
function map.Reset()
    for l = 1, MAP_HEIGHT do
        map.grid[l] = {}
        for c = 1, MAP_HEIGHT do
            map.grid[l][c] = 33 -- Tile par défaut
        end
    end
end

--- Découpage des quads
---@return table
function map.Quads()
    local quads   = {}
    local x, y    = 0, 0
    local width   = map.image:getWidth()
    local height  = map.image:getHeight()
    local nbQuads = (width / TILE_WIDTH) * (height / TILE_HEIGHT)
    for q = 1, nbQuads do
        quads[q] = love.graphics.newQuad(
            x, y,
            TILE_WIDTH, TILE_HEIGHT,
            width, height
        )
        x = x + TILE_WIDTH
        if x >= width then
            x = 0
            y = y + TILE_HEIGHT
        end
    end
    return quads
end

---Retourne colonne et ligne en fonction des coordonée x y
---@param x number
---@param y number
---@return integer
---@return integer
function map.PixelToMap(x, y)
    local c = math.floor((x) / TILE_WIDTH) + 1
    local l = math.floor((y) / TILE_HEIGHT) + 1
    return c, l
end

---Retourne x et x en fonction des coordonée colonne et ligne
---@param c number
---@param l number
---@return integer
---@return integer
function map.MapToPixel(c, l)
    local x = ((c - 1) * TILE_WIDTH)
    local y = ((l - 1) * TILE_HEIGHT)
    return x, y
end

function map.Load()
    map.Reset()
    local fileName = "maps/level_" .. tostring(map.currentLevel) .. ".json"
    local file = io.open(fileName, "r")
    if file ~= nil then
        local formatJSON = file:read()
        local formatLUA  = json:decode(formatJSON)
        ---@diagnostic disable-next-line: need-check-nil
        map.grid         = formatLUA.grid
    end
end

function map.Save()
    local toSave = {
        grid           = map.grid,
        tileSizeWIdth  = TILE_WIDTH,
        tileSizeHeight = TILE_HEIGHT,
        mapWidth       = MAP_WIDTH,
        mapHeight      = MAP_HEIGHT
    }
    local formatJSON = json:encode(toSave)
    local fileName = "maps/level_" .. map.currentLevel .. ".json"
    local file = io.open(fileName, "w")
    ---@diagnostic disable-next-line: need-check-nil
    file:write(formatJSON)
    ---@diagnostic disable-next-line: need-check-nil
    file:close()
end

return map
