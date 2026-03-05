local Button = require("ui.button")
local Buttons = require("ui.buttons")
-- Nodes
local BaseNode = require("maps.nodes.BaseNode")
local CombatNode = require("maps.nodes.CombatNode")
local EliteCombatNode = require("maps.nodes.EliteCombatNode")
local BossCombatNode = require("maps.nodes.BossCombatNode")
local RestNode = require("maps.nodes.RestNode")

Buttons.NodeButtons = {}
local Map = {
    width = 7,   --Columns
    height = 10, --Rows Level
    nodes = {},  --2D array: nodes[y][x]
    allNodes = {},
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
        newNode.pos_y = y * 100
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
                        node:draw()
                        love.graphics.setColor(0, 0, 0, 0)
                        node.button:drawCircle(x * 100 + 200, y * 100)
                        if node.connections then
                            for _, connectedNode in ipairs(node.connections) do
                                love.graphics.setColor(0.5, 0.5, 0.5) -- gray line
                                love.graphics.line(
                                    node.pos_x,
                                    node.pos_y,
                                    connectedNode.pos_x,
                                    connectedNode.pos_y
                                )
                            end
                        end
                    end
                end
            end
        end
        love.graphics.setColor(1, 1, 1)
    end,

    generateMap = function(self, w, h)
        if Game.hasMap == nil then
            Game.map:init(w, h)
            -- Fills grid /map with empty rooms
            for width = Game.map.width, 1, -1 do
                for floor = 1, Game.map.height do
                    Game.map:addNode(width, floor, BaseNode)
                end
            end
            -- Adds and conects filled rooms
            local iteration_rooms = {}
            for i = 1, 6 do
                iteration_rooms[i] = {}
                local prev_room = nil
                for floor = Game.map.height, 1, -1 do
                    iteration_rooms[i][floor] = {}
                    local width = math.random(1, Game.map.width)
                    local room = { floor = floor, width = width, type = nil }
                    local current_max_width = Game.map.width
                    local current_min_width = 1

                    if prev_room then
                        local r = math.random(prev_room.width -
                            1, prev_room.width + 1)
                        if r >= Game.map.width then
                            width = math.random(prev_room.width -
                                2, current_max_width)
                        elseif r <= 1 then
                            width = math.random(
                                current_min_width,
                                prev_room.width + 2)
                        else
                            width = r
                        end
                        room.width = width

                        if i ~= 1 and floor ~= Game.map.height then
                            while prev_room and not
                                self:canConnect(floor, width,
                                    prev_room,
                                    iteration_rooms, i) do
                                width = math.random(1,
                                    Game.map.width)
                            end
                        end
                    end
                    room.width = width

                    if floor == 1 then
                        room.width = math.floor(Game.map.width / 2)
                    end
                    ::continue ::
                    RandomNumber = math.random(1, 4)
                    if Game.map.nodes[floor][RandomNumber].type ~= BaseNode then
                        goto continue
                    end
                    if floor < Game.map.height - 3 and floor ~= 3 and floor ~= 1 and RandomNumber == 1 then
                        if prev_room and prev_room.type ~= EliteCombatNode then
                            Game.map:addNode(room.width, room.floor, EliteCombatNode)
                            room.type = EliteCombatNode
                        elseif not prev_room then
                            Game.map:addNode(room.width, room.floor, EliteCombatNode)
                            room.type = EliteCombatNode
                        end
                    elseif floor == 1 then
                        Game.map:addNode(room.width, room.floor, BossCombatNode)
                        room.type = BossCombatNode
                    elseif floor == 3 then
                        Game.map:addNode(room.width, room.floor, RestNode)
                        room.type = RestNode
                    elseif floor <= Game.map.height - 3 and RandomNumber == 1 then
                        if prev_room and prev_room.type ~= RestNode then
                            Game.map:addNode(room.width, room.floor, RestNode)
                            room.type = RestNode
                        end
                    elseif floor ~= 1 and floor ~= 3 then
                        Game.map:addNode(room.width, room.floor, CombatNode)
                    end
                    iteration_rooms[i][room.floor] = room

                    if prev_room then
                        Game.map:connectNodes(
                            prev_room.floor,
                            prev_room.width,
                            room.floor, room.width)
                    end

                    prev_room = room
                end
            end
        end
        -- Removes empty rooms
        for floor = 1, Game.map.height do
            if Game.map.nodes[floor] then
                for width = 1, Game.map.width do
                    if Game.map.nodes[floor][width] then
                        if Game.map.nodes[floor][width].type == BaseNode then
                            Game.map.nodes[floor][width] = nil
                        end
                    end
                end
            end
        end
        Game.hasMap = true
    end,

    canConnect = function(self, current_floor, current_width, prev_room, existing_rooms, current_iter)
        for past_iter, _ in ipairs(existing_rooms) do
            if past_iter ~= current_iter then
                local prev_floor = current_floor + 1
                local current_room_w = current_width
                if past_iter > 0 then
                    local past_room_w = existing_rooms[past_iter][current_floor].width
                    local past_prev_room_w = existing_rooms[past_iter][prev_floor].width
                    local prev_room_w = prev_room.width
                    local noCrossing = (current_room_w >= past_room_w and
                            prev_room_w >= past_prev_room_w) or
                        (current_room_w <= past_room_w and
                            prev_room_w <= past_prev_room_w)
                    if not noCrossing then
                        return false
                    end
                end
            end
        end
        return true
    end
}
return Map
