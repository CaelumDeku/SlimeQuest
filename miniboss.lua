-----------------------------------------------------------------------------------------
---------------------------Gerstion des mini-Boss----------------------------------------
-----------------------------------------------------------------------------------------
local miniBoss = {}

miniBoss.TileHEIGHT = 32
miniBoss.TileWIDTH = 32
miniBoss.x = 0
miniBoss.y = 32 
miniBoss.speed = 50
miniBoss.oX = miniBoss.TileWIDTH*0.5
miniBoss.oY = miniBoss.TileHEIGHT*0.5
miniBoss.ShootOx = 72 * 0.5
miniBoss.ShootOy = 72 * 0.5
miniBoss.timer = 5
miniBoss.distChase = 400
miniBoss.rangeAtt = 200
miniBoss.keyPressed = false
miniBoss.DIRECTION = {"D","U","L","R","S"}
miniBoss.LstShoot = {}
miniBoss.shootDistance = 500
miniBoss.list = {}
miniBoss.lifeMax = 5

function miniBoss.load()
    myGame.CreateQuad("Racoon","Sprite/racoon",48,48)
    -- racoon 1
    myGame.CreateSprite("Racoon","RacoonU1",10,12)
    myGame.CreateSprite("Racoon","RacoonD1",1,3)
    myGame.CreateSprite("Racoon","RacoonR1",7,9)
    myGame.CreateSprite("Racoon","RacoonL1",4,6)
    --[[-- racoon 2
    myGame.CreateSprite("Racoon","RacoonU2",43,45)
    myGame.CreateSprite("Racoon","RacoonD2",7,9)
    myGame.CreateSprite("Racoon","RacoonR2",31,33)
    myGame.CreateSprite("Racoon","RacoonL2",19,21)
    myGame.CreateSprite("Racoon","RacoonKo2",44,44)
    -- racoon 3
    myGame.CreateSprite("Racoon","RacoonU3",52,54)
    myGame.CreateSprite("Racoon","RacoonD3",88,90)
    myGame.CreateSprite("Racoon","RacoonR3",76,78)
    myGame.CreateSprite("Racoon","RacoonL3",64,66)
    myGame.CreateSprite("Racoon","RacoonKo3",53,53)]]--
    --KO
    myGame.CreateQuad("RacoonKo","Sprite/ko",48,48)
    
    myGame.CreateSprite("RacoonKo","RacoonKo1",16,18)
    -- ATK
    myGame.CreateQuad("ATKracoon","Sprite/racoonATK",72,72)
    myGame.CreateSprite("ATKracoon","ATKracoon",1,4)
end
function miniBoss.new(pname,pi,pX,pY)
  local i
  local enn = {}
    enn = {
      index = #miniBoss.list + 1,
      type = pname,
      x = pX,
      y = pY,
      direction = pname .. miniBoss.DIRECTION[1] .. pi,
      pi = pi,
      inMove = false,
      oX = myGame.Map.TileWIDHT,
      oY = myGame.Map.TileHEIGHT,
      rX = 30 * myGame.Map.TileWIDHT,
      rY = 24 * myGame.Map.TileHEIGHT,
      timer = 0,
      state = myGame.StateIA.STATE,
      atk = false,
      life = miniBoss.lifeMax,
      damage = false,
      noDamage = false,
    }
    table.insert(miniBoss.list,enn)
end
function miniBoss.update(pMap,dt)
    -- mini racoon 1 
    myGame.CurrentSprite("Racoon",false,dt)
    myGame.CurrentSprite("ATKracoon",false,dt)
    myGame.CurrentSprite("RacoonKo",false,dt)
    for i , pEnn in ipairs(miniBoss.list) do
      miniBoss[pEnn.state](dt,pEnn) 
      -- Maj du timer
      pEnn.timer = pEnn.timer + dt
    end

    for i , shoot in ipairs(miniBoss.LstShoot) do
      shoot.x = shoot.x + myGame.shoot.speed * dt * math.cos(shoot.angle)
      shoot.y = shoot.y + myGame.shoot.speed * dt * math.sin(shoot.angle)

      if math.dist(shoot.startX,shoot.startY,shoot.x,shoot.y) >= miniBoss.shootDistance then
        table.remove(miniBoss.LstShoot,i)
      end

      if miniBoss.colhero(shoot) then
        table.remove(miniBoss.LstShoot,i)
      end
    end

    if #miniBoss.list == 0 then
      for i , tp in ipairs(myGame.TpDirection) do
        if tp.mapS == "donjonBoss" then
          tp.actif = true
        end
      end
    end
