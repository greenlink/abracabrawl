function love.load()
    love.window.setTitle("AbracaBrawl")
    love.window.setMode(600, 600, { fullscreen=false, resizable=false, centered=true, vsync=0, msaa=8})
    love.graphics.setBackgroundColor(148/255, 217/255, 235/255)
    rockImage = love.graphics.newImage("resources/sprites/objects/rock.png")
    rockInit = love.graphics.newQuad(0, 0, 52, 52, rockImage:getDimensions())
    rockSecond = love.graphics.newQuad(59, 0, 52, 52, rockImage:getDimensions())
    rockQuad = rockInit
    rock = {}
    rock.x = 300
    rock.y = 524
    timer = 0
    colorMode = love.graphics.getColorMode
end

function love.update(dt)
    timer = timer + dt
    divider = math.floor(timer)
    if 5 % divider == 0 then
        rockQuad = rockSecond
    elseif 10 % divider == 0 then
        rockQuad = rockInit
    end
end

function love.draw()
    love.graphics.setColor(140/255, 96/255, 48/255)
    love.graphics.rectangle("fill", 0, 550, 600, 50)

    love.graphics.setColor(108/255, 199/255, 76/255)
    love.graphics.print({{108/255, 199/255, 76/255}, timer}, 300, 20, 0, 2, 2)

    love.graphics.setColor(1, 1, 1, 1)
    love.graphics.draw(rockImage, rockQuad, rock.x, rock.y)
end