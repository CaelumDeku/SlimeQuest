-----------------------------------------------------------------------------------------
---------------------------------------Game----------------------------------------------
-----------------------------------------------------------------------------------------
local game = {}
-----------------------------------------------------------------------------------------
require("extension")
require("util")
-----------------------------------------------------------------------------------------
game.myScreen = require("sceneManager")
-----------------------------------------------------------------------------------------
-- interface vie et endurance
lifebarre = love.graphics.newImage("picture/GUI/lifebar.png")
endubarre = love.graphics.newImage("picture/GUI/energybar.png")
game.life = require("life")
game.energy = require("energy")
-----------------------------------------------------------------------------------------
--game.interface = require("interface")
game.cursor = nil
-- Son du jeux 
game.mySon = require("sonManager")
-----------------------------------------------------------------------------------------
-- héro : Lyo
game.hero = require("hero")
game.shoot = require("shoot")
-----------------------------------------------------------------------------------------
-- Pnj
game.pnj = require("pnj")
-----------------------------------------------------------------------------------------
-- Enemy
game.enemy = require("enemy")
-----------------------------------------------------------------------------------------
-- mini boss
game.miniboss = require("miniboss")
-----------------------------------------------------------------------------------------
-- Boss
game.boss = require("boss")
-----------------------------------------------------------------------------------------
-- MAPS
game.TpDirection = {}
-- map maison Lyo
game.homeHero = require("homeHero")
--map world
game.worldMap = require("Worldmap")
-- map village
game.village = require("Village")
--Map Shop
game.shop = require("INN")
-- donjon 
-- salle simple
game.donjonSimple = require("Donjon-simple")
game.donjon = require("Donjon")
--salle mini boss
game.donjonMiniBoss = require("Donjonminiboss")
--salle boss
game.donjonBoss = require("Donjonbossfinal")
--entrée
game.donjonEntrer = require("DonjonEntree")
--dialogue 
game.dialogueManager = require("dialogueManager")
--evenement
game.evenement = require("evenement")
-----------------------------------------------------------------------------------------
game.Map = {}
game.Map.MapWIDTH = 32
game.Map.MapHEIGHT = 23
game.Map.TileWIDHT = 32
game.Map.TileHEIGHT = 32
game.TileSheet = {}
game.TileTextures = {}
game.TileTypes = {}
-----------------------------------------------------------------------------------------
game.quadList = {}
game.StriteList = {}
game.dtSpeed = 5
game.mapLoad = ""
game.mapLoadText = ""
-----------------------------------------------------------------------------------------
game.StateIA = {
  STATE = "state",
  WALK = "walk",
  CHASE = "chase",
  ATTACK = "attack",
  KO = "ko",
  DAMAGE = "damage"
}
-----------------------------------------------------------------------------------------
function game.load()
  game.cursor = love.mouse.newCursor("picture/cursor.png", 0, 0)
  love.mouse.setCursor(game.cursor)
  -----------------------------------------------------------------------------------------
   -- recup tilesheet
   local id = 1
  -----------------------------------------------------------------------------------------
  game.LoadMap("homeHero")
  game.LoadMap("village")
  game.LoadMap("shop")
  game.LoadMap("donjonEntrer")
  game.LoadMap("donjon")
  game.LoadMap("donjonSimple")
  game.LoadMap("donjonMiniBoss")
  game.LoadMap("donjonBoss")
  game.LoadMap("worldMap")

  game.hero.load()
  game.enemy.load()
  game.miniboss.load()
  game.boss.load()
  game.pnj.load()
  -- enemy
 -- game.enemy.new(1,16*32,6*32,6*32,10*32)
 game.dialogueManager.load()
end
-----------------------------------------------------------------------------------------
function game.update(dt)
end
-----------------------------------------------------------------------------------------
function game.draw()
-- life et energy
   love.graphics.draw(lifebarre,0,0)
   love.graphics.draw(endubarre,largeur*0.5,0)
   game.life.draw(game.Map)
   game.energy.draw(game.Map)

   for i , TpD in ipairs(game.TpDirection) do
    if TpD.actif == true then
      love.graphics.setColor(255, 255, 255, 50)
      love.graphics.draw(TpD.pic,TpD.x,TpD.y,0,1,1,TpD.pic:getWidth() * 0.5,TpD.pic:getHeight() * 0.5)
    end
  end
  game.evenement.draw()
