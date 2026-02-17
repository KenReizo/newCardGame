-- Version 008
package.path = package.path ..
    ";src/?.lua;src/lib/?.lua;src/cards/?.lua;src/systems/?.lua;src/entities/?.lua;src/debug/?.lua;src/ui/?.lua;src/maps/?.lua;src/maps/nodes/?.lua"

Card = require("cards.Card")
Game = require("systems.Game")
Input = require("systems.Input")

UI = require("systems.UI")
Debug = require("dbug.debugPrints")


Screen = {}
Screen.width = 1920
Screen.height = 1080


function love.load()
    love.window.setMode(Screen.width, Screen.height, { resizable = true, fullscreen = true })
    math.randomseed(os.time())
    Game:new()
    Game:load()
end

function love.update()
    RandomNumber = math.random(0, 1)
    Game:update()
    Input:update()
end

function love.draw()
    UI.draw()

    -- Debug
    Debug.debugPrint()
end
