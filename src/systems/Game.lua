local Object = require("lib.classic")
local Game = Object:extend()


local Map = require("maps.map")
local BaseNode = require("maps.nodes.BaseNode")
local CombatNode = require("maps.nodes.CombatNode")
local EliteCombatNode = require("maps.nodes.EliteCombatNode")
local BossCombatNode = require("maps.nodes.BossCombatNode")

local CM = require("systems.CardManager")
local Player = require("entities.Player")
local Enemy = require("entities.enemies.test")



Game.SiteType = {
    NormalCombat = "NormalCombat",
    EliteCombat = "EliteCombat",
    BossCombat = "BossCombat",
    Rest = "Rest"
}
Game.Stages = {
    MainMenu = "MainMenu",
    Map = "Map",
    Combat = "Combat",
    DeckMenu = "DeckMenu",
    Options = "Options"

}

Game.States = {
    PlayerTurn = "PlayerTurn",
    CPUTurn = "CPUTurn",
    CombatStart = "CombatStart",
    CombatEnd = "CombatEnd"
}

function Game:new()
    self.super.new(self)
    self.State = Game.States.CombatStart
    self.Stage = Game.Stages.MainMenu
    self.endTurn = false
    self.turnStart = true
    self.cpuTurnStart = true
    self.cpuEndTurn = false
    self.round = 0
    self.cpuEndTime = 0
    self.hasMap = nil
end

local function canConnect(current_floor, current_width, prev_room, existing_rooms, current_iter)
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

function Game:generateMap(w, h)
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
                local room = { floor = floor, width = width }
                local current_max_width = Game.map.width
                local current_min_width = 1



                -- Find neighbor nodes on the width line and set there width's as min and max
                -- prev_room has to be between these to nodes or outside of them
                if prev_room then
                    local r = math.random(prev_room.width - 1,
                        prev_room.width + 1)
                    if r >= Game.map.width then
                        width = math.random(prev_room.width - 2, current_max_width)
                    elseif r <= 1 then
                        width = math.random(current_min_width, prev_room.width + 2)
                    else
                        width = r
                    end
                    room.width = width

                    if i ~= 1 and floor ~= Game.map.height then
                        while prev_room and not canConnect(floor, width,
                                prev_room, iteration_rooms, i) do
                            width = math.random(1, Game.map.width)
                        end
                    end
                end
                room.width = width

                if floor == 1 then
                    room.width = math.floor(Game.map.width / 2)
                end
                if Game.map.nodes[floor][width].type ~= BaseNode then
                    goto continue
                end
                if floor == 4 then
                    Game.map:addNode(room.width, room.floor, EliteCombatNode)
                elseif floor == 1 then
                    Game.map:addNode(room.width, room.floor, BossCombatNode)
                else
                    Game.map:addNode(room.width, room.floor, CombatNode)
                end
                ::continue ::
                iteration_rooms[i][room.floor] = room
                if prev_room then
                    Game.map:connectNodes(
                        room.floor, room.width,
                        prev_room.floor,
                        prev_room.width)
                end

                prev_room = room
            end
        end
    end
    -- Removes empty rooms
    -- for floor = 1, Game.map.height do
    --     if Game.map.nodes[floor] then
    --         for width = 1, Game.map.width do
    --             if Game.map.nodes[floor][width] then
    --                 if Game.map.nodes[floor][width].type == BaseNode then
    --                     Game.map.nodes[floor][width] = nil
    --                 end
    --             end
    --         end
    --     end
    -- end
    Game.hasMap = true
end

function Game:createMap(w, h)
    if Game.hasMap == nil then
        if w and h then
            Game.map:init(w, h)
        else
            Game.map:init()
        end
        local nodeY
        local nodeX
        for y = 1, Game.map.height do
            RandomNumber = math.random(0, 1)
            if RandomNumber == 1 then
                nodeY = y
                if nodeX == nil then
                    nodeX = math.random(1, Game.map.width)
                end
            end
            for x = 1, Game.map.width do
                RandomNumber = math.random(0, 1)
                if RandomNumber == 1 then
                    nodeX = x
                    if nodeY == nil then
                        nodeY = math.random(1, Game.map.height)
                    end
                end
            end
            if nodeX and nodeY then
                Game.map:addNode(nodeX, nodeY, CombatNode)
            else
                print("Error: nodeX = " ..
                    nodeX ..
                    " nodeY = " .. nodeY .. "Map.width = " .. Game.map.width .. "Map.height = " .. Game.map.height)
            end
        end
        Game.hasMap = true
    end
end

function Game:load()
    Game.map = Map
    Player:new()
    Enemy:new()

    -- Game.map = Map
    -- Game.map:init()
    -- Game.map:addNode(1, 1, CombatNode)
    -- Game.map:addNode(7, 7, CombatNode)
    -- Game.map:addNode(3, 6, CombatNode)
    -- Game.map:addNode(1, 5, CombatNode)
end

function Game:update()
    if self.Stage == Game.Stages.MainMenu then
        Game.hasMap = nil
    end
    if self.Stage == Game.Stages.Map then
        Game:generateMap()
    end
    if self.Stage == Game.Stages.DeckMenu then

    end
    if self.Stage == Game.Stages.Combat then
        Player:update()
        Enemy:update()
        CM.update()
        if self.State == Game.States.CombatStart then
            CM.deck = CM.createDeck()
            CM.hand = {}
            CM.discardPile = {}
            CM.deck = CM.shuffledCopy(CM.deck)
            self:toPlayerTurn()
        end
        if self.State == Game.States.PlayerTurn then
            if self.turnStart then
                Player.Armor = 0
                Player.Mana = Player.MAX_MANA
                self.round = self.round + 1
                CM.drawCard(5, CM.deck, CM.hand)
                for _, amount in ipairs(Player.pendingEffects.manaNextTurn) do
                    Player.Mana = Player.Mana + amount
                end
                Player.pendingEffects.manaNextTurn = {}
                self.turnStart = false
            end

            if self.endTurn then
                CM.discardHand(CM.hand, CM.discardPile)
                self:toCPUTurn()
                self.endTurn = false
                self.turnStart = true
            end
        end
        if self.State == Game.States.CPUTurn then
            if self.cpuTurnStart then
                Enemy.Armor = 0
                Enemy:action()
                self.cpuTurnStart = false
                self.cpuEndTime = love.timer.getTime() + 1
            end
            self.cpuEndTurn = true

            if self.cpuEndTurn and love.timer.getTime() >= self.cpuEndTime then
                self:toPlayerTurn()
                self.cpuEndTurn = false
                self.cpuTurnStart = true
            end
        end
        if self.State == Game.States.CombatEnd then
            self.round = 0
            self:toCombatStart()
        end
    end
end

function Game:toCPUTurn()
    self.State = Game.States.CPUTurn
end

function Game:toPlayerTurn()
    self.State = Game.States.PlayerTurn
end

function Game:toCombatStart()
    self.State = Game.States.CombatStart
end

function Game:toCombatEnd()
    self.State = Game.States.CombatEnd
end

function Game:switchStage(toStage)
    if self.Stage ~= toStage then
        self.Stage = toStage
    end
end

return Game
