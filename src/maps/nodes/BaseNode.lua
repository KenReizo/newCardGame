local BaseNode = {}

function BaseNode.new(type, floor, x, y)
    local self = {}
    self.type = type
    self.floor = floor
    self.x = x
    self.y = y
    self.pos_x = 0
    self.pos_y = 0
    self.visited = false
    self.connections = {}
    return self
end

function BaseNode:draw()

end

function BaseNode:trigger()

end

return BaseNode
