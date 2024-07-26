-----------------------------------------------------------------------------------------
----------------------------Gestion Ennemie----------------------------------------------
-----------------------------------------------------------------------------------------
local enemy = {}

enemy.speed = 100
enemy.TILE_WIDTH = {
  Bats = 32,
  Ork = 48,
  Atk = 72
}
enemy.TILE_HEIGHT = {
  Bats = 32,
  Ork = 48,
  Atk = 72
}
enemy.oX = {
  Bats = enemy.TILE_WIDTH.Bats * 0.5,
  Ork = enemy.TILE_WIDTH.Ork * 0.5,
  Atk = enemy.TILE_WIDTH.Atk * 0.5,
}
enemy.oY = {
  Bats = enemy.TILE_WIDTH.Bats * 0.5,
  Ork = enemy.TILE_WIDTH.Ork * 0.5,
  Atk = enemy.TILE_WIDTH.Atk * 0.5,
}
enemy.keyPressed = false
enemy.DIRECTION = {"D","U","L","R","S"}
enemy.TYPE = {"Bats"}
enemy.FLY = {"Bats"}
enemy.distChase = 400
enemy.rangeAtt = 0

enemy.timer = 5
enemy.list = {}

function enemy.load()

    enemy.rangeAtt = myGame.hero.Ox

    myGame.CreateQuad("Bats","Sprite/bats",enemy.TILE_WIDTH.Bats,enemy.TILE_WIDTH.Bats)

    myGame.CreateSprite("Bats","BatsU",9,12)
    myGame.CreateSprite("Bats","BatsD",1,4)
    myGame.CreateSprite("Bats","BatsR",5,8)
    myGame.CreateSprite("Bats","BatsL",13,16)
    myGame.CreateSprite("Bats","BatsKo",1,1) 
    
   -- ATK
   
    myGame.CreateQuad("ATKenemy","Sprite/enemyATK",enemy.TILE_WIDTH.Atk,enemy.TILE_WIDTH.Atk)
    myGame.CreateSprite("ATKenemy","ATKenemy",1,8)

   --[[ myGame.CreateQuad("Ork","Sprite/orc",enemy.TILE_WIDTH.Ork,enemy.TILE_WIDTH.Ork)

    myGame.CreateSprite("Ork","OrkU",37,39)
    myGame.CreateSprite("Ork","OrkD",1,3)
    myGame.CreateSprite("Ork","OrkR",25,27)
    myGame.CreateSprite("Ork","OrkL",13,15)
    myGame.CreateSprite("Ork","Ork",38,38)
    myGame.CreateSprite("Ork","OrkS",1,1) ]]--

end


function enemy.new(pNb,pX,pY,pRx,pRy,pType)
  local i
  local enn = {}
  local type = ""
  local fly
  
  for i = 1 , pNb do
    type = enemy.TYPE[pType]
    for i , pFly in ipairs(enemy.FLY) do
      if type == pFly then
        fly = true
        break
      end
    end 
    enn = {
      type = type,
      x = love.math.random(pX,pX + pRx),
      y = love.math.random(pY,pY + pRy),
      direction = type .. enemy.DIRECTION[1],
      oX = pX,
      oY = pY,
      rX = pRx,
      rY = pRy,
      timer = 0,
      fly = fly,
      state = myGame.StateIA.STATE,
      atk = false,
      noDamage = false
    }
    table.insert(enemy.list,enn)
    i = i + 1
  end
end

function enemy.update(pMap,dt)

  -- Changement de current img
  for index , pEnn in ipairs(enemy.TYPE) do
    myGame.CurrentSprite(pEnn,false,dt)
  end
  myGame.CurrentSprite("ATKenemy",false,dt)
  -- Modification de la liste des ennemies
  for index , pEnn in ipairs(enemy.list) do 
    enemy[pEnn.state](dt,pEnn,index)
  end
   
end

