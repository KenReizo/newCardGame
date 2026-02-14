local Card = require("cards.Card")
local Cards = {}

Cards.AttackCard = Card:extend()
function Cards.AttackCard:new(x, y)
    Cards.AttackCard.super.new(self, x, y)
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

Cards.BlockCard = Card:extend()
function Cards.BlockCard:new(x, y)
    Cards.BlockCard.super.new(self, x, y)
    self.image = love.graphics.newImage("assets/Block_card_image.png")
    self.type = "self"
    self.Block = 5
    self.cost = 1
    self.action = function(target)
        if target then
            target.Armor = target.Armor + self.Block
        end
    end
    self.cardName = "Block"
    self.cardDescription = "Gives " .. self.Block .. " Block"
    self.cost = 1
end

Cards.AddManaCard = Card:extend()
function Cards.AddManaCard:new(x, y)
    Cards.AddManaCard.super.new(self, x, y)
    self.image = love.graphics.newImage("assets/Add_mana_card_image.png")
    self.x = x
    self.y = y
    self.name = "Add Mana"
    self.cost = 1
    self.addMana = 2
    self.cardDescription = "Gain " .. self.addMana .. " Mana next turn"
    self.type = "self"
    self.action = function(target)
        if target then
            table.insert(target.pendingEffects.manaNextTurn, self.addMana)
        end
    end
end

Cards.DrawCardCard = Card:extend()
function Cards.DrawCardCard:new(x, y)
    Cards.DrawCardCard.super.new(self, x, y)
    self.image = love.graphics.newImage("assets/Draw_Card_card_image.png")
    self.x = x
    self.y = y
    self.cost = 1
    self.drawNumber = 2
    self.type = "Utility"
    self.name = "Draw Card"
    self.cardDescription = "Draws " .. self.drawNumber .. " Cards"
    self.action = function()
        CM.drawCard(self.drawNumber, CM.deck, CM.hand)
    end
end

return Cards
