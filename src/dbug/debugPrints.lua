local M = {}
Card = require("cards.Card")
CM = require("systems.CardManager")
Game = require("systems.Game")
Player = require("entities.Player")
Enemy = require("entities.enemies.Slime_Enemy_Green")
UI = require("systems.UI")

function M.debugPrint()
    local mx, my = love.mouse.getPosition()
    love.graphics.print("Mouse Pos: x = " .. mx .. " y = " .. my, 10)
    love.graphics.print("Cards in Deck: " .. tostring(#CM.deck), 10, 10)
    love.graphics.print("Cards in Hand: " .. tostring(#CM.hand), 10, 20)
    love.graphics.print("Cards in DiscardPile: " .. tostring(#CM.discardPile), 10, 30)
    if #CM.deck > 0 then
        love.graphics.print("Card Width: " .. tostring(CM.deck[1].width) .. " Height: " .. tostring(CM.deck[1].height),
            10, 40)
    end
    if #CM.hand > 0 then
        love.graphics.print("First card in hand pos x: " .. tostring(CM.hand[1].x) .. " y: " .. tostring(CM.hand[1].y),
            10, 50)
    end
    love.graphics.print("Game State: " .. tostring(Game.State), 10, 60)
    love.graphics.print("Round: " .. tostring(Game.round), 10, 70)
    love.graphics.print("Enemy HP: " .. tostring(Enemy.HP), 10, 80)
    love.graphics.print("Enemy HP_BAR: " .. tostring(Enemy.HP_BAR), 10, 90)
    if UI.Buttons.EndTurnButton then
        love.graphics.print(
            UI.Buttons.EndTurnButton.text ..
            " Button X: " .. UI.Buttons.EndTurnButton.x ..
            " Y: " .. UI.Buttons.EndTurnButton.y ..
            " Width: " .. UI.Buttons.EndTurnButton.width ..
            " Height: " .. UI.Buttons.EndTurnButton.height,
            10, 104

        )
    end
end

return M
