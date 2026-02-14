Button = require("ui.button")
local M = {}
-- Deck Menu
M.DeckMenuAddCard = Button(
    "Add Card",
    function() print("hi") end,
    100,
    30
)
M.DeckMenuRemoveCard = Button(
    "Remove Card",
    function() print("hi") end,
    100,
    30
)
M.DeckMenuButtons = {
    M.DeckMenuAddCard,
    M.DeckMenuRemoveCard
}
return M
