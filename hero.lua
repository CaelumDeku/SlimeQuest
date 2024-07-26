-----------------------------------------------------------------------------------------
---------------------------------------Gestion Héro--------------------------------------
-----------------------------------------------------------------------------------------
local hero = {}
 hero.tileW = 32
 hero.tileH = 32
 hero.Ox =  hero.tileW * 0.5
 hero.Oy =  hero.tileH * 0.5
 hero.tilesetW = 32
 hero.tilesetH = 32
------------------------------------------------------------------------------------------
hero.pixie = {}
hero.pixie.x = 0
hero.pixie.y = 0
hero.pixie.actif = false
hero.pixie.Ox = 48 * 0.5
hero.pixie.Oy = 48 * 0.5
hero.pixie.direction = "pixieD"
------------------------------------------------------------------------------------------
  hero.CurrentPic = 1
  
  hero.moveSpeed = 200
  hero.x = largeur * 0.5
  hero.y = hauteur * 0.5

  hero.keyPressed = false
  --
  hero.direction = "HeroD"
  
-----------------------------------------------------------------------------------------
function hero.load()
  myGame.CreateQuad("Hero","Sprite/hero",32,32)

  myGame.CreateSprite("Hero","HeroD",1,2)
  myGame.CreateSprite("Hero","HeroL",3,4)
  myGame.CreateSprite("Hero","HeroR",5,6)
  myGame.CreateSprite("Hero","HeroT",7,8)
  myGame.CreateSprite("Hero","HeroUp",9,9)
  myGame.CreateSprite("Hero","HeroKo",10,10)

  myGame.CreateQuad("pixie","Sprite/pixie",48,48)

  myGame.CreateSprite("pixie","pixieD",1,3)
  myGame.CreateSprite("pixie","pixieL",4,6)
  myGame.CreateSprite("pixie","pixieR",7,9)
  myGame.CreateSprite("pixie","pixieT",10,12)

  myGame.shoot.load()

end
-----------------------------------------------------------------------------------------
function hero.update(pMap,dt)

  myGame.CurrentSprite("Hero",false,dt)
  myGame.CurrentSprite("pixie",false,dt)

  if myGame.dialogueManager.inDialogue == false then
    if love.keyboard.isDown("z") then
      myGame.mySon.playSound("slime")
      hero.y = hero.y - hero.moveSpeed * dt
      hero.direction = "HeroT"
      if myGame.collision(hero.x,hero.y,hero.Ox,hero.Oy,myGame.mapLoad) or hero.y <= myGame.Map.TileHEIGHT
      or myGame.collisionPnj(hero.x,hero.y,hero.Ox,hero.Oy) then
        hero.y = hero.y + hero.moveSpeed * dt
      end
    end 
    if love.keyboard.isDown("d")then
      myGame.mySon.playSound("slime")
      hero.x = hero.x + hero.moveSpeed * dt
      hero.direction = "HeroR"
      if myGame.collision(hero.x,hero.y,hero.Ox,hero.Oy,myGame.mapLoad) or hero.x >= (largeur - myGame.Map.TileWIDHT)
      or myGame.collisionPnj(hero.x,hero.y,hero.Ox,hero.Oy) then
        hero.x = hero.x - hero.moveSpeed * dt
      end
    end 
    if love.keyboard.isDown("s")then
      myGame.mySon.playSound("slime")
      hero.y = hero.y + hero.moveSpeed * dt
      hero.direction = "HeroD"
      if myGame.collision(hero.x,hero.y,hero.Ox,hero.Oy,myGame.mapLoad) or hero.y >= (hauteur-myGame.Map.TileHEIGHT)
        or myGame.collisionPnj(hero.x,hero.y,hero.Ox,hero.Oy) then
        hero.y = hero.y - hero.moveSpeed * dt
      end
    end 
    if love.keyboard.isDown("q") then
      myGame.mySon.playSound("slime")
      hero.x = hero.x - hero.moveSpeed * dt
      hero.direction = "HeroL"
      if myGame.collision(hero.x,hero.y,hero.Ox,hero.Oy,myGame.mapLoad) or hero.x <= 0 
      or myGame.collisionPnj(hero.x,hero.y,hero.Ox,hero.Oy) then
        hero.x = hero.x + hero.moveSpeed * dt
      end
    end
    if hero.pixie.actif then 
      myGame.shoot.update(dt,hero)
    end

    local idMap = myGame.tpmapColision(hero.x,hero.y)
    if idMap ~= "" then
      myGame.myScreen.changeMap(idMap,myGame.mapLoadText)
    end

    myGame.evenement.colEve(hero.x - hero.Ox * 0.5,hero.y - hero.Oy * 0.5,hero.x + hero.Ox * 0.5,hero.y + hero.Oy * 0.5,dt)
  end

   --Folow de ptite <3 pixie <3
   hero.pixiefolow(dt)
   ----------------------------

end
-----------------------------------------------------------------------------------------    
function hero.draw()
    myGame.DrawSprite(hero.direction,hero.x,hero.y,0,1,hero.Ox,hero.Oy)
    if hero.pixie.actif then
      myGame.DrawSprite(hero.pixie.direction,hero.pixie.x,hero.pixie.y,0,0.5,hero.pixie.Ox,hero.pixie.Oy)
    end
    myGame.shoot.draw()
end
-----------------------------------------------------------------------------------------
function hero.damageIN(pPdv)
  if myGame.shoot.shield.actif then
    myGame.shoot.shield.damage = true
    myGame.shoot.shield.empy = true
    myGame.energy.nbrmana = 0
    return true
  else
   myGame.life.nbrpv = myGame.life.nbrpv - pPdv 
    --myGame.mySon.playEffect("Heart")
  end
  return false
end
-----------------------------------------------------------------------------------------
function hero.pixiefolow(dt)
  if hero.pixie.actif then
    local newX = hero.x - hero.pixie.Ox
    local newY = hero.y - hero.pixie.Oy
    if math.dist(hero.pixie.x,hero.pixie.y,newX,newY) > 20 then
      local angle = math.angle(hero.pixie.x,hero.pixie.y,newX,newY)
      hero.pixie.x = hero.pixie.x + math.cos(angle) * dt * (hero.moveSpeed - 10)
      hero.pixie.y = hero.pixie.y + math.sin(angle) * dt * (hero.moveSpeed - 10)
      hero.pixie.direction = hero.direction:gsub("Hero","pixie")
    end
  end
end

function hero.pixieresetXY()
  local newX = hero.x - hero.pixie.Ox
  local newY = hero.y - hero.pixie.Oy
  hero.pixie.x = newX
  hero.pixie.y = newY
end
return hero