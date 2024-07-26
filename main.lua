-----------------------------------------------------------------------------------------
--------------------------------------Slime quest---------------------------------------
-----------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------
-----------------------------------------------------------------Dev by : Caelum---------
---------------------------------------------------------------------------------- ------
-- Debug
if arg[#arg] == "vsc_debug" then
  require("lldebugger").start()
end
io.stdout:setvbuf('no')
love.graphics.setDefaultFilter("nearest")

if arg[#arg] == "-debug" then require("mobdebug").start() end
-----------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------
-- Position / Origine
-----------------------------------------------------------------------------------------
local x,y = 0,0 
local ox,oy = 0,0
love.window.setMode(1024,768)
largeur = love.graphics.getWidth()
hauteur = love.graphics.getHeight()
utf8 = require("utf8")
-----------------------------------------------------------------------------------------
myGame = require("game")
-----------------------------------------------------------------------------------------
-- Game loop
local timer = 0
-----------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------
function love.load()
   -- Taille de la fenêtre

        x = love.graphics.getWidth()/2
        y = love.graphics.getHeight()/2
          ox = 0
          oy = 0
   -- Affichage du nom du jeu comme nom de fenêtre
    love.window.setTitle("Slime Quest")

  myGame.myScreen.load()
  myGame.load() 
end
-----------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------
function love.update (dt)
  myGame.myScreen.update(dt)
  myGame.update(dt)
end
-----------------------------------------------------------------------------------------
function love.draw()
  myGame.myScreen.draw()
end
-----------------------------------------------------------------------------------------
function love.mousepressed(pX, pY, button)
    local name = nil
    if button == 1 then
      for index, button in ipairs (myGame.myScreen.lstButton) do
        if pX >= button.x and pX<= button.x + button.largeur and 
           pY >= button.y and pY <= button.y + button.hauteur
        then
          name = button.name
        end
        if name == "Start" then 
            myGame.myScreen.screen = "intro"
            myGame.mySon.playEffect("Cursor")
        end
        if name == "Reprendre" then
           myGame.myScreen.screen = "game"
            myGame.mySon.playEffect("Cursor")
        end
        if name == "Charger" then
            myGame.TpDirection = {}
            myGame.myScreen.changeMap("donjonEntrer","worldMap")
            myGame.myScreen.screen = "game"
            myGame.life.nbrpv = myGame.life.nbrpvmax
            myGame.mySon.StopMusic(6)
            myGame.mySon.StopMusic(7)
            myGame.mySon.PlayMusic(5)
            myGame.mySon.playEffect("Cursor")
        end
        if name == "Option" then
            myGame.myScreen.screen = "option"
            myGame.mySon.playEffect("Cursor")
        end
         if name == "Passer" then
            myGame.myScreen.screen = "game"
            myGame.dialogueManager.inDialogue = true
            myGame.mySon.playEffect("Cursor")
        end
        if name == "Menu" then
           myGame.myScreen.screen = "menu"
           myGame.mySon.playEffect("Cursor")
        end
        if name == "Retour" then
           myGame.myScreen.screen = "Pause"
           myGame.mySon.playEffect("Cursor")
        end
        if name == "Quitter" then
          os.exit()
        end
      end
      myGame.myScreen.lstButton = {}
  end 
end
--
function love.keypressed(key)
  myGame.myScreen.keyPressed(key)
end