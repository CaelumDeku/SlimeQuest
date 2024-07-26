-----------------------------------------------------------------------------------------
------------------------------Générateur de Son et musique-------------------------------
-----------------------------------------------------------------------------------------
local sonManager = {}
-----------------------------------------------------------------------------------------
sonManager.lstsons = {} -- Liste des musiques du mixer
sonManager.currentson = 0 -- ID de la musique en cours
sonManager.Listeffect = {}
sonManager.pathEffect = "/song/effect/"
-----------------------------------------------------------------------------------------
-- Les musiques
local sonMenu = love.audio.newSource("song/music/001.ogg", "stream")
local sonIntro = love.audio.newSource("song/music/002.ogg", "stream")
local sonGame = love.audio.newSource("song/music/003.ogg", "stream")
local sonTown = love.audio.newSource("song/music/004.ogg", "stream")
local sonDonjon1 = love.audio.newSource("song/music/005.ogg", "stream")
local sonDonjon2 = love.audio.newSource("song/music/006.ogg", "stream")
local sonDonjon3 = love.audio.newSource("song/music/007.ogg", "stream")
local sonWin = love.audio.newSource("song/music/008.ogg", "stream")
-----------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------
function sonManager.load()

  local file = {}
    file = love.filesystem.getDirectoryItems(sonManager.pathEffect)
    local i
    local effect = {}
    local fileInfo = {}
    for i = 1,  #file do
        effect = {}
        fileInfo = love.filesystem.getInfo(sonManager.pathEffect .. file[i])
        if(fileInfo.type == "file") then
            effect.name = file[i]:explode("%.")[1]
            effect.sound = love.audio.newSource(sonManager.pathEffect .. file[i], "static")
        end
       table.insert(sonManager.Listeffect,effect)
        i = i + 1
    end

 --1
  sonManager.addson(sonMenu)
--2
  sonManager.addson(sonIntro)
--3
  sonManager.addson(sonGame)
--4
  sonManager.addson(sonTown)
--5
  sonManager.addson(sonDonjon1)
--6
  sonManager.addson(sonDonjon2)
--7
  sonManager.addson(sonDonjon3)
--8
  sonManager.addson(sonWin)
end
-----------------------------------------------------------------------------------------
------------------------------Ajout de la piste audio------------------------------------
-----------------------------------------------------------------------------------------
function sonManager.addson(pson)
  local newson = {}
  newson.source = pson
  newson.source:setVolume(0)
  table.insert(sonManager.lstsons, newson)
end
-----------------------------------------------------------------------------------------
-- Mettre à jour le mixer (à appeler dans update)
function sonManager.update(dt)
end
-----------------------------------------------------------------------------------------
-- Méthode pour démarrer une musique de la liste (par son ID)
function sonManager.PlayMusic(pNum)
  -- Récupère la musique dans la liste et la démarre
  local son = sonManager.lstsons[pNum]
  if not son.source:isPlaying() then
    son.source:play()
    son.source:setVolume(0.1)
  end
  sonManager.currentson = pNum
end
function sonManager.StopMusic(pNum)
  local son = sonManager.lstsons[pNum]
  son.source:play() 
  sonManager.currentson = pNum
  son.source:stop()
end
-----------------------------------------------------------------------------------------
------------------------------Jouer un Effet---------------------------------------------
-----------------------------------------------------------------------------------------
function sonManager.playEffect(pName)
  for index , pEffect in ipairs(sonManager.Listeffect) do
      if pEffect.name == pName then
        if pEffect.sound:isPlaying() then
          pEffect.sound:stop()
        end
          pEffect.sound:play()
          pEffect.sound:setVolume(0.5)
      end
  end
end
function sonManager.playSound(pName)
  for index , pEffect in ipairs(sonManager.Listeffect) do
      if pEffect.name == pName then
        if not pEffect.sound:isPlaying() then
          pEffect.sound:play()
          if pEffect.name == "slime" then
            pEffect.sound:setVolume(0.05)
          else
            pEffect.sound:setVolume(0.5)
          end
          
        end
      end
  end
end
-----------------------------------------------------------------------------------------
return sonManager