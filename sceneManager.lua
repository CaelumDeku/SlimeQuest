-----------------------------------------------------------------------------------------
------------------------------Générateur des scènes du jeu-------------------------------
-----------------------------------------------------------------------------------------
local sceneManager = {}
-----------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------
local introY = 700
local introX = 180
local introLine = 30
local picy = 300
local lastIntroY = 700
-----------------------------------------------------------------------------------------
sceneManager.picAll = love.graphics.newImage("picture/screen/fonts.jpg")
sceneManager.picTitre = love.graphics.newImage("picture/screen/titre.png")
sceneManager.picMenu = love.graphics.newImage("picture/screen/Loyd.png")
sceneManager.picGameOver = love.graphics.newImage("picture/screen/gameover.png")
sceneManager.picAureole= love.graphics.newImage("picture/screen/aureole.png")
sceneManager.picPause = love.graphics.newImage("picture/screen/pause.png")
--sceneManager.picMaj = love.graphics.newImage("picture/screen/textmaj.png")
sceneManager.picKey= love.graphics.newImage("picture/screen/touches.png")
sceneManager.picIntro = love.graphics.newImage("picture/screen/intro.jpg")
sceneManager.picContour= love.graphics.newImage("picture/screen/contour1.png")
sceneManager.picwin = love.graphics.newImage("picture/screen/win.png")
sceneManager.picButton1 = love.graphics.newImage("picture/GUI/button.png")
sceneManager.picButton2 = love.graphics.newImage("picture/GUI/buttonP.png")
sceneManager.picPanel = love.graphics.newImage("picture/GUI/panel.png")
-----------------------------------------------------------------------------------------
sceneManager.screen = "menu"
-----------------------------------------------------------------------------------------
sceneManager.lstButton = {}
-----------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------
function sceneManager.load()
  largeur = love.graphics.getWidth()
  hauteur = love.graphics.getHeight()
  myGame.mySon.load()
  myGame.load()
end
-----------------------------------------------------------------------------------------
---------------------------------------Menu----------------------------------------------
-----------------------------------------------------------------------------------------
function drawMenu()
  love.graphics.draw(sceneManager.picAll,0,0)
  love.graphics.draw(sceneManager.picMenu,0,300)
  love.graphics.draw(sceneManager.picTitre,200,0,0,2)
  sceneManager.createButton("Start",largeur*0.5,350)
  sceneManager.createButton("Quitter",largeur*0.5,450 )
end
function updateMenu (dt)
 myGame.mySon.PlayMusic(1)
end
-----------------------------------------------------------------------------------------
---------------------------------------Intro---------------------------------------------
-----------------------------------------------------------------------------------------
function drawintro()
  local  ox = sceneManager.picIntro:getWidth()*0.5  
  local oy = sceneManager.picIntro:getHeight()*0.5
  ----------------------------------------------------------------------------------------
  love.graphics.draw(sceneManager.picAll,0,0)
  love.graphics.draw(sceneManager.picIntro,largeur*0.5,picy,0,1,1,ox,oy)
  sceneManager.createButton("Passer",825,5)
  ----------------------------------------------------------------------------------------
  love.graphics.setFont (love.graphics.newFont (30))
  font = love.graphics.getFont ()
  text = love.graphics.newText(font)
  height = font:getHeight( )
  -----------------------------------------------------------------------------------------
  text:add( {{2,2,2}, "Nous sommes en l'an 666, de l'ère d'Ouroboros.\nLa prophétie, annonçant le retour de l'Absolue,\nest sur le point de se réaliser, son premier\ndonjon vient d'apparaître dans le but d'asservir \nles humains.\nLe premier Général vient de se réveiller.\nConnu sous le nom de sorcière du silence,\nelle déclencha une guerre sanglante.\nLe culte de la lune, décida d'envoyer ses paladins.\nC'est ainsi que Loyd, un jeune prodige, fut maudit.\nAfin de rétablir la paix et lever cette malédiction\nAurile, la déesse de la lune, donna \nun masque de conjuration à son élu.\nLa lame purificatrice figée dans son socle \nattend celui qui portera la bénédiction \ndu croissant de lune.\nLe temps presse, tu devrais te hâter ! \nLève la malédiction avant d'être soumis par l'Absolue."},introX , introY)  love.graphics.draw (text, 10, 10) 
