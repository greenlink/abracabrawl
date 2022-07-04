local anim8 = require '../libraries/anim8'
local playerSource = {}

---------------------------- New Player -----------------------------------

local Player = {}
local Playernmt ={ __index = Player }

local function newPlayer()

    local x = 50
    local y = 0
    local width = 36
    local height = 42
    local scalex = 2
    local scaley = 2
    local xVel = 0
    local yVel = 0
    local maxSpeed = 200
    local acceleration = 4000
    local friction = 3500
    local gravity = 1500
    local spriteSheetWalk = love.graphics.newImage("assets/sprites/characters/player/player_walk.png")
    local gridWalk = anim8.newGrid(width, height, spriteSheetWalk:getWidth(), spriteSheetWalk:getHeight())
    local animations = {}
    animations.right = anim8.newAnimation(gridWalk("4-1", 1), 0.125)
    animations.left = anim8.newAnimation(gridWalk("4-1", 1), 0.125):flipH()
    local currentAnimation = animations.right
    local physics = {}
    physics.body = love.physics.newBody(Map.World, x, y, "dynamic")
    physics.body:setFixedRotation(true)
    physics.shape = love.physics.newRectangleShape(width*scalex, height*scaley)
    physics.fixture = love.physics.newFixture(physics.body, physics.shape)
    return setmetatable(
        {
            x = x,
            y = y,
            width = width,
            height = height,
            scalex = scalex,
            scaley = scaley,
            offsetx = 18,
            offsety = 21,
            xVel = xVel,
            yVel = yVel,
            maxSpeed = maxSpeed,
            acceleration = acceleration,
            friction = friction,
            gravity = gravity,
            grounded = false,
            spriteSheetWalk = spriteSheetWalk,
            gridWalk = gridWalk,
            animations = animations,
            currentAnimation = currentAnimation,
            physics = physics
        },
        Playernmt
    )
end

function calculatePlayerY(height)
    local city_floorH = 96
    local trueOffsetY = 21*2
    local playerY = height - city_floorH - trueOffsetY
    return playerY
end

---------------------------- Love Functions -----------------------------------

function Player:update(dt)
    self:syncPlayer(dt)
    self:move(dt)
    self:applyGravity(dt)
    self.currentAnimation:update(dt)
end

function Player:draw()
    self.currentAnimation:draw(self.spriteSheetWalk, self.x - self.offsetx * self.scalex, self.y - self.offsety * self.scaley, nil, self.scalex, self.scaley)
end

---------------------------- Player Functions -----------------------------------

function Player:syncPlayer()
    self.x, self.y = self.physics.body:getPosition()
    self.physics.body:setLinearVelocity(self.xVel, self.yVel)
    if self.xVel == 0 then
        self.currentAnimation:pauseAtEnd()
    end
end

function Player:move(dt)
    if love.keyboard.isDown("d", "right") then
        self:moveRight(dt)
    elseif love.keyboard.isDown("a", "left") then
        self:moveLeft(dt)
    else
        self:applyFriction(dt)
    end
end

function Player:moveRight(dt)
    if self.xVel < self.maxSpeed then
        if self.xVel + self.acceleration * dt < self.maxSpeed then
            self.xVel = self.xVel + self.acceleration * dt
        else
            self.xVel = self.maxSpeed
        end
    end
    self.currentAnimation = self.animations.right
    self.currentAnimation:resume()
end

function Player:moveLeft(dt)
    if self.xVel > -self.maxSpeed then
        if self.xVel - self.acceleration * dt > -self.maxSpeed then
            self.xVel = self.xVel - self.acceleration * dt
        else
            self.xVel = -self.maxSpeed
        end
    end
    self.currentAnimation = self.animations.left
    self.currentAnimation:resume()
end

function Player:applyFriction(dt)
    if self.xVel > 0 then
        if self.xVel - self.friction * dt > 0 then
            self.xVel = self.xVel - self.friction * dt
        else
            self.xVel = 0
        end
    elseif self.xVel < 0 then
        if self.xVel + self.friction * dt < 0 then
            self.xVel = self.xVel + self.friction * dt
        else
            self.xVel = 0
        end
    end
end

function Player:applyGravity(dt)
    if not self.grounded then
        self.yVel = self.yVel + self.gravity * dt
    end
end

function Player:beginContact(a, b, collision)
    if self.grounded then return end
    local nx, ny = collision:getNormal()
    if a == self.physics.fixture then
        if ny > 0 then
            self:land()
        end
    elseif b == self.physics.fixture then
        if ny < 0 then
            self:land()
        end
    end
end

function Player:land()
    self.yVel = 0
    self.grounded = true
end

function Player:endContact(a, b, collision)

end

playerSource.newPlayer = newPlayer
return playerSource