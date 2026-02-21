local M = {}

CM = require("systems.CardManager")

Game = require("systems.Game")
M.Buttons = require("ui.buttons")

function M.DrawMainMenu()
    for i, button in ipairs(M.Buttons.MainMenuButtons) do
        local y = i * 40
        if button ~= M.Buttons.MainMenuButtonsImport.BackButoon then
            button:draw(
                (Screen.width / 2) - (button.width / 2),
                Screen.height / 3 + y

            )
        end
    end
end

function M.drawDeckMenu()
    M.Buttons.DeckMenuButtonsImport.DeckMenuAddCard:draw(
        Screen.width * 0.2,
        Screen.height * 0.8
    )
    M.Buttons.DeckMenuButtonsImport.DeckMenuRemoveCard:draw(
        Screen.width * 0.2 + 120,
        Screen.height * 0.8
    )
    M.Buttons.MainMenuButtonsImport.BackButoon:draw(
        Screen.width * 0.8,
        Screen.height * 0.8
    )
end

function M.drawMapMenu()
    Game.map:drawMap()
    M.Buttons.MainMenuButtonsImport.BackButoon:draw(
        Screen.width * 0.8,
        Screen.height * 0.8
    )
end

function M.DrawCombatUI()
    -- Draws Player and enemy sprites
    if Game.Stage == Game.Stages.Combat then
        Player:draw(Screen.width * 0.15, Screen.height / 2)
        if Game.Enemy then
            Game.Enemy:draw(Screen.width * 0.8, Screen.height / 2)
        end
    end
    -- End Turn Button
    M.Buttons.CombatButtonsImport.EndTurn:draw(Screen.width * 0.6, Screen.height * 0.8)
    -- Draws Players Mana.
    love.graphics.print(
        "Mana: " .. Player.Mana .. "/" .. Player.MAX_MANA,
        Screen.width * 0.2,
        Screen.height * 0.8

    )
    for i = #CM.deck, 1, -1 do
        local card = CM.deck[i]
        card:draw((Screen.width * 0.1), (Screen.height * 0.8))
    end
    -- Draws cards and draws hoverdCard with elevation.
    for i = 1, #CM.hand do
        local card = CM.hand[i]
        if card == CM.heldCard then goto continue end
        local x = (Screen.width * 0.35) + (i - 1) * 40
        local y = (Screen.height * 0.8)

        if card == CM.hoverdCard then
            --x = 200 + (i - 1) * 30 + 80
            y = (Screen.height * 0.8) - 20
            CM.hoverdCard.y = y
        else
            card:draw(x, y)
        end
        ::continue::
    end
    for _, card in ipairs(CM.discardPile) do
        card:draw((Screen.width * 0.8), (Screen.height * 0.8))
    end
    if CM.hoverdCard and not CM.heldCard then
        CM.hoverdCard:draw()
    end
    if CM.heldCard then
        CM.heldCard:draw()
    end
end

function M.drawOptionsMenu()
    local button = M.Buttons.MainMenuButtonsImport.BackButoon
    button:draw(
        (Screen.width / 2) - (button.width / 2),
        Screen.height / 3
    )
end

function M.drawPlayer()
end

function M.draw()
    if Game.Stage == Game.Stages.MainMenu then
        M.DrawMainMenu()
    end
    if Game.Stage == Game.Stages.DeckMenu then
        M.drawDeckMenu()
    end
    if Game.Stage == Game.Stages.Map then
        M.drawMapMenu()
    end
    if Game.Stage == Game.Stages.Combat then
        M.DrawCombatUI()
    end
    if Game.Stage == Game.Stages.Options then
        M.drawOptionsMenu()
    end
end

return M
