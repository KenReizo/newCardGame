local BaseNode = require("maps.nodes.BaseNode")

local CombatNode = {}

function CombatNode.new(floor, x, y)
    local self = BaseNode.new("combat", floor, x, y)
    self.enemyType = "normal"
    self.size = 20
    return self
end

function CombatNode:draw()
    local posx = self.x * 100 + 200
    local posy = self.y * 100
    if self.enemyType == "normal" then
        love.graphics.setColor(0, 0, 1)
    end
    if self.enemyType == "elite" then
        love.graphics.setColor(1, 0, 0)
    end
    if self.enemyType == "boss" then
        love.graphics.setColor(1, 0, 1)
    end

    love.graphics.circle("fill", posx, posy, self.size)

    if self.visited then
        love.graphics.setColor(1, 1, 1, 0.5)
        love.graphics.setLineWidth(3)
        love.graphics.circle("line", posx, posy, self.size)
        love.graphics.setLineWidth(1)
    end
    love.graphics.setColor(1, 1, 1, 1)
end

function CombatNode:trigger()
    if not self.visited then
        self.visited = true
        Game.map.currentNode = self
        Game:switchStage(Game.Stages.Combat)
    end
end

return CombatNode
