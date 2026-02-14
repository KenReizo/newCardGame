local Entity = require("entities.Entity")
local Enemy = Entity:extend()

function Enemy:new()
    self.super.new(self)
    self.x = 0
    self.y = 0
    self.width = 50
    self.height = 50
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
        love.graphics.rectangle("fill", x, y, 50, 50)
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
