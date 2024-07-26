local shoot = {}

shoot.lst = {}
shoot.TILE_WIDTH = 32
shoot.TILE_HEIGHT = 32
shoot.x = 0
shoot.y = 0
shoot.oX = 0
shoot.oY = 0
shoot.speed = 150
shoot.shootDelay = 4
shoot.shootDelayNow = 4
shoot.distance = 300
shoot.loadend = 2
shoot.loadspeed = 1

shoot.shield = {
    x = 0,
    y = 0,
    ox = 0,
    oy = 0,
    actif = false,
    damage = false,
    timerDamage = 0,
    timerDamageDelay = 1,
    empy = false,
}
function shoot.load()

    myGame.CreateQuad("shoot","Sprite/ignis",shoot.TILE_WIDTH,shoot.TILE_HEIGHT)
    myGame.CreateSprite("shoot","ignis",1,4)

    myGame.CreateQuad("shield","Sprite/shield",48,48)
    myGame.CreateSprite("shield","shieldA",1,5)
    myGame.CreateQuad("shieldD","Sprite/shield2",48,48)
    myGame.CreateSprite("shieldD","shieldD",2,4)

    myGame.CreateQuad("load","Sprite/invoc",shoot.TILE_WIDTH,shoot.TILE_HEIGHT)
    myGame.CreateSprite("load","load",1,4)
    

end

function shoot.update(dt,hero)

    myGame.CurrentSprite("shoot",false,dt)
    myGame.CurrentSprite("shield",false,dt)
    myGame.CurrentSprite("shieldD",false,dt)
    myGame.CurrentSprite("load",false,dt)

    if myGame.dialogueManager.inDialogue == false then 
        --shoot.x = hero.x
        --shoot.y = hero.y
        --shoot.oX = hero.Ox
        --shoot.oY = hero.Oy
        shoot.x = hero.pixie.x
        shoot.y = hero.pixie.y
        shoot.oX = hero.pixie.Ox
        shoot.oY = hero.pixie.Oy

        local MouseX,MouseY = love.mouse.getPosition()

        shoot.shootDelayNow = shoot.shootDelayNow + dt
        -----------------------------------------------------------------------------
        -- shoot
        if love.mouse.isDown(1) and #shoot.lst <= 0 and shoot.shootDelayNow > shoot.shootDelay then
            myGame.mySon.playEffect("ignis")
            local newshoot = {
                x = shoot.x,
                y = shoot.y,
                startx = shoot.x,
                starty = shoot.y,
                oX = shoot.oX,
                oY = shoot.oY,
                id = #shoot.lst + 1,
                load = 0,
                fire = false,
                angle = math.atan2(MouseY - shoot.y,MouseX - shoot.x)
            }
            table.insert(shoot.lst,newshoot)
            shoot.shootDelayNow = 0
        end

        for index , pshoot in ipairs(shoot.lst) do
            if pshoot.load >= shoot.loadend then
                pshoot.fire = true
                pshoot.x = pshoot.x + shoot.speed * dt * math.cos(pshoot.angle)
                pshoot.y = pshoot.y + shoot.speed * dt * math.sin(pshoot.angle)
            else
                pshoot.load = pshoot.load + shoot.loadspeed * dt
                pshoot.x = hero.pixie.x
                pshoot.y = hero.pixie.y
                pshoot.angle = math.atan2(MouseY - shoot.y,MouseX - shoot.x)
                pshoot.fire = false
                pshoot.startx = pshoot.x + shoot.speed * dt * math.cos(pshoot.angle)
                pshoot.starty = pshoot.y + shoot.speed * dt * math.sin(pshoot.angle)
            end
            if math.dist(pshoot.startx,pshoot.starty,pshoot.x,pshoot.y) >= shoot.distance then
                shoot.lst = {}
                break
            end
            if shoot.colenemy(pshoot) then
                shoot.lst = {}
                break
            end
            if shoot.colBoss(pshoot,"miniboss") then
                shoot.lst = {}
                break
            end
            if shoot.colBoss(pshoot,"boss") then
                shoot.lst = {}
                break
            end
        end

        -----------------------------------------------------------------------------
        -- shield
        shoot.shield.x = hero.x
        shoot.shield.y =  hero.y
        shoot.shield.oX = 48 * 0.5
        shoot.shield.oY = 48 * 0.5

        if love.mouse.isDown(2) and shoot.shield.empy == false then
            shoot.shield.actif = true
            myGame.energy.nbrmana = myGame.energy.nbrmana - dt * 5
            if myGame.energy.nbrmana <= 0.5 then
                myGame.energy.nbrmana = 1
                shoot.shield.empy = true
            end
        else 
            if myGame.energy.nbrmana <= myGame.energy.nbrmanamax and shoot.shield.damage == false then
                if shoot.shield.empy == true then
                    myGame.energy.nbrmana = myGame.energy.nbrmana + dt * 2
                else
                    myGame.energy.nbrmana = myGame.energy.nbrmana + dt * 5
                end
                -- si le chargement du bouclier n'est pas arriver a la moitier on ne pourra pas le réutiliser
                if shoot.shield.empy == true and myGame.energy.nbrmana > myGame.energy.nbrmanamax * 0.5 then
                    shoot.shield.empy = false
                end
            end
            shoot.shield.actif = false
        end
        if shoot.shield.damage == true then
            myGame.mySon.playSound("ShieldDeflec")
            shoot.shield.timerDamage = shoot.shield.timerDamage + dt
            if shoot.shield.timerDamage > shoot.shield.timerDamageDelay then
                shoot.shield.damage = false
                shoot.shield.timerDamage = 0
            end
        end
    end   
