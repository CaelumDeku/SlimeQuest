local pnj = {}

pnj.TILE_WIDTH = 48
pnj.TILE_HEIGHT = 48
pnj.oX = pnj.TILE_WIDTH * 0.5
pnj.oY = pnj.TILE_HEIGHT * 0.5
pnj.DIRECTION = {"D","U","R","L"}

pnj.list = {}

function pnj.load ()
    myGame.CreateQuad("pnj","Sprite/pnjVillage",pnj.TILE_WIDTH,pnj.TILE_WIDTH)
-- Arnes Mage (compagnon de voyage de Loyd)
    myGame.CreateSprite("pnj","pnjU1",1,3)
    myGame.CreateSprite("pnj","pnjD1",13,15)
    myGame.CreateSprite("pnj","pnjR1",25,27)
    myGame.CreateSprite("pnj","pnjL1",37,39)

-- Guerrière (apprendra les compétences futur à l'épée)
    myGame.CreateSprite("pnj","pnjU2",4,6)
    myGame.CreateSprite("pnj","pnjD2",16,18)
    myGame.CreateSprite("pnj","pnjR2",28,30)
    myGame.CreateSprite("pnj","pnjL2",40,42)

  -- Aubergiste(Gère le dodo restauration dispo dans le futur)
    myGame.CreateSprite("pnj","pnjU3",7,9)
    myGame.CreateSprite("pnj","pnjD3",19,21)
    myGame.CreateSprite("pnj","pnjR3",31,33)
    myGame.CreateSprite("pnj","pnjL3",43,45)

-- je sais pas encore()
    myGame.CreateSprite("pnj","pnjU4",10,12)
    myGame.CreateSprite("pnj","pnjD4",22,24)
    myGame.CreateSprite("pnj","pnjR4",34,36)
    myGame.CreateSprite("pnj","pnjL4",46,48)

-- Petit garçon(donnera une futur quest secondaire)
    myGame.CreateSprite("pnj","pnjU5",49,51)
    myGame.CreateSprite("pnj","pnjD5",61,63)
    myGame.CreateSprite("pnj","pnjR5",73,75)
    myGame.CreateSprite("pnj","pnjL5",85,87)

-- Papy Loyd(:))
    myGame.CreateSprite("pnj","pnjU6",52,54)
    myGame.CreateSprite("pnj","pnjD6",64,66)
    myGame.CreateSprite("pnj","pnjR6",76,78)
    myGame.CreateSprite("pnj","pnjL6",88,90)

-- Erudit(renseignement sur les malédictions)
    myGame.CreateSprite("pnj","pnjU7",55,57)
    myGame.CreateSprite("pnj","pnjD7",67,69)
    myGame.CreateSprite("pnj","pnjR7",79,81)
    myGame.CreateSprite("pnj","pnjL7",91,93)

 -- Alchimiste(possède des potions de soins)
    myGame.CreateSprite("pnj","pnjU8",58,60)
    myGame.CreateSprite("pnj","pnjD8",70,72)
    myGame.CreateSprite("pnj","pnjR8",82,84)
    myGame.CreateSprite("pnj","pnjL8",94,96)
end
function pnj.update(pMap,dt)
  myGame.CurrentSprite("pnj",false,dt * 0.5)
  for i , pPnj in ipairs(pnj.list) do
      pnj[pPnj.state](dt,pPnj)
  end
end
function pnj.draw()
  for index , pPnj in ipairs(pnj.list) do 
    myGame.DrawSprite(pPnj.direction,pPnj.x,pPnj.y,0,1,pnj.oX,pnj.oY)
  end
end

function pnj.newPnj(pId,pX,pY,rX,rY,pDirection)
  local newpnj = {
    id = pId,
    x = pX,
    y = pY,
    rx = rX,
    ry = rY,
    state = myGame.StateIA.STATE,
    direction = "pnj" .. pnj.DIRECTION[pDirection] .. pId,
    timer = 0,
  }
  table.insert(pnj.list,newpnj)
end

function pnj.state(dt,pPnj)
  if pPnj.inMove == false then
    pPnj.direction = "pnj" .. pnj.DIRECTION[pDirection] .. pId
    pPnj.inMove = true
    pPnj.timer = 0
    pPnj.inState = false
  end
end

function pnj.walk(dt,pPnj)
  
  -- Mouvement des pnj
  if pPnj.direction == "pnj" .. pnj.DIRECTION[1] .. pId then
    pPnj.y = pPnj.y + pnj.speed * dt
    if pPnj.y >= pPnj.oY + pPnj.rY or myGame.collision(pPnj.x,pPnj.y + pnj.oY,pnj.oX,pnj.oY,myGame.mapLoad) then
      pPnj.y = pPnj.y - pnj.speed * dt
      pPnj.inMove = false
    end
  end
  if pPnj.direction == "pnj" .. pnj.DIRECTION[2] .. pId then
    pPnj.y = pPnj.y - pnj.speed * dt
    if pPnj.y <= pPnj.oY or myGame.collision(pPnj.x,pPnj.y - pnj.oY,pnj.oX,pnj.oY,myGame.mapLoad) then
      pPnj.y = pPnj.y + pnj.speed * dt
      pPnj.inMove = false
    end
  end
  if pPnj.direction == "pnj" .. pnj.DIRECTION[3] .. pId then
    pPnj.x = pPnj.x - pnj.speed * dt
    if pPnj.x <= pPnj.oX or myGame.collision(pPnj.x - pnj.oX,pPnj.y,pnj.oX,pnj.oY,myGame.mapLoad) then
      pPnj.x = pPnj.x + pnj.speed * dt
      pPnj.inMove = false
    end
  end
  if pPnj.direction == "pnj" .. pnj.DIRECTION[4] .. pId then
    pPnj.x = pPnj.x + pnj.speed * dt
    if pPnj.x >= pPnj.oX + pPnj.rX or myGame.collision(pPnj.x + pnj.oX,pPnj.y,pnj.oX,pnj.oY,myGame.mapLoad) then
      pPnj.x = pPnj.x - pnj.speed * dt
      pPnj.inMove = false
    end
  end
  
  -- Maj du timer
  pPnj.timer = pPnj.timer + dt
end


function pnj.talk(dt,pPnj)
end

return pnj