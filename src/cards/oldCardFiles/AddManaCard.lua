local Card = require("cards.Card")
local AddManaCard = Card:extend()

function AddManaCard:new(x, y)
    AddManaCard.super.new(self, x, y)
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

return AddManaCard
