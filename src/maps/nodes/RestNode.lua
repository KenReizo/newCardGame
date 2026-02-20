local BaseNode = require("maps.nodes.BaseNode")
local RestNode = {
    new = function(type, floor, x, y)
        local self = BaseNode.new("rest", floor, x, y)
        self.type = type
        return self
    end,
}
return RestNode
