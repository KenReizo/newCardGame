local Entity = require("entities.Entity")
local Player = Entity:extend()

function Player:new()
    self.super.new(self)
    self.MAX_HP = 100
    self.HP = self.MAX_HP
    self.MAX_MANA = 3
    self.Mana = 3
    self.x = 0
    self.y = 0
    self.image = love.graphics.newImage("assets/Player_Sprite.png")
    self.width = self.image.getWidth(self.image)
    self.height = self.image.getHeight(self.image)
    self.name = "Player"
end

Player.pendingEffects = {
    manaNextTurn = {}
}

function Player:draw(x, y)
    love.graphics.draw(self.image, x, y)
    love.graphics.print(
        "Block: " .. self.Armor,
        x - (self.width / 5),
        y + self.height + 20
    )
    Player:drawHealthBar(x - (self.width / 5), y + self.height + 10)
end

return Player
