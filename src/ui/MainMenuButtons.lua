Button = require("ui.button")

local M = {}
-- Main Menu
M.MainMenuPlay = Button(
    "Paly",
    function() Game.Stage = Game.Stages.Combat end,
    100,
    30
)
M.MainMenuDeckMenu = Button(
    "Deck",
    function() Game.Stage = Game.Stages.DeckMenu end,
    100,
    30
)
M.MainMenuMap = Button(
    "Map",
    function() Game.Stage = Game.Stages.Map end,
    100,
    30
)
M.MainMenuOptions = Button(
    "Options",
    function() Game.Stage = Game.Stages.Options end,
    100,
    30
)
M.BackButoon = Button(
    "Back",
    function() Game.Stage = Game.Stages.MainMenu end,
    100,
    30
)

M.MainMenuButtons = {
    M.MainMenuPlay,
    M.MainMenuMap,
    M.MainMenuDeckMenu,
    M.MainMenuOptions,
    M.BackButoon
}
return M
