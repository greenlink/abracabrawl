local anim8 = require 'libraries/anim8'
--[[ local camera = require 'libraries/camera' ]]
local sti = require 'libraries/sti'
local playerSource = require 'src/playerSource'
require('src/loadMap')

function love.load()
    love.graphics.setDefaultFilter("nearest", "nearest")
    love.keyboard.setKeyRepeat(true)
    Map:load()
    Map.World:setCallbacks(beginContact, endContact)
    merlin = playerSource.newPlayer()
end

function love.update(dt)
    Map:update(dt)
    merlin:update(dt)
end

function love.draw()
    Map:draw()
    merlin:draw()
end

function beginContact(a, b, collision)
    merlin:beginContact(a, b, collision)
end

function endContact(a, b, collision)
    merlin:endContact(a, b, collision)
end