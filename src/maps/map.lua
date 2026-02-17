local Button = require("ui.button")
local Buttons = require("ui.buttons")

Buttons.NodeButtons = {}
local Map = {
    width = 7,   --Columns
    height = 10, --Rows Level
    nodes = {},  --2D array: nodes[y][x]
    currentNode = nil,


    -- Initialize empty gridd
    init = function(self, w, h)
        self.width = w or self.width
        self.height = h or self.height
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
        newNode.pos_x = x * 100 + 200
        newNode.pos_Y = y * 100
        newNode.type = nodeType
        table.insert(Buttons.NodeButtons, newNode.button)
        self.nodes[y][x] = newNode
    end,

    changeNode = function(self, y, x, nodeType)
        for width = 1, self.width do
            if self.nodes[y] then
                for height = 1, self.height do
                    if width == x and height == y then
                        if self.nodes[height][width] then
                            self.addNode(self, x, y, nodeType)
                        end
                    end
                end
            end
        end
    end,

    connectNodes = function(self, node1_y, node1_x, node2_y, node2_x)
        local node1 = self.nodes[node1_y][node1_x]
        local node2 = self.nodes[node2_y][node2_x]
        table.insert(node1.connections, node2)
        table.insert(node2.connections, node1)
        table.insert(node2.connections, node1)
        table.insert(node1.connections, node2)
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
                        if node.connections then
                            for _, connectedNode in ipairs(node.connections) do
                                love.graphics.setColor(0.5, 0.5, 0.5) -- gray line
                                love.graphics.line(
                                    node.pos_x,
                                    node.pos_Y,
                                    connectedNode.pos_x,
                                    connectedNode.pos_Y
                                )
                            end
                        end
                    end
                end
            end
        end
        love.graphics.setColor(1, 1, 1)
    end
}
return Map
