local anim8 = require '../libraries/anim8'
local playerSource = {}


local player = {}
local playernmt ={ __index = player }

local function newPlayer()
    local spriteSheetWalk = love.graphics.newImage("assets/sprites/characters/player/player_walk.png")
    local gridWalk = anim8.newGrid(36, 42, spriteSheetWalk:getWidth(), spriteSheetWalk:getHeight())
    local y = calculatePlayerY(love.graphics.getHeight())
    local animations = {}
    animations.right = anim8.newAnimation(gridWalk("4-1", 1), 0.125)
    animations.left = anim8.newAnimation(gridWalk("4-1", 1), 0.125):flipH()
    local currentAnimation = animations.right
    return setmetatable(
        {
            x = love.graphics.getWidth()/2 - 17,
            y = y,
            scalex = 4,
            scaley = 4,
            offsetx = 17,
            offsety = 21,
            speed = 0.5,
            isMoving = false,
            spriteSheetWalk = spriteSheetWalk,
            gridWalk = gridWalk,
            animations = animations,
            currentAnimation = currentAnimation
        },
        playernmt
    )
end

function calculatePlayerY(height)
    local city_floorH = 64
    local trueOffsetY = 21*4
    local playerY = height - city_floorH - trueOffsetY
    return playerY
end

playerSource.newPlayer = newPlayer
return playerSource