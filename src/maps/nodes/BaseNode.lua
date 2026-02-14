local Object = require("lib.classic")
local Node = Object:extend()

function Node:new(type, floor, x, y)
    self.type = type
    self.floor = floor
    self.x = y
    self.y = y
    self.visited = false
    self.connections = {}
end

return Node
