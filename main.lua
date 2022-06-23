function love.load()
    anim8 = require 'libraries/anim8'
    bg_title = love.graphics.newImage("assets/maps/backgrounds/mountain_title.png")
    bg_title:setWrap("repeat", "repeat")
    bg_title_quad = love.graphics.newQuad(0, 0, 1280, 720, bg_title:getWidth(), bg_title:getHeight())
    love.graphics.setBackgroundColor(love.math.colorFromBytes(148, 217, 235))
    love.graphics.setDefaultFilter("nearest", "nearest")
    love.keyboard.setKeyRepeat(true)
    rock = {}
    rock.x = 612
    rock.y = 644
    rock.scalex = 2
    rock.scaley = 2
    rock.offsetx = 26
    rock.offsety = 26
    rock.speed = 0.4
    rock.spriteSheet = love.graphics.newImage("assets/sprites/objects/rock.png")
    rock.grid = anim8.newGrid(52,52, rock.spriteSheet:getWidth(), rock.spriteSheet:getHeight())
    rock.isMoving = false
    rock.animations = {}
    rock.animations.right = anim8.newAnimation(rock.grid("1-6", 2), 0.14)
    rock.animations.left = anim8.newAnimation(rock.grid("1-6", 1), 0.14)
    rock.currentAnimation = rock.animations.right
    timer = 0
    keyboard_actions_pressed = {["right"] = move_rock_to_right, ["left"] = move_rock_to_left}
    keyboard_actions_released = {["right"] = stop_rock, ["left"] = stop_rock}
end

function love.update(dt)
    local isMoving = false
    timer = timer + dt

    if love.keyboard.isDown("right") then
        isMoving = move_rock_to_right(isMoving)
    end

    if love.keyboard.isDown("left") then
        isMoving = move_rock_to_left(isMoving)
    end

    if isMoving == false then
        rock.currentAnimation:gotoFrame(1)
    end

    rock.currentAnimation:update(dt)
end

function love.draw()
    love.graphics.draw(bg_title, bg_title_quad, 0, 0, nil, 4.5, 4.5)

    love.graphics.setColor(love.math.colorFromBytes(140, 96, 48))
    love.graphics.rectangle("fill", 0, 670, 1280, 50)

    love.graphics.setColor(love.math.colorFromBytes(224, 13, 9))
    love.graphics.print(timer, 40, 10, nil, 3)

    love.graphics.setColor(1, 1, 1, 1)
    rock.currentAnimation:draw(rock.spriteSheet, rock.x, rock.y, nil, rock.scalex, rock.scaley, rock.offsetx, rock.offsety)
end

function move_rock_to_right()
    rock.x = rock.x + rock.speed
    rock.currentAnimation = rock.animations.right
    return true
end

function move_rock_to_left()
    rock.x = rock.x - rock.speed
    rock.currentAnimation = rock.animations.left
    return true
end

function love.keypressed(key, scancode, isrepeat)
    move_rock(key)
end

function move_rock(key)
    if keyboard_actions_pressed[key] ~= nil then
        rock.isMoving = keyboard_actions_pressed[key]()
    end
end

function love.keyreleased(key)
    stop_rock(key)
end

function stop_rock(key)
    if keyboard_actions_released[key] ~= nil then
        keyboard_actions_released[key]()
    end
end

function stop_rock()
    rock.currentAnimation:gotoFrame(1)
    rock.isMoving = false
end