function enemy.draw()
    for index , pEnn in ipairs(enemy.list) do 
      myGame.DrawSprite(pEnn.direction,pEnn.x,pEnn.y,0,1,enemy.oX[pEnn.type],enemy.oY[pEnn.type])
      -- love.graphics.ellipse("line",pEnn.x,pEnn.y,enemy.oX[pEnn.type],enemy.oY[pEnn.type])
      if pEnn.state == myGame.StateIA.ATTACK and pEnn.noDamage then
        myGame.DrawSprite("ATKenemy",myGame.hero.x,myGame.hero.y,0,1,enemy.oX.Atk,enemy.oX.Atk)
      end
    end
end

------------------------------------------------------------------------------------------------------------
--------------------------------------- -Machine a état  --   ----------------------------------------------
------------------------------------------------------------------------------------------------------------
function enemy.state(dt,pEnn,pId)

  pEnn.timer = pEnn.timer + dt
  -- On test si l'ennemie est volant
  
  -- Si l'ennemie ne vole pas on met la direction d'attente
  if pEnn.fly == false then
    pEnn.direction = pEnn.type .. enemy.DIRECTION[5]
  end
  -- Si on atteint le temps "timer" on arrete l'attente
  if pEnn.timer >= enemy.timer then
    pEnn.direction = pEnn.type .. enemy.DIRECTION[math.random(1,4)]
    pEnn.state = myGame.StateIA.WALK
    pEnn.timer = 0
  end

  if math.dist(pEnn.x,pEnn.y,myGame.hero.x,myGame.hero.y) < enemy.distChase then
    pEnn.state = myGame.StateIA.CHASE
  end

end

function enemy.walk(dt,pEnn,pId) 

  -- Mouvement des ennemie
  if pEnn.direction == pEnn.type .. enemy.DIRECTION[1] then
    pEnn.y = pEnn.y + enemy.speed * dt
  end
  if pEnn.direction == pEnn.type .. enemy.DIRECTION[2] then
    pEnn.y = pEnn.y - enemy.speed * dt
  end
  if pEnn.direction == pEnn.type .. enemy.DIRECTION[3] then
    pEnn.x = pEnn.x - enemy.speed * dt
  end
  if pEnn.direction == pEnn.type .. enemy.DIRECTION[4] then
    pEnn.x = pEnn.x + enemy.speed * dt
  end
  -- Test si on a atteint le rectangle invisible
  if pEnn.x >= pEnn.oX + pEnn.rX 
  or myGame.collision(pEnn.x + enemy.oX[pEnn.type],pEnn.y,enemy.oX[pEnn.type],enemy.oY[pEnn.type],myGame.mapLoad)
  or enemy.col(pEnn.x,pEnn.y,enemy.oX[pEnn.type],enemy.oY[pEnn.type],pId) 
  then
    pEnn.x = pEnn.x - enemy.speed * dt
    pEnn.state = myGame.StateIA.STATE
  end
  if pEnn.x <= pEnn.oX 
  or myGame.collision(pEnn.x - enemy.oX[pEnn.type],pEnn.y,enemy.oX[pEnn.type],enemy.oY[pEnn.type],myGame.mapLoad)
  or enemy.col(pEnn.x,pEnn.y,enemy.oX[pEnn.type],enemy.oY[pEnn.type],pId) 
  then
    pEnn.x = pEnn.x + enemy.speed * dt
    pEnn.state = myGame.StateIA.STATE
  end
  if pEnn.y >= pEnn.oY + pEnn.rY 
  or myGame.collision(pEnn.x,pEnn.y + enemy.oY[pEnn.type],enemy.oX[pEnn.type],enemy.oY[pEnn.type],myGame.mapLoad) 
  or enemy.col(pEnn.x,pEnn.y,enemy.oX[pEnn.type],enemy.oY[pEnn.type],pId) 
  then
    pEnn.y = pEnn.y - enemy.speed * dt
    pEnn.state = myGame.StateIA.STATE
  end
  if pEnn.y <= pEnn.oY 
  or myGame.collision(pEnn.x,pEnn.y - enemy.oY[pEnn.type],enemy.oX[pEnn.type],enemy.oY[pEnn.type],myGame.mapLoad) 
  or enemy.col(pEnn.x,pEnn.y,enemy.oX[pEnn.type],enemy.oY[pEnn.type],pId) 
  then
    pEnn.y = pEnn.y + enemy.speed * dt
    pEnn.state = myGame.StateIA.STATE
  end
  -- Maj du timer
  pEnn.timer = pEnn.timer + dt

  -- Test si le timer a atteint le "timer" définie
  if pEnn.timer >= enemy.timer then
    pEnn.state = myGame.StateIA.STATE
    pEnn.timer = 0
  end

  if math.dist(pEnn.x,pEnn.y,myGame.hero.x,myGame.hero.y) < enemy.distChase then
    pEnn.state = myGame.StateIA.CHASE
  end

