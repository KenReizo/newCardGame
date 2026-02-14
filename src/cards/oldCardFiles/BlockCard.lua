local Card = require("cards.Card")
local BlockCard = Card:extend()

function BlockCard:new(x, y)
    BlockCard.super.new(self, x, y)
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

return BlockCard
