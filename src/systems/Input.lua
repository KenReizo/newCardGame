local function isMouseInCircle(circle_x, circle_y, circle_radius, mx, my)
    local dx = mx - circle_x
    local dy = my - circle_y
    local distanceSquared = dx * dx * dy * dy
    return distanceSquared <= circle_radius * circle_radius
end
local M = {}
function M:update()
    function love.mousepressed(x, y, button)
        if button == 1 then
            for _, uiButton in ipairs(
                UI.Buttons.DeckMenuButtons) do
                if x >= uiButton.x and
                    x <= uiButton.x + uiButton.width and
                    y >= uiButton.y and
                    y <= uiButton.y + uiButton.height then
                    uiButton.func()
                end
            end
            for _, uiButton in ipairs(
                UI.Buttons.MainMenuButtons) do
                if x >= uiButton.x and
                    x <= uiButton.x + uiButton.width and
                    y >= uiButton.y and
                    y <= uiButton.y + uiButton.height then
                    uiButton.func()
                end
            end
            for _, uiButton in ipairs(
                UI.Buttons.CombatButtons) do
                if x >= uiButton.x and
                    x <= uiButton.x + uiButton.width and
                    y >= uiButton.y and
                    y <= uiButton.y + uiButton.height then
                    uiButton.func()
                end
            end
            for _, uiButton in ipairs(
                UI.Buttons.NodeButtons) do
                if isMouseInCircle(uiButton.x, uiButton.y,
                        uiButton.radius, x, y) then
                    uiButton.func()
                end
            end
        end
    end

    function love.mousereleased(x, y, button)
        x = x
        if CM.heldCard and button == 1 then
            if y <= Screen.height / 2 and Player.Mana >= CM.heldCard.cost then
                if CM.heldCard.type == "target" then
                    CM.heldCard.action(Enemy)
                elseif CM.heldCard.type == "self" then
                    CM.heldCard.action(Player)
                elseif CM.heldCard.type == "Utility" then
                    CM.heldCard.action()
                end
                Player.Mana = Player.Mana - CM.heldCard.cost
                CM.cardToTable(CM.heldCard, CM.hand, CM.discardPile)
                CM.heldCard = nil
            end
            CM.heldCard = nil
        end
    end

    function love.keypressed(key)
        if key == "d" then
            CM.drawCard(1, CM.deck, CM.hand)
        end
        if key == "return" then
            CM.discardHand(CM.hand, CM.discardPile)
        end
        if key == "space" then
            Game.endTurn = true
        end
        if key == "m" then
            Game.cpuEndTurn = true
        end
    end
end

return M