end

function enemy.chase(dt,pEnn,pId) 
   -- Maj du timer
   pEnn.timer = pEnn.timer + dt

  local angle = math.angle(pEnn.x,pEnn.y,myGame.hero.x,myGame.hero.y)

  if math.cos(angle) > 0 then
    pEnn.direction = pEnn.type .. enemy.DIRECTION[1]
  elseif math.cos(angle) < 0 then
    pEnn.direction = pEnn.type .. enemy.DIRECTION[3]
  end

  --test range avec héro
  if math.dist(pEnn.x,pEnn.y,myGame.hero.x,myGame.hero.y) > enemy.rangeAtt then
    pEnn.x = pEnn.x + math.cos(angle) * dt * enemy.speed
    if enemy.col(pEnn.x,pEnn.y,enemy.oX[pEnn.type] ,enemy.oY[pEnn.type],pId) then
      pEnn.x = pEnn.x - math.cos(angle) * dt * enemy.speed
    end
    pEnn.y = pEnn.y + math.sin(angle) * dt * enemy.speed
    if enemy.col(pEnn.x,pEnn.y,enemy.oX[pEnn.type] ,enemy.oY[pEnn.type],pId) then
      pEnn.y = pEnn.y - math.sin(angle) * dt * enemy.speed
    end
    
  else
      pEnn.state = myGame.StateIA.ATTACK
      pEnn.timer = 0
  end

end

function enemy.attack(dt,pEnn,pId) 
    -- Maj du timer
    pEnn.timer = pEnn.timer + dt

    local angle = math.angle(pEnn.x,pEnn.y,myGame.hero.x,myGame.hero.y)
  
    if math.cos(angle) > 0 then
      pEnn.direction = pEnn.type .. enemy.DIRECTION[1]
    elseif math.cos(angle) < 0 then
      pEnn.direction = pEnn.type .. enemy.DIRECTION[3]
    end

    if pEnn.atk == false then
      if myGame.hero.damageIN(1) == false then
        myGame.mySon.playEffect("enemyHit")
        pEnn.noDamage = true
      else
        pEnn.noDamage = false
      end
      pEnn.atk = true
    end

    if pEnn.timer > enemy.timer then
      pEnn.state = myGame.StateIA.WALK
      pEnn.timer = 0
      pEnn.atk = false
    end
end

function enemy.damage(id)
  table.remove(enemy.list,id)
end

function enemy.ko(dt,pEnn,pId) 
end

function enemy.col(pX,pY,pRx,pRy,pId)
  local dx = pX - pRx / 3
  local dy = pY - pRy / 3
  local fx = pX + pRx / 3
  local fy = pX - pRx / 3
  for i, pEnn in ipairs(enemy.list) do
    if pId ~= i then
      local edx = pEnn.x - enemy.oX[pEnn.type] / 4
      local edy = pEnn.y - enemy.oY[pEnn.type] / 4
      local efx = pEnn.x + enemy.oX[pEnn.type] / 4
      local efy = pEnn.y + enemy.oY[pEnn.type] / 4
      if (dx > edx or fx > edx) and ( edx < efx or fx < efx)
      and (dy > edy or fy > edy) and (dy < efy or fy < efy) then
        print('aie Enemy' .. dx)
          return true
      end
    end
  end
  return false
end


return enemy