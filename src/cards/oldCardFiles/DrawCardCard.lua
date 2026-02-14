local Card = require("cards.Card")
local DrawCardCard = Card:extend()

function DrawCardCard:new(x, y)
    DrawCardCard.super.new(self, x, y)
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

return DrawCardCard
