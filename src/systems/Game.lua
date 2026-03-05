local Object = require("lib.classic")
local Game = Object:extend()

local Map = require("maps.map")
local CombatNode = require("maps.nodes.CombatNode")
local EliteCombatNode = require("maps.nodes.EliteCombatNode")
local BossCombatNode = require("maps.nodes.BossCombatNode")

local CM = require("systems.CardManager")
local Player = require("entities.Player")
local Enemies = {}
Enemies.Slime = require("entities.enemies.Slime_Enemy_Green")
Enemies.Elite = require("enemies.Elite_Enemy_Test")
Enemies.Boss = require("enemies.BossEnemy")

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
    RoundStart = "RoundStart",
    RoundEnd = "RoundEnd",
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
    self.deckCreated = false
end

function Game:load()
    Game.map = Map
    Player:new()
end

function Game:update()
    if Game.Stage == Game.Stages.MainMenu then
        Game.hasMap = nil
    end
    if Game.Stage == Game.Stages.Map then
        Game.map:generateMap()
    end
    -- if Game.Stage == Game.Stages.DeckMenu then
    -- end
    if Game.Stage == Game.Stages.Combat then
        if not Game.Enemy then
            if Game.map.currentNode.type == CombatNode then
                Enemies.Slime:new()
                Game.Enemy = Enemies.Slime
            elseif Game.map.currentNode.type == EliteCombatNode then
                Enemies.Elite:new()
                Game.Enemy = Enemies.Elite
            elseif Game.map.currentNode.type == BossCombatNode then
                Enemies.Boss:new()
                Game.Enemy = Enemies.Boss
            end
        end

        Player:update()
        Game.Enemy:update()
        CM.update()
        if not Game.Enemy.alive then
            Game:toCombatEnd()
        end
        if Game.State == Game.States.CombatStart then
            if not Game.deckCreated then
                CM.deck = CM.createDeck()
                CM.hand = {}
                CM.discardPile = {}
                CM.deck = CM.shuffledCopy(CM.deck)
                Game.deckCreated = true
            elseif Game.round == 0 then
                if #CM.discardPile > 0 then
                    CM.discardHand(CM.discardPile, CM.deck)
                end
                if #CM.hand > 0 then
                    CM.discardHand(CM.hand, CM.deck)
                end
                CM.deck = CM.shuffledCopy(CM.deck)
                Game.turnStart = true
            end
            Game:toRoundStart()
        end
        if Game.State == Game.States.RoundStart then
            Game:toPlayerTurn()
        end
        if Game.State == Game.States.PlayerTurn then
            if Game.turnStart then
                Player.Armor = 0
                Player.Mana = Player.MAX_MANA
                Game.round = Game.round + 1
                CM.drawCard(5, CM.deck, CM.hand)
                for _, amount in ipairs(Player.pendingEffects.manaNextTurn) do
                    Player.Mana = Player.Mana + amount
                end
                Player.pendingEffects.manaNextTurn = {}
                Game.turnStart = false
            end

            if Game.endTurn then
                CM.discardHand(CM.hand, CM.discardPile)
                Game:toCPUTurn()
                Game.endTurn = false
                Game.turnStart = true
            end
        end
        if Game.State == Game.States.CPUTurn then
            if Game.cpuTurnStart then
                Game.Enemy.Armor = 0
                Game.Enemy:action()
                Game.cpuTurnStart = false
                Game.cpuEndTime = love.timer.getTime() + 1
            end
            Game.cpuEndTurn = true

            if Game.cpuEndTurn and love.timer.getTime() >= Game.cpuEndTime then
                Game:toPlayerTurn()
                Game.cpuEndTurn = false
                Game.cpuTurnStart = true
            end
        end
        if Game.State == Game.States.RoundEnd then
            Game:toRoundStart()
        end
        if Game.State == Game.States.CombatEnd then
            Game.round = 0
            Game.Enemy = nil
            Game:switchStage(Game.Stages.Map)
            Game:toCombatStart()
        end
    end
end

function Game:toCPUTurn()
    self.State = Game.States.CPUTurn
end

function Game:toPlayerTurn()
    self.State = Game.States.PlayerTurn
end

function Game:toRoundStart()
    self.State = Game.States.RoundStart
end

function Game:toRoundEnd()
    self.State = Game.States.RoundEnd
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
