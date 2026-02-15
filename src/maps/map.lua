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
        self.nodes[y][x] = {
            type = nodeType,
            x = x,
            y = y,
            visited = false,
            content = {}
        }
    end,
    -- Draw map to screen
    drawMap = function(self)
        for y = self.height, 1, -1 do
            for x = 1, self.width do
                if self.nodes[x][y] then
                    love.graphics.setColor(1, 0, 0)
                end
                love.graphics.setColor(1, 1, 1)
            end
        end
    end
}
return Map
