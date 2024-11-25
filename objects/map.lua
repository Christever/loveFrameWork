local map          = {}

local json         = require("utils.JSON2")

map.MAPSIZEWIDTH   = 32 -- Largeur de la carte
map.MAPSIZEHEIGHT  = 32 -- Hauteur de la carte
map.TILESIZEWIDTH  = 32 -- Largeur des tiles
map.TILESIZEHEIGHT = 32 -- Hauteur des tiles

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
end

--- Dessine la carte
function map.Draw()
    for l = 1, map.MAPSIZEHEIGHT do
        for c = 1, map.MAPSIZEWIDTH do
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
    for l = 1, map.MAPSIZEHEIGHT do
        map.grid[l] = {}
        for c = 1, map.MAPSIZEWIDTH do
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
    local nbQuads = (width / map.TILESIZEWIDTH) * (height / map.TILESIZEHEIGHT)
    for q = 1, nbQuads do
        quads[q] = love.graphics.newQuad(
            x, y,
            map.TILESIZEWIDTH, map.TILESIZEHEIGHT,
            width, height
        )
        x = x + map.TILESIZEWIDTH
        if x >= width then
            x = 0
            y = y + map.TILESIZEHEIGHT
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
    local c = math.floor((x) / map.TILESIZEWIDTH) + 1
    local l = math.floor((y) / map.TILESIZEHEIGHT) + 1
    return c, l
end

---Retourne x et x en fonction des coordonée colonne et ligne
---@param c number
---@param l number
---@return integer
---@return integer
function map.MapToPixel(c, l)
    local x = ((c - 1) * map.TILESIZEWIDTH)
    local y = ((l - 1) * map.TILESIZEHEIGHT)
    return x, y
end

function map.Save()
    local toSave = {
        grid           = map.grid,
        tileSizeWIdth  = map.TILESIZEWIDTH,
        tileSizeHeight = map.TILESIZEHEIGHT,
        mapWidth       = map.MAPSIZEWIDTH,
        mapHeight      = map.MAPSIZEHEIGHT
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
