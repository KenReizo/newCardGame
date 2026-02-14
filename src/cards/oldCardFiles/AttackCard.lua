local Card = require("cards.Card")
local AttackCard = Card:extend()

function AttackCard:new(x, y)
    AttackCard.super.new(self, x, y)
    self.image = love.graphics.newImage("assets/attack_card_image.png")

    self.type = "target"
    self.Attack = 5
    self.cardName = "Attack"
    self.cardDescription = "Deals " .. self.Attack .. " Damage"
    self.cost = 1
    self.action = function(target)
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
end

return AttackCard
