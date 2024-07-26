local evenement = {}

evenement.current = false
evenement.draweve = false
evenement.timer = 2

evenement.lst = {
    {
        map = "worldMap",
        exe = function(nbExe)
                if nbExe < 1 then
                    evenement.current = true
                    myGame.dialogueManager.inDialogue = true
                    myGame.dialogueManager.textActif = ""
                    myGame.dialogueManager.scene = 2
                    myGame.hero.pixie.actif = true
                    myGame.hero.pixie.x = 10 * 32
                    myGame.hero.pixie.y = 2 * 32
                    myGame.mySon.playEffect("pixie")
                    nbExe = nbExe + 1
                end
                return nbExe
            end,
        dx = 4 * 32,
        dy = 1 * 32,
        rx = 1 * 32,
        ry = 4 * 32,
        nbExe = 0,
        Repeat = false,
    },
    {
        map = "worldMap",
        exe = function(nbExe)
                if nbExe < 1 then
                    evenement.current = true
                    myGame.dialogueManager.inDialogue = true
                    myGame.dialogueManager.textActif = ""
                    myGame.dialogueManager.scene = 3
                    myGame.mySon.playEffect("pixie")
                    nbExe = nbExe + 1
                end
                return nbExe
            end,
        dx = 5 * 32,
        dy = 1 * 32,
        rx = 1 * 32,
        ry = 4 * 32,
        nbExe = 0,
        Repeat = false,
    },
    {
        map = "donjonEntrer",
        exe = function(nbExe)
                if nbExe < 1 then
                    evenement.current = true
                    myGame.dialogueManager.inDialogue = true
                    myGame.dialogueManager.textActif = ""
                    myGame.dialogueManager.scene = 12
                    nbExe = nbExe + 1
                end
                return nbExe
            end,
        dx = 0 * 32,
        dy = 0 * 32,
        rx = 32 * 32,
        ry = 24 * 32,
        nbExe = 0,
        Repeat = false,
    },
    {
        map = "donjonMiniBoss",
        exe = function(nbExe)
                if nbExe < 1 then
                    evenement.current = true
                    myGame.dialogueManager.inDialogue = true
                    myGame.dialogueManager.textActif = ""
                    myGame.dialogueManager.scene = 13
                    nbExe = nbExe + 1
                end
                return nbExe
            end,
        dx = 0 * 32,
        dy = 0 * 32,
        rx = 32 * 32,
        ry = 24 * 32,
        nbExe = 0,
        Repeat = false,
    },
    {
        map = "donjonMiniBoss",
        exe = function(nbExe)
                if nbExe < 1 then
                    if #myGame.miniboss.list == 0 then
                        evenement.current = true
                        myGame.dialogueManager.inDialogue = true
                        myGame.dialogueManager.textActif = ""
                        myGame.mySon.playEffect("pixie")
                        myGame.dialogueManager.scene = 14
                        nbExe = nbExe + 1
                    end
                end
                return nbExe
            end,
        dx = 13 * 32,
        dy = 0 * 32,
        rx = 6 * 32,
        ry = 2 * 32,
        nbExe = 0,
        Repeat = false,
    },
    {
        map = "donjonBoss",
        exe = function(nbExe)
                if nbExe < 1 then
                    evenement.current = true
                    myGame.dialogueManager.inDialogue = true
                    myGame.dialogueManager.textActif = ""
                    myGame.dialogueManager.scene = 15
                    myGame.mySon.playEffect("mouhaha")
                    nbExe = nbExe + 1
                end
                return nbExe
            end,
        dx = 0 * 32,
        dy = 0 * 32,
        rx = 32 * 32,
        ry = 24 * 32,
        nbExe = 0,
        Repeat = false,
    },
    {
        map = "donjonBoss",
        exe = function(nbExe)
                if nbExe < 1 then
                    if #myGame.boss.list == 0 then
                        evenement.current = true
                        myGame.dialogueManager.inDialogue = true
                        myGame.dialogueManager.textActif = ""
                        myGame.dialogueManager.scene = 16
                        myGame.mySon.playEffect("pixie")
                        nbExe = nbExe + 1
                    end
                end
                return nbExe
            end,
        dx = 0 * 32,
        dy = 0 * 32,
        rx = 32 * 32,
        ry = 24 * 32,
        nbExe = 0,
        Repeat = false,
    },
    {
        map = "village",
        exe = function(nbExe)
                if nbExe < 1 then
                    if love.keyboard.isDown("f") then
                        evenement.current = true
                        myGame.dialogueManager.inDialogue = true
                        myGame.dialogueManager.textActif = ""
                        myGame.dialogueManager.scene = 6
                        nbExe = nbExe + 1
                    end
                end
                return nbExe
            end,
        dx = 15 * 32,
        dy = 8 * 32,
        rx = 3 * 32,
        ry = 3 * 32,
        nbExe = 0,
        Repeat = false,
    },
    {
        map = "village",
        exe = function(nbExe)
                if nbExe < 1 then
                    if love.keyboard.isDown("f") then
                        evenement.current = true
                        myGame.dialogueManager.inDialogue = true
                        myGame.dialogueManager.textActif = ""
                        myGame.dialogueManager.scene = 5
                        nbExe = nbExe + 1
                    end
                end
                return nbExe
            end,
        dx = 1 * 32,
        dy = 18.5 * 32,
        rx = 3 * 32,
        ry = 2.5 * 32,
        nbExe = 0,
        Repeat = true,
    },
    {
            map = "village",
        exe = function(nbExe)
                if nbExe < 1 then
                    if love.keyboard.isDown("f") then
                        evenement.current = true
                        myGame.dialogueManager.inDialogue = true
                        myGame.dialogueManager.textActif = ""
                        myGame.dialogueManager.scene = 19
                        nbExe = nbExe + 1
                    end
                end
                return nbExe
            end,
        dx = 0.5* 32,
        dy = 10.5* 32,
        rx = 3 * 32,
        ry = 3 * 32,
        nbExe = 0,
        Repeat = true,
    },
    {
        map = "village",
        exe = function(nbExe)
                if nbExe < 1 then
                        evenement.current = true
                        myGame.dialogueManager.inDialogue = true
                        myGame.dialogueManager.textActif = ""
                        myGame.dialogueManager.scene = 4
                        myGame.mySon.playEffect("pixie")
                        nbExe = nbExe + 1
                end
                return nbExe
            end,
        dx = 0 * 32,
        dy = 0 * 32,
        rx = 32 * 32,
        ry = 24 * 32,
        nbExe = 0,
        Repeat = false,
    },
    {
        map = "shop",
        exe = function(nbExe)
                if nbExe < 1 then
                    if love.keyboard.isDown("f") then
                        evenement.current = true
                        myGame.dialogueManager.inDialogue = true
                        myGame.dialogueManager.textActif = ""
                        myGame.dialogueManager.scene = 8
                        nbExe = nbExe + 1
                    end
                end
                return nbExe
            end,
        dx = 6.5 * 32,
        dy = 6.5 * 32,
        rx = 3 * 32,
        ry = 3 * 32,
        nbExe = 0,
        Repeat = false,
    },
    {
        map = "shop",
        exe = function(nbExe)
                if love.keyboard.isDown("f") then
                    evenement.current = true
                    myGame.dialogueManager.inDialogue = true
                    myGame.dialogueManager.textActif = ""
                    myGame.dialogueManager.scene = 9
                    nbExe = nbExe + 1
                end
                return nbExe
            end,
        dx = 21.5 * 32,
        dy = 6.5 * 32,
        rx = 3 * 32,
        ry = 3 * 32,
        nbExe = 0,
        Repeat = true,
    },
    {
        map = "shop",
        exe = function(nbExe)
                if love.keyboard.isDown("f")then
                    evenement.current = true
                    myGame.dialogueManager.inDialogue = true
                    myGame.dialogueManager.textActif = ""
                    myGame.dialogueManager.scene = 7
                    nbExe = nbExe + 1
                end
                return nbExe
            end,
        dx = 6 * 32,
        dy = 13 * 32,
        rx = 3 * 32,
        ry = 4 * 32,
        nbExe = 0,
        Repeat = true,
    },
    {
        map = "worldMap",
        exe = function(nbExe)
                if love.keyboard.isDown("f")then
                    evenement.current = true
                    myGame.dialogueManager.inDialogue = true
                    myGame.dialogueManager.textActif = ""
                    myGame.dialogueManager.scene = 11
                    nbExe = nbExe + 1
                end
                return nbExe
            end,
        dx = 26 * 32,
        dy = 16 * 32,
        rx = 2 * 32,
        ry = 2 * 32,
        nbExe = 0,
        Repeat = true,
    },
}

function evenement.colEve(pdx,pdy,pfx,pfy,dt)
    if evenement.current == false then
        for index , args in ipairs(evenement.lst) do
            if args.map == myGame.mapLoadText then
                local fx = args.dx + args.rx
                local fy = args.dy + args.ry
                if (pdx > args.dx or pfx > args.dx) and (pfx < fx or pfx < fx)
                and (pdy > args.dy or pfy > args.dy) and (pdy < fy or pfy < fy) then
                    if type(args.exe) == "function" then
                        if args.nbExe == 0 then
                            args.nbExe = args.exe(args.nbExe)
                            evenement.current = false
                        end
                    end
                elseif args.Repeat then
                    args.nbExe = 0
                end
            end
        end
    end
end

function evenement.draw()
    if evenement.draweve == true then
        for index , args in ipairs(evenement.lst) do
            if args.map == myGame.mapLoadText then
                love.graphics.rectangle("line",args.dx,args.dy,args.rx,args.ry)
            end
        end
    end
end

return evenement