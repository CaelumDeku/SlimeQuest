local boss = {}
boss.TileHEIGHT = 48
boss.TileWIDTH = 48
boss.x = 0
boss.y = 32 
boss.speed = 70
boss.oX = boss.TileWIDTH*0.5
boss.oY = boss.TileHEIGHT*0.5
boss.ShootOx = 72 * 0.5
boss.ShootOy = 72 * 0.5
boss.timer = 5
boss.distChase = 500
boss.rangeAtt = 0
boss.rangeAttDist = 400
boss.rangeAttCacDist = 150
boss.keyPressed = false
boss.DIRECTION = {"D","U","L","R","S"}
boss.LstShoot = {}
boss.life = 10
boss.enterHero = false
boss.shootDistance = 600
-- transition ko
boss.timerTransition = 0
boss.timerTransitionEnd = 10

boss.list = {}

function boss.load ()
    boss.rangeAtt = myGame.hero.Ox

    myGame.CreateQuad("Witch","Sprite/Witch",48,48)
 
    myGame.CreateSprite("Witch","WitchU",10,13)
    myGame.CreateSprite("Witch","WitchD",1,3)
    myGame.CreateSprite("Witch","WitchR",7,9)
    myGame.CreateSprite("Witch","WitchL",4,6)
    myGame.CreateSprite("Witch","WitchS",1,1)
    --myGame.CreateSprite("Witch","WitchKo",1,1)
    
   --KO
    myGame.CreateQuad("WitchKo","Sprite/ko",48,48)
    
    myGame.CreateSprite("WitchKo","WitchKo",7,9)
   -- ATK
    myGame.CreateQuad("ATKwitch","Sprite/WitchATK",72,72)
    myGame.CreateSprite("ATKwitch","ATKwitch",3,8)
    myGame.CreateSprite("ATKwitch","loadATKwitch",1,2)

   end 
function boss.new(pname,pi,pX,pY)
  local i
  local enn = {}
    enn = {
      type = pname,
      x = pX,
      y = pY,
      direction = pname .. boss.DIRECTION[1],
      inMove = false,
      -- origine deplacement 
      oX = 0,
      oY = myGame.Map.TileHEIGHT,
      -- range deplacement 
      rX = largeur,
      rY = hauteur - myGame.Map.TileHEIGHT,
      timer = 0,
      state = myGame.StateIA.STATE,
      atkCac = false,
      atkDist = false,
      -- dommage entrant
      damage = false,
      -- vunerabilité
      noDamage = false,
      life = boss.life
    }
    table.insert(boss.list,enn)
end
function boss.update(pMap,dt)
    myGame.CurrentSprite("Witch",false,dt)
    myGame.CurrentSprite("ATKwitch",false,dt)
    -- ralentissement de l'animation
    myGame.CurrentSprite("WitchKo",false,dt / 3)
    -- parcours liste en fonction de son etat
    for i , pEnn in ipairs(boss.list) do
     boss[pEnn.state](dt,pEnn)
    end
     -- mouvement de pew pew 
    for i , shoot in ipairs(boss.LstShoot) do
      if shoot.load == false then
        shoot.x = shoot.x + myGame.shoot.speed * dt * math.cos(shoot.angle)
        shoot.y = shoot.y + myGame.shoot.speed * dt * math.sin(shoot.angle)

        if math.dist(shoot.startX,shoot.startY,shoot.x,shoot.y) >= boss.shootDistance then
          table.remove(boss.LstShoot,i)
        end
      else
        -- chargement de pew pew
        shoot.timer = shoot.timer + dt
        if shoot.timer > 1 then
          shoot.load = false
        end
      end
      -- pewpew touch loyd
      if boss.colhero(shoot) then
        table.remove(boss.LstShoot,i)
      end
    end

  end
  
  
function boss.draw()
  for index , pEnn in ipairs(boss.list) do
    myGame.DrawSprite(pEnn.direction,pEnn.x,pEnn.y,0,1,boss.oX,boss.oY)
    -- love.graphics.ellipse("line",pEnn.x,pEnn.y,boss.oX,boss.oY)
  end
  for index , shoot in ipairs(boss.LstShoot) do
    if shoot.load then
      myGame.DrawSprite("loadATKwitch",shoot.x,shoot.y,shoot.angle,1,72*0.5,72*0.5)
    --love.graphics.ellipse("line",shoot.x,shoot.y,72*0.5,72*0.5)
    else 
      myGame.DrawSprite("ATKwitch",shoot.x,shoot.y,shoot.angle,1,72*0.5,72*0.5)
    --love.graphics.ellipse("line",shoot.x,shoot.y,72*0.5,72*0.5)
    end
    
  end

