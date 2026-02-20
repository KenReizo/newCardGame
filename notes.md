# Ideas
* Keep as much as posible at one place, do not spread out over
    mutiple files if posible.

## Todo 
* [x] Pollis buttons to make it easier to create more buttons and to 
    use them. (I think the current system will work fine)
* Work on game loop system.
    - [ ] play should go to map and map to combat / room then back 
        to map.
* Make more enemies
    - [ ] Need to make elites and bosses along whit more normal
        enemies.
- Work on Map
    - [x] Create more nodes for rooms.
        (Have crated the basic rooms)
    - [ ] Work on question mark rooms. 
        (This is low priority for now)
    - [ ] Flesh out the basic room nodes
        - [ ] Normal CombatNode
        - [ ] Elite CombatNode
        - [ ] Boss CombatNode
        - [ ] RestNode
    - [ ] Create one map per Act (probably going to be 3 Acts)
* Work on combat.
    - [ ] Add status effects like, streght, weak, poison, dexterity, 
        frail...
* Make artworks 
    
    - [x] Since this is a hobby /passion project, then maybe using
        AI for art is accepteble.
        (Turns out that most AI image
        generators only do 1024x1024 which dose not go well for 
        pixelart. The AI say i will have to downscale it my 
        self which will ruin the image)
    - [ ] Enemy sprites, player sprite
    - [ ] Buttons?
    - [ ] Backgrounds

# Updates

* 20.02.26 --Version 008
    Created EliteCombatNode and BossCmbatNode. The only 
    diffrence between them for now is that they are diffrent
    collors on the map.(Need more enemies, elites and Bosses)

    RestNode now heals player 25 HP and if HP > maxHP then 
    HP == MAXHP. 

    There are now nodes for all basic rooms exept for question 
    mark rooms, wich are more complicated and not a priority for 
    the moment. 
    The funconality for the rooms are basic and needs to be 
    expanded on.

* 19.02.26 --Version 008
    Map nodes do not cross each other if there are 2 iterations.
    If there are more iterations then they can cross. 

    I think it's beacuse we only check against one iteration at 
    a time. So if there are 5 iterations and we are on the 5 
    iteration and checking the 2 iter and find a legal move,
    then that move is chosen and the later iter is not checked.

    Have now updated canConnect() to go though all iter and
    then return true. Did this by making the "if check" in to a
    variable and doing if not noCrossing retun false. Then 
    returning true at the end, insted of the first noCrossing
    found.

* 18.02.26 --Version 008
    Redesigend Game:generateMap(), shorter and more readble. 
    Generartes a "node Path" 6 times all paths ends in one node. 
    Nodes are not added if a node allready exists in that spot.
    
    nodes added to map now can only be in a range of max 1+ or 1- 
    the previous node chosen at random. If the previous node is 
    on the eage of the map then the new node can not be outside 
    the map and instad gets a rage of max +2 or -2 depending on 
    which side of the map the previous node is.

    Tried to make it so nodes don't cross paths but is 
    unsucessfull. Tried with help form AI but no luck.

* 17.02.26 --Version 008
    Nodes in the map menu now have buttons that are clickeble 
    have functions. The map.lua is responible for making the 
    buttons any new nodes just needs to have a trigger() for the 
    button to work.

    I have also made a functions in Input.lua that checks if 
    mouse is with inn a circle.

    Created a rudamentaly map generator (Currently only has 
    CombatNode)
    Added "Paths" between rooms, some ends in a dead end.

* 15.02.26 --Version 008
    Nodes are now drawn in the correct place. Got help from AI to
    class figure it out. Aparrently I could not use the 
    classic.lua to create nodes as Objects, I needed to make the 
    nodes in "pure" lua else the last node would overwright the 
    earlier nodes.

* 13.02.26 --Version 008
    Started on Map system, created BaseNode.lua and 
    CombatNode.lua. Map.lua need to be updated to make use of the 
    draw functions from the Nodes.

* 12.02.26 --Version 008
    Replaced WINDOW_WIDTH and WINDOW_HEIGHT with Screen.width and 
    Screen.height.

* 10.02.26 --Version 008
    I have splitt up the buttons into diffrent files coresponding 
    to there respective menus or where they are used. (Might need 
    to work a bit more on it so it's easier to make more buttons.)

* 09.02.26 
    Done some cleen up. Have moved most of what was in main.lua to 
    Game.lua, UI.lua or Input.lua and so on. Moved the induvidual
    cards like AttackCard into Player1Cards.lua (needs better name).
    
    Moved buttons from UI.lua to ui/buttons.lua. Might move splitt
    buttons up into MainMenuButtons.lua and OptionsMenuButtons.lua
    for better organization and implimentation of buttons.