end
function miniBoss.draw()
  for index , pEnn in ipairs(miniBoss.list) do 
   myGame.DrawSprite(pEnn.direction,pEnn.x,pEnn.y,0,1,miniBoss.oX,miniBoss.oY)
  --  love.graphics.ellipse("line",pEnn.x,pEnn.y,miniBoss.oX,miniBoss.oY)
  end
  for index , shoot in ipairs(miniBoss.LstShoot) do
    myGame.DrawSprite("ATKracoon",shoot.x,shoot.y,shoot.angle,1.5,72*0.5,72*0.5)
    --love.graphics.ellipse("line",shoot.x,shoot.y,miniBoss.ShootOx* 0.25,miniBoss.ShootOy* 0.25)
  end
end
function miniBoss.state(dt,pEnn)

  pEnn.timer = pEnn.timer + dt

  -- Si on atteint le temps "timer" on arrete l'attente
  if pEnn.timer >= miniBoss.timer then
    pEnn.direction = pEnn.type .. miniBoss.DIRECTION[math.random(1,4)] .. pEnn.pi
    pEnn.state = myGame.StateIA.WALK
    pEnn.timer = 0
  end

  if math.dist(pEnn.x,pEnn.y,myGame.hero.x,myGame.hero.y) < miniBoss.distChase then
    pEnn.state = myGame.StateIA.CHASE
  end

end

function miniBoss.walk(dt,pEnn) 

  -- Mouvement des ennemie
  if pEnn.direction == pEnn.type .. miniBoss.DIRECTION[1]  .. pEnn.pi then
    pEnn.y = pEnn.y + miniBoss.speed * dt
  end
  if pEnn.direction == pEnn.type .. miniBoss.DIRECTION[2] .. pEnn.pi then
    pEnn.y = pEnn.y - miniBoss.speed * dt
  end
  if pEnn.direction == pEnn.type .. miniBoss.DIRECTION[3] .. pEnn.pi then
    pEnn.x = pEnn.x - miniBoss.speed * dt
  end
  if pEnn.direction == pEnn.type .. miniBoss.DIRECTION[4] .. pEnn.pi then
    pEnn.x = pEnn.x + miniBoss.speed * dt
  end
  -- Test si on a atteint le rectangle invisible
  if pEnn.x >= pEnn.oX + pEnn.rX or myGame.collision(pEnn.x + miniBoss.oX,pEnn.y,miniBoss.oX,miniBoss.oY,myGame.mapLoad)then
    pEnn.x = pEnn.x - miniBoss.speed * dt
    pEnn.state = myGame.StateIA.STATE
  end
  if pEnn.x <= pEnn.oX or myGame.collision(pEnn.x - miniBoss.oX,pEnn.y,miniBoss.oX,miniBoss.oY,myGame.mapLoad)then
    pEnn.x = pEnn.x + miniBoss.speed * dt
    pEnn.state = myGame.StateIA.STATE
  end
  if pEnn.y >= pEnn.oY + pEnn.rY or myGame.collision(pEnn.x,pEnn.y + miniBoss.oY,miniBoss.oX,miniBoss.oY,myGame.mapLoad) then
    pEnn.y = pEnn.y - miniBoss.speed * dt
    pEnn.state = myGame.StateIA.STATE
  end
  if pEnn.y <= pEnn.oY or myGame.collision(pEnn.x,pEnn.y - miniBoss.oY,miniBoss.oX,miniBoss.oY,myGame.mapLoad) then
    pEnn.y = pEnn.y + miniBoss.speed * dt
    pEnn.state = myGame.StateIA.STATE
  end
  -- Maj du timer
  pEnn.timer = pEnn.timer + dt

  -- Test si le timer a atteint le "timer" définie
  if pEnn.timer >= miniBoss.timer then
    pEnn.state = myGame.StateIA.STATE
    pEnn.timer = 0
  end

  if math.dist(pEnn.x,pEnn.y,myGame.hero.x,myGame.hero.y) < miniBoss.distChase then
    pEnn.state = myGame.StateIA.CHASE
  end

end