end
-----------------------------------------------------------------------------------------
---------------------------------Générateur de Map---------------------------------------
-----------------------------------------------------------------------------------------
function game.drawMAP(pMap,pName)
  local c,l
   for line = 1, #pMap.layers do
      if pMap.layers[line].type == "tilelayer" then
          local id = 0
          l=1
          local column = 0
        for c=1 , #pMap.layers[line].data  do
          if c > l*pMap.layers[line].width then
            l = l+1
            column = 1 
          else
            column = column +1
          end
            id = pMap.layers[line].data[c]
            local texQuad = nil
          for index, tilesheet in ipairs(game.TileSheet) do
            if(tilesheet.name == pName) then
              texQuad = tilesheet.ListTileTextures.TileTextures[id].data 
              if texQuad ~= nil then
                love.graphics.draw(tilesheet.ListTileTextures.data[tilesheet.ListTileTextures.TileTextures[id].id], 
                texQuad, (column-1)*game.Map.TileWIDHT, 
                (l)*game.Map.TileHEIGHT
                )
                end
            end
          end
        end
      end
    end
end
function game.LoadMap(pFile)
  local TileTextures= {}
  local id = 1
  TileTextures.TileTextures = {}
  TileTextures.TileTextures[0] = {
    data = nil,
    id = 0
   }
   TileTextures.data = {}
  for i = 1 ,#game[pFile].tilesets do 
    TileTextures.data[i] = love.graphics.newImage("picture/Tiles/"..game[pFile].tilesets[i].name..".png")
    local nbColumns = TileTextures.data[i]:getWidth() / game.Map.TileWIDHT
    local nbLines = TileTextures.data[i]:getHeight() / game.Map.TileHEIGHT
    for l=1,nbLines do
      for c=1,nbColumns do
        TileTextures.TileTextures[id]= {
          id = i,
          data = love.graphics.newQuad(
            (c-1)*game.Map.TileWIDHT, (l-1)*game.Map.TileHEIGHT,
            game.Map.TileWIDHT, game.Map.TileHEIGHT, 
            TileTextures.data[i]:getWidth(), TileTextures.data[i]:getHeight()
          )
         }
        id = id + 1
      end
    end
  end  
  local TileSheet = {
    name = pFile,
    ListTileTextures = TileTextures
  }
  table.insert(game.TileSheet,TileSheet)
end
-----------------------------------------------------------------------------------------
-----------------CreateQuad et CreateSprite à mettre dans LOAD !!!!----------------------
-----------------------------------------------------------------------------------------
function game.CreateQuad(psName,psImageSheet,psHeightImg,psWidthImg)
  local quad = {}

  local i 

  --test si le quad existe déja 
  for i , quad in ipairs(game.quadList) do 
      if psName == quad.name then
          return
      end
  end

  quad.name = psName
  quad.tileSheet = love.graphics.newImage("picture/"..psImageSheet..".png")
  
  quad.tileTexture = {}
  quad.tileTexture[0] = nil

  local c,nbCol,nbLine
  nbCol = quad.tileSheet:getWidth() / psWidthImg
  nbLine = quad.tileSheet:getHeight() / psHeightImg
  local id = 1

  for l = 1, nbLine do
      for c = 1, nbCol do
          quad.tileTexture[id] = love.graphics.newQuad(
              (c-1) * psWidthImg,
              (l-1) * psHeightImg,
              psWidthImg,
              psHeightImg,
              quad.tileSheet:getWidth(),
              quad.tileSheet:getHeight()
          )

          id = id + 1
      end
  end

  table.insert(game.quadList,quad)
end
-----------------------------------------------------------------------------------------
---------------------------------Générateur de sprite------------------------------------
-----------------------------------------------------------------------------------------
function game.CreateSprite(psNameQuad,psNameSprite,pnStart,pnEnd)
  local sprite =  {}

  for i, quad in ipairs(game.quadList) do
      if quad.name == psNameQuad then
          sprite.name = psNameSprite
          sprite.quad = psNameQuad
          sprite.currentImg = 1
          sprite.tileSheet = quad.tileSheet
          sprite.list = {}
          local spriteid = 1
          for id = pnStart, pnEnd do
              sprite.list[spriteid] = quad.tileTexture[id]
              spriteid = spriteid + 1
          end

          table.insert(game.StriteList,sprite)
      end
  end
