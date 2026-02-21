local CombatNode = require("maps.nodes.CombatNode")

local EliteCombatNode = {
    new = function(floor, x, y)
        local self = CombatNode.new(floor, x, y)
        self.enemyType = "elite"

        return self
    end,
    draw = function(self) CombatNode.draw(self) end,
    trigger = function(self)
        self.visited = true
        CombatNode.trigger(self)
    end
}

return EliteCombatNode
