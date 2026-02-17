local Button = require("ui.button")
local Buttons = require("ui.buttons")
Buttons.NodeButtons = {}
local Map = {
    width = 7,   --Columns
    height = 10, --Rows Level
    nodes = {},  --2D array: nodes[y][x]
    currentNode = nil,

    -- Initialize empty gridd
    init = function(self)
        for y = self.height, 1, -1 do
            self.nodes[y] = {}
            for x = 1, self.width do
                self.nodes[y][x] = nil
            end
        end
    end,

    -- Add node at position
    addNode = function(self, x, y, nodeType)
        local newNode = nodeType.new(1, x, y)
        newNode.draw = function(node) nodeType.draw(node) end
        newNode.trigger = function(node) nodeType.trigger(node) end
        newNode.button = Button(
            "",
            function() newNode:trigger() end,
            20,
            20,
            20
        )
        table.insert(Buttons.NodeButtons, newNode.button)
        self.nodes[y][x] = newNode
    end,

    -- Draw map to screen
    drawMap = function(self)
        for y = self.height, 1, -1 do
            if self.nodes[y] then
                for x = 1, self.width do
                    if self.nodes[y][x] then
                        local node = self.nodes[y][x]
                        love.graphics.setColor(1, 0, 0)
                        node:draw()
                        node.button:drawCircle(x * 100 + 200, y * 100)
                    end
                end
            end
        end
        love.graphics.setColor(1, 1, 1)
    end
}
return Map
