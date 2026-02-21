local anim8 = require("lib.anim8")
local Entity = require("entities.Entity")
local Enemy = Entity:extend()

function Enemy:new()
    self.super.new(self)
    self.x = 0
    self.y = 0
    --self.sprite_sheect = love.graphics.newImage("assets/Monster_Creatures_Fantasy/Goblin/Attack3.png")
    -- self.image = anim8.newGrid(12, 1,
    --     self.sprite_sheect:getHeight(),
    --     self.sprite_sheect:getWidth()
    -- )
    self.image = love.graphics.newImage("assets/Slime_Enemy_Green.png")
    self.width = self.image.getWidth(self.image)
    self.height = self.image.getHeight(self.image)
    self.MAX_HP = 50
    self.HP = self.MAX_HP
    self.Attack = math.random(5, 20)
    self.Block = math.random(5, 10)
    self.intent = "Attacking for " .. self.Attack
end

function Enemy:action()
    if math.fmod(Game.round, 2) == 1 then
        self.Attack = math.random(5, 20)
        if Game.round == 1 then
            self.Attack = 5
        end
        Enemy:attack(Player)
        -- Next Round
        self.intent = "Blocking for " .. self.Block
    end
    if math.fmod(Game.round, 2) == 0 then
        self.Block = math.random(5, 10)
        if Game.round == 1 then
            self.Block = 5
        end
        self:block()
        -- Next Round
        self.intent = "Attacking for " .. self.Attack
    end
end

function Enemy:draw(x, y)
    if self.alive then
        love.graphics.setColor(0, 1, 0)
        -- love.graphics.rectangle("fill", x, y, 50, 50)
        love.graphics.draw(self.image, x, y)
        love.graphics.setColor(1, 1, 1)
        Enemy:drawHealthBar(x - 25, y + 60)
        love.graphics.print(
            "Block: " .. self.Armor,
            x - (self.width / 5),
            y + self.height + 20
        )
        love.graphics.print(self.intent,
            x - (self.width / 5),
            y - 20
        )
    end
end

return Enemy