end

function shoot.draw()

    for index , pshoot in ipairs(shoot.lst) do
        if pshoot.fire == true then
            myGame.DrawSprite("ignis",pshoot.x,pshoot.y,pshoot.angle,1,pshoot.oX,pshoot.oY)
        else
            myGame.DrawSprite("load",pshoot.x,pshoot.y,0,1,myGame.hero.Ox,myGame.hero.Oy)
        end
        
    end

    if shoot.shield.actif == true and shoot.shield.damage == false then
        myGame.DrawSprite("shieldA",shoot.shield.x,shoot.shield.y,0,1,shoot.shield.oX,shoot.shield.oY)
    elseif shoot.shield.damage == true then
        myGame.DrawSprite("shieldD",shoot.shield.x,shoot.shield.y,0,1,shoot.shield.oX,shoot.shield.oY)
    end
end

function shoot.colenemy(pShoot)
    if pShoot.fire == true then
        local sdx = pShoot.x - pShoot.oX
        local sfx = pShoot.x + pShoot.oX
        local sdy = pShoot.y - pShoot.oY
        local sfy = pShoot.y + pShoot.oY
        for index, pEnn in ipairs(myGame.enemy.list) do
            local dx = pEnn.x - myGame.enemy.oX[pEnn.type]
            local fx = pEnn.x + myGame.enemy.oX[pEnn.type]
            local dy = pEnn.y - myGame.enemy.oY[pEnn.type]
            local fy = pEnn.y + myGame.enemy.oY[pEnn.type]
            if (sdx > dx or sfx > dx) and ( sdx < fx or sfx < fx)
            and (sdy > dy or sfy > dy) and (sdy < fy or sfy < fy) then
                myGame.enemy.damage(index)
                return true
            end
        end
    end
    return false
end

function shoot.colBoss(pShoot,typeBoss)
    if pShoot.fire == true then
        local sdx = pShoot.x - pShoot.oX
        local sfx = pShoot.x + pShoot.oX
        local sdy = pShoot.y - pShoot.oY
        local sfy = pShoot.y + pShoot.oY
        for index, Boss in ipairs(myGame[typeBoss].list) do
            if Boss.state ~= myGame.StateIA.KO then
                local dx = Boss.x - myGame[typeBoss].oX
                local fx = Boss.x + myGame[typeBoss].oX
                local dy = Boss.y - myGame[typeBoss].oY
                local fy = Boss.y + myGame[typeBoss].oY
                if (sdx > dx or sfx > dx) and ( sdx < fx or sfx < fx)
                and (sdy > dy or sfy > dy) and (sdy < fy or sfy < fy) then
                    if Boss.noDamage == false then
                        Boss.timer = 0
                        Boss.state = myGame.StateIA.DAMAGE
                        Boss.atk = false 
                        myGame.mySon.playEffect("enemyHit") 
                    end
                    return true
                end
            end
        end
    end
    return false
end




return shoot