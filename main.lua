function love.load()
    anim8 = require 'libraries/anim8'
    camera = require 'libraries/camera'
    playerSource = require 'src/playerSource'
    cam = camera()
    bg_title = {}
    bg_title.image = love.graphics.newImage("assets/maps/backgrounds/city_bg.png")
    bg_title.image:setWrap("mirroredrepeat")
    bg_title.imageQuad = love.graphics.newQuad(0, 0, 1280, 720, bg_title.image:getWidth(), bg_title.image:getHeight())
    city_floor = love.graphics.newImage("assets/maps/tileSets/city_floor.png")
    city_floor:setWrap("repeat", "repeat")
    city_floor_quad = love.graphics.newQuad(0, 0, 1280, 32, city_floor:getWidth(), city_floor:getHeight())
    love.graphics.setBackgroundColor(love.math.colorFromBytes(148, 217, 235))
    love.graphics.setDefaultFilter("nearest", "nearest")
    love.keyboard.setKeyRepeat(true)
    merlin = playerSource.newPlayer()
    keyboard_actions_pressed = {["right"] = move_merlin_to_right, ["left"] = move_merlin_to_left}
    keyboard_actions_released = {["right"] = stop_merlin, ["left"] = stop_merlin}
end

function love.update(dt)
    local isMoving = false

    if love.keyboard.isDown("right") then
        isMoving = move_merlin_to_right(isMoving)
    end

    if love.keyboard.isDown("left") then
        isMoving = move_merlin_to_left(isMoving)
    end

    if isMoving == false and merlin.isMoving == false then
        merlin.currentAnimation:pauseAtEnd()
    end

    merlin.currentAnimation:update(dt)

    cam:lookAt(merlin.x, CalculateCamHeight(), nil, 2, 2, merlin.offsetx, merlin.offsety)

    local windowWidth = love.graphics.getWidth()

    if cam.x < windowWidth/2 then
        cam.x = windowWidth/2
    end
end

function love.draw()
    cam:attach()
        love.graphics.draw(bg_title.image, bg_title.imageQuad, 0, 0, nil, 4.5, 4.5)
        love.graphics.draw(city_floor, city_floor_quad, 0, 656, nil, 2)
        merlin.currentAnimation:draw(merlin.spriteSheetWalk, merlin.x, merlin.y, nil, merlin.scalex, merlin.scaley, merlin.offsetx, merlin.offsety)
    cam:detach()
end

function move_merlin_to_right()
    merlin.x = merlin.x + merlin.speed
    merlin.currentAnimation = merlin.animations.right
    merlin.currentAnimation:resume()
    return true
end

function move_merlin_to_left()
    merlin.x = merlin.x - merlin.speed
    merlin.currentAnimation = merlin.animations.left
    merlin.currentAnimation:resume()
    return true
end

function love.keypressed(key, scancode, isrepeat)
    move_merlin(key)
end

function move_merlin(key)
    if keyboard_actions_pressed[key] ~= nil then
        merlin.isMoving = keyboard_actions_pressed[key]()
    end
end

function love.keyreleased(key)
    stop_merlin(key)
end

function stop_merlin(key)
    if keyboard_actions_released[key] ~= nil then
        merlin.isMoving = keyboard_actions_released[key]()
    end
end

function stop_merlin()
    merlin.currentAnimation:pauseAtEnd()
    return false
end

function CalculateCamHeight()
    local trueOffsetY = merlin.offsety*merlin.scaley
    local city_floorH = city_floor:getHeight()*2
    --[[ return merlin.y+trueOffsetY+city_floorH-love.graphics.getHeight()/2 ]]
    return 360
end