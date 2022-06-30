function love.load()
    anim8 = require 'libraries/anim8'
    camera = require 'libraries/camera'
    playerSource = require 'src/playerSource'
    cam = camera()
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
    return 360
end