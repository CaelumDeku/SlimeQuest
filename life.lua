-----------------------------------------------------------------------------------------
---------------------------------Gestion vie---------------------------------------------
-----------------------------------------------------------------------------------------
local life = {}
-----------------------------------------------------------------------------------------
---------------------------------------Coeur Plein---------------------------------------
life.lifeFull = love.graphics.newImage ("picture/life/coeurfull.png")
-----------------------------------------------------------------------------------------
---------------------------------------Coeur Vide----------------------------------------
life.lifeNil = love.graphics.newImage ("picture/life/coeurvide.png")
-----------------------------------------------------------------------------------------
---------------------------------------1/4 de coeur--------------------------------------
life.lifeQuard = love.graphics.newImage ("picture/life/coeur1.png")
-----------------------------------------------------------------------------------------
---------------------------------------Demi coeur----------------------------------------
life.lifeMid = love.graphics.newImage ("picture/life/coeur2.png")
-----------------------------------------------------------------------------------------
---------------------------------------3/4 de coeur--------------------------------------
life.lifeTQuard = love.graphics.newImage ("picture/life/coeur3.png")
-----------------------------------------------------------------------------------------
life.nbrpvmax = 48
life.nbrpv = 48
local time = 0
-----------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------
function PV (pX, pY)
  -- Vie max du héro
  if life.nbrpv > life.nbrpvmax then 
    life.nbrpv = life.nbrpvmax
  end
  -- Affichage des vies par 1/4 de coeur
    local x = pX
    local y = pY
    local largeur = life.lifeMid:getWidth()
    local lifeR = math.floor(life.nbrpv / 4)
    for n = 1, lifeR do
        love.graphics.draw(life.lifeFull, x, y)
        x =x + largeur
    end
    local seeLife = life.nbrpv % 4
    if seeLife == 3 then
        love.graphics.draw(life.lifeTQuard, x, y)
        lifeR = lifeR + 1
        x = x + largeur
    elseif seeLife == 2 then
        love.graphics.draw(life.lifeMid, x, y)
        lifeR = lifeR + 1
        x = x + largeur
    elseif seeLife == 1 then
        love.graphics.draw(life.lifeQuard, x, y)
        lifeR = lifeR + 1
        x = x + largeur
    end
    -- Affichage du coeur vide de façon fix
    for n = (lifeR + 1), math.floor(life.nbrpvmax / 4) do
        love.graphics.draw(life.lifeNil, x, y)
        x = x + largeur
    end
end
-----------------------------------------------------------------------------------------
function life.update(Pmap,dt)
    time = time + dt *2
    if time > 2 then
        time = 0
    end
  -- GAMEOVER
    if life.nbrpv <= 0 then 
      myGame.mySon.playEffect("KO") 
      myGame.myScreen.screen = "gameOver" 
    end 
end
-----------------------------------------------------------------------------------------
function life.draw()
  -- Clignotement des vies basse
    local afficher = true
    if life.nbrpv <= 8 then
        if math.floor(time) == 0 then
         afficher =false
         myGame.mySon.playEffect("LowHealth") 
        end
    end
  -- Affichage de la vie dans la barre
    if afficher then
        PV(64,1)
    end
end
-----------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------
return life