function miniBoss.chase(dt,pEnn) 
   -- Maj du timer
   pEnn.timer = pEnn.timer + dt

  local angle = math.angle(pEnn.x,pEnn.y,myGame.hero.x,myGame.hero.y)

  if math.cos(angle) > 0 then
    pEnn.direction = pEnn.type .. miniBoss.DIRECTION[1] .. pEnn.pi
  elseif math.cos(angle) < 0 then
    pEnn.direction = pEnn.type .. miniBoss.DIRECTION[3] .. pEnn.pi
  end

  --test range avec héro
  if math.dist(pEnn.x,pEnn.y,myGame.hero.x,myGame.hero.y) > miniBoss.rangeAtt then
    pEnn.x = pEnn.x + dt * miniBoss.speed * math.cos(angle)
    if pEnn.x < pEnn.oX or pEnn.x > (pEnn.oX + pEnn.rX) then
       pEnn.x = pEnn.x - dt * miniBoss.speed * math.cos(angle)
    end
    pEnn.y = pEnn.y  + dt * miniBoss.speed * math.sin(angle)
    if pEnn.y < pEnn.oY or pEnn.y > (pEnn.oY + pEnn.rY) then
       pEnn.y = pEnn.y - dt * miniBoss.speed * math.sin(angle)
    end
  else
      pEnn.state = myGame.StateIA.ATTACK
      pEnn.timer = 0
  end

end

function miniBoss.attack(dt,pEnn) 
    -- Maj du timer
    pEnn.timer = pEnn.timer + dt

    local angle = math.angle(pEnn.x,pEnn.y,myGame.hero.x,myGame.hero.y)
  
    if math.cos(angle) > 0 then
      pEnn.direction = pEnn.type .. miniBoss.DIRECTION[1] .. pEnn.pi
    elseif math.cos(angle) < 0 then
      pEnn.direction = pEnn.type .. miniBoss.DIRECTION[3] .. pEnn.pi
    end

    if pEnn.atk == false then
      myGame.mySon.playEffect("miniBossHit")
      for i = 1 , 3 do
        local angleShoot = angle
        if i == 1 then
          angleShoot = angle - math.rad(30)
        elseif i == 3 then
          angleShoot = angle + math.rad(30)
        end
        local shoot = {
          startX = pEnn.x,
          startY = pEnn.y,
          x = pEnn.x,
          y = pEnn.y,
          id = #miniBoss.LstShoot + 1,
          angle = angleShoot
        }
        table.insert(miniBoss.LstShoot,shoot)
        i = i + 1
      end
      pEnn.atk = true
    end

    if pEnn.timer > miniBoss.timer * 0.5 then
      pEnn.state = myGame.StateIA.WALK
      pEnn.timer = 0
      pEnn.atk = false
    end
end

function miniBoss.damage(dt,pEnn)
  -- Maj du timer
  pEnn.timer = pEnn.timer + dt
  if pEnn.damage == false then 
    pEnn.life = pEnn.life - 1
    pEnn.damage = true
  end
  
  if pEnn.life <= 0 then
    pEnn.state = myGame.StateIA.KO
    pEnn.timer = 0
    return false
  end
  local angle = math.angle(pEnn.x,pEnn.y,myGame.hero.x,myGame.hero.y)
  local angleShoot
  if pEnn.atk == false then
    for i = 1 , 12 do
      if i > 1 then
        angleShoot = angleShoot + math.rad(30)
      else
        angleShoot = angle
      end
      local shoot = {
        startX = pEnn.x,
        startY = pEnn.y,
        x = pEnn.x,
        y = pEnn.y,
        id = #miniBoss.LstShoot + 1,
        angle = angleShoot
      }
      table.insert(miniBoss.LstShoot,shoot)
      i = i + 1
    end
    pEnn.atk = true
  end 

  if pEnn.timer > miniBoss.timer * 0.5 then
    pEnn.state = myGame.StateIA.WALK
    pEnn.timer = 0
    pEnn.damage = false
    pEnn.atk = false
  end
end

function miniBoss.ko(dt,pEnn) 
  -- Maj du timer
  pEnn.timer = pEnn.timer + dt

  myGame.mySon.playSound("BossKill")
  pEnn.direction = pEnn.type .. "Ko" .. pEnn.pi

  if pEnn.timer > miniBoss.timer * 2 then
    table.remove(miniBoss.list,pEnn.index)
  end
end

function miniBoss.colhero(pShoot)
    local sdx = pShoot.x - miniBoss.ShootOx * 0.25
    local sfx = pShoot.x + miniBoss.ShootOy * 0.25
    local sdy = pShoot.y - miniBoss.ShootOx * 0.25
    local sfy = pShoot.y + miniBoss.ShootOy * 0.25
    local dx = myGame.hero.x - myGame.hero.Ox * 0.75
    local fx = myGame.hero.x + myGame.hero.Ox * 0.75
    local dy = myGame.hero.y - myGame.hero.Oy * 0.75
    local fy = myGame.hero.y + myGame.hero.Oy * 0.75
    if (sdx > dx or sfx > dx) and ( sdx < fx or sfx < fx)
    and (sdy > dy or sfy > dy) and (sdy < fy or sfy < fy) then
        myGame.hero.damageIN(2)
        return true
    end
  return false
end

return miniBoss