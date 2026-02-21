local CombatNode = require("maps.nodes.CombatNode")

local BossCombatNode = {
    new = function(floor, x, y)
        local self = CombatNode.new(floor, x, y)
        self.enemyType = "boss"
        return self
    end,
    draw = function(self) CombatNode.draw(self) end,
    trigger = function(self)
        CombatNode.trigger(self)
        self.visited = true
        Game.map.currentNode = self
    end
}
return BossCombatNode
