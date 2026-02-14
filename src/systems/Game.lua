local Object = require("lib.classic")
local Game = Object:extend()


local Map = require("maps.map")
local CombatNode = require("maps.nodes.CombatNode")

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
end

function Game:load()
    Player:new()
    Enemy:new()
    Game.map = Map
    Game.map:init()
    Game.map:addNode(1, 1, CombatNode)
    Game.map:addNode(7, 4, CombatNode)
end

function Game:update()
    if self.Stage == Game.Stages.MainMenu then

    end
    if self.Stage == Game.Stages.Map then
        --Game.map:addNode(0, 0, "combat")
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
