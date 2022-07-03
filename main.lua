local anim8 = require 'libraries/anim8'
--[[ local camera = require 'libraries/camera' ]]
local sti = require 'libraries/sti'
local playerSource = require 'src/playerSource'

function love.load()
    love.graphics.setDefaultFilter("nearest", "nearest")
    love.keyboard.setKeyRepeat(true)
    gameMap = sti('maps/testMap.lua', {"box2d"})
    world = love.physics.newWorld(0, 0)
    gameMap:box2d_init(world)
    gameMap.layers.SolidGround.visible = false
    background = love.graphics.newImage('assets/backgrounds/sky.png')
    background:setWrap("mirroredrepeat", "clampzero", "clampzero")
    backgroundQuad = love.graphics.newQuad(0, 0, love.graphics.getWidth()*2, love.graphics.getHeight()+240, background:getDimensions())
    merlin = playerSource.newPlayer(world)
end

function love.update(dt)
    world:update(dt)
    merlin:update(dt)
    merlin.currentAnimation:update(dt)
end

function love.draw()
    love.graphics.draw(background, backgroundQuad, 0, -240, nil, nil, 4)
    gameMap:draw(0, -240)
    merlin.currentAnimation:draw(merlin.spriteSheetWalk, merlin.x, merlin.y, nil, merlin.scalex, merlin.scaley, merlin.offsetx, merlin.offsety)
end