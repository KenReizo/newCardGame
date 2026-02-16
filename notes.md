# Ideas
* Keep as much as posible at one place, do not spread out over
    mutiple files if posible.

* Put the statemachine in Game.lua into it's own function with 
    Game.state and Game.Stage as args. 
    (Tried but the statemachine is continusly going on and dose not wait)

## Todo 
* Pollis buttons to make it easier to create more buttons and to use them.
* Figure out how to make the map.
    * Grid system for map.
    * Nodes for rooms.
    * Need to make Nodes/ Rooms clickeble.
* Add status effects like, streght, weak, poison, dexterity, frail...

# Updates

* 15.02.26 --Version 008
    Nodes are now drawn in the correct place. Got help from AI to class
    figure it out. Aparrently I could not use the classic.lua to create
    nodes as Objects, I needed to make the nodes in "pure" lua else the 
    last node would overwright the earlier nodes.

* 13.02.26 --Version 008
    Started on Map system, created BaseNode.lua and CombatNode.lua.
    Map.lua need to be updated to make use of the draw functions
    from the Nodes.

* 12.02.26 --Version 008
    Replaced WINDOW_WIDTH and WINDOW_HEIGHT with Screen.width and Screen.height.

* 10.02.26 --Version 008
    I have splitt up the buttons into diffrent files coresponding to
    there respective menus or where they are used. (Might need to 
    work a bit more on it so it's easier to make more buttons.)

* 09.02.26 
    Done some cleen up. Have moved most of what was in main.lua to 
    Game.lua, UI.lua or Input.lua and so on. Moved the induvidual
    cards like AttackCard into Player1Cards.lua (needs better name).
    
    Moved buttons from UI.lua to ui/buttons.lua. Might move splitt
    buttons up into MainMenuButtons.lua and OptionsMenuButtons.lua
    for better organization and implimentation of buttons.