end
function updateIntro(dt)
  local speed = 15
  introY = introY - dt * speed
  picy = picy - dt* speed
   if introY < 0 then
     sceneManager.screen = "game"
     myGame.dialogueManager.inDialogue = true
    end
end
-----------------------------------------------------------------------------------------
---------------------------------------Game----------------------------------------------
-----------------------------------------------------------------------------------------
function drawGame()
  love.graphics.draw(sceneManager.picAll , 0,0)
 -- sceneManager.createButton("Quest",800,64)
  -- maps
   if myGame.mapLoadText ~= "" then
     myGame.mapLoad = myGame[myGame.mapLoadText]
     myGame.drawMAP(myGame.mapLoad, myGame.mapLoad.class)
   end 
  -- interface
  myGame.draw()
  --PNJ
  myGame.pnj.draw()
  -- héro
  myGame.hero.draw()
  -- Ennemie
  myGame.enemy.draw()
  -- Racoon
  myGame.miniboss.draw()
  -- Witch
  myGame.boss.draw()
  --dialogue
  myGame.dialogueManager.draw()
end
function updateGame(dt)
  myGame.mySon.StopMusic(1)
  myGame.mySon.update(dt)
  myGame.dialogueManager.update(dt)
   if myGame.mapLoadText == "" then
     myGame.mapLoadText = "homeHero"
     --myGame.mySon.PlayMusic(3)
     myGame.hero.x = largeur * 0.5
     myGame.hero.y = hauteur * 0.5
     myGame.tpmap(12,18.5,"worldMap",true)
     myGame.pnj.newPnj(6,14.5*32,11*32,0,0,2)
   end
  myGame.hero.update(myGame.Map, dt)
  if myGame.dialogueManager.inDialogue == false then
  myGame.pnj.update(myGame.Map, dt)
  myGame.enemy.update(myGame.Map, dt)
  myGame.miniboss.update(myGame.Map, dt)
  myGame.boss.update(myGame.Map, dt)
end
  myGame.life.update(myGame.Map,dt)
  myGame.energy.update(myGame.Map,dt)
end
-----------------------------------------------------------------------------------------
-----------------------------------------Option------------------------------------------
-----------------------------------------------------------------------------------------
function drawOption ()
  local x = 650
  local y = 250
 love.graphics.draw(sceneManager.picAll , 0,0)
 love.graphics.draw(sceneManager.picKey,0,0) 
 sceneManager.createButton("Retour",x,y)
end
function updateOption(dt)
  myGame.mySon.update(dt)
end
-----------------------------------------------------------------------------------------
-----------------------------------------Pause-------------------------------------------
-----------------------------------------------------------------------------------------
function drawPause ()
  local x = 400
  local y = 275
 love.graphics.draw(sceneManager.picAll,0,0)
 love.graphics.draw(sceneManager.picContour,0,0) 
 
 love.graphics.draw(sceneManager.picPanel,310,100,0,2)
 love.graphics.draw(sceneManager.picPause,410,105)
 sceneManager.createButton("Reprendre",x,y)
 sceneManager.createButton("Option",x,y+100)
 sceneManager.createButton("Quitter",x,y+200)
end
function updatePause(dt)
 myGame.mySon.update(dt)
end
-----------------------------------------------------------------------------------------
---------------------------------------Game Over-----------------------------------------
-----------------------------------------------------------------------------------------
function drawGameOver ()
  myGame.mySon.StopMusic(2)
  love.graphics.draw(sceneManager.picGameOver,0,0)

  sceneManager.createButton("Menu",largeur*0.5,325 )
  sceneManager.createButton("Charger",largeur*0.5,425 )
  sceneManager.createButton("Quitter",largeur*0.5,525 )

  myGame.DrawSprite("HeroKo",355,450,0,4,myGame.hero.tilesetW*0.5, myGame.hero.tilesetW * 0.5)
  love.graphics.draw(sceneManager.picAureole,355,450,0,1,1,sceneManager.picAureole:getWidth()*0.5, sceneManager.picAureole:getHeight()*0.5)
