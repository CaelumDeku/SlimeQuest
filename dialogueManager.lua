local dialogueManager = {}

dialogueManager.imgHero1 = love.graphics.newImage("picture/faces/slime.png")
dialogueManager.imgfond = love.graphics.newImage("picture/GUI/dialogue.png")

dialogueManager.xImg = largeur - dialogueManager.imgfond:getWidth() - 75
dialogueManager.yImg = hauteur - dialogueManager.imgfond:getHeight()
dialogueManager.xFace = largeur - dialogueManager.imgfond:getWidth() - 225
dialogueManager.yFace = hauteur - dialogueManager.imgHero1:getHeight() * 2 - 25
dialogueManager.xText = largeur - dialogueManager.imgfond:getWidth() - 75 + 45
dialogueManager.yText = hauteur - dialogueManager.imgfond:getHeight() + 45

dialogueManager.scene = 1
dialogueManager.index = 1
dialogueManager.pnjindex = 1
dialogueManager.pnj = {
    "papy",
    "pixie",
    "petitG",
    "guerriere",
    "Arnes",
    "aubergiste",
    "erudit",
    "alchimiste",
    "narateur",
    "racoon",
    "witch"
}
dialogueManager.textActif = ""
dialogueManager.timer = 1
love.graphics.setFont (love.graphics.newFont (20))
dialogueManager.textFond = love.graphics.getFont()
dialogueManager.text = love.graphics.newText(dialogueManager.textFond)

dialogueManager.inDialogue = false
dialogueManager.endDialogue = false
dialogueManager.inPlayer = true

dialogueManager.lst = require("dialogue")

function dialogueManager.load()
    myGame.CreateQuad("PNJ","faces/pnj",144,144)
    myGame.CreateSprite("PNJ","Arnes",1,1)
    myGame.CreateSprite("PNJ","guerriere",2,2)
    myGame.CreateSprite("PNJ","aubergiste",3,3)
   -- myGame.CreateSprite("PNJ","",4,4)
    myGame.CreateSprite("PNJ","petitG",5,5)
    myGame.CreateSprite("PNJ","papy",6,6)
    myGame.CreateSprite("PNJ","alchimiste",7,7)
    myGame.CreateSprite("PNJ","erudit",8,8)
    myGame.CreateSprite("PNJ","pixie",9,9)
    myGame.CreateSprite("PNJ","narateur",10,10)
    myGame.CreateSprite("PNJ","Aurile",11,11)
    myGame.CreateSprite("PNJ","garde",12,12)
    myGame.CreateSprite("PNJ","Loyd",13,13)
    myGame.CreateSprite("PNJ","witch",14,14)
    myGame.CreateSprite("PNJ","absolue",15,15)
    myGame.CreateSprite("PNJ","racoon",17,17)
end

function dialogueManager.update(dt)
    if  dialogueManager.inDialogue == true and dialogueManager.textActif == "" then
        dialogueManager.textActif = dialogueManager.lst["dialogue" .. dialogueManager.scene][dialogueManager.index]
        if dialogueManager.textActif.player ~= nil then
            dialogueManager.textActif = dialogueManager.textActif.player
            dialogueManager.inPlayer = true
            dialogueManager.timer = 1
            dialogueManager.text = love.graphics.newText(dialogueManager.textFond)
        else
            for i = 1 , #dialogueManager.pnj do
                if  dialogueManager.textActif[dialogueManager.pnj[i]] ~= nil then
                    dialogueManager.textActif = dialogueManager.textActif[dialogueManager.pnj[i]]
                    dialogueManager.pnjindex = i
                    dialogueManager.timer = 1
                    dialogueManager.text = love.graphics.newText(dialogueManager.textFond)
                    break
                end
                i = i + 1 
            end
            dialogueManager.inPlayer = false
        end
    end
    if dialogueManager.inDialogue == true then
        local ok, res = pcall(dialogueManager.animation, dt)
        if not ok then
            dialogueManager.text:add({{2,2,2},dialogueManager.textActif})
        end
    end
end

function dialogueManager.draw()
    if  dialogueManager.inDialogue == true then
        love.graphics.draw(dialogueManager.imgfond,dialogueManager.xImg,dialogueManager.yImg,0,1,1)
        love.graphics.draw(dialogueManager.text,dialogueManager.xText,dialogueManager.yText,0,1,1)
        if dialogueManager.inPlayer then
            love.graphics.draw(dialogueManager.imgHero1,dialogueManager.xFace,dialogueManager.yFace,0,2,2)
        else
            myGame.DrawSprite(dialogueManager.pnj[dialogueManager.pnjindex],dialogueManager.xFace,dialogueManager.yFace,0,1)
        end
    end
end

function dialogueManager.animation(dt)
    local length = #dialogueManager.textActif

    if dialogueManager.timer <= length then
        --local tabletext = dialogueManager.textActif:explode(" ")
        dialogueManager.timer = dialogueManager.timer + dt * 20

        local text = string.sub(dialogueManager.textActif,1,math.floor(dialogueManager.timer))
        -- Soucis avec les accents ex: "à" represente 3 caractere en utf8  
        local c,l = string.find(string.sub(dialogueManager.textActif,math.floor(dialogueManager.timer),math.floor(dialogueManager.timer) + 1),"[à,é,è]")
        if c == 2 and l == 2 then
            dialogueManager.timer = dialogueManager.timer + 2
        end
        dialogueManager.text:add({{2,2,2},text})
    else
        dialogueManager.endDialogue = true
    end

end

function dialogueManager.keypressed(key)
    if  dialogueManager.inDialogue == true then
        if key == "f" and dialogueManager.endDialogue then
            dialogueManager.index = dialogueManager.index + 1
            dialogueManager.textActif = ""
            dialogueManager.endDialogue = false
            if dialogueManager.index > #dialogueManager.lst["dialogue" .. dialogueManager.scene] then
                dialogueManager.inDialogue = false
                dialogueManager.index = 1
            end
        elseif key == "f" then
            dialogueManager.timer = #dialogueManager.textActif
            dialogueManager.endDialogue = false
        end
    end
end

return dialogueManager