local anim8 = require 'libraries/anim8'
--[[ local camera = require 'libraries/camera' ]]
local sti = require 'libraries/sti'
local playerSource = require 'src/playerSource'

function love.load()
    love.graphics.setDefaultFilter("nearest", "nearest")
    love.keyboard.setKeyRepeat(true)
    background = love.graphics.newImage('assets/backgrounds/sky.png')
    background:setWrap("mirroredrepeat", "clampzero", "clampzero")
    backgroundQuad = love.graphics.newQuad(0, 0, love.graphics.getWidth()*2, love.graphics.getHeight()+240, background:getDimensions())
    gameMap = sti("maps/testMap.lua", { "box2d" })
    world = love.physics.newWorld(0, 0)
    gameMap.layers.SolidGround.visible = false
    merlin = playerSource.newPlayer()
    gameMap:box2d_init(world)
    world:setCallbacks(beginContact, endContact)
end

function love.update(dt)
    world:update(dt)
    merlin:update(dt)
end

function love.draw()
    love.graphics.draw(background, backgroundQuad, 0, -240, nil, nil, 3)
    gameMap:draw(0, -240)
    merlin:draw()
end

function beginContact(a, b, collision)
    merlin:beginContact(a, b, collision)
end

function endContact(a, b, collision)
    merlin:endContact(a, b, collision)
end