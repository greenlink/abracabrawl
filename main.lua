function love.load()
    love.graphics.setBackgroundColor(love.math.colorFromBytes(148, 217, 235))
    love.keyboard.setKeyRepeat(true)
    rock = {}
    rock.x = 300
    rock.y = 644
    rock.speed = 5
    rock.spriteSheet = love.graphics.newImage("assets/sprites/objects/rock.png")
    timer = 0
    keyboard_actions = {["right"] = move_rock_to_right, ["left"] = move_rock_to_left}
end

function love.update(dt)
    timer = timer + dt
end

function love.draw()
    love.graphics.setColor(love.math.colorFromBytes(140, 96, 48))
    love.graphics.rectangle("fill", 0, 670, 1280, 50)

    love.graphics.setColor(love.math.colorFromBytes(224, 13, 9))
    love.graphics.print(timer, 40, 10, 0, 1, 1)

    love.graphics.setColor(1, 1, 1, 1)
    --love.graphics.draw(rockImage, rockQuad, rock.x, rock.y)
end

function love.keypressed(key, scancode, isrepeat)
    move_rock(key)
end

function move_rock(key)
    if keyboard_actions[key] ~= nil then
        keyboard_actions[key]()
    end
end

function move_rock_to_right()
    rock.x = rock.x + rock.speed
end

function move_rock_to_left()
    rock.x = rock.x - rock.speed
end