end
function updateGameOver (dt)
  myGame.mySon.update(dt)
end
-----------------------------------------------------------------------------------------
---------------------------------------Game win------------------------------------------
-----------------------------------------------------------------------------------------
function drawWin()
  love.graphics.draw(sceneManager.picAll , 0,0)
  love.graphics.draw(sceneManager.picwin,0,0)
end
function updateWin (dt)
myGame.mySon.update(dt)
end
-----------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------
function sceneManager.update(dt)
 if sceneManager.screen == "menu" then 
    updateMenu (dt)
 elseif sceneManager.screen == "game" then 
    updateGame (dt) 
 elseif sceneManager.screen == "gameOver" then 
    updateGameOver (dt) 
 elseif sceneManager.screen == "intro" then
    updateIntro(dt)
  elseif sceneManager.screen == "pause" then
    updatePause(dt)
  elseif sceneManager.screen == "option" then
    updatePause(dt)
  elseif sceneManager.screen == "win" then
    updateWin(dt)
 end
 if myGame.myScreen.screen == "menu" then 
   myGame.mySon.PlayMusic(1)
 elseif myGame.myScreen.screen == "intro" then 
   myGame.mySon.StopMusic(1)
   myGame.mySon.PlayMusic(2)
elseif myGame.myScreen.screen == "game" and myGame.mapLoadText == "homeHero" then
   myGame.mySon.StopMusic(2)
   myGame.mySon.PlayMusic(3)
  elseif myGame.mapLoadText == "village" then
   myGame.mySon.StopMusic(3)
   myGame.mySon.PlayMusic(4)
  elseif myGame.mapLoadText == "worldMap" then
    myGame.mySon.StopMusic(4)
   myGame.mySon.PlayMusic(3)
  elseif myGame.mapLoadText == "donjonEntrer" then
   myGame.mySon.StopMusic(3)
   myGame.mySon.PlayMusic(5)
  elseif myGame.mapLoadText == "donjonMiniBoss" then
   myGame.mySon.StopMusic(5)
   myGame.mySon.PlayMusic(6)
  elseif myGame.mapLoadText == "donjonBoss" then
   myGame.mySon.StopMusic(6)
   myGame.mySon.PlayMusic(7)
elseif myGame.myScreen.screen == "win" then 
   myGame.mySon.StopMusic(7)
   myGame.mySon.PlayMusic(8)
 end
end
-----------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------
function sceneManager.draw()
    if sceneManager.screen == "menu" then 
        drawMenu ()
    elseif sceneManager.screen == "game" then
        drawGame()
    elseif sceneManager.screen == "gameOver" then
        drawGameOver()
    elseif sceneManager.screen == "intro" then
        drawintro()
    elseif sceneManager.screen == "Pause" then
        drawPause()
    elseif sceneManager.screen == "win" then
        drawWin()
    elseif sceneManager.screen == "option" then
        drawOption()
    end
end
-----------------------------------------------------------------------------------------
--------------------------------Création bouton------------------------------------------
-----------------------------------------------------------------------------------------
function sceneManager.createButton(pText,pX,pY)
  local bEstButton = false
  for index , pButton in ipairs(sceneManager.lstButton) do
    if pText == pButton.name then
      bEstButton = true
      break
    end
  end
  if bEstButton == false then
    local button = {
      name = pText,
      x = pX,
      y = pY, 
      largeur = sceneManager.picButton1:getWidth(),
      hauteur = sceneManager.picButton1:getHeight()
    }
    table.insert(sceneManager.lstButton, button) 
  end
    love.graphics.draw(sceneManager.picButton1,pX,pY,0,1,1.5)
    if love.mouse.isDown(1) then
       love.graphics.draw(sceneManager.picButton2,pX,pY,0,1,1.5)
    end
    love.graphics.setFont (love.graphics.newFont (30))
    font = love.graphics.getFont ()
    text = love.graphics.newText(font)
    height = font:getHeight( )
    text:add( {{2,2,2}, pText},pX, pY)
    love.graphics.draw (text,sceneManager.picButton1:getWidth() * 1 * 0.5,
    sceneManager.picButton1:getHeight() * 1 * 0.5,0,1,1,text:getWidth() * 0.5,text:getHeight() * 0.5) 
