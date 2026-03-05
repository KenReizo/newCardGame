local BaseNode = require("maps.nodes.BaseNode")

local BossCombatNode = {}
function BossCombatNode.new(floor, x, y)
    local self = BaseNode.new("combat", floor, x, y)
    self.enemyType = "boss"
    self.size = 20
    return self
end

function BossCombatNode:draw()
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
        love.graphics.setColor(1, 0, 0)
    else
        love.graphics.setColor(1, 1, 1)
    end
    love.graphics.setLineWidth(2)
    love.graphics.circle("line", posx, posy, self.size)
    love.graphics.setLineWidth(1)
    love.graphics.setColor(1, 1, 1, 1)
end

function BossCombatNode:trigger()
    if not self.visited then
        Game.map.nodes[self.y][self.x].visited = true
        Game.map.currentNode = Game.map.nodes[self.y][self.x]
        Game:switchStage(Game.Stages.Combat)
    end
end

return BossCombatNode
