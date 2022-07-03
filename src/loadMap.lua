local sti = require 'libraries/sti'

Map = {}

function Map:load()
    Map.background = love.graphics.newImage('assets/backgrounds/sky.png')
    Map.background:setWrap("mirroredrepeat", "clampzero", "clampzero")
    Map.backgroundQuad = love.graphics.newQuad(0, 0, love.graphics.getWidth()*2, love.graphics.getHeight()+240, Map.background:getDimensions())
    Map.TiledMap = sti("maps/testMap.lua", { "box2d" })
    Map.TiledMap.layers.SolidGround.visible = false
    Map.World = love.physics.newWorld(0, 0)
    Map.TiledMap:box2d_init(Map.World)
end

function Map:update(dt)
    Map.World:update(dt)
end

function Map:draw()
    love.graphics.draw(Map.background, Map.backgroundQuad, 0, -240, nil, nil, 3)
    Map.TiledMap:draw(0, -240)
end