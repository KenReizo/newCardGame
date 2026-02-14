Button = require("ui.button")

local M = {}
local B = {}
M.EndTurn = Button(
    "End Turn",
    function() Game.endTurn = true end,
    100,
    30
)

M.CombatButtons = {
    M.EndTurn
}
return M
