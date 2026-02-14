local Object = require("lib.classic")
local Entity = Object:extend()
function Entity:new()
    self.MAX_HP = 1
    self.HP = self.MAX_HP
    self.Armor = 0
    self.Block = 0
    self.Attack = 0
    self.name = "Entity"
    self.image = love.graphics.newImage(
        "assets/Player_Sprite.png"
    )
    self.alive = true
    self.HP_BAR_MAX = self.MAX_HP
    self.HP_BAR = self.HP
    self.intent = ""
end

function Entity:attack(target)
    if target then
        if target.Armor > self.Attack then
            target.Armor = target.Armor - self.Attack
        elseif target.Armor < self.Attack and target.Armor > 0 then
            local damage = self.Attack - target.Armor
            target.Armor = 0
            target.HP = target.HP - damage
        elseif target.Armor == 0 then
            target.HP = target.HP - self.Attack
        end
    end
end

function Entity:block()
    self.Armor = self.Armor + self.Block
end

function Entity:update()
    if self.HP <= 0 then
        self.HP = 0
        self.alive = false
    end

    self.HP_BAR_MAX = (100 / self.MAX_HP) * self.MAX_HP
    self.HP_BAR = (100 / self.MAX_HP) * self.HP
end

function Entity:drawHealthBar(x, y)
    if self.alive then
        love.graphics.setColor(0.5, 0, 0)
        love.graphics.rectangle("fill", x, y, self.HP_BAR_MAX, 10)
        love.graphics.setColor(1, 0, 0)
        love.graphics.rectangle("fill", x, y, self.HP_BAR, 10)
        love.graphics.setColor(1, 1, 1)
    end
end

function Entity:draw(x, y)
end

return Entity
