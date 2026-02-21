local BaseNode = require("maps.nodes.BaseNode")
local RestNode = {
    new = function(floor, x, y)
        local self = BaseNode.new("rest", floor, x, y)
        return self
    end,
    draw = function(self)
        local posx = self.x * 100 + 200
        local posy = self.y * 100

        love.graphics.setColor(0, 1, 0)
        love.graphics.circle("fill", posx, posy, self.size)
        if self.visited then
            love.graphics.setColor(1, 1, 1, 0.5)
            love.graphics.setLineWidth(3)
            love.graphics.circle("line", posx, posy, self.size)
            love.graphics.setLineWidth(1)
        end

        love.graphics.setColor(1, 1, 1, 1)
    end,
    trigger = function(self)
        Player.HP = Player.HP + 25
        if Player.HP >= Player.MAX_HP then
            Player.HP = Player.MAX_HP
        end
        self.visited = true
        Game.map.currentNode = self
    end
}
return RestNode
