local BaseNode = require("maps.nodes.BaseNode")
local CombatNode = BaseNode:extend()

function CombatNode:new(floor, x, y)
    self.super.new(self, "combat", floor, x, y)
    self.enemyType = "normal"
    self.size = 50
end

function CombatNode:draw()
    -- Color based on enemy enemyType
    if self.enemyType == "normal" then
        love.graphics.setColor(0, 0, 1)
    end
    if self.enemyType == "elite" then
        love.graphics.setColor(1, 0, 0)
    end
    if self.enemyType == "boss" then
        love.graphics.setColor(1, 0, 1)
    end

    -- Draw Node cicle
    love.graphics.circle("fill", self.x, self.y, self.size)

    if self.visited then
        love.graphics.setColor(1, 1, 1, 0.5)
        love.graphics.setLineWidth(3)
        love.graphics.circle("line", self.x, self.y, self.size)
    end
    love.graphics.setColor(1, 1, 1, 1)
end

function CombatNode:trigger()
    if self.enemyType == "normal" then
        Enemy:new()
    elseif self.enemyType == "elite" then
        Enemy:new()
    elseif self.enemyType == "boss" then
        Enemy:new()
    end

    self.visited = true

    Game:switchStage(Game.Stage.Combat)
end

return CombatNode