end
function boss.state(dt,pEnn)

  pEnn.timer = pEnn.timer + dt
  
  -- Si on atteint le temps "timer" on arrete l'attente
  if pEnn.timer >= boss.timer then
    pEnn.direction = pEnn.type .. boss.DIRECTION[math.random(1,4)]
    pEnn.state = myGame.StateIA.WALK
    pEnn.timer = 0
  end

  if math.dist(pEnn.x,pEnn.y,myGame.hero.x,myGame.hero.y) < boss.distChase and boss.enterHero == true then
    pEnn.state = myGame.StateIA.CHASE
    pEnn.timer = 0
  end

end

function boss.walk(dt,pEnn) 

  -- Mouvement des ennemie
  if pEnn.direction == pEnn.type .. boss.DIRECTION[1]  then
    pEnn.y = pEnn.y + boss.speed * dt
  end
  if pEnn.direction == pEnn.type .. boss.DIRECTION[2] then
    pEnn.y = pEnn.y - boss.speed * dt
  end
  if pEnn.direction == pEnn.type .. boss.DIRECTION[3] then
    pEnn.x = pEnn.x - boss.speed * dt
  end
  if pEnn.direction == pEnn.type .. boss.DIRECTION[4] then
    pEnn.x = pEnn.x + boss.speed * dt
  end
  -- Test si on a atteint le rectangle invisible
  if pEnn.x >= pEnn.oX + pEnn.rX or myGame.collision(pEnn.x + boss.oX,pEnn.y,boss.oX,boss.oY,myGame.mapLoad)then
    pEnn.x = pEnn.x - boss.speed * dt
    pEnn.state = myGame.StateIA.STATE
  end
  if pEnn.x <= pEnn.oX or myGame.collision(pEnn.x - boss.oX,pEnn.y,boss.oX,boss.oY,myGame.mapLoad)then
    pEnn.x = pEnn.x + boss.speed * dt
    pEnn.state = myGame.StateIA.STATE
  end
  if pEnn.y >= pEnn.oY + pEnn.rY or myGame.collision(pEnn.x,pEnn.y + boss.oY,boss.oX,boss.oY,myGame.mapLoad) then
    pEnn.y = pEnn.y - boss.speed * dt
    pEnn.state = myGame.StateIA.STATE
  end
  if pEnn.y <= pEnn.oY or myGame.collision(pEnn.x,pEnn.y - boss.oY,boss.oX,boss.oY,myGame.mapLoad) then
    pEnn.y = pEnn.y + boss.speed * dt
    pEnn.state = myGame.StateIA.STATE
  end
  -- Maj du timer
  pEnn.timer = pEnn.timer + dt

  -- Test si le timer a atteint le "timer" définie
  if pEnn.timer >= boss.timer then
    pEnn.state = myGame.StateIA.STATE
    pEnn.timer = 0
  end

  if math.dist(pEnn.x,pEnn.y,myGame.hero.x,myGame.hero.y) < boss.distChase and boss.enterHero == true then
    pEnn.state = myGame.StateIA.CHASE
  end

end

function boss.chase(dt,pEnn) 
   -- Maj du timer
   pEnn.timer = pEnn.timer + dt

  local angle = math.angle(pEnn.x,pEnn.y,myGame.hero.x,myGame.hero.y)
   -- direction du sprite 
  if math.cos(angle) > 0 then
    pEnn.direction = pEnn.type .. boss.DIRECTION[1]
  elseif math.cos(angle) < 0 then
    pEnn.direction = pEnn.type .. boss.DIRECTION[3]
  end

  --test range avec héro
  if math.dist(pEnn.x,pEnn.y,myGame.hero.x,myGame.hero.y) > boss.rangeAttDist then
    pEnn.x = pEnn.x + dt * boss.speed * math.cos(angle)
    pEnn.y = pEnn.y + dt * boss.speed * math.sin(angle)
  else
      pEnn.state = myGame.StateIA.ATTACK
      pEnn.timer = 0
  end

end