end
-----------------------------------------------------------------------------------------
---------------------------------------Option clavier------------------------------------
-----------------------------------------------------------------------------------------
function sceneManager.keyPressed(key)
 if sceneManager.screen == "game" then
  myGame.dialogueManager.keypressed(key)
    if key == "tab" then
      myGame.mySon.playEffect("menu") 
      sceneManager.screen ="Pause"
      sceneManager.draw()
    end
  elseif sceneManager.screen == "game" then
    if sceneManager.screen == "game" then
      sceneManager.draw()
    end
  elseif sceneManager.screen == "Pause" then
    if key == "tab" then
      myGame.mySon.playEffect("menu") 
      sceneManager.screen = "game"
      sceneManager.draw()
    end
  end
end
-----------------------------------------------------------------------------------------
function sceneManager.changeMap(pMap,pMapPrec)
  myGame.mapLoadText = pMap
  if pMap == "worldMap" and pMapPrec == "homeHero" then
    myGame.hero.x = 3 * myGame.Map.TileWIDHT
    myGame.hero.y = 4 * myGame.Map.TileHEIGHT
  elseif pMap == "worldMap" and pMapPrec == "village" then
    myGame.hero.x = 28 * myGame.Map.TileWIDHT
    myGame.hero.y = 4.5 * myGame.Map.TileHEIGHT
  elseif pMap == "worldMap" and pMapPrec == "donjonEntrer" then
    myGame.hero.x = 3 * myGame.Map.TileWIDHT
    myGame.hero.y = 18 * myGame.Map.TileHEIGHT
  elseif pMap == "village" and pMapPrec == "worldMap" then
    myGame.hero.x = 2 * myGame.Map.TileWIDHT
    myGame.hero.y = 10 * myGame.Map.TileHEIGHT
  elseif pMap == "shop" and pMapPrec == "village" then
    myGame.hero.x = 9 * myGame.Map.TileWIDHT
    myGame.hero.y = 20 * myGame.Map.TileHEIGHT
  elseif pMap == "village" and pMapPrec == "shop" then
    myGame.hero.x = 10.5 * myGame.Map.TileWIDHT
    myGame.hero.y = 7.5 * myGame.Map.TileHEIGHT
  elseif pMap == "donjonEntrer" and pMapPrec == "worldMap" then
    myGame.hero.x = 16 * myGame.Map.TileWIDHT
    myGame.hero.y = 22 * myGame.Map.TileHEIGHT
  elseif pMap == "donjonEntrer" and pMapPrec == "donjonSimple" then
    myGame.hero.x = 1 * myGame.Map.TileWIDHT
    myGame.hero.y = 12 * myGame.Map.TileHEIGHT
  elseif pMap == "donjonSimple" and pMapPrec == "donjonEntrer" then
    myGame.hero.x = 30 * myGame.Map.TileWIDHT
    myGame.hero.y = 12 * myGame.Map.TileHEIGHT
  elseif pMap == "donjon" and pMapPrec == "donjonSimple" then
    myGame.hero.x = 16 * myGame.Map.TileWIDHT
    myGame.hero.y = 22 * myGame.Map.TileHEIGHT
  elseif pMap == "donjonSimple" and pMapPrec == "donjon" then
    myGame.hero.x = 16 * myGame.Map.TileWIDHT
    myGame.hero.y = 2 * myGame.Map.TileHEIGHT
  elseif pMap == "donjonMiniBoss" and pMapPrec == "donjon" then
    myGame.hero.x = 16 * myGame.Map.TileWIDHT
    myGame.hero.y = 23 * myGame.Map.TileHEIGHT
  elseif pMap == "donjonMiniBoss" and pMapPrec == "donjonMiniBoss" then
    myGame.hero.x = 16 * myGame.Map.TileWIDHT
    myGame.hero.y = 18 * myGame.Map.TileHEIGHT
  elseif pMap == "donjonBoss" and pMapPrec == "donjonMiniBoss" then
    myGame.boss.enterHero = false
    myGame.hero.x = 16 * myGame.Map.TileWIDHT
    myGame.hero.y = 23 * myGame.Map.TileHEIGHT
  elseif pMap == "donjonBoss" and pMapPrec == "donjonBoss" then
    myGame.boss.enterHero = true
    myGame.hero.x = 16 * myGame.Map.TileWIDHT
    myGame.hero.y = 18 * myGame.Map.TileHEIGHT
  end
  myGame.hero.pixieresetXY()
  sceneManager.mapMANAGER(pMap)
