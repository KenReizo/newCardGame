local Object = require("lib.classic")
local Card = Object:extend()

function Card:new(x, y)
    self.x = x
    self.y = y
    self.Background = love.graphics.newImage("assets/Card_Base_Sprite.png")
    self.width = self.Background.getWidth(self.Background)
    self.height = self.Background.getHeight(self.Background)
    self.image = love.graphics.newImage("assets/attack_card_image.png")
    self.cardName = "Card Name"
    self.cardDescription = "This is the cardDescription"
    self.cost = 0


    self.discard = true
end

function Card:cardHover(mx, my)
    if mx >= self.x
        and mx <= (self.x + self.width)
        and my >= self.y
        and my <= (self.y + self.height) then
        return true
    else
        return false
    end
end

function Card:draw(x, y)
    if x then
        self.x = x
    end
    if y then
        self.y = y
    end
    love.graphics.push()
    local dx = self.x
    local dy = self.y
    love.graphics.draw(self.image, dx + 7, dy + 33)
    love.graphics.draw(self.Background, dx, dy)
    love.graphics.setColor(0, 0, 0)
    love.graphics.printf(tostring(self.cardName), dx + 10, dy + 10, 100, "left")
    love.graphics.printf(tostring(self.cost), dx + 90, dy + 10, 100, "left")
    love.graphics.printf(tostring(self.cardDescription), dx + 10, dy + 100, 90, "center")
    love.graphics.setColor(1, 1, 1)

    love.graphics.pop()
end

return Card
