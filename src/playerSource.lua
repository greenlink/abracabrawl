local anim8 = require '../libraries/anim8'
local playerSource = {}


local player = {}
local playernmt ={ __index = player }

local function newPlayer(world)
    local spriteSheetWalk = love.graphics.newImage("assets/sprites/characters/player/player_walk.png")
    local gridWalk = anim8.newGrid(36, 42, spriteSheetWalk:getWidth(), spriteSheetWalk:getHeight())
    local x = 50
    local y = calculatePlayerY(love.graphics.getHeight())
    local xVel = 0
    local yVel = 0
    local maxSpeed = 200
    local acceleration = 4000
    local friction = 3500
    local animations = {}
    animations.right = anim8.newAnimation(gridWalk("4-1", 1), 0.125)
    animations.left = anim8.newAnimation(gridWalk("4-1", 1), 0.125):flipH()
    local currentAnimation = animations.right
    local physics = {}
    physics.body = love.physics.newBody(world, x, y, "dynamic")
    physics.body:setFixedRotation(true)
    physics.shape = love.physics.newRectangleShape(36, 42)
    physics.fixture = love.physics.newFixture(physics.body, physics.shape)
    return setmetatable(
        {
            x = x,
            y = y,
            scalex = 2,
            scaley = 2,
            offsetx = 18,
            offsety = 21,
            speed = 0.5,
            xVel = xVel,
            yVel = yVel,
            maxSpeed = maxSpeed,
            acceleration = acceleration,
            friction = friction,
            isMoving = false,
            spriteSheetWalk = spriteSheetWalk,
            gridWalk = gridWalk,
            animations = animations,
            currentAnimation = currentAnimation,
            physics = physics
        },
        playernmt
    )
end

function player:update(dt)
    self:syncPlayer(dt)
    self:move(dt)
end

function player:syncPlayer()
    self.x, self.y = self.physics.body:getPosition()
    self.physics.body:setLinearVelocity(self.xVel, self.yVel)
end

function player:move(dt)
    if love.keyboard.isDown("right") then
        self.isMoving = self:moveRight(dt)
    end

    if love.keyboard.isDown("left") then
        self.isMoving = self:moveLeft(dt)
    end

    if self.isMoving == false then
        self.currentAnimation:pauseAtEnd()
    end
end

function player:moveRight(dt)
    self.x = self.x + self.speed
    self.currentAnimation = self.animations.right
    self.currentAnimation:resume()
    return true
end

function player:moveLeft(dt)
    self.x = self.x - self.speed
    self.currentAnimation = self.animations.left
    self.currentAnimation:resume()
    return true
end

function calculatePlayerY(height)
    local city_floorH = 96
    local trueOffsetY = 21*2
    local playerY = height - city_floorH - trueOffsetY
    return playerY
end

playerSource.newPlayer = newPlayer
return playerSource