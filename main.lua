function love.load()
    love.graphics.setBackgroundColor(love.math.colorFromBytes(148, 217, 235))
    rockImage = love.graphics.newImage("assets/sprites/objects/rock.png")
    rockInit = love.graphics.newQuad(0, 0, 52, 52, rockImage:getDimensions())
    rockSecond = love.graphics.newQuad(59, 0, 52, 52, rockImage:getDimensions())
    rockQuad = rockInit
    rock = {}
    rock.x = 300
    rock.y = 644
    rock.speed = 2
    timer = 0
end

function love.update(dt)
    timer = timer + dt

    if love.keyboard.isDown("right") then
        rock.x = rock.x + rock.speed
    end

    if love.keyboard.isDown("left") then
        rock.x = rock.x - rock.speed
    end

end

function love.draw()
    love.graphics.setColor(love.math.colorFromBytes(140, 96, 48))
    love.graphics.rectangle("fill", 0, 670, 1280, 50)

    love.graphics.setColor(love.math.colorFromBytes(224, 13, 9))
    love.graphics.print(timer, 40, 10, 0, 1, 1)

    love.graphics.setColor(1, 1, 1, 1)
    love.graphics.draw(rockImage, rockQuad, rock.x, rock.y)
end