end
-----------------------------------------------------------------------------------------
function sceneManager.mapMANAGER(pMap)
  if pMap == "worldMap" then
    myGame.tpmap(30.5,4.5,"village",true)
    myGame.tpmap(2,17.5,"donjonEntrer",true)
    myGame.pnj.list = {}
    myGame.enemy.list = {}
    myGame.enemy.new(4,16*32,6*32,6*32,10*32,1)
  elseif pMap == "village" then
    myGame.tpmap(10.5,6.5,"shop",true)
    myGame.tpmap(0.5,10.5,"worldMap",true)
    myGame.enemy.list = {}
    myGame.pnj.list = {}
    myGame.pnj.newPnj(1,2*32,12*32,0,0,2)
    myGame.pnj.newPnj(2,16.5*32,9.5*32,0,0,2)
    myGame.pnj.newPnj(4,24*32,6*32,0,0,2)
    myGame.pnj.newPnj(5,2*32,19.5*32,0,0,2)
  elseif pMap == "shop" then
    myGame.tpmap(9,22.5,"village",true)
    myGame.pnj.list = {}
    myGame.pnj.newPnj(3,6.5*32,14*32,0,0,2)
    myGame.pnj.newPnj(7,8*32,8*32,0,0,2)
    myGame.pnj.newPnj(8,23*32,8*32,0,0,2)
  elseif pMap == "donjonEntrer" then
    myGame.tpmap(0.5,12,"donjonSimple",true)
   -- myGame.tpmap(19,23.5,"worldMap",true)
    myGame.miniboss.list = {}
    myGame.miniboss.LstShoot = {}
    myGame.boss.list = {}
    myGame.boss.LstShoot = {}
    myGame.enemy.list = {}
    myGame.pnj.list = {}
  elseif pMap == "donjonSimple" then
    myGame.tpmap(16,1.5,"donjon",true)
    myGame.tpmap(31.5,12,"donjonEntrer",true)
    myGame.pnj.list = {}
    myGame.enemy.list = {}
    myGame.enemy.new(10,16*32,6*32,6*32,10*32,1)
  elseif pMap == "donjon" then
    myGame.tpmap(16,23.5,"donjonSimple",true)
    myGame.tpmap(16,1.5,"donjonMiniBoss",true)
    myGame.enemy.list = {}
    myGame.pnj.list = {}
    myGame.enemy.new(10,16*32,6*32,6*32,10*32,1)
  elseif pMap == "donjonMiniBoss" then
    myGame.tpmap(16,21.5,"donjonMiniBoss",true)
    myGame.tpmap(16,1.5,"donjonBoss",false)
    myGame.pnj.list = {}
    myGame.enemy.list = {}
    myGame.miniboss.list = {}
    myGame.miniboss.new("Racoon","1",largeur*0.5,2*myGame.Map.TileHEIGHT)
    myGame.enemy.new(2,16*32,6*32,6*32,10*32,1)
  elseif pMap == "donjonBoss" then
     myGame.tpmap(16,21.5,"donjonBoss",true)
     myGame.pnj.list = {}
     myGame.enemy.list = {}
     myGame.miniboss.list = {}
     myGame.boss.list = {}
     myGame.boss.new("Witch","1",largeur*0.5,400)
  end
end
-----------------------------------------------------------------------------------------
return sceneManager 