end
-----------------------------------------------------------------------------------------
---------------------------------Dessin du sprite----------------------------------------
-----------------------------------------------------------------------------------------
function game.DrawSprite(psNameSprite,pX,pY,pAngle,pnScale,pOx,pOy)
  for i, sprite in ipairs(game.StriteList) do 
      if sprite.name == psNameSprite and #sprite.list ~= 0 then
          love.graphics.draw(sprite.tileSheet,sprite.list[math.floor(sprite.currentImg)],pX,pY,pAngle,pnScale,pnScale,pOx,pOy)
      end
  end
end

-- psName nom du quad ou sprite a chercher dans la list
-- pbSprite booléen true si Name est Sprite false si Quad
function game.CurrentSprite(psName,pbSprite,dt)

  for i, sprite in ipairs(myGame.StriteList) do
      if sprite.quad == psName and not pbSprite or sprite.name == psName and pbSprite then
          sprite.currentImg = sprite.currentImg + (game.dtSpeed * dt)
          if sprite.currentImg > #sprite.list + 1 then
              sprite.currentImg = 1
          end
      end
  end
end

-----------------------------------------------------------------------------------------
---------------------------------Générateur Collision------------------------------------
-----------------------------------------------------------------------------------------
function game.collision(pX,pY,Ox,Oy,pMap)
  local c = math.floor(pX / pMap.tilewidth) + 1 -- 262 / 32 = c
  local l = math.floor(pY / pMap.tileheight)
  for index , Layers in ipairs(pMap.layers) do
    if Layers.type == "tilelayer" then
      local i = l * pMap.tileheight - (pMap.tileheight - c)
      local id = Layers.data[i]
      if id ~= nil then
        for ti , pTileSet in ipairs(pMap.tilesets) do
          if pTileSet.tiles ~= nil then
            for tj, pTiles in ipairs(pTileSet.tiles) do
              local idTiles = pTiles.id + pTileSet.firstgid - 1
              if idTiles == id - 1 then
                for iObj , Obj in ipairs(pTiles.objectGroup.objects) do
                  local dx = (c-1) * game.Map.TileWIDHT + Obj.x
                  local fx = dx + Obj.width
                  local dy = l * game.Map.TileHEIGHT + Obj.y
                  local fy = dy + Obj.height
                  local hdx = pX - Ox
                  local hfx = pX + Ox
                  local hdy = pY
                  local hfy = pY + Oy
                  if (hdx > dx or hfx > dx) and  ( hdx < fx or hfx < fx) and
                      (hdy > dy or hfy > dy) and ( hdy < fy or hfy < fy) 
                  then
                    print("aie " .. pX .. "  " .. pY)
                    return true
                  end
                end
              end
            end
          end
        end
      end
    end
  end
  return false
end

function game.collisionPnj(pX,pY,Ox,Oy)
  for index , argsPnj in ipairs(game.pnj.list) do
    local dx = pX - Ox
    local fx = pX + Ox
    local dy = pY - Oy
    local fy = pY + Oy
    local hdx = argsPnj.x - game.pnj.oX
    local hfx = argsPnj.x + game.pnj.oX
    local hdy = argsPnj.y - game.pnj.oY
    local hfy = argsPnj.y + game.pnj.oY
    if (hdx > dx or hfx > dx) and  ( hdx < fx or hfx < fx) and
    (hdy > dy or hfy > dy) and ( hdy < fy or hfy < fy) 
    then
      print("aiePNJ " .. pX .. "  " .. pY)
      return true
    end
  end
  return false
end

function game.tpmap(pC,pL,pMapS,pActif)
  local TpDirect = {
    x = pC * game.Map.TileHEIGHT,
    y = pL * game.Map.TileWIDHT,
    mapS = pMapS,
    pic = love.graphics.newImage("picture/GUI/tp.png"),
    actif = pActif
  }
  table.insert(game.TpDirection,TpDirect)
end

function game.tpmapColision(pX,pY)
  local hdx = pX - game.hero.Ox * 0.5
  local hfx = pX + game.hero.Ox * 0.5
  local hdy = pY - game.hero.Oy * 0.5
  local hfy = pY + game.hero.Oy * 0.5
  for index, Tpd in ipairs(game.TpDirection) do
    if Tpd.actif == true then
      local dx = Tpd.x - 10
      local fx = Tpd.x + 10
      local dy = Tpd.y - 10
      local fy = Tpd.y + 10
      --print(hdx .." ".. hfx .." ".. dx .. " " .. fx)
      if (hdx > dx or hfx > dx) and ( hdx < fx or hfx < fx)
          and (hdy > dy or hfy > dy) and (hdy < fy or hfy < fy) then
            game.TpDirection = {}
            return Tpd.mapS
      end
    end
  end
  return ""
end
 return game