function boss.attack(dt,pEnn) 
    -- Maj du timer
    pEnn.timer = pEnn.timer + dt

    local angle = math.angle(pEnn.x,pEnn.y,myGame.hero.x,myGame.hero.y)

    if math.dist(pEnn.x,pEnn.y,myGame.hero.x,myGame.hero.y) < boss.rangeAttDist and
    math.dist(pEnn.x,pEnn.y,myGame.hero.x,myGame.hero.y) > boss.rangeAttCacDist then
      if math.cos(angle) > 0 then
        pEnn.direction = pEnn.type .. boss.DIRECTION[1]
      elseif math.cos(angle) < 0 then
        pEnn.direction = pEnn.type .. boss.DIRECTION[3]
      end

      if pEnn.atkDist == false then
        myGame.mySon.playEffect("miniBossHit")
        for i = 1 , 5 do
          local angleShoot = angle
          if i < 3 then
            angleShoot = angle - math.rad(15) * i
          else
            angleShoot = angle + math.rad(15) * (i - 3)
          end
          local shoot = {
            startX = pEnn.x + math.cos(angleShoot) * boss.oX * 2,
            startY = pEnn.y + math.sin(angleShoot) * boss.oY * 2 ,
            x = pEnn.x + math.cos(angleShoot) * boss.oX * 2,
            y = pEnn.y + math.sin(angleShoot) * boss.oY * 2,
            id = #boss.LstShoot + 1,
            angle = angleShoot,
            load = true,
            timer = 0
          }
          table.insert(boss.LstShoot,shoot)
          i = i + 1
        end
        pEnn.atkDist = true
      end
    else
      if pEnn.atkCac == false then
        pEnn.x = pEnn.x + dt * boss.speed * 2 * math.cos(angle)
        pEnn.y = pEnn.y + dt * boss.speed * 2 * math.sin(angle)
       -- degat cac -5pv
        if math.dist(pEnn.x,pEnn.y,myGame.hero.x,myGame.hero.y) < boss.rangeAtt then
          if myGame.hero.damageIN(5) == false then
            myGame.mySon.playSound("enemyHit")
            pEnn.noDamage = true
          else
            pEnn.noDamage = false
          end
          pEnn.atkCac = true
        end
      end
    end
   -- quand il atk il pause 
    if pEnn.timer > boss.timer / 3 then
      pEnn.state = myGame.StateIA.WALK
      pEnn.timer = 0
      pEnn.atkDist = false
      pEnn.atkCac = false
    end
end

function boss.damage(dt,pEnn)
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

    if pEnn.life == 6 or pEnn.life == 3 then
      pEnn.state = "TransisionPhase"
      pEnn.timer = 0
      return false
    end
    -- pause apres degat
    if pEnn.timer > boss.timer * 0.5 then
      pEnn.state = myGame.StateIA.WALK
      pEnn.timer = 0
      pEnn.damage = false
      pEnn.atkCac = false
      pEnn.atkDist = false
    end
end
-- vrille du boss
function boss.TransisionPhase(dt,pEnn)
  -- position du pentacle
  pEnn.x = 13.5 * myGame.Map.MapWIDTH
  pEnn.y = 12.5 * myGame.Map.MapHEIGHT
  -- invunerable
  pEnn.noDamage = true
  pEnn.timer = pEnn.timer + dt
  boss.timerTransition = boss.timerTransition + dt
  -- envoie pewpew toute les 0.05dt
  if pEnn.timer > 0.05 then
    myGame.mySon.playEffect("BossHit")
    -- angle aleatoire autour de lui 
  local angle = math.rad(love.math.random(0,360))
    local shoot = {
      startX = pEnn.x + math.cos(angle) * boss.oX * 2,
      startY = pEnn.y + math.sin(angle) * boss.oY * 2 ,
      x = pEnn.x + math.cos(angle) * boss.oX * 2,
      y = pEnn.y + math.sin(angle) * boss.oY * 2,
      id = #boss.LstShoot + 1,
      angle = angle,
      load = true,
      timer = 0
    }
    table.insert(boss.LstShoot,shoot)
    pEnn.timer = 0
  end
  -- retour au mode calme
  if boss.timerTransition > boss.timerTransitionEnd then
    pEnn.state = myGame.StateIA.WALK
    pEnn.timer = 0
    pEnn.damage = false
    pEnn.noDamage = false
    pEnn.atkCac = false
    pEnn.atkDist = false
    boss.timerTransition = 0
  end

end

function boss.ko(dt,pEnn) 
  -- Maj du timer
  pEnn.timer = pEnn.timer + dt
  myGame.mySon.playSound("BossKill")

  pEnn.direction = pEnn.type .. "Ko"

  if pEnn.timer > boss.timer then
    table.remove(boss.list,pEnn.index)
    if #boss.list == 0 then
      myGame.myScreen.screen = "win"
    end
  end
end

function boss.colhero(pShoot)
  local sdx = pShoot.x - boss.ShootOx * 0.25
  local sfx = pShoot.x + boss.ShootOy * 0.25
  local sdy = pShoot.y - boss.ShootOx * 0.25
  local sfy = pShoot.y + boss.ShootOy * 0.25
  local dx = myGame.hero.x - myGame.hero.Ox * 0.75
  local fx = myGame.hero.x + myGame.hero.Ox * 0.75
  local dy = myGame.hero.y - myGame.hero.Oy * 0.75
  local fy = myGame.hero.y + myGame.hero.Oy * 0.75
  if (sdx > dx or sfx > dx) and ( sdx < fx or sfx < fx)
  and (sdy > dy or sfy > dy) and (sdy < fy or sfy < fy) then
      myGame.hero.damageIN(3)
      return true
  end
return false
end

return boss