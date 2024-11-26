local player = {}

function player.Init(c, l)
    player.x = (c * TILE_WIDTH) + MAP_DECALX
    player.y = (c * TILE_HEIGHT) + MAP_DECALY
end


function player.Draw()
    
end
return player
