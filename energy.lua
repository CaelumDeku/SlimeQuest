-----------------------------------------------------------------------------------------
---------------------------Gestion Energie-----------------------------------------------
-----------------------------------------------------------------------------------------
local energy = {}
-----------------------------------------------------------------------------------------
local energy = {}
-----------------------------------------------------------------------------------------
--------------------------------------Energie remplie------------------------------------
energy.energyFull = love.graphics.newImage("picture/life/energyfull.png")
-----------------------------------------------------------------------------------------
---------------------------------------Energie vide--------------------------------------
energy.energyNil = love.graphics.newImage("picture/life/energynil.png")
-----------------------------------------------------------------------------------------
energy.nbrmanamax = 25
energy.nbrmana = 25
local time = 0
-----------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------
function energy.update(Pmap,dt)
    time = time + dt *2
    if time > 2 then
        time = 0
    end
end
-----------------------------------------------------------------------------------------
function energy.draw()
    -- Clignotement de l'energie basse
    local afficher = true
    if energy.nbrmana == 2 then
        if math.floor(time) == 0 then
         afficher =false
        end
    end
    -- Affichage de l'energie dans la barre
    if afficher then
        mana(largeur*0.5+64)
    end
end
-----------------------------------------------------------------------------------------
function mana(pX, pY)
    -- Energy max du héro
  if energy.nbrmana > energy.nbrmanamax then 
    energy.nbrmana = energy.nbrmanamax
    end
  -- Affichage de l'energie remplie
    local x = pX
    local y = pY
    local largeur = energy.energyFull:getWidth()
    local energyR = math.floor(energy.nbrmana* 0.5)
       for m = 1, energyR do
        love.graphics.draw(energy.energyFull, x, y)
        x =x + largeur
    end
    -- Affichage de l'energy vide
         for m = (energyR+1), math.floor(energy.nbrmanamax * 0.5) do
          love.graphics.draw(energy.energyNil, x, y)
          x = x + largeur
        end
      end
-----------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------
return energy
