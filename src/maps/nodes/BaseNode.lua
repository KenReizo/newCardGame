local BaseNode = {}

function BaseNode.new(type, floor, x, y)
    local self = {}
    self.type = type
    self.floor = floor
    self.x = x
    self.y = y
    self.visited = false
    self.connections = {}
    return self
end

return BaseNode
